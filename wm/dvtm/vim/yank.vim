let g:copyfile = tempname()

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

function! LoadAndCopy()
    call system("touch " . g:copyfile)
    call system("mv " . g:copyfile . " " . expand("%") . "")
endfunction

function! YankSel()
    call writefile(GetVisualSelection(visualmode()), g:copyfile, "ab")
    call writefile([" "], g:copyfile, "ab")
endfunction

function! YankLine()
    call writefile([getline(".")], g:copyfile, "a")
endfunction

vmap y :<C-U> call YankSel()<Cr>
nmap y :<C-U> call YankLine()<Cr>
nmap yy :<C-U> call YankLine()<Cr>

set autoread

au BufWinLeave dvtm-editor* call LoadAndCopy()
