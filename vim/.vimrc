" Pathogen load
runtime bundle/vim-pathogen/autoload/pathogen.vim
filetype off
call pathogen#infect()
call pathogen#helptags()
filetype plugin indent on
syntax on

set nocompatible
let mapleader=","

set t_Co=256

set shiftround
set ts=4 sw=4 et
set tw=72
set formatoptions=croqn
set wildmode=longest,list,full
    
set ignorecase smartcase
set wrap
    
" when jumping to next quickfix, don't change the file in the current
" window
set switchbuf=useopen,split

runtime! macros/matchit.vim

noremap <C-j> <C-w>j
noremap <C-k> <C-w>k
noremap <C-l> <C-w>l
noremap <C-h> <C-w>h
noremap <C-_> <C-w>_

map \x o-------------------------<CR><ESC>:r !date<CR>o<CR>

" ----------------------------------
" zap trailing whitespace
map <leader>z :%s/  *$//<ENTER>:w<ENTER>

" ----------------------------------
" git commit diff view
" http://twitter.com/bitprophet/status/249912652921466880
map ,cd :vsplit DIFF<ENTER>:setlocal bt=nofile ft=diff<ENTER>:r !git diff --cached<ENTER><C-w>wgg
map <leader>d :!git diff<SPACE>
map <leader>s :!git status<ENTER>
map <leader>ga :!git add %
  
" ----------------------------------
" http://learnvimscriptthehardway.stevelosh.com/chapters/07.html
nnoremap <leader>ev :split $MYVIMRC<cr>
nnoremap <leader>sv :source $MYVIMRC<cr>
    
" ----------------------------------
" https://github.com/SirVer/ultisnips
let g:ultisnips_python_style='none'
    
" ----------------------------------
" https://github.com/scrooloose/syntastic.git
"let g:syntastic_python_checkers=['pylint', 'pyflakes']
let g:syntastic_python_checkers=['pyflakes']
let g:syntastic_html_checkers=['validator', 'w3']
    
" ----------------------------------
" https://github.com/reinh/vim-makegreen
let g:makegreen_stay_on_file=1

" ----------------------------------
" https://github.com/janko-m/vim-test
nmap <silent> <leader>m :TestNearest<CR>
nmap <silent> <leader>t :TestFile<CR>
nmap <silent> <leader>a :TestSuite<CR>
nmap <silent> <leader>g :TestLast<CR>
"nmap <silent> <leader>g :TestVisit<CR>
let g:test#preserve_screen = 1
function MakeGreenStrategy(cmd) abort
    call MakeGreen(join(split(a:cmd)[1:]))
endfunction
let g:test#custom_strategies = {'makegreen': function('MakeGreenStrategy')}
let g:test#strategy = 'makegreen'

" ----------------------------------
" https://github.com/milkypostman/vim-togglelist.git
let g:toggle_list_no_mappings = 1
nnoremap <script> <silent> <leader>l :call ToggleLocationList()<CR>
nnoremap <script> <silent> <leader>q :call ToggleQuickfixList()<CR>
