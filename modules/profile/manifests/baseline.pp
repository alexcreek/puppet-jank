#
class profile::baseline {
  include profile::puppet
  include profile::baseline::packages
}
