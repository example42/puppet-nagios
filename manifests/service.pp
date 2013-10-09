# Define nagios::service
#
# Use this to define nagios service objects
# This is an exported resource.
# It should be included on the nodes to be monitored but
# has effects on the nagios server
# You can decide what method to use to create resources on the
# nagios server with the $::nagios_filemode top scope variable
# NOTE: THIS MUST BE the same for all nodes
#
define nagios::service (
  $host_name           = $::fqdn,
  $check_command       = '',
  $service_description = '',
  $use                 = 'generic-service',
  $template            = 'nagios/service.erb',
  $options_hash        = {},
  $ensure              = 'present'
  ) {

  # Autoinclude the target host class
  # (each service must have a defined host)
  include nagios::target

  # Set defaults based on the same define $name
  $real_check_command = $check_command ? {
    ''      => $name,
    default => $check_command,
  }

  $real_service_description = $service_description ? {
    ''      => $name,
    default => $service_description,
  }

  case $::nagios_filemode {

    'concat': {
      if $ensure == 'present' {
        @@concat::fragment { "nagios-${host_name}-${name}":
          target  => "${nagios::target::customconfigdir}/hosts/${host_name}.cfg",
          order   => 05,
          notify  => Service['nagios'],
          content => template( $template ),
          tag     => "nagios_check_${nagios::target::magic_tag}",
        }
      }
    }

    'pupmod-concat': {
      if $ensure == 'present' {
        @@concat_fragment { "nagios-${host_name}+200_${name}.tmp":
          content => template( $template ),
        }
      }
    }

    default: {
      @@file { "${nagios::target::customconfigdir}/services/${host_name}-${name}.cfg":
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
