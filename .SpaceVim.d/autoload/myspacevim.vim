func! myspacevim#before() abort
    "key mapping
    inoremap fd <esc>
    "set clipboard+=unnamedplus
    "逗号后空格
    "inoremap , ,<Space>
    "等号左右空格
    "inoremap = <Space>=<Space>
    nmap <silent> <A-k> :wincmd k<CR>
    nmap <silent> <A-j> :wincmd j<CR>
    nmap <silent> <A-h> :wincmd h<CR>
    nmap <silent> <A-l> :wincmd l<CR>

    "ale
    let g:ale_linters = {
    \   'python': ['pyls'],
    \}
    let g:ale_fixers = {
    \   'python': ['yapf'],
    \   'r': ['trim_whitespace', 'remove_trailing_lines'],
    \}
    let g:ale_sign_column_always = 1
    "let g:ale_r_lintr_options = 'lintr::with_defaults(line_length_linter = lintr::line_length_linter(100))'
    let g:ale_echo_msg_error_str = 'E'
    let g:ale_echo_msg_warning_str = 'W'
    let g:ale_echo_msg_format = '[%linter%] %s [%severity%]'
    nmap <F9> <Plug>(ale_fix)

    "Nvim-R config
    if $DISPLAY != ""
        let R_openpdf = 1
    endif
    let r_syntax_folding = 1
    let rrst_syn_hl_chunk = 1
    let rmd_syn_hl_chunk = 1
    "let R_objbr_place = 'console,top'
    let R_objbr_h = 15
    let R_hi_fun_paren = 1
    let Rout_more_colors = 1
    au TermOpen * setlocal nonu


    "pandoc
    let g:pandoc#folding#fold_yaml = 1

    "ultisnips
    let g:snips_author = ""
    let g:snips_email = "wangxinxing961129@gmail.com"
    let g:snips_github = "https://github.com/oouxx"
endf
