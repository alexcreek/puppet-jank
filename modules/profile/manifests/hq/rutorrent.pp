class profile::hq::rutorrent {
  file { ['/opt/rutorrent',
          '/opt/rutorrent/downloads',
          '/opt/rutorrent/config/',
          '/opt/rutorrent/config/rtorrent/',
          '/opt/rutorrent/config/rutorrent/']:
    ensure => directory,
    owner  => root,
    group  => root,
    mode   => '0755',
  }

  vcsrepo { '/opt/rutorrent/plugins':
    ensure   => present,
    provider => git,
    source   => 'https://github.com/alexcreek/plugins.git',
    revision => 'master',
    require  => File['/opt/rutorrent'],
  }

  file { '/opt/rutorrent/docker-compose.yaml':
    ensure => file,
    owner  => root,
    group  => root,
    mode   => '0755',
    source => 'puppet:///modules/profile/hq/rutorrent/docker-compose.yaml',
    require => File['/opt/rutorrent'],
  }

  file { '/opt/rutorrent/config/rtorrent/rtorrent.rc':
    ensure => file,
    owner  => root,
    group  => root,
    mode   => '0755',
    source => 'puppet:///modules/profile/hq/rutorrent/rtorrent.rc',
    require => File['/opt/rutorrent/config/rtorrent'],
  }

  file { '/etc/systemd/system/rutorrent.service':
    ensure => file,
    owner  => root,
    group  => root,
    mode   => '0755',
    source => 'puppet:///modules/profile/hq/rutorrent/rutorrent.service',
  }

  service { 'rutorrent':
    ensure  => running,
    enable  => true,
  }
}
