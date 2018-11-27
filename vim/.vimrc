colorscheme default

set nocompatible
filetype off

call plug#begin('~/.vim/plugged')
" langs
Plug 'sheerun/vim-polyglot'

Plug 'othree/xml.vim'
Plug 'jnwhiteh/vim-golang'
Plug 'vim-scripts/py-coverage'

Plug 'majutsushi/tagbar'
Plug 'scrooloose/nerdtree'
Plug 'guns/xterm-color-table.vim'
Plug 'sjl/gundo.vim'

" Git
Plug 'tpope/vim-fugitive'
Plug 'airblade/vim-gitgutter'

Plug 'vim-scripts/DirDiff.vim'
Plug 'ConradIrwin/vim-bracketed-paste'

Plug 'vim-scripts/ingo-library'
Plug 'vim-scripts/SearchHighlighting'
Plug '~/.vim/bundle/mark/'

Plug 'MarcWeber/vim-addon-mw-utils'
Plug 'tomtom/tlib_vim'
Plug 'garbas/vim-snipmate'
Plug 'honza/vim-snippets'

" syntastic
Plug 'scrooloose/syntastic'

" Unite
Plug 'Shougo/unite.vim'
Plug 'Shougo/vimproc.vim'

Plug 'embear/vim-localvimrc'
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
set modeline
set foldmethod=syntax
set nobackup
"set mouse=a
"set ttymouse=xterm2
set switchbuf+=newtab "always open new tab
set scrolloff=3
set showcmd
set diffopt+=vertical
set splitright " Unite split preview to the right
set ttimeoutlen=0 " exit visual/insert mode immediately
set updatetime=500

" Unite
call unite#custom#default_action('jump_list', 'tabopen')
call unite#custom#source('grep/git', 'max_candidates', 0)
call unite#custom#source('grep', 'max_candidates', 0)

nnoremap S :UniteWithCursorWord -no-quit -no-wrap -no-truncate -vertical-preview -hide-source-names -auto-resize -winheight=10 -max-multi-lines=1 grep/git:/:-w<CR>
nnoremap X :UniteWithCursorWord -no-quit -no-wrap -no-truncate -vertical-preview -hide-source-names -auto-resize -winheight=10 -max-multi-lines=1 grep:.:-w<CR>
nnoremap <C-F> :Unite -tab -create -start-insert file_rec/async<CR>

autocmd FileType unite call s:unite_my_settings()
function! s:unite_my_settings()
	nmap <silent><buffer> <C-H> :tabprevious<CR>
	nmap <silent><buffer> <C-L> :tabnext<CR>
	nmap <silent><buffer> <C-D> <Plug>(unite_exit)
	autocmd CursorHold <buffer> nested call unite#view#_do_auto_preview()
endfunction

highlight link uniteStatusNormal StatusLine
highlight link uniteStatusHead StatusLine
highlight link uniteStatusSourceNames StatusLine
highlight link uniteStatusSourceCandidates StatusLine
highlight link uniteStatusMessage StatusLine
highlight link uniteStatusLineNR StatusLine

" syntastic
let g:syntastic_always_populate_loc_list = 1
let g:syntastic_auto_loc_list = 1
let g:syntastic_check_on_open = 1
let g:syntastic_check_on_wq = 0
let g:syntastic_stl_format = '[%E{E:%fe#%e}%B{,}%W{W:%fw#%w}]'
let g:syntastic_python_checkers = ['flake8']

inoremap <C-H> <Esc>:tabprevious<CR>
inoremap <C-L> <Esc>:tabnext<CR>
inoremap <C-D> <Esc>:quit<CR>
inoremap <C-S-T> <Esc>:tabnew 

nnoremap <C-H> :tabprevious<CR>
nnoremap <C-L> :tabnext<CR>

nnoremap <C-D> :quit<CR>
nnoremap <C-S-T> :tabnew 

nnoremap <C-N> :cnext<CR>
nnoremap <C-P> :cprevious<CR>
nnoremap <C-J> :lnext<CR>
nnoremap <C-K> :lprevious<CR>

nnoremap ; :pop<CR>
nnoremap ' :tag<CR>

nnoremap <C-]> g<C-]>

nnoremap <F8> :TagbarToggle<CR>

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

set cinoptions=+0,j1,(1s " C++11 indent

" Auto adjust quickfix/location-list window size
autocmd FileType qf call s:AdjustWindowHeight(2, 5)
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
