# Define nagios::baseservices
#
# Use this to define Nagios basic service objects that will be
# used for to all nodes
# All local disks, memory, cpu, local users...
# It's automatically loaded in nagios::target
#
# This is an exported resource.
#
define nagios::baseservices (
  $host_name           = $::fqdn,
  $service_description = '',
  $use                 = 'generic-service',
  $template            = 'nagios/baseservices.erb',
  $options_hash        = {},
  $ensure              = 'present'
  ) {

  include nagios::target

  case $::nagios_filemode {

    'concat': {
      if $ensure == 'present' {
        @@concat::fragment { "nagios-${host_name}-baseservices":
          target  => "${nagios::target::customconfigdir}/hosts/${host_name}.cfg",
          order   => 02,
          notify  => Service['nagios'],
          content => template( $template ),
          tag     => "nagios_check_${nagios::target::magic_tag}",
        }
      }
    }

    'pupmod-concat': {
      if $ensure == 'present' {
        @@concat_fragment { "nagios-${host_name}+100_baseservices.tmp":
          content => template( $template ),
        }
      }
    }

    default: {
      @@file { "${nagios::target::customconfigdir}/services/${host_name}-00-baseservices.cfg":
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
