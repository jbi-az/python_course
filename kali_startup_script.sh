#!/bin/bash 

# Startup script environment for Python course 
#  
# Environment kali-linux 2022.4 with shared folder mounted to ~/shared
# 
# Includes:
# - pip installation: Jupyter Notebook 
# - add .local/bin to PATH
# - fetch of .vimrc
# - copy ssh keys and ssh config
# - add ssh identities
# - clone SnippetsABC

pip install notebook
echo 'export PATH=$PATH:/home/kali/.local/bin' >> .zshrc  
wget -q https://raw.githubusercontent.com/ben-ilan/learning_vim/master/vimrc -O .vimrc
cp -r ~/shared/ssh /.ssh
chmod 600 ~/.ssh/id_ed25519 ~/.ssh/az
chmod 644 ~/.ssh/*

eval "$(ssh-agent -s)"
ssh-add ~/.ssh/id_ed25519
ssh-add ~/.ssh/az

ssh-keyscan -H "github.com" >> ~/.ssh/known_hosts
mkdir -p ~./vim/pack/abc/start && cd ~/.vim/pack/abc/start
git clone git@github.com:ben-ilan/snippets_ABC.git
ln -s .vim/pack/abc/start/snippets_ABC abc 
git remote set-url git@git-az:ben-ilan/snippets_ABC.git  

