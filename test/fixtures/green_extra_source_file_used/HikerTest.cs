using Xunit;

public class HikerTest
{
    [Fact]
    public void the_digits_of_the_answer_add_up_to_six()
    {
        Assert.Equal(6, new Hiker().AnswerChecksum());
    }
}
