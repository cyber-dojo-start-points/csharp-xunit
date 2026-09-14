using Xunit;

public class FizzBuzzTest
{
    [Fact]
    public void fifteen_says_fizz_buzz()
    {
        Assert.Equal("FizzBuzz", new FizzBuzz().Say(15));
    }
}
