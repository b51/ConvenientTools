# My Vim Configuration

Include .vimrc, ctags, cscope, jedi and pathogen settings
After git clone, cp .vim and .vimrc to ~/

    cp -rf .vim* ~/
    cd ~/.vim/bundle/
    cat .rosinstall | grep uri | awk '{print $2}' | while read line; do git clone --recursive $line; done;
    cd YouCompleteMe
    python install.py --clang-completer

