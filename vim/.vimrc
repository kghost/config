colorscheme default
set background=light

set nocompatible
filetype off

call plug#begin('~/.vim/plugged')
" langs
Plug 'sheerun/vim-polyglot'

Plug 'othree/xml.vim'
Plug 'jnwhiteh/vim-golang'
Plug 'vim-scripts/py-coverage'
Plug 'fatih/vim-go', { 'do': ':GoUpdateBinaries' }

Plug 'majutsushi/tagbar'
Plug 'scrooloose/nerdtree'
Plug 'guns/xterm-color-table.vim'
Plug 'mbbill/undotree'
"Plug 'sjl/gundo.vim'

Plug 'google/vim-maktaba'
Plug 'bazelbuild/vim-bazel'

" Git
Plug 'tpope/vim-fugitive'
Plug 'airblade/vim-gitgutter'
Plug 'knsh14/vim-github-link'

Plug 'will133/vim-dirdiff'
Plug 'ConradIrwin/vim-bracketed-paste'

Plug 'vim-scripts/ingo-library'
Plug 'vim-scripts/SearchHighlighting'
Plug '~/.vim/bundle/mark/'

Plug 'MarcWeber/vim-addon-mw-utils'
Plug 'tomtom/tlib_vim'
Plug 'garbas/vim-snipmate'
Plug 'honza/vim-snippets'

"
Plug 'tpope/vim-dispatch'

" syntastic
Plug 'scrooloose/syntastic'

" Denite
Plug 'roxma/vim-hug-neovim-rpc'
Plug 'roxma/nvim-yarp'
Plug 'Shougo/denite.nvim'
Plug 'kghost/denite-grep-git'
Plug 'kghost/denite-filter-equal'

Plug 'embear/vim-localvimrc'

Plug 'MattesGroeger/vim-bookmarks'

call plug#end()

if has("win32")
	source $VIMRUNTIME/vimrc_example.vim
	source $VIMRUNTIME/mswin.vim
	behave mswin

	set diffexpr=MyDiff()
	function MyDiff()
		let opt = '-a --binary '
		if &diffopt =~ 'icase' | let opt = opt . '-i ' | endif
		if &diffopt =~ 'iwhite' | let opt = opt . '-b ' | endif
		let arg1 = v:fname_in
		if arg1 =~ ' ' | let arg1 = '"' . arg1 . '"' | endif
		let arg2 = v:fname_new
		if arg2 =~ ' ' | let arg2 = '"' . arg2 . '"' | endif
		let arg3 = v:fname_out
		if arg3 =~ ' ' | let arg3 = '"' . arg3 . '"' | endif
		let eq = ''
		if $VIMRUNTIME =~ ' '
			if &sh =~ '\<cmd'
				let cmd = '""' . $VIMRUNTIME . '\diff"'
				let eq = '"'
			else
				let cmd = substitute($VIMRUNTIME, ' ', '" ', '') . '\diff"'
			endif
		else
			let cmd = $VIMRUNTIME . '\diff'
		endif
		silent execute '!' . cmd . ' ' . opt . arg1 . ' ' . arg2 . ' > ' . arg3 . eq
	endfunction
else
	set grepprg=grep\ -nH\ $*
	let g:tex_flavor='latex'
endif

filetype plugin indent on
syntax on
set number
set autoread
set directory-=. " don't create .swp in current dir
set spell
set spelllang=en
set hlsearch
set showmatch
set incsearch
set autoindent
set history=1000
set cursorline
if has("unnamedplus")
  set clipboard=unnamedplus
elseif has("clipboard")
  set clipboard=unnamed
endif

set list listchars=tab:▸\ ,trail:·
set shiftwidth=4
set tabstop=4
set softtabstop=4
set expandtab
set modeline
"set foldmethod=syntax
"set foldlevel=999
set nobackup
"set mouse=a
"set ttymouse=xterm2
set switchbuf=useopen
set scrolloff=3
set showcmd
set diffopt+=vertical
set splitright " Unite split preview to the right
set ttimeoutlen=0 " exit visual/insert mode immediately
set updatetime=500
set matchpairs+=<:>

