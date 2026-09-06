
lambda { |stdout,stderr,status|
  output = stdout + stderr

  # xunit ends with a line of counts, which is what this reads. Matching the
  # counts rather than any wording means a reworded banner cannot silently
  # change a colour.
  #
  #   dojo  Total: 1, Errors: 0, Failed: 1, Skipped: 0, Not Run: 0, Time: 0.052s
  #
  # A compile that failed prints no such line at all, and reaches the amber at
  # the bottom.
  counts = /Total:\s*(\d+),\s*Errors:\s*(\d+),\s*Failed:\s*(\d+),\s*Skipped:\s*(\d+),\s*Not Run:\s*(\d+)/.match(output)

  if counts
    total, errors, failed, _skipped, not_run = counts.captures.map(&:to_i)
    # Nothing ran, so there is nothing to be green about.
    return :amber if total.zero?
    return :amber if errors.positive?
    return :amber if not_run.positive?
    return :green if failed.zero?

    # A failed assertion is red and a thrown exception is amber, and xunit
    # counts both of them as Failed, so the counts cannot tell them apart. The
    # line under each [FAIL] can: an assertion names itself, and anything else
    # names its exception type.
    #
    #     HikerTest.life_the_universe_and_everything [FAIL]
    #       Assert.Equal() Failure: Values differ      <- an assertion
    #       System.Exception : the earth is demolished <- not an assertion
    #
    # Every failure has to be an assertion for this to be red. One that is not
    # means something went wrong rather than something being wrong.
    failures = output.scan(/\[FAIL\]/).size
    assertions = output.scan(/^\s*Assert\.\w+\(\) Failure/).size
    return :red if failures.positive? && failures == assertions
    return :amber
  end

  #dotnet test, which the fallback line in cyber-dojo.sh uses:
  return :green if /^Passed!/.match(output)
  return :red   if /^Failed!/.match(output)

  return :amber
}
