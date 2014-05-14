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

  $manual_dir_source = undef
  $manual_dir_purge = false

  $install_prerequisites = true

  # Default nagiosadmin password is 'example42'
  $nagiosadmin_password = 'B5dPQYYjf.jjA'
  $nagiosadmin_email = 'root@localhost'
  $nagiosadmins_members = 'nagiosadmin'

  $grouplogic = ''

  $check_external_commands = true

  $plugins = true

  $use_ssl = true

  $cachedir = $::operatingsystem ? {
    /(?i:RedHat|Centos|Scientific|Fedora|Amazon|Linux)/ => '/var/log/nagios',
    /(?i:Debian|Ubuntu|Mint)/                           => '/var/cache/nagios3',
    default                                             => '/var/cache/nagios',
  }

  $resourcefile = $::operatingsystem ? {
    /(?i:RedHat|Centos|Scientific|Fedora|Amazon|Linux)/ => '/etc/nagios/private/resource.cfg',
    /(?i:Debian|Ubuntu|Mint)/                           => '/etc/nagios3/resource.cfg',
    default                                             => '/etc/nagios/resource.cfg',
  }

  $statusfile = $::operatingsystem ? {
    /(?i:RedHat|Centos|Scientific|Fedora|Amazon|Linux)/ => '/var/log/nagios/status.dat',
    /(?i:Debian|Ubuntu|Mint)/                           => '/var/cache/nagios3/status.dat',
    default                                             => '/var/lib/nagios/status.dat',
  }

  $commandfile = $::operatingsystem ? {
    /(?i:RedHat|Centos|Scientific|Fedora|Amazon|Linux)/ => '/var/spool/nagios/cmd/nagios.cmd',
    /(?i:Debian|Ubuntu|Mint)/                           => '/var/lib/nagios3/rw/nagios.cmd',
    default                                             => '/var/lib/nagios/rw/nagios.cmd',
  }

  $resultpath = $::operatingsystem ? {
    /(?i:RedHat|Centos|Scientific|Fedora|Amazon|Linux)/ => '/var/log/nagios/spool/checkresults',
    /(?i:Debian|Ubuntu|Mint)/                           => '/var/lib/nagios3/spool/checkresults',
    default                                             => '/var/lib/nagios/spool/checkresults',
  }

  $retentionfile = $::operatingsystem ? {
    /(?i:RedHat|Centos|Scientific|Fedora|Amazon|Linux)/ => '/var/log/nagios/retention.dat',
    /(?i:Debian|Ubuntu|Mint)/                           => '/var/lib/nagios3/retention.dat',
    default                                             => '/var/lib/nagios/retention.dat',
  }

  $p1file  = $::operatingsystem ? {
    /(?i:RedHat|Centos|Scientific|Fedora|Amazon|Linux)/ => '/usr/sbin/p1.pl',
    /(?i:Debian|Ubuntu|Mint)/                           => '/usr/lib/nagios3/p1.pl',
    default                                             => '/usr/lib/nagios/p1.pl',
  }

  $nrpepluginpackage = $::operatingsystem ? {
    /(?i:RedHat|Centos|Scientific|Fedora|Amazon|Linux)/ => 'nagios-plugins-nrpe',
    default                                             => 'nagios-nrpe-plugin',
  }

  $pluginspackage = $::operatingsystem ? {
    /(?i:RedHat|Centos|Scientific|Fedora|Amazon|Linux)/ => 'nagios-plugins-all',
    default                                             => 'nagios-plugins',
  }

  $htpasswdfile = $::operatingsystem ? {
    /(?i:Debian|Ubuntu|Mint)/ => '/etc/nagios3/htpasswd.users',
    default                   => '/etc/nagios/htpasswd.users',
  }


  ### Application related parameters

  $package = $::operatingsystem ? {
    /(?i:Debian|Ubuntu|Mint)/ => 'nagios3',
    default                   => 'nagios',
  }

  $service = $::operatingsystem ? {
    /(?i:Debian|Ubuntu|Mint)/ => 'nagios3',
    default                   => 'nagios',
  }

  $service_status = $::operatingsystem ? {
    default => true,
  }

  $process = $::operatingsystem ? {
    /(?i:Debian|Ubuntu|Mint)/ => 'nagios3',
    default                   => 'nagios',
  }

  $process_args = $::operatingsystem ? {
    default => '',
  }

  $process_user = $::operatingsystem ? {
    /(?i:Debian|Ubuntu|Mint)/ => 'nagios',
    default                   => 'nagios',
  }

  $config_dir = $::operatingsystem ? {
    /(?i:Debian|Ubuntu|Mint)/ => '/etc/nagios3',
    default                   => '/etc/nagios',
  }

  $config_file = $::operatingsystem ? {
    /(?i:Debian|Ubuntu|Mint)/ => '/etc/nagios3/nagios.cfg',
    default                   => '/etc/nagios/nagios.cfg',
  }

  $config_file_mode = $::operatingsystem ? {
    /(?i:RedHat|Scientific|Centos|Amazon|Linux)/ => '0664',
    default                                      => '0644',
  }

  $config_file_owner = $::operatingsystem ? {
    /(?i:RedHat|Scientific|Centos|Amazon|Linux)/ => 'nagios',
    default                                      => 'root',
  }

  $config_file_group = $::operatingsystem ? {
    /(?i:RedHat|Scientific|Centos|Amazon|Linux)/ => 'nagios',
    default                                      => 'root',
  }

  $config_file_init = $::operatingsystem ? {
    /(?i:Debian|Ubuntu|Mint)/ => '/etc/default/nagios3',
    default                   => '/etc/sysconfig/nagios',
  }

  $pid_file = $::operatingsystem ? {
    /(?i:RedHat|Scientific|Centos|Amazon|Linux)/ => '/var/run/nagios.pid',
    /(?i:Debian|Ubuntu|Mint)/                    => '/var/run/nagios3/nagios3.pid',
    default                                      => '/var/run/nagios/nagios.pid',
  }

  $data_dir = $::operatingsystem ? {
    /(?i:Debian|Ubuntu|Mint)/ => '/var/lib/nagios3',
    default                   => '/var/lib/nagios',
  }

  $log_dir = $::operatingsystem ? {
    /(?i:Debian|Ubuntu|Mint)/ => '/var/log/nagios3',
    default                   => '/var/log/nagios',
  }

  $log_file = $::operatingsystem ? {
    /(?i:Debian|Ubuntu|Mint)/ => '/var/log/nagios3/nagios.log',
    default                   => '/var/log/nagios/nagios.log',
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
