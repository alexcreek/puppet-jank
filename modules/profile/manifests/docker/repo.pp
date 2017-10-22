#
class profile::docker::repo {
  include ::apt

  apt::source { 'docker':
    location => 'https://download.docker.com/linux/ubuntu',
    release  => 'zesty',
    repos    => 'stable',
    key      => {
      'id'     => '9DC858229FC7DD38854AE2D88D81803C0EBFCD88',
      'source' => 'https://download.docker.com/linux/ubuntu/gpg',
    },
  }
}
