# My Vim Configuration

Include .vimrc, ctags, cscope, jedi and pathogen settings
After git clone, cp .vim and .vimrc to ~/

    cp -rf .vim* ~/
    cd ~/.vim/bundle/
    cat .rosinstall | grep uri | awk '{print $2}' | while read line; do git clone --recursive $line; done;
    cd YouCompleteMe
    python install.py --clang-completer
    sudo apt install clang-format

## Usage
Leader key == \

### NerdTree
    Open, :NERDTree

### TagList
    Open/Close, F8

### MarkdownPreview
    Open , F9 + o
    Close, F9 + q

### VimMark
    Mark/Unmark, \ + m

### GoogleCodefmt
    Enable,  :AutoFormatBuffer
    Disable, :NoAutoFormatBuffer
