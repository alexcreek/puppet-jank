#
class profile::baseline {
  package { ['htop', 'strace', 'bash-completion', 'mtr', 'tcpdump', 'nmap', 'sysstat']:
    ensure => installed,
  }
}
