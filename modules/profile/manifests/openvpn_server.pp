#
class profile::openvpn_server {
  openvpn::server { 'vpnserver':
#    remote       => ['168.235.81.155'],
    topology     => 'subnet',
    country      => 'US',
    province     => 'CA',
    city         => 'San Fran',
    organization => 'Prestige Worldwide',
    email        => 'root@fuckoff.io',
    server       => '10.10.10.0 255.255.255.0',
  }
  openvpn::client { 'client1':
    server => 'vpnserver',
  }
  openvpn::client_specific_config { 'client1':
    server           => 'vpnserver',
    redirect_gateway => true,
    ifconfig         => '10.10.10.2 255.255.255.0',
  }
}
