# ydict.vim

A (Neo)Vim plugin for [ydict]( https://github.com/sayuan/ydict.js ) integration:

## Prerequisite

Install ydict:

```sh
npm install -g ydict.js
```

## Usage

* Search a word under cursor:

    ```vim
    " search a word
    nnoremap <silent> <Leader>d :call YDict([expand('<cword>'), expand('<cWORD>')])<Return>
    ```

* Search a word for your selected text:

    ```vim
    " search a word
    vnoremap <silent> <Leader>d y:<C-U>call YDict(getreg(0))<Return>
    ```

* Configure where results are displayed:

    ```vim
    " create window below current one (default)
    let g:ydict_results_window = 'new'

    " create window beside current one
    let g:ydict_results_window = 'vnew'

    " use current window to show results
    let g:ydict_results_window = 'enew'

    " create panel at left-most edge
    let g:ydict_results_window = 'topleft vnew'

    " create panel at right-most edge
    let g:ydict_results_window = 'botright vnew'

    " create new tab beside current one
    let g:ydict_results_window = 'tabnew'
    ```

## Testing

Developers can run the [vim-spec]( https://github.com/kana/vim-vspec ) tests:

```sh
gem install bundler         # first time
bundle install              # first time
bundle exec vim-flavor test # every time
```

## License

This plugin is inspired by ydict.js <https://github.com/sayuan/ydict.js/>.

The code is copied from vim-dasht <https://github.com/sunaku/vim-dasht>.

Copyright 2018 Sean Lee <https://github.com/weilonge>

Distributed under the same terms as Vim itself.
