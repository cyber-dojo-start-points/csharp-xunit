using System;

public class Hiker
{
    public int Answer()
    {
        // Both streams reach the learner. cyber-dojo.sh puts every
        // System.*.dll of the shared framework on the compiler command line,
        // and System.Console.dll is one of them, so Console is there to be
        // called and a write to either stream arrives as that stream. The
        // framework's own summary comes on stdout, alongside the first of
        // these.
        Console.WriteLine("debug on stdout: answer was called");
        Console.Error.WriteLine("debug on stderr: answer was called");
        return 6 * 7;
    }
}
