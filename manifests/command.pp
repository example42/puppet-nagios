# Define nagios::command
#
# Use this to define nagios command objects
#
define nagios::command ( $command_line  = '' ) {

  require nagios

  file { "${nagios::customconfigdir}/commands/${name}.cfg":
    mode    => $nagios::configfile_mode,
    owner   => $nagios::configfile_owner,
    group   => $nagios::configfile_group,
    ensure  => present,
    notify  => Service['nagios'],
    content => template( 'nagios/command.erb' ),
  }

}
