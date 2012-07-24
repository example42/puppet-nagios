# Define: nagios::plugin
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
  $source = ''
  $enable = true
  ) {

  include nagios::params
  include nrpe::params

  $ensure = bool2ensure( $enable )

  $real_source = $source {
    ''      => "nagios/nagios-plugins/${name}",
    default => $source,
  }

  file { "nagios_plugin_${name}":
    path    => "${nrpe::params::pluginsdir}/${name}",
    owner   => root,
    group   => root,
    mode    => 0755,
    ensure  => $ensure,
    source  => "puppet:///modules/${source}",
    require => Package['nagios-plugins'],
  }

}
