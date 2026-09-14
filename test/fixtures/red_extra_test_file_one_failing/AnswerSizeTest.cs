using Xunit;

public class AnswerSizeTest
{
    [Fact]
    public void the_answer_is_three_digits_long()
    {
        Assert.Equal(3, new Hiker().Answer().ToString().Length);
    }
}
