# install chocolatey
Set-ExecutionPolicy Bypass -Scope Process -Force; iex ((New-Object System.Net.WebClient).DownloadString('https://chocolatey.org/install.ps1'))

refreshenv

# install packages
choco install -y ctags, vim, python

refreshenv

python -m pip install --upgrade pip
pip3 install jedi
cd ~
if(!(Test-Path -Path ~\.vim)){
  git clone https://github.com/nettrino/vimconf.git .vim
  md ~\.vim\autoload
  $uri = 'https://raw.githubusercontent.com/junegunn/vim-plug/master/plug.vim'
  (New-Object Net.WebClient).DownloadFile($uri, $ExecutionContext.SessionState.Path.GetUnresolvedProviderPathFromPSPath("~\.vim\autoload\plug.vim"))
}
cp _vimrc ~\_vimrc
vim +PlugInstall +qall
