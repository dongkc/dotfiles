" jump backwards to the function name
if exists("loaded_backname")
    finish
endif
let loaded_backname = 1

fun Backname()
    let s:num = search('^\h\w\+.*[^0-9A-Za-z_\x20\t:*]', 'b')
    let s:num = search('\h\w\+\s*[^0-9A-Za-z_\x20\t:*]', 'c') 
endfun

nmap <Leader>b :call Backname()<CR>
