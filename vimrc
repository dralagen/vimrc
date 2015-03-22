set nocompatible

set backspace=indent,eol,start

if has("vms")
	set nobackup		" do not keep a backup file, use versions instead
else
	set backup		" keep a backup file
endif
set history=50		" keep 50 lines of command line history
"set ruler		" show the cursor position all the time
set showcmd		" display incomplete commands
set incsearch		" do incremental searching
"set background=dark
set number
"set smartindent

set backupdir=/tmp
set directory=/tmp

" Don't use Ex mode, use Q for formatting
map Q gq

nnoremap <F12>  :let @/=""<CR>

" CTRL-U in insert mode deletes a lot.  Use CTRL-G u to first break undo,
" so that you can undo CTRL-U after inserting a line break.
inoremap <C-U> <C-G>u<C-U>

" In many terminal emulators the mouse works just fine, thus enable it.
if has('mouse')
	set mouse=a
endif

" Switch syntax highlighting on, when the terminal has colors
" Also switch on highlighting the last used search pattern.
if &t_Co > 2 || has("gui_running")
	syntax on
	set hlsearch
endif

" Only do this part when compiled with support for autocommands.
if has("autocmd")

	" Enable file type detection.
	" Use the default filetype settings, so that mail gets 'tw' set to 72,
	" 'cindent' is on in C files, etc.
	" Also load indent files, to automatically do language-dependent indenting.
	filetype plugin indent on

	" Put these in an autocmd group, so that we can delete them easily.
	augroup vimrcEx
		au!

		" For all text files set 'textwidth' to 78 characters.
		autocmd FileType text setlocal textwidth=78

		" When editing a file, always jump to the last known cursor position.
		" Don't do it when the position is invalid or when inside an event handler
		" (happens when dropping a file on gvim).
		" Also don't do it when the mark is in the first line, that is the default
		" position when opening a file.
		autocmd BufReadPost *
					\ if line("'\"") > 1 && line("'\"") <= line("$") |
					\   exe "normal! g`\"" |
					\ endif

	augroup END

	autocmd FileType tex source ~/.vim/auctex.vim

else

	set autoindent		" always set autoindenting on

endif " has("autocmd")

" Convenient command to see the difference between the current buffer and the
" file it was loaded from, thus the changes you made.
" Only define it when not defined already.
if !exists(":DiffOrig")
	command DiffOrig vert new | set bt=nofile | r ++edit # | 0d_ | diffthis
				\ | wincmd p | diffthis
endif

" et : expendtab : use espace
" noet : use tab
"
" sts : softtabstop
" sw : shiftwidth
" ts : tabstop
set et sts=0 sw=4 ts=4
set cindent
set cinoptions=(0,u0,U0
set cinkeys=0{,0},0),:,0#,!^F,o,O,e,!<Tab>

" delete space end line
autocmd BufWritePre * silent! %s/\s*$//i|norm!``
" delete space begin file
autocmd BufWritePre * silent! %s/\%^\n*//i|norm!``
" just one end line
autocmd BufWritePre * silent! %s/\n*\%$/\r/i|norm!``

nnoremap <F8> :make -j$NBCORECPU<cr>
nnoremap <F9> :make mrproper && make -j$NBCORECPU<cr>

colorscheme desert

" Wildmenu
if has("wildmenu")
	set wildignore+=*.a,*.o
	set wildignore+=*.bmp,*.gif,*.ico,*.jpg,*.png
	set wildignore+=.DS_Store,.git,.hg,.svn
	set wildignore+=*~,*.swp,*.tmp
	set wildmenu
	set wildmode=longest,list
endif

imap <C-w>j <C-o><C-w>j
imap <C-w>k <C-o><C-w>k
imap <C-w>l <C-o><C-w>l
imap <C-w>h <C-o><C-w>h

let Tlist_GainFocus_On_ToggleOpen = 1
let Tlist_Close_On_Select = 1
nnoremap <C-l> :TlistToggle<CR>

map <PageDown> :set scroll=0<CR>:set scroll^=2<CR>:set scroll-=1<CR><C-D>:set scroll=0<CR>
map <PageUp> :set scroll=0<CR>:set scroll^=2<CR>:set scroll-=1<CR><C-U>:set scroll=0<CR>
nnoremap <silent> <PageUp> <C-U><C-U>
vnoremap <silent> <PageUp> <C-U><C-U>
inoremap <silent> <PageUp> <C-\><C-O><C-U><C-\><C-O><C-U>
nnoremap <silent> <PageDown> <C-D><C-D>
vnoremap <silent> <PageDown> <C-D><C-D>
inoremap <silent> <PageDown> <C-\><C-O><C-D><C-\><C-O><C-D>

" reindent all file
nmap <Leader>ri gg=G``
vmap <Leader>ri =
" max double \n
nmap <Leader>dl :%s/\_^\n\{2,\}/\r/ie<CR>
nmap <Leader>uf :call g:ClangUpdateQuickFix()<CR>
nmap <Leader>tr :NERDTreeToggle<CR>

let g:DoxygenToolkit_authorName 	= "Dralagen"

" TABS "
" ---------------------------------

" CREATE A NEW TAB
map <LocalLeader>tc :tabnew<CR>
nnoremap <C-W><C-k> :tabnew<CR>
inoremap <C-W><C-k> <c-o>:tabnew<CR>

" LAST TAB
map <LocalLeader>t<Space> :tablast<CR>

" CLOSE A TAB
map <LocalLeader>tk :tabclose<CR>
nnoremap <C-W><C-j> :tabclose<CR>
inoremap <C-W><C-j> <c-o>:tabclose<CR>

" NEXT TAB
map <LocalLeader>tn :tabnext<CR>
nnoremap <C-W><C-l> :tabnext<CR>
inoremap <C-W><C-l> <c-o>:tabnext<CR>

" PREVIOUS TAB
map <LocalLeader>tp :tabprev<CR>
nnoremap <C-W><C-h> :tabprev<CR>
inoremap <C-W><C-h> <c-o>:tabprev<CR>

