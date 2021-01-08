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

function Idesh_grep(search)
    execute "silent! grep! -srnw --binary-files=without-match --exclude-dir=.git . -e " . a:search . " "
endfunction

autocmd QuickFixCmdPost * call Idesh_qfix()
