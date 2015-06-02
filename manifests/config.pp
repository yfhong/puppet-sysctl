# == Class sysctl::config
#
# This class is called from sysctl for service config.
#
class sysctl::config {

  $entries = hiera_hash('sysctl::entries')

  file { $::sysctl::conffile:
    ensure  => 'present',
    owner   => 'root',
    group   => $::sysctl::params::root_group,
    mode    => '0640',
    content => '',
  }

  file { $::sysctl::confdir:
    ensure  => 'directory',
    owner   => 'root',
    group   => $::sysctl::params::root_group,
    mode    => '0750',
    purge   => true,
    recurse => true,
  }

  file { $::sysctl::customized_file:
    ensure  => 'present',
    owner   => 'root',
    group   => $::sysctl::params::root_group,
    mode    => '0640',
    content => template('sysctl/customization.conf.erb'),
  }
}
