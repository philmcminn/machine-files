# Installing Ruby on macOS

Ensure that, via brew, you have installed:

* `asdf`
* `openssl@3`
* `readline`
* `libyaml`
* `gmp`

Ensure this line is in `.zshrc:`

``. "$(brew --prefix asdf)/libexec/asdf.sh"``

Then do:

``
asdf plugin add ruby
asdf list all ruby
asdf install ruby 4.0.1
asdf set ruby 4.0.1``

Finally, you may wish to add a `.tool-versions` file in the `~/workspace` directory to suppress warnings. The contents is just the version used in the `asdf set` command, i.e. `ruby 4.0.1` in this example. 

