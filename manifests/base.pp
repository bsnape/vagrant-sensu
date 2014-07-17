node 'sensu-server' {

  class { '::erlang':
    epel_enable => true
  }

  class { '::redis':
    version => '2.8.13',
  }

  class { '::rabbitmq':
    require               => Class['::erlang'],
    environment_variables => {
    'RABBITMQ_NODENAME' => 'rabbit',
    'HOME'              => '/var/lib/rabbitmq',
    }
  }

  rabbitmq_vhost { '/sensu':
    ensure  => present,
    require =>  Class['::rabbitmq']
  }

  rabbitmq_user { 'sensu':
    password => 'password',
    admin    => true,
    require  =>  Class['::rabbitmq']
  }

  rabbitmq_user_permissions { 'sensu@/sensu':
    configure_permission => '.*',
    read_permission      => '.*',
    write_permission     => '.*',
    require              => Class['::rabbitmq']
  }

  class { 'sensu':
    rabbitmq_password => 'password',
    rabbitmq_host     => 'sensu-server',
    rabbitmq_port     => '5672',
    client            => false,
    server            => true,
    dashboard         => true,
    api               => true,
    require           => [Class['::rabbitmq'], Class['::redis'], Package['sensu-plugin']],
  }

  package { 'sensu-plugin':
    ensure   => 'installed',
    provider => 'gem',
  }

}


node 'sensu-client' {

  class { 'sensu':
    rabbitmq_password => 'password',
    rabbitmq_host     => '33.33.33.90',
    rabbitmq_port     => '5672',
    subscriptions     => 'sensu-test',
    require           => Package['sensu-plugin']
  }

  package { 'sensu-plugin':
    ensure   => 'installed',
    provider => 'gem',
  }

}
