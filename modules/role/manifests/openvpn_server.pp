#
class role::openvpn_server {
  include profile::openvpn::server
  include profile::bind
}
