# Managing dotfiles
## Starting from scratch  
Add alias to .zshrc:
```bash
alias bare="git --git-dir=$HOME/Developer/.dotfiles/ --work-tree=$HOME"
```
Init bare repository:
```bash
git init --bare
bare config --local status.showUntrackedFiles no
```

Add file to GitHub:  
```bash
bare add file-name
bare commit -m "Commit message"
bare push -u origin main
```
## Installing dotfiles onto a new system  
Create folder for dotfiles and add alias to your .zshrc:  
```bash
mkdir $HOME/Developer/.dotfiles
echo 'alias bare="git --git-dir=$HOME/Developer/.dotfiles/ --work-tree=$HOME"' >> .zshrc
```
Clone dotfiles into a bare repository in a "_dot_" folder:
```bash
git clone --bare https://github.com/pokeskive/dotfiles.git $HOME/Developer/.dotfiles
```  
Checkout the actual content from the bare repository:
```bash
bare checkout 2>&1 | egrep "\s+\." | awk {'print $1'} | \
xargs -I{} rm {} {}
bare checkout
bare config --local status.showUntrackedFiles no
```

## References  
[Dotfiles: Best way to store in a bare git repository](https://www.atlassian.com/git/tutorials/dotfiles)  
[Git Bare Repository - A Better Way To Manage Dotfiles](https://www.youtube.com/watch?v=tBoLDpTWVOM)  
[Git Bare: The best way to manage dotfiles on Gitlab or Github](https://www.youtube.com/watch?v=iYElODEf6aw)
