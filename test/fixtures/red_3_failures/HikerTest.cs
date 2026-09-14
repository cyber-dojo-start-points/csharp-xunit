using Xunit;

public class HikerTest
{
    [Fact]
    public void life_the_universe_and_everything()
    {
        Assert.Equal(42, new Hiker().Answer());
    }

    [Fact]
    public void the_answer_is_a_multiple_of_seven()
    {
        Assert.Equal(0, new Hiker().Answer() % 7);
    }

    [Fact]
    public void the_answer_reads_as_forty_two()
    {
        Assert.Equal("42", new Hiker().Answer().ToString());
    }
}
