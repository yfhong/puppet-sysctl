# == Class sysctl::service
#
# This class is meant to be called from sysctl.
# It ensure the service is running.
#
class sysctl::service {

  exec { 'refresh_sysctl':
    command => 'sysctl -p',
    path    => '/usr/local/sbin:/usr/local/bin:/usr/sbin:/usr/bin:/sbin:/bin',
  }
}
