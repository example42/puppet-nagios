# Define nagios::command
#
# Use this to define nagios command objects
#
define nagios::command ( $command_line  = '' , ensure => 'present' ) {

  require nagios

  file { "${nagios::customconfigdir}/commands/${name}.cfg":
    ensure  => $ensure,
    mode    => $nagios::configfile_mode,
    owner   => $nagios::configfile_owner,
    group   => $nagios::configfile_group,
    notify  => Service['nagios'],
    content => template( 'nagios/command.erb' ),
  }

}
