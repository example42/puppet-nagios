# Define nagios::contact
#
# Use this to define nagios contact objects
# It creates a contact_${name}.cfg in settings dir
# Define parameters are the same Nagios contact parameters
#
define nagios::contact (
  $alias                          = $name,
  $service_notification_period    = '24x7',
  $host_notification_period       = '24x7',
  $service_notification_options   = 'w,u,c,r',
  $host_notification_options      = 'd,r',
  $service_notification_commands  = 'notify-service-by-email',
  $host_notification_commands     = 'notify-host-by-email',
  $email                          = 'root@localhost',
  $pager                          = '',
  $options_hash                   = {},
  $ensure                         = 'present' ) {

  include nagios

  file { "${nagios::customconfigdir}/settings/contact_${name}.cfg":
    ensure  => $ensure,
    mode    => $nagios::config_file_mode,
    owner   => $nagios::config_file_owner,
    group   => $nagios::config_file_group,
    notify  => Service['nagios'],
    content => template( 'nagios/contact.erb' ),
  }

}
