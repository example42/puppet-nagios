# Define nagios::hostgroup
#
#
define nagios::hostgroup (
  $members,
  $alias_name,
  $ensure        = 'present',
  $template      = 'nagios/hostgroup.erb',
  ) {

  include nagios::target

  case $::nagios_filemode {

    'concat': {
      if $ensure == 'present' {
        @@concat { "${nagios::target::customconfigdir}/hostsgroups/${name}.cfg":
          owner   => 'root',
          group   => 'root',
          mode    => '0644',
          tag     => "nagios_check_${nagios::target::magic_tag}",
        }
        @@concat::fragment { "nagios-${name}":
          target  => "${nagios::target::customconfigdir}/hostsgroups/${name}.cfg",
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
          target => "${nagios::target::customconfigdir}/hostgroups/${name}.cfg",
          order  => ['*.tmp'],
        }
        @@concat_fragment { "nagios-${::hostname}+200_${name}.tmp":
          content => template( $template ),
        }
      }
    }

    default: {
      @@file { "${nagios::target::customconfigdir}/hostgroups/${name}.cfg":
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

