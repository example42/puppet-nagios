# Define: pagios::plugin
#
# Adds a custom nagios plugin
#
# Usage:
# With standard source (looked in icing/files/nagios-plugins/$name):
# nagios::plugin { 'check_mount': }
#
# With custom source (looked in source => $source)
# nagios::plugin { 'check_orientdb':
#   source => 'orientdb/nagios-plugins/check_orientdb.sh'
# }
define nagios::plugin (
  $source       = '',
  $nrpe_cfg     = '',
  $options_hash = {},
  $enable       = true
  ) {

  include nrpe

  $ensure = bool2ensure( $enable )

  $real_source = $source ? {
    ''      => "nagios/nagios-plugins/${name}",
    default => $source,
  }

  if ( $source != 'no' ) {
    file { "nagios_plugin_${name}":
      ensure   => $ensure,
      path     => "${nrpe::pluginsdir}/${name}",
      owner    => 'root',
      group    => 'root',
      mode     => '0755',
      source   => "puppet:///modules/${real_source}",
      require  => Class['nrpe'],
      seluser  => 'system_u',
      selrole  => 'object_r',
      seltype  => 'nagios_system_plugin_exec_t',
      selrange => 's0',
    }
  }

  if ( $nrpe_cfg != '' ) {
    file { "nrpe_nagios_plugin_${name}":
      ensure  => $ensure,
      path    => "${nrpe::config_dir}/${name}.cfg",
      owner   => 'root',
      group   => 'root',
      mode    => '0755',
      notify  => $nrpe::manage_service_autorestart,
      content => template($nrpe_cfg),
    }
  }
}
