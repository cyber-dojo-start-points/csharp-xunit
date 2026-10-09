# --------------------------------------------------------------
# Text files under /sandbox are automatically returned...
source ~/cyber_dojo_fs_cleaners.sh

# Must be 0. With W^X on, the .NET JIT keeps its code in a memfd that grows
# past the runner's fsize ulimit, and dotnet aborts.
export DOTNET_EnableWriteXorExecute=0

function cyber_dojo_enter()
{
  : # 1. Only return _newly_ generated reports.
  #cyber_dojo_reset_dirs ${...}
}
function cyber_dojo_exit()
{
  : # 2. Remove new text files we don't want returned.
  cyber_dojo_delete_dirs /sandbox/bin
  cyber_dojo_delete_dirs /sandbox/obj
}
cyber_dojo_enter
trap cyber_dojo_exit EXIT SIGTERM

#FALLBACK, SLOWER ~2.5s:
# comment in the next line if anything below fails
#dotnet test --nologo ; exit

#FAST ~0.45s:
CSC=$(find /usr/share/dotnet/sdk -name csc.dll | head -1)
CORE=$(ls -d /usr/share/dotnet/shared/Microsoft.NETCore.App/* | tail -1)

# An xunit test project is a program you run, not something a separate runner
# loads, so it needs a Main. Normally the build writes one for you. Nothing
# here runs that build, so the image carries the same Main and it is compiled
# in alongside your own files.
ENTRY_POINT=~/xunit_entry/XunitEntryPoint.cs

# The assemblies your code is compiled against. They were resolved when this
# image was built, which is why there is nothing to download when you run.
REFERENCES=''
for dll in ~/dojo_refs/*.dll; do REFERENCES="${REFERENCES} -r:${dll}"; done
for dll in ${CORE}/System.*.dll ${CORE}/netstandard.dll; do REFERENCES="${REFERENCES} -r:${dll}"; done

# xunit is beside your compiled tests rather than on a search path, so the
# assemblies it needs at run time are put next to them.
mkdir -p bin
cp ~/dojo_refs/*.dll bin/
cp ~/dojo_refs/dojo.runtimeconfig.json bin/

# Every .cs file is compiled, at any depth, including ones nothing else refers
# to yet, so a file you are midway through writing shows its errors instead of
# being passed over in silence.
#
# -nowarn:1701,1702 keeps one warning out of your way. Moq was built against an
# older System.Linq.Expressions than this runtime carries. The mismatch is
# harmless, and there is nothing you could do about it from here.
if ! dotnet ${CSC} -nologo -nowarn:1701,1702 -target:exe -out:bin/dojo.dll ${REFERENCES} ${ENTRY_POINT} $(find . -name '*.cs'); then
  exit 1
fi

# Colour is off because this output is read by a program as well as by you.
# xunit spells its options with a single dash.
dotnet bin/dojo.dll -noColor
