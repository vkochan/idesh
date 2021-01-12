function Idesh_open()
    let l:erridx = getqflist({'idx' : 0 }).idx
    let l:lnum = get(getqflist(), l:erridx - 1).lnum
    call system(printf("idesh wm open %s %d", expand('%:p'), l:lnum))
    bd
endfunction

function Idesh_qfix()
    au BufEnter * if &buftype !=# 'quickfix' | call Idesh_open() | endif
    execute 'copen'
    execute 'only'
endfunction

autocmd QuickFixCmdPost * call Idesh_qfix()
