#!/bin/bash
if [[ $UID -ne 0 ]]; then
  echo 'not root try again'
  exit 1
fi

# install puppet
pushd /tmp
wget https://apt.puppetlabs.com/puppet5-release-xenial.deb
dpkg -i puppet5-release-xenial.deb
apt-get update
apt-get install -y puppet-agent
. /etc/profile.d/puppet-agent.sh
/opt/puppetlabs/puppet/bin/gem install r10k

# pull upstream modules
popd
/opt/puppetlabs/puppet/bin/r10k puppetfile install
