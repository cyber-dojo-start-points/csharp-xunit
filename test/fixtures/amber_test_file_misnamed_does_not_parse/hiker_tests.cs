using Xunit;

// Named hiker_tests.cs rather than HikerTest.cs. The name buys nothing here:
// the compiler is handed every .cs file whatever it is called, so this one is
// compiled too and its missing bracket stops the build before any test runs.
public class HikerTests
{
    [Fact]
    public void the_answer_is_two_digits_long()
    {
        Assert.Equal(2, new Hiker().Answer().ToString().Length;
    }
}
