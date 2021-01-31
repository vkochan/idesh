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

vmap <C-y> :<C-U> silent call Idesh_YankSel()<CR>
nmap <C-y> :<C-U> silent call Idesh_YankLine()<CR>

nmap <C-e>gB :<C-U> call system("idesh vc blame " . expand('%:t'))<CR>
nmap <C-e>gb :<C-U> call system("idesh vc blame " . expand('%:t') . " -L" . line(".") . ",+1")<CR>
nmap <C-e>gd :<C-U> call system("idesh vc diff " . expand('%:t'))<CR>
