" All system-wide defaults are set in $VIMRUNTIME/debian.vim (usually just
" /usr/share/vim/vimcurrent/debian.vim) and sourced by the call to :runtime
" you can find below.  If you wish to change any of those settings, you should
" do it in this file (/etc/vim/vimrc), since debian.vim will be overwritten
" everytime an upgrade of the vim packages is performed.  It is recommended to
" make changes after sourcing debian.vim since it alters the value of the
" 'compatible' option.

" This line should not be removed as it ensures that various options are
" properly set to work with the Vim-related packages available in Debian.
runtime! debian.vim

" Uncomment the next line to make Vim more Vi-compatible
" NOTE: debian.vim sets 'nocompatible'.  Setting 'compatible' changes numerous
" options, so any other options should be set AFTER setting 'compatible'.
"set compatible

" Vim5 and later versions support syntax highlighting. Uncommenting the next
" line enables syntax highlighting by default.
if has("syntax")
  syntax on
endif

" If using a dark background within the editing area and syntax highlighting
" turn on this option as well
"set background=dark

" Uncomment the following to have Vim jump to the last position when
" reopening a file
"if has("autocmd")
"  au BufReadPost * if line("'\"") > 1 && line("'\"") <= line("$") | exe "normal! g'\"" | endif
"endif

" Uncomment the following to have Vim load indentation rules and plugins
" according to the detected filetype.
"if has("autocmd")
execute pathogen#infect()
filetype plugin indent on
"endif

" The following are commented out as they cause vim to behave a lot
" differently from regular Vi. They are highly recommended though.
"set showcmd		" Show (partial) command in status line.
"set showmatch		" Show matching brackets.
"set ignorecase		" Do case insensitive matching
"set smartcase		" Do smart case matching
"set incsearch		" Incremental search
"set autowrite		" Automatically save before commands like :next and :make
"set hidden             " Hide buffers when they are abandoned
"set mouse=a		" Enable mouse usage (all modes)

" Source a global configuration file if available
if filereadable("/etc/vim/vimrc.local")
  source /etc/vim/vimrc.local
endif

"****************************************
        "taglist config
"****************************************
if getfsize(".vimscript")>0
    source .vimscript
endif

"let Tlist_Exit_OnlyWindow=1
"let Tlist_Auto_Open=1
"let Tlist_File_Fold_Auto_Close=1

"****************************************
        "cscope config
"****************************************
nmap <F5>g :cs find g <C-R>=expand("<cword>")<CR><CR>
nmap <F5>s :cs find s <C-R>=expand("<cword>")<CR><CR>
nmap <F5>d :cs find d <C-R>=expand("<cword>")<CR><CR>
nmap <F5>c :cs find c <C-R>=expand("<cword>")<CR><CR>
nmap <F5>t :cs find t <C-R>=expand("<cword>")<CR><CR>
nmap <F5>f :cs find f <C-R>=expand("<cfile>")<CR><CR>
nmap <F5>I :cs find i <C-R>=expand("<cfile>")<CR><CR>
map <C-F12> :!ctags -R --c++-kinds=+p --fields=+iaS --extra=+q .<CR><CR>

"****************************************
        "NERDTREE config"
"****************************************
autocmd vimenter * NERDTree
wincmd w
autocmd vimenter * wincmd w
autocmd bufenter * if (winnr("$") == 1 && exists("b:NERDTree") && b:NERDTree.isTabTree()) | q | endif

" Highlight current line
"au WinLeave * set nocursorline nocursorcolumn
"au WinEnter * set cursorline cursorcolumn
"set cursorline cursorcolumn

"****************************************
        "powerline settings
"****************************************
"set guifont=PowerlineSymbols\ for\ Powerline
"set nocompatible
"set laststatus=2
"set t_Co=256
"let g:Powerline_symbols = 'fancy'
"let Powerline_symbols='compatible'

"****************************************
        "airline settings
"****************************************
let g:airline_theme="hybridline"
set laststatus=2
set t_Co=256
let g:airline#extensions#tabline#enabled = 1
let g:airline#extensions#tabline#left_sep = ' '
let g:airline#extensions#tabline#left_alt_sep = '|'
let g:airline#extensions#tabline#buffer_nr_show = 1
nnoremap <C-TAB> :bn<CR>
nnoremap <C-S-TAB> :bp<CR>
" unicode symbols
let g:airline_left_sep = '»'
let g:airline_left_sep = '▶'
let g:airline_right_sep = '«'
let g:airline_right_sep = '◀'
let g:airline_symbols_branch = '⎇'

"****************************************
        "vim-fugitive config"
"****************************************
"set laststatus=2 " Always display the status line
"set statusline+=%{fugitive#statusline()} "  Git Hotness

"****************************************
        "tagbar settings
"****************************************
let g:tagbar_width=35
let g:tagbar_autofocus=1
nmap <F6> :TagbarToggle<CR>

"****************************************
        "ctrlp settings:
"****************************************
let g:ctrlp_map = '<c-p>'
let g:ctrlp_cmd = 'CtrlP'
let g:ctrlp_working_path_mode = 'ra'

let g:ctrlp_custom_ignore = '\v[\/]\.(git|hg|svn)$'
let g:ctrlp_user_command = 'find %s -type f'        " MacOSX/Linux

set wildignore+=*/tmp/*,*.so,*.swp,*.zip     " MacOSX/Linux
set wildignore+=*/.git/*,*/.hg/*,*/.svn/*,*/.idea/*,*/.DS_Store,*/vendor

let g:ag_working_path_mode="r"

set nu
set hlsearch
set noautoindent
set ruler
syntax enable
syntax on

"set background=light
"colorscheme solarized
colorscheme delek 

set shiftwidth=2
set softtabstop=2
set tabstop=2
set cindent
set expandtab
set autochdir
set showcmd
set smartcase
set smartindent
set pastetoggle=<F12>
let g:indentLine_char = '︙'
set tags=./tags,tags;
set runtimepath^=~/.vim/bundle/ag
set complete=.,w,b,u,t
