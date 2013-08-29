#
# Class: nagios::plugins
#
# Installs Nagios custom plugins used in Example42 modules
#
# Usage:
# include nagios::plugins
#
class nagios::plugins {

  $nagios_check_disks_nrpe_cfg = $::nagios_check_disks_nrpe_cfg ? {
    ''      => 'nagios/nrpe_cfg/nrpe-check_disk.cfg.erb',
    default => $::nagios_check_disks_nrpe_cfg,
  }

  # Include Extra custom Plugins (Provided via Puppet)
  nagios::plugin { 'check_mount': }
  nagios::plugin { 'check_disks':
    source   => 'no' ,
    nrpe_cfg => $nagios_check_disks_nrpe_cfg,
  }
  nagios::plugin { 'check_yum':
    nrpe_cfg => 'nagios/nrpe_cfg/nrpe-check_yum.cfg.erb',
  }
  nagios::plugin { 'check_ageandcontent.pl': }

}
