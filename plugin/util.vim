
function! MakeStatusLine()
    let cur_mode = nvim_get_mode()
    let modified_color = &modified ? "3" : "2"

    return " " . cur_mode['mode'] . " "
                \ . "%1*%4c"
                \ . " ॐ  "
                \ . "%4 %L "
                \ . "%" . modified_color . "*"
                \ . " %-F"
                \ . "%m"
                \ . "%="
                \ . "%(%1"
                \ . " " . FugitiveHead(8) . " "
                \ . "%* %y "
                \ . "%)"
endfunction

