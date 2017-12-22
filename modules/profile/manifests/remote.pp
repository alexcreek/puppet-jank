#
class profile::remote {
  class { 'supervisord':
    install_pip => true,
  }
  
  Supervisord::Program {
    autostart   => true,
    autorestart => true,
  }

  supervisord::program { 'remote':
    command             => '/usr/local/bin/flask run -h 0.0.0.0 -p 5000',
    directory           => '/opt/remote',
    program_environment => {
      'FLASK_APP'   => 'remote.py',
      'FLASK_DEBUG' => '0',
    }
  }

  supervisord::program { 'websocketd':
    command => '/usr/local/sbin/websocketd --port=9001 --dir=/opt/remote/websockets',
  }
}
