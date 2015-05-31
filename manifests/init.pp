# == Class: sysctl
#
# Full description of class sysctl here.
#
# === Parameters
#
# [*sample_parameter*]
#   Explanation of what this parameter affects and what it defaults to.
#
class sysctl (
  $confdir         = $::sysctl::params::confdir
  $conffile        = $::sysctl::params::conffile
  $customized_file = $::sysctl::params::customized_file
  $entries         = {},
) inherits ::sysctl::params {

  # validate parameters here

  class { '::sysctl::config': } ~>
  class { '::sysctl::service': } ->
  Class['::sysctl']
}
