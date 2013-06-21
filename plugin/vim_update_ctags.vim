" Exit quickly when already loaded.
if exists("g:load_vim_update_ctags")
  finish
endif

" Exit quicky if running in compatible mode
if &compatible
  echohl ErrorMsg
  echohl none
  finish
endif

" Check for Ruby functionality.
if !has("ruby")
  echohl ErrorMsg
  echon "Sorry, This plugin in ruby online doc requires ruby support."
  finish
endif


let g:load_vim_update_ctags = "true"


function! LoadCtagsRails()
  :ruby LoadCtagsRails.new
  :echo "Completed..."
endfunction

command LoadCtagsRails :call LoadCtagsRails()

ruby << EOF
	class LoadCtagsRails 
		def initialize
      update_ctags
		end

    def update_ctags
      vimputs("This can take a while ...")
      # system("ctags -R --exclude=.git --exclude=log --exclude=*.js * #{gem_path}/bundler #{gem_path}")
      system("ctags -R --exclude=.git --exclude=log --exclude=*.js *  #{gem_path}")
    end

    def gem_path
      ENV['GEM_PATH'].split(':')[0]
    end

		def vimputs(s)
      print s
		end
	end
EOF

