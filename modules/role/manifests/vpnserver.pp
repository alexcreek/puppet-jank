#
class role::vpnserver {
  include role::baseline
  include profile::openvpn::server
  include profile::bind
}
