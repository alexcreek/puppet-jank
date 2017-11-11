#!/bin/bash
if [[ $UID -ne 0 ]]; then
  echo 'not root try again'
  exit 1
fi

RESTORE='\033[0m'
GREEN='\033[00;32m'

# install puppet
echo -e "${GREEN}[*] Installing puppet${RESTORE}"
pushd /tmp
wget https://apt.puppetlabs.com/puppet5-release-xenial.deb
dpkg -i puppet5-release-xenial.deb
apt-get update
apt-get install -y puppet-agent
. /etc/profile.d/puppet-agent.sh
/opt/puppetlabs/puppet/bin/gem install r10k

# pull upstream modules
echo -e "${GREEN}[*] Installing modules using r10k${RESTORE}"
popd
/opt/puppetlabs/puppet/bin/r10k puppetfile install

# install data
PUPPET_DIR='/etc/puppetlabs/code/environments/production/'
echo -e "${GREEN}[*] Installing data into ${PUPPET_DIR}${RESTORE}"
if [[ $PWD =~ 'puppet-jank' ]]; then
  rm -rf ${PUPPET_DIR}/*
  mv $PWD/* $PWD/.git $PUPPET_DIR/
  if [[ -L ~/production ]]; then
    :
  else
    ln -s $PUPPET_DIR ~/production
  fi
fi

# patch and reboot because kernel exploits suck ass
echo -e "${GREEN}[*] Patching and rebooting${RESTORE}"
apt-get update && apt-get -y upgrade && reboot
