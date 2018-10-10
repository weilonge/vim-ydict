command! -nargs=* -complete=tag -bang YDict call YDict(<q-args>, '<bang>')

" Searches for the given pattern in docsets configured for current filetype
" unless the second argument is `!`, in which case it searches all docsets.
function! YDict(pattern, ...) abort
  call ydict#search(a:pattern)
endfunction
