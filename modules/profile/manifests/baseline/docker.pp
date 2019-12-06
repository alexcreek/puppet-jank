class profile::baseline::docker (
  $version = '17.09.0~ce-0~ubuntu',
) {

  # repo
  apt::source { 'docker':
    location => 'https://download.docker.com/linux/ubuntu',
    release  => $::os['distro']['codename'],
    repos    => 'stable',
    key      => {
      'id'     => '9DC858229FC7DD38854AE2D88D81803C0EBFCD88',
      'source' => 'https://download.docker.com/linux/ubuntu/gpg',
    },
  }

  # deps
  package { ['linux-image-extra-virtual', 'apt-transport-https', 'ca-certificates',
              'curl', 'software-properties-common']:
    ensure => installed,
    before => Apt::Source['docker'],
  }

  # install docker + compose
  package { 'docker-ce':
    ensure  => $version,
    require => Apt::Source['docker'],
  }

  exec { 'install_docker_compose':
    command => '/usr/bin/curl -L https://github.com/docker/compose/releases/download/1.16.1/docker-compose-$(uname -s)-$(uname -m) -o /usr/local/bin/docker-compose && chmod +x /usr/local/bin/docker-compose',
    creates =>  '/usr/local/bin/docker-compose',
  }

  service { 'docker':
    ensure  => running,
    enable  => true,
    require => Package['docker-ce'],
  }
}
