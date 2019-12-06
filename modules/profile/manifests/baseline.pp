class profile::baseline {
  include profile::baseline::puppet
  include profile::baseline::datadog
  include profile::baseline::docker
  include apt

  package { ['htop', 'strace', 'bash-completion', 'mtr', 'tcpdump', 'nmap', 'sysstat', 'ansible']:
    ensure => installed,
  }
}
