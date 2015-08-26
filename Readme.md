# taskrunner.nvim

taskrunner is a simple plugin for Neovim that adds a :Task cmd that runs gulp/grunt in a terminal split.

The plugin by default will look for your gulp/gruntfile in your current working directory. If no taskrunner file is found it'll look up a directory 5 times. If you don't like/want this to happen, there's an option below to look through more directories and to disable this.

The plugin only works with Neovim because it makes use of neovim's built in terminal splits to create the taskrunner split. If installed in regular vim the plugin won't do anything.

![Gulp](https://raw.githubusercontent.com/dylanaraps/taskrunner.nvim/master/screenshots/gulp.png)

## Installation

Use your favorite plugin manager.

- [vim-plug](https://github.com/junegunn/vim-plug)
  1. Add `Plug 'dylanaraps/taskrunner.nvim'` to your .nvimrc
  2. Run `:PlugInstall`

## Options

### :Task
```vimL
	" Command Example
	" The command on it's own will look in the open file's current working directory.
	" If left blank the command will use the 'default' task.
	:Task taskname

	" More Command Examples:
	" You can also use all of gulp/grunt's cmdline flags!
	:Task --gulpfile ~/projects/gulpfile.coffee coffeescript
	:Task --cwd ~/projects/startpage/
	:Task --no-color
```

### Number of directories to go up
The plugin by default will look up 5 directories from the open file's location to locate a gulp/gruntfile.

```vimL
	" Change directories to go up

	" Look up 5 directories if file isn't found in :pwd
	let g:taskrunner#dirs_to_go_up = 5

	" You can disable this behavior by changing the value to a "1" or a "0"
	let g:taskrunner#dirs_to_go_up = 1

```

### Manually set task runner

```vimL
	" Manually set taskrunner
	let g:taskrunner = "gulp"
```

### Size of the split
Default: `let g:taskrunner#split = "10new"`

```vimL
	" taskrunner split size/position

	" Opens a horizontal split that is 10 high
	let g:taskrunner#split = "10new"

	" Opens a vertical split that is 30 wide
	let g:taskrunner#split = "30vnew"
```

### Split Direction
Default: `let g:taskrunner#split_direction = "splitbelow splitright"`

```vimL
	" Split Direction

	" Sets split to open to the bottom and right
	let g:taskrunner#split_direction = "splitbelow splitright"

	" left/top
	let g:taskrunner#split_direction = "nosplitbelow nosplitright"

	" top
	let g:taskrunner#split_direction = "nosplitbelow"

	" top/right
	let g:taskrunner#split_direction = "nosplitbelow splitright"

```

### Unlisted
Default: `let g:taskrunner#unlisted = 1`

```vimL
	" Hide the buffer from the buffer list.
	let g:taskrunner#unlisted = 1
```

### Focus On Open
Default: `let g:taskrunner#focus_on_open = 0`

```vimL
	" Focus on open
	let g:taskrunner#focus_on_open = 1
```
