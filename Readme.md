# taskrunner.nvim

taskrunner is a simple plugin for Neovim that adds a :Task cmd that runs gulp/grunt in a terminal split. It supports gulp/grunt's cmdline flags:

The plugin works best with [Vim-rooter](https://github.com/airblade/vim-rooter) which sets the current working directory of the files you open to the nearest .git folder. You can also configure Vim-Rooter to set your working directory to the nearest gulp/gruntfile!

The plugin only works with Neovim because it makes use of neovim's built in terminal splits to create the taskrunner split.

![Gulp](https://raw.githubusercontent.com/dylanaraps/taskrunner.nvim/master/screenshots/gulp.png)

## Installation

Use your favorite plugin manager.

- [vim-plug](https://github.com/junegunn/vim-plug)
  1. Add `Plug 'dylanaraps/taskrunner.nvim'` to your .nvimrc
  2. Run `:PlugInstall`

## Options

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

The plugin will try and find out whether or not you're using gulp/grunt by checking to see if a taskfile exists in your :pwd. If the plugin fails you can manually set it by adding this to your .nvimrc.

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
Default: `let g:taskrunner#focus_on_open = 1`

```vimL
	" Focus on open
	let g:taskrunner#focus_on_open = 1
```
