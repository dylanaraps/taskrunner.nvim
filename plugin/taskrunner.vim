" gulp.nvim
" by Dylan Araps

if exists("g:loaded_taskrunner")
	finish
endif

let g:loaded_taskrunner = 1

if !exists("g:taskrunner")
	let g:taskrunner = "gulp"
endif

if !exists("g:taskrunner#auto")
	let g:taskrunner#auto = 1
endif

if !exists("g:taskrunner#dirs_to_go_up")
	let g:taskrunner#dirs_to_go_up = 5
endif

if !exists("g:taskrunner#split")
	let g:taskrunner#split = "10new"
endif

if !exists("g:taskrunner#split_direction")
	let g:taskrunner#split_direction = "splitbelow splitright"
endif

if !exists("g:taskrunner#unlisted")
	let g:taskrunner#unlisted = 1
endif

if !exists("g:taskrunner#focus_on_open")
	let g:taskrunner#focus_on_open = 0
endif

" Find Taskrunner {{{

" Looks for a taskrunner in the current file's directory.
" if no task file is found it then checks up a directory for a task file.
function! SearchDir()
	if g:taskrunner#auto == 1
		if !empty(glob("gulpfile.js")) || !empty(glob("gulpfile.coffee"))
			let g:taskrunner = "gulp"

		elseif !empty(glob("gruntfile.js")) || !empty(glob("gruntfile.coffee"))
			let g:taskrunner = "grunt"

		else
			lcd ..
			let g:taskrunner = "none"

		endif

	elseif g:taskrunner#auto == 0 && g:taskrunner == "gulp"
		if !empty(glob("gulpfile.js")) || !empty(glob("gulpfile.coffee"))
			let g:taskrunner = "gulp"

		else
			lcd ..
			let g:taskrunner = "none"

		endif

	elseif g:taskrunner#auto == 0 && g:taskrunner == "grunt"
		elseif !empty(glob("gruntfile.js")) || !empty(glob("gruntfile.coffee"))
			let g:taskrunner = "grunt"

		else
			lcd ..
			let g:taskrunner = "none"

		endif
endfunction

function! FindTaskRunner()
	" Go up directories if no task file found
	for i in range(1,g:taskrunner#dirs_to_go_up)
		call SearchDir()
	endfor
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
			execute "setlocal" . " " . g:taskrunner#split_direction
			execute g:taskrunner#split
			call termopen(g:taskrunner . " " . a:command)

			if g:taskrunner#unlisted == 1
				setlocal nobuflisted
			endif

			if g:taskrunner#focus_on_open == 0
				wincmd w
			endif

		endif
	else
		echom "taskrunner.nvim only works with neovim"
	endif
endfunction

" }}}

" This command works with all of gulp/grunt's cmdline flags
command! -nargs=* -complete=file Task call RunTask(<q-args>)