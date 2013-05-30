#
# Class: nagios::target
#
# Basic host target class
# Include it on nodes to be monitored by nagios
#
# Usage:
# include nagios::target
#
class nagios::target {

  case $nagios::target_host_options {
    undef:   { $target_host_options = {} }
    default: { $target_host_options = $nagios::target_host_options }
  }

  case $target_host_options['host_parent'] {
    undef:   { $target_host_options['host_parent'] = '' }
    default: { }
  }

  # This variable defines where nagios automatically generated 
  # files are places. This MUST be the same of $::nagios::customconfigdir
  # HINT: Do not mess with default path names...

  $customconfigdir = $::nagios_customconfigdir ? {
    ''      => '/etc/nagios/auto.d',
    default => $::nagios_customconfigdir,
  }

  # TODO: Find a smarter solution that doesn't requre TopScope Variables
  $magic_tag = get_magicvar($::nagios_grouplogic)

  if !defined(Nagios::Host[$::fqdn]) {
    nagios::host { $::fqdn:
      use => 'generic-host',
      host_parent => $target_host_options['host_parent']
    }
  }

  nagios::baseservices { $::fqdn:
    use => 'generic-service',
  }

  include nagios::plugins

# TODO: Automatic hostgroup management is broken. We'll review it later
#  nagios::hostgroup { "${nagios::params::hostgroups}-$fqdn": 
#    hostgroup => "${nagios::params::hostgroups}",
#  }

}
