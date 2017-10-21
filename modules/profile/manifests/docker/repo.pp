#
class profile::docker::repo {
  exec { 'install_docker_gpg_key':
    command => '/usr/bin/curl -fsSL -o docker.gpg https://download.docker.com/linux/ubuntu/gpg && apt-key add docker.gpg',
    cwd     => '/var/lib/apt/',
    creates => '/var/lib/apt/docker.gpg',
  }

  exec { 'install_docker_repo':
    command     => '/usr/bin/add-apt-repository "deb [arch=amd64] https://download.docker.com/linux/ubuntu $(lsb_release -cs) stable"',
    refreshonly => true,
    subscribe   => Exec['install_docker_gpg_key'],
  }

  exec { 'update_apt_cache':
    command     => '/usr/bin/apt-get update',
    refreshonly => true,
    subscribe   => Exec['install_docker_repo'],
  }
}
