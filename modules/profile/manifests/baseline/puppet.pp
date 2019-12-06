class profile::baseline::puppet {
  Service {
    provider => systemd,
  }

  service { 'puppet':
    ensure => stopped,
    enable => false,
    }

  service { 'mcollective':
    ensure => stopped,
    enable => false,
    }
}
