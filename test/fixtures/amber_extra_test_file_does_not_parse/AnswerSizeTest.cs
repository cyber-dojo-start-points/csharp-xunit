using Xunit;

public class AnswerSizeTest
{
    [Fact]
    public void the_answer_is_two_digits_long()
    {
        Assert.Equal(2, new Hiker().Answer().ToString().Length;
    }
}
