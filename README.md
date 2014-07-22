# Vagrant Sensu (Sandbox)

Ready to go Sensu client/server VM's (Centos 6.5) with all dependencies.

## Pre-requisites

You'll need the following installed on your system. The versions are provided in parentheses for info but there shouldn't be any problems with earlier versions of things.

- Vagrant (`1.5.1`, `1.6.3` both confirmed working)
- VirtualBox (`4.3.8`, `4.3.12` both confirmed working)
- Ruby (`2.1.0` confirmed working, `1.9.3` onwards should be fine)
- Bundler (`1.5.2` confirmed working) 

## Usage

Install the required gems:

    $ bundle install

Install the required Puppet modules:

    $ librarian-puppet install

Bring up the VM:

    $ vagrant up
