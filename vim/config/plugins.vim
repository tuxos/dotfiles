" Pathogen.vim

" Must turn filetype off and then back on.
filetype off
call pathogen#infect()
call pathogen#helptags()
filetype plugin indent on

" Ctrl-P

let g:ctrlp_match_window_bottom = 0
let g:ctrlp_match_window_reversed = 0
let g:ctrlp_max_height = 20
let g:ctrlp_show_hidden = 0
let g:ctrlp_max_files = 0
let g:ctrlp_switch_buffer = 0

" Files to skip.
" Possibly used by other plugins, like Command-T.
set wildignore+=*.o,*.obj,.git,tmp
set wildignore+=public/uploads,db/sphinx,vim/backup
set wildignore+=.themes  " Octopress.

" Compatibility with colleagues used to Command-T.
map <leader>t :CtrlP<CR>

" Syntastic

let g:syntastic_enable_signs=1
let g:syntastic_quiet_warnings=0
" Slow, so only run on :SyntasticCheck
let g:syntastic_mode_map = { 'mode': 'passive', 'active_filetypes': [], 'passive_filetypes': [] }

" NERDTree

let NERDTreeIgnore=['\.rbc$', '\~$']

" Disable menu.
let g:NERDMenuMode=0

map <leader>n :NERDTreeToggle<CR>
map <leader>N :NERDTreeFindIfFindable<CR>

" Rails.vim

" :Rfac item
autocmd User Rails Rnavcommand factory    spec/factories   -suffix=_factory.rb

" :Rfab item
autocmd User Rails Rnavcommand fabricator spec/fabricators -suffix=_fabricator.rb

" :A on app/models/foo.rb -> {spec,unit}/models/foo_spec.rb
autocmd User Rails/app/* let common = rails#buffer().name()[4:-4].'_spec.rb' | let spec = 'spec/'.common | let unit = 'unit/'.common | let b:rails_alternate = filereadable(spec) ? spec : unit
" :A on unit/models/foo_spec.rb -> app/models/foo.rb
autocmd User Rails/unit/* let b:rails_alternate = 'app/' . rails#buffer().name()[5:-9] . '.rb'

" :A on lib/foo.rb -> unit/lib/foo_spec.rb
autocmd User Rails/lib/* let b:rails_alternate = 'unit/' . rails#buffer().name()[0:-4] . '_spec.rb'
" :A on unit/lib/foo_spec.rb -> lib/foo.rb
autocmd User Rails/unit/lib/* let b:rails_alternate = rails#buffer().name()[5:-9] . '.rb'

" :A on engines/foo/bar.rb -> {spec,unit}/engines/foo/bar_spec.rb
autocmd User Rails/engines/* let common = rails#buffer().name()[0:-4].'_spec.rb' | let spec = 'spec/'.common | let unit = 'unit/'.common | let b:rails_alternate = filereadable(spec) ? spec : unit
" :A on spec/engines/foo/bar_spec.rb -> engines/foo/bar.rb
autocmd User Rails/spec/engines/* let b:rails_alternate = rails#buffer().name()[5:-9] . '.rb'
" :A on unit/engines/foo/bar_spec.rb -> engines/foo/bar.rb
autocmd User Rails/unit/engines/* let b:rails_alternate = rails#buffer().name()[5:-9] . '.rb'

" Commentary

xmap <leader>c <Plug>Commentary
nmap <leader>c <Plug>Commentary
nmap <leader>cc <Plug>CommentaryLine
nmap <leader>cu <Plug>CommentaryUndo

" Git grep

" Using "a" because it used to be :Ack.
" We need the trailing space.
exe "nnoremap <leader>a :GitGrep "

" Yankstack

" Plugin must redefine mappings before we do.
call yankstack#setup()

" Don't add default keymaps; we'll set our own.
let g:yankstack_map_keys = 0

nmap å <Plug>yankstack_substitute_older_paste
nmap ä <Plug>yankstack_substitute_newer_paste

" vimux

let g:VimuxOrientation = "h"
let g:VimuxUseNearestPane = 1

" turbux

let g:no_turbux_mappings = 1
map M <Plug>SendTestToTmux
map m <Plug>SendFocusedTestToTmux
let g:turbux_command_rspec = 'script/turbux_rspec'

" CamelCasemotion

" Make c,w not include the trailing underscore:
" https://github.com/bkad/CamelCaseMotion/issues/10
nmap c,w c,e
nmap ci,w ci,e

" Blockle

" ,b is taken by CamelCaseMotion.
let g:blockle_mapping = '<leader>B'

" Ack.vim

" Use The Silver Searcher.
let g:ackprg = 'ag --nogroup --nocolor --column'
