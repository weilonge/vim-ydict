describe 'ydict#command'
  it 'runs ydict with blank argument when no/blank pattern is given'
    Expect ydict#command('') == "ydict.js  | less -R"
    Expect ydict#command(' ') == "ydict.js   | less -R"
    Expect ydict#command(['']) == "ydict.js [''] | less -R"
    Expect ydict#command([]) == "ydict.js [] | less -R"
  end

  it 'runs ydict with argument when pattern is given'
    Expect ydict#command('foo') == "ydict.js foo | less -R"
    Expect ydict#command(['foo']) == "ydict.js ['foo'] | less -R"
  end

  it 'joins commands with || when fallback patterns are given'
    Expect ydict#command(['foo', 'bar']) == "ydict.js ['foo', 'bar'] | less -R"
  end

  it 'joins commands with || when pattern expands into forgiving fallback'
    Expect ydict#command('foo!') == "ydict.js foo! | less -R"
    Expect ydict#command(['foo!']) == "ydict.js ['foo!'] | less -R"
  end

  it 'ignores duplicate patterns and instead only operates on unique ones'
    Expect ydict#command(['foo', 'foo']) == "ydict.js ['foo', 'foo'] | less -R"
  end
end
