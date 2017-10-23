#
class profile::baseline {
  include ::apt

  package { ['htop', 'strace', 'bash-completion', 'mtr', 'tcpdump', 'nmap', 'sysstat']:
    ensure => installed,
  }
}
