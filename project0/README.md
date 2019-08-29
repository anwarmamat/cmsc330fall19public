# Project 0: Setup

This project is simply to get your system ready. It will not be submitted for
a grade.

## Introduction

In this course, among other things, you will learn three different programming
languages: Ruby, OCaml, and Rust. To complete the projects you have to
install the appropriate software to develop programs in these languages.
We recommend installing these packages on your local machine, but Grace is
available as an alternative.

Here are the packages that you are required to install.

* [Ruby](https://www.ruby-lang.org)
  - [minitest](https://rubygems.org/gems/minitest)
  - [sqlite3](https://rubygems.org/gems/sqlite3)
  - [sinatra](https://rubygems.org/gems/sinatra)
* [OCaml](http://ocaml.org)
  - [OPAM](https://opam.ocaml.org)
  - [OUnit](https://opam.ocaml.org/packages/ounit)
  - [ocamlfind](https://opam.ocaml.org/packages/ocamlfind)
  - [dune](https://opam.ocaml.org/packages/dune/)
* [Rust](https://www.rust-lang.org)
* [SQLite3](https://sqlite.org)

We highly recommend, but do not require, installing the following
packages.

* [Graphviz](http://graphviz.org)
* [utop](https://opam.ocaml.org/packages/utop)

The next sections will help guide you through installing these
on different operating systems. Read the section relevant to you. Some
of these steps may take a long time, be patient. To verify you have
completed all the steps correctly, run `ruby public.rb` in this directory.
You should not get any errors.

Computers are like people, each unique in its own way. These instructions
may require slight (or large) modifications depending on your setup.
Search engines are your friend if something goes wrong. If you are unable
to install **anything**, please come to office hours **as soon as possible**.

## macOS

First, we will install the Homebrew package manager.

* `/usr/bin/ruby -e "$(curl -fsSL https://raw.githubusercontent.com/Homebrew/install/master/install)"`

Check your Ruby version with `ruby -v`. If it's older than 2.2.2 you'll need
to install a newer version using `brew install ruby`.

Next, we can install some of the software through Homebrew.

* `brew install ocaml opam rust graphviz`

Macs already come with Ruby and the Ruby Gems package manager. We only need
to install the required gems.

* `sudo gem install sqlite3 sinatra`

If it hangs installing documentation for Sinatra, hit Ctrl-C. It will
have successfully installed anyway.

The OCaml package manager needs some initial configuration.

* `opam init`
* When prompted to modify `~/.bash_profile` (or another file) type "y".
* `source ~/.bash_profile` (or the file mentioned above).

First we want to make sure that we have the correct version of OCaml. We'll be
using version 4.07.0. Run  `ocaml -version` to see which version you have.

If the version is not 4.07.0, then use `opam switch 4.07.0` (you may need to
run `opam switch create 4.07.0` instead). Don't forget to run the
advertised ``eval `opam config env` `` to update your PATH accordingly.

Then run `ocaml -version` to make sure it says 4.07.0

Next, we will install the required OCaml packages through OPAM.

* `opam install ocamlfind ounit utop dune qcheck`

## Windows 10

Enable the [Windows Subsystem for Linux](https://docs.microsoft.com/en-us/windows/wsl/install-win10)
and install Ubuntu. Make sure to run `sudo apt update && sudo apt upgrade` after installing.
Then follow the instructions in the Linux section below.

## Linux

These instructions will assume you have a Debian-based system. This includes
distributions like Ubuntu. If you have a different distribution, use the
native package manager.

We will install all the packages we need.

* `sudo apt-get install ruby-dev sqlite3 libsqlite3-dev ocaml ocaml-native-compilers camlp4 opam make m4 curl graphviz default-jre`

Next, we will install some gems.

* `sudo gem install sqlite3 sinatra`

If it hangs installing documentation for Sinatra, hit Ctrl-C. It will
have successfully installed anyway.

The OCaml package manager needs some initial configuration.

* `opam init`
* If it hangs at "Fetching repository information" press Enter. This may take awhile, be patient.
* When prompted to modify `~/.profile` (or another file) type "n".
* Open `~/.profile` (or the file mentioned above) in your text editor (probably emacs).
* Add ``eval `opam config env` `` (these are **backticks** located to the left of the 1 key, not single quotes).
* Save the file and run `source ~/.profile` (or the file mentioned above).

We want to make sure that we have the correct version of OCaml. We'll be
using version 4.07.0. Run  `ocaml -version` to see which version you have.

If the version is not 4.07.0, then use `opam switch 4.07.0`
(you may need to run `opam switch create 4.07.0` instead).
Don't forget to run the advertised ``eval `opam config env` `` to update your
PATH accordingly.

Then run `ocaml -version` to make sure it says 4.07.0

Next, we will install the required OCaml packages through OPAM.

* `opam install ocamlfind ounit utop dune qcheck`

Finally, we'll install Rust. Note this may take some time.

* `curl https://sh.rustup.rs -sSf | sh`

## Grace

Most everything is installed on Grace, but there are still some
language-specific packages that must be installed. First, we
configure some things. Do the following:

* clone this repository
* cd into project0
* `csh <grace.csh` This will take quite a long time to run. Be patient.
* `opam init` (when prompted to modify .profile say no)
* ``eval `opam config env` `` (these are **backticks** located to the left
  of the 1 key, not single quotes).
* At this point, log out of grace and log back in. Then run:
* ``eval `opam config env` `` (yes, again)

From there everything should be setup correctly.

If you run:

`ocaml -version`

The ocaml version should be 4.07.1, and if you run

`opam list`

You should see all of the following:

ocamlfind ounit utop dune qcheck
