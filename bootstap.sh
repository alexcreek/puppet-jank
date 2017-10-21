#!/bin/bash
pushd /tmp
wget https://apt.puppetlabs.com/puppet5-release-xenial.deb
sudo dpkg -i puppet5-release-xenial.deb
sudo apt update
sudo apt-get install -y puppet-agent
