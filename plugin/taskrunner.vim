" gulp.nvim
" by Dylan Araps

if exists("g:loaded_taskrunner")
	finish
endif

let g:loaded_taskrunner = 1

if !exists("g:taskrunner")
	let g:taskrunner = "gulp"
endif

if !exists("g:taskrunner#split")
	let g:taskrunner#split = "10new"
endif

if !exists("g:taskrunner#split_direction")
	let g:taskrunner#split_direction == "splitbelow splitright"
endif

" Find Taskrunner {{{

function! FindTaskRunner()
	if !empty(glob("gulpfile.js")) || !empty(glob("gulpfile.coffee"))
		let g:taskrunner = "gulp"

	elseif !empty(glob("gruntfile.js")) || !empty(glob("gruntfile.coffee"))
		let g:taskrunner = "grunt"

	else
		let g:taskrunner = "none"

	endif
endfunction

" }}}

" RunTask {{{

function! RunTask(command)
	if has('nvim')
		call FindTaskRunner()

		if g:taskrunner == "none"
			echom "No taskrunner file found"
			echom "You can also point to the file like so :Task --gulpfile path/to/gulpfile.js task"

		else
			execute setlocal g:taskrunner#split_direction
			execute g:taskrunner#split
			call termopen(g:taskrunner . " " . a:command)
			wincmd w

		endif
	else
		echom "taskrunner.nvim only works with neovim"
	endif
endfunction

" }}}

" This command works with all of gulp/grunt's cmdline flags
command! -nargs=* -complete=file Task call RunTask(<q-args>)