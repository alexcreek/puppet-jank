#
class profile::docker (
  $version = '17.09.0~ce-0~ubuntu',
) {

  # repo
  class { '::profile::docker::repo': }

  # deps
  package { ['linux-image-extra-4.4.0-93-generic','linux-image-extra-virtual', 'apt-transport-https', 'ca-certificates',
             'curl', 'software-properties-common']:
    ensure => installed,
    before => Class['::profile::docker::repo'],
  }

  # install docker + compose
  package { 'docker-ce':
    ensure  => $version,
    require => Class['::profile::docker::repo'],
  }
  
  exec { 'install_docker_compose':
    command => '/usr/bin/curl -L https://github.com/docker/compose/releases/download/1.16.1/docker-compose-$(uname -s)-$(uname -m) -o /usr/local/bin/docker-compose && chmod +x /usr/local/bin/docker-compose',
    creates =>  '/usr/local/bin/docker-compose',
  }

  service { 'docker':
    ensure => running,
    enable => true,
  }
}
