# Define nagios::command
#
# Use this to define nagios command objects
#
define nagios::command ( $command_line  = '' , $ensure = 'present' ) {

  require nagios

  file { "${nagios::customconfigdir}/commands/${name}.cfg":
    ensure  => $ensure,
    mode    => $nagios::config_file_mode,
    owner   => $nagios::config_file_owner,
    group   => $nagios::config_file_group,
    notify  => Service['nagios'],
    content => template( 'nagios/command.erb' ),
  }

}
