# Class: nagios::skel
#
# Some extra stuff necessary for Example42 nagios implementation
# Needed to make things go smoothly
#
# Usage:
# Autoincluded by nagios class
#
class nagios::skel {

  include nagios

  file { 'nagios_configdir':
    ensure  => directory,
    path    => $nagios::customconfigdir,
    mode    => '0755',
    owner   => $nagios::config_file_owner,
    group   => $nagios::config_file_group,
    require => Package['nagios'],
  }

  file { 'nagios_configdir_hosts':
    ensure  => directory,
    path    => "${nagios::customconfigdir}/hosts",
    mode    => '0755',
    owner   => $nagios::config_file_owner,
    group   => $nagios::config_file_group,
    require => File['nagios_configdir'],
    recurse => true,
    purge   => $nagios::bool_source_dir_purge,
    force   => true,
  }

  file { 'nagios_configdir_services':
    ensure  => directory,
    path    => "${nagios::customconfigdir}/services",
    mode    => '0755',
    owner   => $nagios::config_file_owner,
    group   => $nagios::config_file_group,
    require => File['nagios_configdir'],
    recurse => true,
    purge   => $nagios::bool_source_dir_purge,
    force   => true,
  }

  file { 'nagios_configdir_commands':
    ensure  => directory,
    path    => "${nagios::customconfigdir}/commands",
    mode    => '0755',
    owner   => $nagios::config_file_owner,
    group   => $nagios::config_file_group,
    require => File['nagios_configdir'],
  }

  file { 'nagios_configdir_settings':
    ensure  => directory,
    path    => "${nagios::customconfigdir}/settings",
    mode    => '0755',
    owner   => $nagios::config_file_owner,
    group   => $nagios::config_file_group,
    require => File['nagios_configdir'],
  }

  file { 'nagios_configdir_hostgroups':
    ensure  => directory,
    path    => "${nagios::customconfigdir}/hostgroups",
    mode    => '0755',
    owner   => $nagios::config_file_owner,
    group   => $nagios::config_file_group,
    require => File['nagios_configdir'],
  }

  file { 'nagios_configdir_extra':
    ensure  => directory,
    path    => "${nagios::customconfigdir}/extra",
    mode    => '0755',
    owner   => $nagios::config_file_owner,
    group   => $nagios::config_file_group,
    require => File['nagios_configdir'],
  }

  file { 'nagios_modulesdir':
    ensure  => directory,
    path    => "${nagios::config_dir}/modules",
    mode    => '0755',
    owner   => $nagios::config_file_owner,
    group   => $nagios::config_file_group,
    require => File['nagios_configdir'],
  }

  # Basic configurations
  file { 'nagios_commands_general.cfg':
    ensure  => $nagios::manage_file,
    path    => "${nagios::customconfigdir}/commands/general.cfg",
    mode    => '0644',
    owner   => $nagios::config_file_owner,
    group   => $nagios::config_file_group,
    require => File['nagios_configdir_commands'],
    content => template('nagios/commands/general.cfg'),
  }

  file { 'nagios_commands_extra.cfg':
    ensure  => $nagios::manage_file,
    path    => "${nagios::customconfigdir}/commands/extra.cfg",
    mode    => '0644',
    owner   => $nagios::config_file_owner,
    group   => $nagios::config_file_group,
    require => File['nagios_configdir_commands'],
    content => template('nagios/commands/extra.cfg'),
  }

  file { 'nagios_commands_special.cfg':
    ensure  => $nagios::manage_file,
    path    => "${nagios::customconfigdir}/commands/special.cfg",
    mode    => '0644',
    owner   => $nagios::config_file_owner,
    group   => $nagios::config_file_group,
    require => File['nagios_configdir_commands'],
    content => template('nagios/commands/special.cfg'),
  }

  # Temporary removal of old default contact file
  # Contacts are now managed via defines
  file { 'nagios_contacts.cfg':
    ensure  => absent,
    path    => "${nagios::customconfigdir}/settings/contacts.cfg",
    mode    => '0644',
    owner   => $nagios::config_file_owner,
    group   => $nagios::config_file_group,
    require => File['nagios_configdir_settings'],
    content => template('nagios/settings/contacts.cfg'),
  }

  nagios::contact { 'nagiosadmin':
    email   => $nagios::nagiosadmin_email,
  }
  nagios::contactgroup { 'admins':
    alias   => 'Nagios Administrators',
    members => $nagios::nagiosadmins_members,
  }


  file { 'nagios_timeperiods.cfg':
    ensure  => $nagios::manage_file,
    path    => "${nagios::customconfigdir}/settings/timeperiods.cfg",
    mode    => '0644',
    owner   => $nagios::config_file_owner,
    group   => $nagios::config_file_group,
    require => File['nagios_configdir_settings'],
    content => template('nagios/settings/timeperiods.cfg'),
  }

  file { 'nagios_templates.cfg':
    ensure  => $nagios::manage_file,
    path    => "${nagios::customconfigdir}/settings/templates.cfg",
    mode    => '0644',
    owner   => $nagios::config_file_owner,
    group   => $nagios::config_file_group,
    require => File['nagios_configdir_settings'],
    content => template('nagios/settings/templates.cfg'),
  }

  file { 'nagios_hostgroup_all.cfg':
    ensure  => $nagios::manage_file,
    path    => "${nagios::customconfigdir}/hostgroups/all.cfg",
    mode    => '0644',
    owner   => $nagios::config_file_owner,
    group   => $nagios::config_file_group,
    require => File['nagios_configdir_hostgroups'],
    content => template('nagios/hostgroups/all.cfg'),
  }

  # nagios group needs permission to write in /var/lib/nagios3/rw
  if $::operatingsystem =~ /(?i:Debian|Ubuntu|Mint)/ {
    file { '/var/lib/nagios3/rw':
      ensure  => directory,
      mode    => '0770',
      owner   => $nagios::process_user,
      group   => $nagios::process_user,
      require => Package["nagios"],
    }
  }

}
