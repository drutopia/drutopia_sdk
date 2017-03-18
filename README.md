# Drutopia development quickstart

This guide helps you jumpstart contributing to the development of the Drutopia distribution for Drupal 8. It assumes you are familiar with git and working on the command line.

## Install Virtualbox and Vagrant

[Download and install Virtualbox](https://www.virtualbox.org/wiki/Downloads)

[Download and install Vagrant](http://www.vagrantup.com/downloads.html)

## Clone the repository and bring up the virtual development environment

From a terminal, move (cd) into the folder where you would like to keep Drutopia's code. Then:

```
$ git clone git@gitlab.com:drutopia/drutopia_sdk.git
$ cd drutopia_sdk
$ vagrant up
```

If this is your first project using the box specified in the Vagrantfile it will be downloaded. This can take a while.

## Give the site a local domain

Add the IP address and host name combination to your /etc/hosts, getting the values from config.vm.network ip and config.vm.hostname in the Vagrantfile.

## Tell git who you are

```
$ git config --global user.name 'Jean R. Hacker'
$ git config --global user.email 'jean@agaric.com'
```

## Create a personal excludesfile

> Patterns which a user wants git to ignore in all situations (e.g., backup or temporary files generated by the user’s editor of choice) generally go into a file specified by core.excludesfile in the user’s ~/.gitconfig.
>
> — <cite>[gitignore manual page](https://git-scm.com/docs/gitignore)

```
$ touch ~/.gitignore
$ git config --global core.excludesfile ~/.gitignore
```

## Temporary manual step

Create web/sites/default/settings.php

## Develop

Pick a ticket, create a branch referencing the ticket number, e.g. `git checkout -b project-123`. Commit your code in small chunks capturing logical steps and follow the [Drupal coding standards](https://drupal.org/coding-standards) and the [guidelines for commit messages](http://tbaggery.com/2008/04/19/a-note-about-git-commit-messages.html). All configuration that accompanies your code, e.g. creating fields and content types, must be in the `config` directory or scripted in an update hook. Once your work is done request a review and eventually your code will get merged into the master branch.

All commands referenced below are from within the virtual machine (use ```vagrant ssh``` to enter the VM).  Git commands should be run from your host computer.

### Pull in others' changes

Other than the first time you run ```vagrant up```, you'll want to make
sure you're up-to-date before starting to contribute changes to the
project.  This involves fetching new code from the repository (```git
pull```), updating the project's dependencies, re-installing the site (NOTE:
site install *will* destroy all content in your database), and compiling CSS
from Sass.  The latter steps can be done with the following commands:

```
composer install
drush -y si drutopia
```

Or just to bring in configuration:

```
drush -y cim
```

### Export configuration

```
$ drush -y cex
```

And then ```git add config``` and review diff (```git diff --cached```) before committing.

### Export default content

While a project is in the phase of its life cycle where it can be
completely built from a site install (before there is a live site where
users add content), it is very useful to have default content for site
structure, templating, and testing purposes.  To export a node, find the
node ID (as in the edit link, node/[node ID]/edit), and use drush dcer
(drupal content export with references) to export:

```
drush dcer node 12
```

Never commit user id 1 created by content export, as this user is created by the site install process.

For more on exporting default content, including menu_link_content,
taxonomy_term content, and comment content, see [Default content in Drupal
8](http://data.agaric.com/drupal-8-default-content-agaric-way).

### Adding contributed modules

With `composer require ...` you can add new dependencies to your installation:

```
$ cd /vagrant
$ composer require drupal/honeypot:8.*
```

### Updating Drupal core

1. Update the version number of `drupal/core` in composer.json.
1. Run `composer update drupal/core`.
1. Run `./scripts/drupal/update-scaffold [drush-version-spec]` to update files in the `web` directory, where `drush-version-spec` is an optional identifier acceptable to Drush, e.g. `drupal-8.0.x` or `drupal-8.1.x`, corresponding to the version you specified in `composer.json`. (Defaults to `drupal-8`, the latest stable release.) Review the files for any changes and restore any customizations to `.htaccess` or `robots.txt`.
1. Commit everything all together in a single commit, so `web` will remain in sync with the `core` when checking out branches or running `git bisect`.

## Getting in sync with other developers

To bring in changes from other developers into the branch you are
working on, from master ```git pull``` and then ```git checkout
your-branch-name``` and ```git rebase master```

To get rid of a commit (the most recent one),

```git reset HEAD^```

to then be able to ```git stash``` changes from the commit, now local changes.  To just throw everything in the commit away, ```git reset --hard HEAD^```

See https://sethrobertson.github.io/GitFixUm/fixup.html
