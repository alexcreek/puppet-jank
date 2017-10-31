#
class profile::openvpn_server {
  openvpn::server { 'vpnserver':
    topology     => 'subnet',
    country      => 'US',
    province     => 'CA',
    city         => 'San Fran',
    organization => 'Prestige Worldwide',
    email        => 'root@fuckoff.io',
    server       => '10.10.10.0 255.255.255.0',
    push         => ['dhcp-option DNS 10.10.10.1'],
  }

  Openvpn::Client {
    remote_host => $::ipaddress,
  }

  openvpn::client { 'client1':
    server      => 'vpnserver',
  }

  openvpn::client_specific_config { 'client1':
    server           => 'vpnserver',
    redirect_gateway => true,
    ifconfig         => '10.10.10.2 255.255.255.0',
  }

  # to allow saving rules
  package { 'iptables-persistent':
    ensure => installed,
  }

  firewall { '1 allow ssh':
    dport  => 22,
    proto  => tcp,
    action => accept,
  }

  firewall { '2 forwarding from tun':
    chain    => 'FORWARD',
    action   => 'accept',
    proto    => 'all',
    outiface => 'eth0',
    source   => '10.10.10.0/24',
    state    => ['NEW'],
  }

  firewall { '3 forwarding in general':
    chain  => 'FORWARD',
    action => 'accept',
    proto  => 'all',
    state  => ['NEW','RELATED','ESTABLISHED'],
  }

  firewall { '4 snat for clients':
    chain    => 'POSTROUTING',
    jump     => 'MASQUERADE',
    proto    => 'all',
    outiface => 'eth0',
    source   => '10.10.10.0/24',
    table    => 'nat',
  }
}
