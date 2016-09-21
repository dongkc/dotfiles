function! NERDTree_Start()
  exe 'q'
  exe 'NERDTree'
endfunction

function! NERDTree_IsValid()
  return 1
endfunction

noremap <f5> :NERDTreeFind<cr>

let g:NERDTree_title = "[NERDTree]"

" Make nerdtree look nice
let NERDTreeMinimalUI = 1
let NERDTreeDirArrows = 1
let g:NERDTreeWinSize = 30
