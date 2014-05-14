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
  # # #
  # Here is defined where on nagios server check files are saved
  # This MUST be the same of $::nagios::customconfigdir
  # HINT: Do not mess with default path names...

  $customconfigdir = $::nagios_customconfigdir ? {
    ''      => '/etc/nagios/auto.d',
    undef   => '/etc/nagios/auto.d',
    default => $::nagios_customconfigdir,
  }

  # TODO: Find a smarter solution that doesn't requre TopScope Variables
  $magic_tag = get_magicvar($::nagios_grouplogic)

  if !defined(Nagios::Host[$::fqdn]) {
    $host_template = $::nagios_host_template ? {
      ''      => 'nagios/host.erb',
      default => $::nagios_host_template,
    }
    nagios::host { $::fqdn:
      use      => 'generic-host',
      template => $host_template,
    }
  }

  $baseservices_template = $::nagios_baseservices_template ? {
    ''      => 'nagios/baseservices.erb',
    default => $::nagios_baseservices_template,
  }
  nagios::baseservices { $::fqdn:
    use      => 'generic-service',
    template => $baseservices_template,
  }

  include nagios::plugins

# TODO: Automatic hostgroup management is broken. We'll review it later
#  nagios::hostgroup { "${nagios::params::hostgroups}-$fqdn":
#    hostgroup => "${nagios::params::hostgroups}",
#  }

}
