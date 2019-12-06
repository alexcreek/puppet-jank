class profile::hq {
  include profile::openvpn::client
  include profile::hq::rutorrent

  service { 'docker-cordon':
    ensure => running,
    enable => true,
  }

  file { '/etc/systemd/system/docker-cordon.service':
    ensure => file,
    owner  => root,
    group  => root,
    mode   => '0755',
    source => 'puppet:///modules/profile/hq/docker-cordon.service',
  }

  file { '/etc/iptables':
    ensure => directory,
    owner  => root,
    group  => root,
    mode   => '0755',
  }

  file { '/etc/iptables/rules.v4':
    ensure  => file,
    owner   => root,
    group   => root,
    mode    => '0755',
    source  => 'puppet:///modules/profile/hq/rules.v4',
    require => File['/etc/iptables'],
  }

  file { '/etc/systemd/system/docker.service.d':
    ensure => directory,
    owner  => root,
    group  => root,
    mode   => '0755',
  }

  # systemd drop-in
  file { '/etc/systemd/system/docker.service.d/docker-cordon.conf':
    ensure => file,
    owner  => root,
    group  => root,
    mode   => '0755',
    source => 'puppet:///modules/profile/hq/docker-cordon.conf',
    require => File['/etc/systemd/system/docker.service.d/']
  }
}
