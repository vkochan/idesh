function Idesh_open()
    if $DVTM_CMD_FIFO != ''
	call system(printf("idesh-wm -c open %s %d", expand('%:p'), line(".") + 1))
    endif
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
