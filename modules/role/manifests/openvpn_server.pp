#
class role::openvpn_server {
  include profile::openvpn_server
  include profile::bind
}
