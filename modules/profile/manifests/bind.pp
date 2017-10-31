#
class profile::bind {
  class { 'dns':
    forward            => only,
    forwarders         => ['8.8.8.8', '8.8.4.4'],
    listen_on_v6       => false,
    additional_options => {
      'listen-on' => '{ 10.10.10.1; }',
    }
  }
}
