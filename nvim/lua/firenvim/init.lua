vim.cmd([[
    function! OnUIEnter(event) abort
      if 'Firenvim' ==# get(get(nvim_get_chan_info(a:event.chan), 'client', {}), 'name', '')
        set guifont=JetBrains_Mono:h26
      endif
    endfunction
    autocmd UIEnter * call OnUIEnter(deepcopy(v:event))
  ]])
