#
class role::baseline {
  include profile::baseline
  include profile::puppet
  include profile::docker
}