" Denite
autocmd VimEnter * if !exists('t:denite_buffer_name') | let t:denite_buffer_name = localtime() | endif
autocmd TabNew * if !exists('t:denite_buffer_name') | let t:denite_buffer_name = localtime() | endif

call denite#custom#source('grep/git', 'sorters', [''])
call denite#custom#source('grep', 'sorters', [''])
call denite#custom#source('tag', 'sorters', [''])
call denite#custom#source('tag', 'matchers', ['matcher/equal'])
call denite#custom#option('_', 'vertical_preview', v:true)
call denite#custom#option('_', 'source_names', 'short')
call denite#custom#option('_', 'auto_resize', v:true)
call denite#custom#option('_', 'winheight', 10)
call denite#custom#option('_', 'auto_action', 'preview')
call denite#custom#option('_', 'default_action', 'tabopen')

nnoremap <expr> S ':DeniteCursorWord -buffer-name='.expand(t:denite_buffer_name).' grep/git::-w<CR>'
nnoremap <expr> F ':Denite -buffer-name='.expand(t:denite_buffer_name).' grep/git::-w<CR>'
nnoremap <expr> X ':DeniteCursorWord -buffer-name='.expand(t:denite_buffer_name).' grep::-w<CR>'
nnoremap <expr> <C-I> ':DeniteCursorWord -buffer-name='.expand(t:denite_buffer_name).' -immediately-1 tag<CR>'
nnoremap <expr> <C-O> ':Denite -buffer-name='.expand(t:denite_buffer_name).' outline<CR>'
nnoremap <C-F> :Denite -split=tab -start-filter file/rec<CR>

autocmd FileType denite call s:denite_my_settings()
function! s:denite_my_settings()
	autocmd BufLeave <buffer> pclose
	nnoremap <silent><buffer><expr> <CR> denite#do_map('do_action')
	nnoremap <silent><buffer><expr> <C-D> denite#do_map('quit')
endfunction

let g:go_def_mapping_enabled = 0

" syntastic
let g:syntastic_mode_map = { 'mode': 'passive' }

let g:syntastic_always_populate_loc_list = 1
let g:syntastic_auto_loc_list = 1
let g:syntastic_check_on_open = 1
let g:syntastic_check_on_wq = 1
let g:syntastic_stl_format = '[%E{E:%fe#%e}%B{,}%W{W:%fw#%w}]'
let g:syntastic_python_checkers = ['flake8']
let g:syntastic_yaml_checkers = ['yamllint']
let g:syntastic_cpp_cpplint_exec = "cpplint"
let g:syntastic_cpp_checkers = ['cpplint']

inoremap <C-H> <Esc>:tabprevious<CR>
inoremap <C-L> <Esc>:tabnext<CR>
inoremap <C-D> <Esc>:quit<CR>
inoremap <C-T> <Esc>:tabnew 

nnoremap <C-H> :tabprevious<CR>
nnoremap <C-L> :tabnext<CR>

nnoremap <C-D> :quit<CR>
nnoremap <C-T> :tabnew 

nnoremap <C-N> :cnext<CR>
nnoremap <C-P> :cprevious<CR>
nnoremap <C-J> :lnext<CR>
nnoremap <C-K> :lprevious<CR>

nnoremap ; :pop<CR>
nnoremap ' :tag<CR>

" nnoremap <C-]> g<C-]>

nnoremap <F6> :NERDTreeToggle<CR>
nnoremap <F7> :vertical Gstatus<CR>

autocmd FileType fugitive call s:fugitive_settings()
function! s:fugitive_settings()
       vertical resize 30
       set nowrap
       set winfixwidth
       set nonumber
endfunction

nnoremap <F8> :TagbarToggle<CR>
nnoremap <F9> :w<CR>:Make<CR>
nnoremap <F10> :SyntasticCheck<CR>
nnoremap <C-U> :UndotreeToggle<CR>

