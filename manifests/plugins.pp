#
# Class: nagios::plugins
#
# Installs nagios plugins. Needed on hosts with nrpe agent
#
# Usage:
# include nagios::plugins
#
class nagios::plugins {

  # Load the variables used in this module. Check the params.pp file 
  require nagios::params

  # Basic Package 
  package { 'nagios-plugins':
    ensure => present,
    name   => $nagios::params::packagenameplugins,
  }

  # Needed only on the nagios server
  package { 'nagios-plugins-nrpe':
    ensure => present,
    name   => $nagios::params::packagenamenrpeplugin,
  }

  # Include Extra custom Plugins (Provided via Puppet)
  if ( $nagios::params::plugins != 'no') { 
    nagios::plugin { 'check_mount': } 
    nagios::plugin { 'check_ageandcontent.pl': } 
  }

}
