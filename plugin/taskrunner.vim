"=============================================================
" file: taskrunner.vim
" author:  dylan araps <dylan.araps at gmail.com>
" license: mit license
"=============================================================

if exists("g:loaded_taskrunner") || !has('nvim')
	finish
endif
let g:loaded_taskrunner = 1

" This command works with all of gulp/grunt's cmdline flags
command! -nargs=* -complete=file Task call taskrunner#RunTask(<q-args>)
