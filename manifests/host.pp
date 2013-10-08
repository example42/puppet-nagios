# Define nagios::host
#
# Use this to define nagios host objects
# This is an exported resource.
# It should be included on the nodes to be monitored
# but has effects on the nagios server
# You can decide what method to use to create resources on the
# nagios server with the $::nagios_filemode top scope variable
# NOTE: THIS MUST BE the same for all nodes
#
# Usage:
# nagios::host { "$fqdn": }
#
define nagios::host (
  $ip            = $::fqdn,
  $short_alias   = $::fqdn,
  $use           = 'generic-host',
  $host_parent   = '',
  $ensure        = 'present',
  $template      = 'nagios/host.erb',
  $options_hash  = {},
  $hostgroups    = 'all'
  ) {

  include nagios::target

  case $::nagios_filemode {

    'concat': {
      if $ensure == 'present' {
        @@concat { "${nagios::target::customconfigdir}/hosts/${name}.cfg":
          owner   => 'root',
          group   => 'root',
          mode    => '0644',
          tag     => "nagios_check_${nagios::target::magic_tag}",
        }
        @@concat::fragment { "nagios-${name}":
          target  => "${nagios::target::customconfigdir}/hosts/${name}.cfg",
          order   => 01,
          notify  => Service['nagios'],
          content => template( $template ),
          tag     => "nagios_check_${nagios::target::magic_tag}",
        }
      }
    }

    'pupmod-concat': {
      if $ensure == 'present' {
        @@concat_build { "nagios-${::hostname}":
          target => "${nagios::target::customconfigdir}/hosts/${name}.cfg",
          order  => ['*.tmp'],
        }
        @@concat_fragment { "nagios-${::hostname}+200_${name}.tmp":
          content => template( $template ),
        }
      }
    }

    default: {
      @@file { "${nagios::target::customconfigdir}/hosts/${name}.cfg":
        ensure  => $ensure,
        mode    => '0644',
        owner   => 'root',
        group   => 'root',
        notify  => Service['nagios'],
        content => template( $template ),
        tag     => "nagios_check_${nagios::target::magic_tag}",
      }
    }

  }

}
