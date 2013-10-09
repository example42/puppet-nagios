# Define nagios::contactgroup
#
# Use this to define nagios contact group objects
# It creates a contactgroup_${name}.cfg in settings dir
# Define parameters are the same Nagios contact parameters
#
define nagios::contactgroup (
  $members,
  $alias                          = $name,
  $options_hash                   = {},
  $ensure                         = 'present'
) {

  include nagios

  file { "${nagios::customconfigdir}/settings/contactgroup_${name}.cfg":
    ensure  => $ensure,
    mode    => $nagios::config_file_mode,
    owner   => $nagios::config_file_owner,
    group   => $nagios::config_file_group,
    notify  => Service['nagios'],
    content => template( 'nagios/contactgroup.erb' ),
  }

}