" disable mark mappings
nnoremap <Plug>IgnoreMarkSearchNext <Plug>MarkSearchNext
nnoremap <Plug>IgnoreMarkSearchPrev <Plug>MarkSearchPrev
nnoremap <Plug>IgnoreMarkSearchCurrentNext <Plug>MarkSearchCurrentNext
nnoremap <Plug>IgnoreMarkSearchCurrentPrev <Plug>MarkSearchCurrentPrev

let &t_SI = "\<Esc>[6 q"
let &t_SR = "\<Esc>[4 q"
let &t_EI = "\<Esc>[2 q"

if has("win32")
else
	cmap w!! w !sudo tee >/dev/null %
endif

set guioptions-=m  "remove menu bar
set guioptions-=T  "remove toolbar
set guioptions-=r  "remove right-hand scroll bar
set guioptions-=L  "remove right-hand scroll bar

set laststatus=2
if has("statusline")
	set statusline=%f
	set statusline+=[
	set statusline+=%M%R%W
	set statusline+=%{(&paste?',P':'')}
	set statusline+=]
	set statusline+=%<
	set statusline+=%=
	set statusline+=[%-8.8(%{getreg('\"')[:7]}%)]
	set statusline+=%(\ %{fugitive#statusline()}%)
	set statusline+=\ (%04B)
	set statusline+=%(\ [%{&fenc!='utf-8'?&fenc:''}%{&bomb?',B':''}%{&ff=='unix'?'':(','.&ff)}%Y]%)
	" syntastic
	set statusline+=%(\ %{SyntasticStatuslineFlag()}%)
	set statusline+=\ %l/%L,%c%V
	set statusline+=\ %P

	function! InsertStatuslineColor(mode)
		if a:mode == 'i'
			highlight statusline ctermfg=blue
		elseif a:mode == 'r'
			highlight statusline ctermfg=red
		else
			highlight statusline ctermfg=magenta
		endif
	endfunction

	autocmd InsertEnter * call InsertStatuslineColor(v:insertmode)
	autocmd InsertChange * call InsertStatuslineColor(v:insertmode)
	autocmd InsertLeave * highlight statusline ctermfg=None
endif

set cinoptions=+0,j1,(1s,t0,N-s,g0,h4

" Auto adjust quickfix/location-list window size
autocmd FileType qf call s:AdjustWindowHeight(3, 15)
function s:AdjustWindowHeight(minheight, maxheight)
  exe max([min([line("$"), a:maxheight]), a:minheight]) . "wincmd _"
endfunction

autocmd FileType ruby setl expandtab shiftwidth=2
autocmd FileType coffee setl expandtab shiftwidth=2
autocmd BufNewFile,BufReadPost *.py setl shiftwidth=4 tabstop=4 foldmethod=indent expandtab colorcolumn=80
autocmd BufNewFile,BufReadPost *.py PyCoverageHighlight

" Nerdtree
let NERDTreeShowBookmarks=1
let NERDTreeChDirMode=0
let NERDTreeQuitOnOpen=0
let NERDTreeMouseMode=2
let NERDTreeShowHidden=1
let NERDTreeIgnore=['\.pyc','\~$','\.swo$','\.swp$','\.git','\.hg','\.svn','\.bzr', '\.o', '\.lo']

if $TERM == "xterm" || $TERM == "screen"
	set t_Co=256
endif

highlight Search ctermbg=227

highlight clear SpellBad
highlight clear SpellCap
highlight clear SpellLocal
highlight clear SpellRare
highlight SpellBad   cterm=underline gui=undercurl guisp=Red
highlight SpellRare  cterm=underline gui=undercurl guisp=Magenta
highlight SpellCap   cterm=underline gui=undercurl guisp=Blue
highlight SpellLocal cterm=underline gui=undercurl guisp=DarkCyan

highlight ColorColumn ctermbg=lightgrey

highlight DiffAdd    ctermbg=224
highlight DiffDelete ctermbg=224
highlight DiffChange ctermbg=224
highlight DiffText   ctermbg=218

highlight LineNr ctermbg=254
highlight CursorLineNr cterm=undercurl ctermbg=249 gui=undercurl
highlight PyCoverageMissed ctermbg=227
