# == Class sysctl::config
#
# This class is called from sysctl for service config.
#
# sysctl::entries:
#   net.ipv4.ip_forward:
#     value: '1'

class sysctl::config {

  $entries = hiera_hash('sysctl::entries', undef)

  $system_defaults = {
    ensure => absent,
    target => "${conffile}",
    apply  => false,
  }

  $custom_defaults = {
    ensure => present,
    target => "${customized_file}",
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
    # Customized kernel parameter always be removed from system default settings.
    create_resources(sysctl, $entries, $system_defaults)

    # Setup customized parameter
    create_resources(sysctl, $entries, $custom_defaults)
  }
}
