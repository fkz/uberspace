Initialization (first time)

  cd ~
  git clone git://github.com/fkz/uberspace
  wget http://static.proot.me/proot-x86_64
  chmod u+x proot-x86_64
  mkdir nix-mnt && cd nix-mnt
  wget http://hydra.nixos.org/build/25489771/download/1/nix-1.10-x86_64-linux.tar.bz2
  tar xvjf nix-*bz2

Then regularly call `uberspace/cron`. That's it.
