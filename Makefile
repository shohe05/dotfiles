DOTFILES_EXCLUDES := .DS_Store .git .gitmodules .travis.yml
DOTFILES_TARGET   := $(wildcard .??*) .vim .zsh
DOTFILES_FILES    := $(filter-out $(DOTFILES_EXCLUDES), $(DOTFILES_TARGET))
UNAME 	          := ${shell uname}

install: zsh-init vim-init
	@$(foreach val, $(DOTFILES_FILES), ln -sfnv $(abspath $(val)) $(HOME)/$(val);)
	vim +PlugInstall +qall
	zsh
vim-init:
	curl -fLo ~/.vim/autoload/plug.vim --create-dirs https://raw.githubusercontent.com/junegunn/vim-plug/master/plug.vim
zsh-init: pure-init peco-init ghq-init
	git clone https://github.com/zsh-users/zsh-autosuggestions.git ~/.zsh/zsh-autosuggestions
	git clone https://github.com/zsh-users/zsh-syntax-highlighting.git ~/.zsh/zsh-syntax-highlighting
pure-init:
	mkdir ~/.zfunctions
	wget https://raw.githubusercontent.com/sindresorhus/pure/master/pure.zsh -O ~/.zfunctions/prompt_pure_setup
	wget https://raw.githubusercontent.com/sindresorhus/pure/master/async.zsh -O ~/.zfunctions/async
peco-init:
ifeq ($(UNAME),Darwin)
	curl -L -O https://github.com/peco/peco/releases/download/v0.5.1/peco_darwin_amd64.zip
	unzip peco_darwin_amd64.zip && sudo mv peco_darwin_amd64/peco /usr/local/bin && rm -rf peco_darwin_amd64 peco_darwin_amd64.zip
endif
ifeq ($(UNAME),Linux)
	curl -L -O https://github.com/peco/peco/releases/download/v0.5.1/peco_linux_amd64.tar.gz
	tar -zxvf peco_linux_amd64.tar.gz && sudo mv peco_linux_amd64/peco /usr/local/bin && rm -rf peco_linux_amd64 peco_linux_amd64.tar.gz
endif
ghq-init:
ifeq ($(UNAME),Darwin)
	wget https://github.com/motemen/ghq/releases/download/v0.7.4/ghq_darwin_amd64.zip
	unzip ghq_darwin_amd64.zip && sudo mv ghq /usr/local/bin && rm -rf ghq_darwin_amd64* zsh README.txt
endif
ifeq ($(UNAME),Linux)
	wget https://github.com/motemen/ghq/releases/download/v0.7.4/ghq_linux_amd64.zip
	sudo yum -y install unzip
	unzip ghq_linux_amd64.zip -d ghq_linux_amd64 && sudo mv ghq_linux_amd64/ghq /usr/local/bin && rm -rf ghq_linux_amd64*
endif
clean:
	@$(foreach val, $(DOTFILES_FILES), rm -rf $(HOME)/$(val);)
