class profile::openvpn::server {
  include profile::baseline

  class { 'dns':
    forward            => only,
    forwarders         => ['8.8.8.8', '8.8.4.4'],
    listen_on_v6       => false,
    additional_options => {
      'listen-on' => '{ 10.10.10.1; }',
    }
  }

  openvpn::server { 'vpnserver':
    topology     => 'subnet',
    proto        => 'udp',
    local        => $::ipaddress,
    cipher       => 'AES-128-CBC',
    country      => 'US',
    province     => 'CA',
    city         => 'San Fran',
    organization => 'Prestige Worldwide',
    email        => 'root@fuckoff.io',
    server       => '10.10.10.0 255.255.255.0',
    push         => ['dhcp-option DNS 10.10.10.1', 'redirect-gateway def1'],
  }

  Openvpn::Client {
    remote_host => $::ipaddress,
    server      => 'vpnserver',
    proto       => 'udp',
    cipher      => 'AES-128-CBC',
  }

  openvpn::client { ['hq', 'mobile', 'remote']:}
  
  Openvpn::Client_specific_config {
    server           => 'vpnserver',
  }

  openvpn::client_specific_config { 'hq':
    ifconfig         => '10.10.10.2 255.255.255.0',
  }

  openvpn::client_specific_config { 'mobile':
    ifconfig         => '10.10.10.3 255.255.255.0',
  }

  openvpn::client_specific_config { 'remote':
    ifconfig         => '10.10.10.4 255.255.255.0',
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
    outiface => 'ens3',
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
    outiface => 'ens3',
    source   => '10.10.10.0/24',
    table    => 'nat',
  }

  firewall { '5 port forward 51413':
    chain   => 'PREROUTING',
    jump    => 'DNAT',
    proto   => 'tcp',
    iniface => 'ens3',
    dport   => '51413',
    todest  => '10.10.10.2:51413',
    table   => 'nat',
  }
}
