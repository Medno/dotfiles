"	SHORTCUTS
""	viw -> select word under cursor
""	yiw -> copy word under cursor
"" :.,2+s/foo/bar/g	-> search foo from the current line -> +2 lines and replace it to bar

syntax on
set cursorline
set showcmd
set statusline="%f%m%r%h%w [%Y] [0x%02.2B]%< %F%=%4v,%4l %3p%% of %L"
set laststatus=2
set smartindent
set ruler
set mouse=a
set backspace=indent,eol,start
set tabstop=4
set shiftwidth=4


if has("multi_byte")
  set encoding=utf-8
  setglobal fileencoding=utf-8
else
  echoerr "Sorry, this version of (g)vim was not compiled with +multi_byte"
endif
set number

