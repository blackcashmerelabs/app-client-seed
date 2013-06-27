app-client-seed
===============

boilerplate to seed an app client to build with gruntjs + angularjs + stylus


-----


## getting started

this assumes development from a machine running osx >= *10.7*.

### prerequisites
* homebrew      >=*0.9.4*     ([http://mxcl.github.com/homebrew](http://mxcl.github.com/homebrew))
* nodejs        >=*v0.10.7*   ([http://nodejs.org](http://nodejs.org))
* npm           >=*1.2.21*    ([http://npmjs.org](http://npmjs.org))
* stylus        >=*0.31.0*    ([http://learnboost.github.io/stylus/](http://learnboost.github.io/stylus/))
* coffeescript  >=*1.4*       ([http://coffeescript.org](http://coffeescript.org))
* grunt         >=*0.4.1*     ([http://gruntjs.com](http://gruntjs.com))
* grunt-cli     >=*v0.1.8*    ([http://gruntjs.com](http://gruntjs.com))


-----


### install homebrew

homebrew simplifies the way packages are installed and managed on osx. until a
vagrant machine image is setup, maeve packages will be installed using brew for
best consistency.

    ruby -e "$(curl -fsSL https://raw.github.com/mxcl/homebrew/go)"

make sure to add homebrew installed packages top the top of the executable path.
to do so append to your `~/.bash_profile`:

    export PATH=/usr/local/bin:${PATH}


### install node

    brew install node


### install grunt + bower + stylus

    npm install -g grunt bower stylus


### install grunt-cli

this puts the `grunt` command in your system path, allowing it to be run from
any directory:

    npm install -g grunt-cli


### install project + dependencies

    git clone git@github.com:blackcashmerelabs/app-client-seed.git client && cd client
    npm install
    bower install
