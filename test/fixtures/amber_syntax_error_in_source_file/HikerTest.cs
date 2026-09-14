using Xunit;

public class HikerTest
{
    [Fact]
    public void life_the_universe_and_everything()
    {
        Assert.Equal(42, new Hiker().Answer());
    }
}
