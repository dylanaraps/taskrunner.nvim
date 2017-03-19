"=============================================================
" file: taskrunner.vim
" author:  dylan araps <dylan.araps at gmail.com>
" license: mit license
"=============================================================

let g:taskrunner = get(g:, 'taskrunner', ' ')
let g:taskrunner#cmd = get(g:, 'taskrunner#cmd', 'default')
let g:taskrunner#split = get(g:, 'taskrunner#split', '10new')
let g:taskrunner#split_direction = get(g:, 'taskrunner#split_direction', 'splitbelow splitright')
let g:taskrunner#unlisted = get(g:, 'taskrunner#unlisted', 1)
let g:taskrunner#focus_on_open = get(g:, 'taskrunner#focus_on_open', 0)
let g:taskrunner#filelist = get(g:, 'taskrunner#filelist', ['gulpfile.js', 'gulpfile.coffee', 'gruntfile.js', 'gruntfile.coffee'])

" Find Taskrunner {{{

function! taskrunner#FindTaskRunner()
	lcd %:p:h

	" Searches using the above list for a task file and goes up a directory
	" if it fails to find anything.
	for l:taskrunnerfile in g:taskrunner#filelist
		let l:taskrunner = findfile(l:taskrunnerfile, '.;')

		if l:taskrunner !=? ''
			break
		endif
	endfor

	" findfile() returns the full path, this line uses a regexp to cut away
	" the path and only show the file name.
	let l:taskfile = matchstr(l:taskrunner, '\(gulp\|grunt\)file\.\(js\|coffee\)')

	if l:taskfile ==? 'gulpfile.js' || l:taskfile ==? 'gulpfile.coffee'
		let g:taskrunner = 'gulp'
	elseif l:taskfile ==? 'gruntfile.js' || l:taskfile ==? 'gruntfile.coffee'
		let g:taskrunner = 'grunt'
	else
		let g:taskrunner = 'none'
	endif
endfunction

" }}}

" RunTask {{{

function! taskrunner#RunTask(command)
    call taskrunner#FindTaskRunner()

    if g:taskrunner ==? 'none'
        echom 'No taskrunner file found'
        echom 'You can also point to the file like so :Task --gulpfile path/to/gulpfile.js task'
    else
        execute 'setlocal' . ' ' . g:taskrunner#split_direction
        execute g:taskrunner#split

        if g:taskrunner#cmd ==? 'default'
            call termopen(g:taskrunner . ' ' . a:command)
        else
            call termopen(g:taskrunner#cmd . ' ' . a:command)
        endif

        if g:taskrunner#unlisted == 1
            setlocal nobuflisted
        endif

        if g:taskrunner#focus_on_open == 0
            wincmd w
        endif
    endif
endfunction

" }}}
