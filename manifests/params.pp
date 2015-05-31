# == Class sysctl::params
#
# This class is meant to be called from sysctl.
# It sets variables according to platform.
#
class sysctl::params {
  $confdir = '/etc/sysctl.d'
  $conffile = '/etc/sysctl.conf'

  $customized_file = "${confdir}/00-customization.conf"

  $root_group = $::operatingsystem ? {
    /(FreeBSD|Solaris)/ => 'wheel',
    default             => 'root',
  }

  case $::operatingsystem {
    'Debian', 'Ubuntu',
    'RedHat', 'CentOS',
    'Amazon': {
    }
    default: {
      fail("${::operatingsystem} not supported")
    }
  }
}
