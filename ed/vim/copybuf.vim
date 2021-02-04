function! GetVisualSelection(mode)
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
    " return join(lines, "\n")
    return lines
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
        call writefile(GetVisualSelection(visualmode()), g:idesh_file_buf, "ab")
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

set autoread
au FocusGained,BufEnter * :checktime
au CursorHold,CursorHoldI * checktime

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
