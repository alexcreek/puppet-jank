#
class profile::cj {
  include profile::openvpn::client
  include profile::rutorrent

  service { 'cordon-docker':
    ensure => running,
    enable => true,
  }

  file { '/etc/systemd/system/docker-cordon.service':
    ensure => file,
    owner  => root,
    group  => root,
    mode   => '0755',
    source => 'puppet:///modules/profiles/cj/docker-cordon.service',
  }

  file { '/etc/iptables/rules.v4':
    ensure => file,
    owner  => root,
    group  => root,
    mode   => '0755',
    source => 'puppet:///modules/profiles/cj/rules.v4',
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
    source => 'puppet:///modules/profiles/cj/docker-cordon.conf',
    require => File['/etc/systemd/system/docker.service.d/']
  }
}
