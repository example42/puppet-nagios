# Class: nagios::params
#
# This class defines default parameters used by the main module class nagios
# Operating Systems differences in names and paths are addressed here
#
# == Variables
#
# Refer to nagios class for the variables defined here.
#
# == Usage
#
# This class is not intended to be used directly.
# It may be imported or inherited by other classes
#
class nagios::params {

  $grouplogic = ''

  $check_external_commands = true

  $plugins = true

  $use_ssl = true

  $cachedir = $::operatingsystem ? {
    /(?i:RedHat|Centos|Scientific|Fedora)/ => '/var/log/nagios',
    default                                => '/var/cache/nagios',
  }

  $resourcefile = $::operatingsystem ? {
    /(?i:RedHat|Centos|Scientific|Fedora)/ => '/etc/nagios/private/resource.cfg',
    default                                => '/etc/nagios/resource.cfg',
  }

  $statusfile = $::operatingsystem ? {
    /(?i:RedHat|Centos|Scientific|Fedora)/ => '/var/log/nagios/status.dat',
    default                                => '/var/lib/nagios/status.dat',
  }

  $commandfile = $::operatingsystem ? {
    /(?i:RedHat|Centos|Scientific|Fedora)/ => '/var/spool/nagios/cmd',
    default                                => '/var/lib/nagios/rw/nagios.cmd',
  }

  $resultpath = $::operatingsystem ? {
    /(?i:RedHat|Centos|Scientific|Fedora)/ => '/var/log/nagios/spool/checkresults',
    default                                => '/var/lib/nagios/spool/checkresults',
  }

  $retentionfile = $::operatingsystem ? {
    /(?i:RedHat|Centos|Scientific|Fedora)/ => '/var/log/nagios/retention.dat',
    default                                => '/var/lib/nagios/retention.dat',
  }

  $p1file  = $::operatingsystem ? {
    /(?i:RedHat|Centos|Scientific|Fedora)/ => '/usr/sbin/p1.pl',
    default                                => '/usr/lib/nagios/p1.pl',
  }

  $nrpepluginpackage = $::operatingsystem ? {
    /(?i:RedHat|Centos|Scientific|Fedora)/ => 'nagios-plugins-nrpe',
    default                                => 'nagios-nrpe-plugin',
  }

  $pluginspackage = $::operatingsystem ? {
    /(?i:RedHat|Centos|Scientific|Fedora)/ => 'nagios-plugins-all',
    default                                => 'nagios-plugins',
  }

  $htpasswdfile = $::operatingsystem ? {
    default => '/etc/nagios/htpasswd.users',
  }


  ### Application related parameters

  $package = $::operatingsystem ? {
    default => 'nagios',
  }

  $service = $::operatingsystem ? {
    default => 'nagios',
  }

  $service_status = $::operatingsystem ? {
    default => true,
  }

  $process = $::operatingsystem ? {
    default => 'nagios',
  }

  $process_args = $::operatingsystem ? {
    default => '',
  }

  $process_user = $::operatingsystem ? {
    /(?i:Debian|Ubuntu|Mint)/ => 'nagios',
    default                   => 'nagios',
  }

  $config_dir = $::operatingsystem ? {
    default => '/etc/nagios',
  }

  $config_file = $::operatingsystem ? {
    default => '/etc/nagios/nagios.cfg',
  }

  $config_file_mode = $::operatingsystem ? {
    /(?i:RedHat|Scientific|Centos)/ => '0664',
    default                         => '0644',
  }

  $config_file_owner = $::operatingsystem ? {
    /(?i:RedHat|Scientific|Centos)/ => 'nagios',
    default                         => 'root',
  }

  $config_file_group = $::operatingsystem ? {
    /(?i:RedHat|Scientific|Centos)/ => 'nagios',
    default                         => 'root',
  }

  $config_file_init = $::operatingsystem ? {
    /(?i:Debian|Ubuntu|Mint)/ => '/etc/default/nagios',
    default                   => '/etc/sysconfig/nagios',
  }

  $pid_file = $::operatingsystem ? {
    /(?i:RedHat|Scientific|Centos)/ => '/var/run/nagios.pid',
    default                         => '/var/run/nagios/nagios.pid',
  }

  $data_dir = $::operatingsystem ? {
    /(?i:RedHat|Scientific|Centos)/ => '/var/log/nagios', 
    default                         => '/var/lib/nagios',
  }

  $log_dir = $::operatingsystem ? {
    default => '/var/log/nagios',
  }

  $log_file = $::operatingsystem ? {
    default => '/var/log/nagios/nagios.log',
  }

  # General Settings
  $my_class = ''
  $source = ''
  $source_dir = ''
  $source_dir_purge = false
  $template = 'nagios/nagios.cfg.erb'
  $options = ''
  $service_autorestart = true
  $version = 'present'
  $absent = false
  $disable = false
  $disableboot = false

  ### General module variables that can have a site or per module default
  $monitor = false
  $monitor_tool = ''
  $monitor_target = $::ipaddress
  $puppi = false
  $puppi_helper = 'standard'
  $debug = false
  $audit_only = false

}
