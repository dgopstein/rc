"execute pathogen#infect()

set ignorecase
set smartcase
set incsearch
set nu
set ai                  " auto indenting
syntax on               " syntax highlighting
filetype plugin on      " use the file type plugins
set ruler               " show the cursor position

set tabstop=2
set shiftwidth=2
set expandtab

"colorscheme grb256

" Rainbow parens for clojure
"au BufEnter *.clj RainbowParenthesesActivate
"au Syntax clojure RainbowParenthesesLoadRound
"au Syntax clojure RainbowParenthesesLoadSquare
"au Syntax clojure RainbowParenthesesLoadBraces

"map <C-A> :w

autocmd BufNewFile,BufReadPost *.md set filetype=markdown

" Don't delay ctrl-c in sql mode
let g:ftplugin_sql_omni_key = '<C-j>'
