# == Class sysctl::config
#
# This class is called from sysctl for service config.
#
# sysctl::entries:
#   net.ipv4.ip_forward:
#     value: '1'

class sysctl::config {

  $entries = hiera_hash('sysctl::entries', undef)

  $custom_defaults = {
    ensure => present,
    apply  => true,
  }

  file { $::sysctl::confdir:
    ensure  => 'directory',
    owner   => 'root',
    group   => $::sysctl::params::root_group,
    mode    => '0755',
    purge   => true,
    recurse => true,
  }

  if ($entries) {
    # Setup customized parameter
    create_resources(sysctl, $entries, $custom_defaults)
  }
}
