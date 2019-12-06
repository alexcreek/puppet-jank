class profile::baseline::datadog (
  $apikey,
) {
  file { '/opt/datadog':
    ensure => directory,
    owner  => root,
    group  => root,
    mode   => '0755',
  }

  file { '/opt/datadog/docker-compose.yaml':
    ensure  => file,
    owner   => root,
    group   => root,
    mode    => '0644',
    content => epp('profile/baseline/docker-compose.yaml.epp'),
    require => File['/opt/datadog'],
    notify  => Service['datadog'],
  }

  file { '/etc/systemd/system/datadog.service':
    ensure => file,
    owner  => root,
    group  => root,
    mode   => '0644',
    source => 'puppet:///modules/profile/baseline/datadog.service',
    notify  => Service['datadog'],
  }

  service { 'datadog':
    ensure => running,
    enable => true,
  }
}
