using Xunit;

public class HikerTest
{
    // The [Fact] attribute is what xunit gathers, and nothing here carries
    // one, so the run proves nothing about the code. cyber-dojo.sh exits 0
    // all the same, which is why the colour is decided from the counts
    // rather than from the exit status.
    private int Expected()
    {
        return 42;
    }
}
