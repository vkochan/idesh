set cscopequickfix=s-,c-,d-,i-,t-,e-

let g:Idesh_Copy_File = tempname()

function! Idesh_GetVisualSelection(mode)
    " call with visualmode() as the argument
    let [line_start, column_start] = getpos("'<")[1:2]
    let [line_end, column_end]     = getpos("'>")[1:2]
    let lines = getline(line_start, line_end)
    if a:mode ==# 'v'
        " Must trim the end before the start, the beginning will shift left.
        let lines[-1] = lines[-1][: column_end - (&selection == 'inclusive' ? 1 : 2)]
        let lines[0] = lines[0][column_start - 1:]
    elseif  a:mode ==# 'V'
        " Line mode no need to trim start or end
    elseif  a:mode == "\<c-v>"
        " Block mode, trim every line
        let new_lines = []
        let i = 0
        for line in lines
            let lines[i] = line[column_start - 1: column_end - (&selection == 'inclusive' ? 1 : 2)]
            let i = i + 1
        endfor
    else
        return ''
    endif
    for line in lines
        echom line
    endfor
    return lines
endfunction

function! Idesh_YankSel()
    let l:sel = Idesh_GetVisualSelection(visualmode())
    call writefile(l:sel, g:Idesh_Copy_File)
    call system("idesh wm copy put -f " . g:Idesh_Copy_File)
    let @0 = join(l:sel, "\n")
endfunction

function! Idesh_YankLine()
    call writefile(["", getline(".")], g:Idesh_Copy_File)
    call system("idesh wm copy put -f " . g:Idesh_Copy_File)
    let @0 = getline(".")
endfunction

function! Idesh_Copybuf_YankSel()
    let l:idesh_buf_begin = 1
    if w:is_scr == 1
        wincmd p
        if col(".") > 1
            let l:idesh_buf_begin = 0
        endif
        wincmd p
        if l:idesh_buf_begin == 0
            call writefile([" "], g:idesh_file_buf, "abs")
        endif
        call writefile(Idesh_GetVisualSelection(visualmode()), g:idesh_file_buf, "ab")
        wincmd p
        wincmd p
    endif
endfunction

function! Idesh_Copybuf_YankLine()
    if w:is_scr == 1
        call writefile(["", getline(".")], g:idesh_file_buf, "as")
        wincmd p
        wincmd p
    endif
endfunction

function! Idesh_Copybuf(buf, scr, pos)
    let g:idesh_file_buf = a:buf
    let g:idesh_file_scr = a:scr
    let w:is_scr = 1

    vmap y :<C-U> call Idesh_Copybuf_YankSel()<Cr>
    nmap yy :<C-U> call Idesh_Copybuf_YankLine()<Cr>

    execute "e " . a:scr
    execute "set ro"

    execute "sp " . a:buf
    let w:is_scr = 0
    wincmd p
    execute ":" . a:pos
endfunction

set autoread
au FocusGained,BufEnter * :checktime
au CursorHold,CursorHoldI * checktime

vmap <C-y> :<C-U> silent call Idesh_YankSel()<CR>
nmap <C-y> :<C-U> silent call Idesh_YankLine()<CR>
map <C-p> :r! idesh wm copy get<CR>

nmap <C-e>gB :<C-U> call system("idesh vc blame " . expand('%:t'))<CR>
nmap <C-e>gb :<C-U> call system("idesh vc blame " . expand('%:t') . " -L" . line(".") . ",+1")<CR>
nmap <C-e>gd :<C-U> call system("idesh vc diff " . expand('%:t'))<CR>
nmap <C-e>gl :<C-U> call system("idesh vc log " . expand('%:t'))<CR>
