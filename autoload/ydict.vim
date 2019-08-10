" Searches for the given pattern (which may be a list).
function! ydict#search(pattern) abort
  let title = type(a:pattern) == type([]) ? a:pattern[0] : a:pattern
  call ydict#execute(ydict#command(title), title)
endfunction

" Runs the given shell command.  If it exits with a nonzero status, waits for
" the user to press any key before clearing the given shell command's output.
" Under NeoVim, the terminal's title is overriden to reflect the given value.
function! ydict#execute(command, title) abort
  if has('terminal')
    call s:open_ydict_window()
    call term_start(['sh', '-c', a:command], {
          \ 'curwin': 1,
          \ 'term_name': a:title,
          \ 'exit_cb': function('s:handle_ydict_exit')
          \ })
  elseif has('nvim')
    call s:open_ydict_window()
    call termopen(a:command, {'on_exit': function('s:handle_ydict_exit')})
    " change tab title; see `:help :file_f`
    silent! execute 'file' shellescape(a:title, 1)
    startinsert
  else
    " stty and dd below emulate getch(3)
    " as answered by Diego Torres Milano
    " http://stackoverflow.com/a/8732057
    let command = 'clear ; '. a:command
          \ .' || {'
          \ .' stty raw -echo  ;'
          \ .' dd bs=1 count=1 ;'
          \ .' stty -raw echo  ;'
          \ .' } >/dev/null 2>&1'

    " gvim has no terminal emulation, so
    " launch an actual terminal emulator
    if has('gui') && has('gui_running')
      let command = 'xterm'
            \ .' -T '. shellescape(a:title)
            \ .' -e '. shellescape(command)
            \ .' &'
    endif

    silent execute '!' command
    redraw!
  endif
endfunction

function! s:open_ydict_window() abort
  execute get(g:, 'ydict_results_window', 'new')
endfunction

function! s:handle_ydict_exit(job_id, exit_status, ...) abort
  if a:exit_status == 0
    bdelete!
  elseif has('nvim')
    " Vim's :terminal exits insert mode when job is terminated,
    " whereas NeoVim's :terminal still remains in insert mode
    " and waits for any keypress before auto-closing itself.
    " This overrides NeoVim's :terminal to behave like Vim.
    call feedkeys("\<C-\>\<C-N>", 'n')
  endif
endfunction

function! ydict#command(pattern) abort
  return join(['ydict.js'] + [a:pattern] + ['| less -R'], ' ')
endfunction
