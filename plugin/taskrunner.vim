" taskrunner.nvim
" by Dylan Araps

if exists("g:loaded_taskrunner")
	finish
endif

let g:loaded_taskrunner = 1

if !exists("g:taskrunner")
	let g:taskrunner = " "
endif

if !exists("g:taskrunner#cmd")
	let g:taskrunner#cmd = "default"
endif

if !exists("g:taskrunner#filelist")
	let g:taskrunner#filelist = ['gulpfile.js', 'gulpfile.coffee', 'gruntfile.js', 'gruntfile.coffee']
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

function! FindTaskRunner()
	lcd %:p:h

	" Searches using the above list for a task file and goes up a directory
	" if it fails to find anything.
	for taskrunnerfile in g:taskrunner#filelist
		let taskrunner = findfile(taskrunnerfile, ".;")

		if taskrunner != ""
			break
		endif
	endfor

	" findfile() returns the full path, this line uses a regexp to cut away
	" the path and only show the file name.
	let taskfile = matchstr(taskrunner, '\(gulp\|grunt\)file\.\(js\|coffee\)')

	if taskfile == "gulpfile.js" || taskfile == "gulpfile.coffee"
		let g:taskrunner = "gulp"
	elseif taskfile == "gruntfile.js" || taskfile == "gruntfile.coffee"
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
			execute "setlocal" . " " . g:taskrunner#split_direction
			execute g:taskrunner#split

			if g:taskrunner#cmd == "default"
				call termopen(g:taskrunner . " " . a:command)
			else
				call termopen(g:taskrunner#cmd . " " . a:command)
			endif

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