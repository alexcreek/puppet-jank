class profile::openvpn::client {
  package { 'openvpn':
    ensure => installed,
  }

  file { '/lib/systemd/system/openvpn.service':
    ensure => file,
    owner  => root,
    group  => root,
    mode   => '0755',
    source => 'puppet:///modules/profile/openvpn/client.service',
  }

  service { 'openvpn':
    ensure => running,
    enable => true,
  }
}
