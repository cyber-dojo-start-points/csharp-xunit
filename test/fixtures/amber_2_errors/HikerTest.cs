using Xunit;

public class HikerTest
{
    [Fact]
    public void life_the_universe_and_everything()
    {
        Assert.Equal(42, new Hiker().Answer());
    }

    [Fact]
    public void the_answer_is_two_digits_long()
    {
        Assert.Equal(2, new Hiker().AnswerSize());
    }
}
