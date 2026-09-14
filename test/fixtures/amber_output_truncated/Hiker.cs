using System;

public class Hiker
{
    public int Answer()
    {
        // The learner put a print inside a loop to see what was happening,
        // and it prints far more than the 50K the runner keeps of a stream.
        // Console.WriteLine goes to stdout, and that is the stream the
        // framework's summary comes on too, so the summary is what falls off
        // the end and there are no counts left for a colour to be read from.
        for (var i = 0; i < 10000; i++)
        {
            Console.WriteLine("debug: i is " + i);
        }
        return 6 * 7;
    }
}
