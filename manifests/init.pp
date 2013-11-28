# = Class: nagios
#
# This is the main nagios class
#
#
# == Parameters
#
# Module specific parameters
#
# [*manual_dir_source*]
#   If defined, the /etc/nagios/auto.d/manual directory is built
#   recursively from the specified source
#
# [*manual_dir_purge*]
#   If set to true (default false) the any existing file on 
#   /etc/nagios/auto.d/manual not present on the source
#   path specified in manual_dir_source is deleted
#
# [*install_prerequisites*]
#
# [*nagiosadmin_password*]
#  Crypted password for nagiosadmin user.
#  Default (in cleartext): 'example42'
#
# [*nagiosadmin_email*]
#  Email of nagiosadmin user
#  Default: 'root@localhost'
#
# [*nagiosadmins_members*]
#  Comma separated list of the members of the nagiosadmins group.
#  Default: 'nagiosadmin'
#
# [*check_external_commands*]
#
# [*plugins*]
#
# [*use_ssl*]
#
# [*cachedir*]
#
# [*resourcefile*]
#
# [*statusfile*]
#
# [*commandfile*]
#
# [*resultpath*]
#
# [*retentionfile*]
#
# [*p1file*]
#
# [*nrpepluginpackage*]
#
# [*htpasswdfile*]
#
# Standard class parameters
# Define the general class behaviour and customizations
#
# [*my_class*]
#   Name of a custom class to autoload to manage module's customizations
#   If defined, nagios class will automatically "include $my_class"
#   Can be defined also by the (top scope) variable $nagios_myclass
#
# [*source*]
#   Sets the content of source parameter for main configuration file
#   If defined, nagios main config file will have the param: source => $source
#   Can be defined also by the (top scope) variable $nagios_source
#
# [*source_dir*]
#   If defined, the whole nagios configuration directory content is retrieved
#   recursively from the specified source
#   (source => $source_dir , recurse => true)
#   Can be defined also by the (top scope) variable $nagios_source_dir
#
# [*source_dir_purge*]
#   If set to true (default false) the existing configuration directory is
#   mirrored with the content retrieved from source_dir
#   (source => $source_dir , recurse => true , purge => true)
#   Can be defined also by the (top scope) variable $nagios_source_dir_purge
#
# [*template*]
#   Sets the path to the template to use as content for main configuration file
#   If defined, nagios main config file has: content => content("$template")
#   Note source and template parameters are mutually exclusive: don't use both
#   Can be defined also by the (top scope) variable $nagios_template
#
# [*options*]
#   An hash of custom options to be used in templates for arbitrary settings.
#   Can be defined also by the (top scope) variable $nagios_options
#
# [*service_autorestart*]
#   Automatically restarts the nagios service when there is a change in
#   configuration files. Default: true, Set to false if you don't want to
#   automatically restart the service.
#
# [*version*]
#   The package version, used in the ensure parameter of package type.
#   Default: present. Can be 'latest' or a specific version number.
#   Note that if the argument absent (see below) is set to true, the
#   package is removed, whatever the value of version parameter.
#
# [*absent*]
#   Set to 'true' to remove package(s) installed by module
#   Can be defined also by the (top scope) variable $nagios_absent
#
# [*disable*]
#   Set to 'true' to disable service(s) managed by module
#   Can be defined also by the (top scope) variable $nagios_disable
#
# [*disableboot*]
#   Set to 'true' to disable service(s) at boot, without checks if it's running
#   Use this when the service is managed by a tool like a cluster software
#   Can be defined also by the (top scope) variable $nagios_disableboot
#
# [*monitor*]
#   Set to 'true' to enable monitoring of the services provided by the module
#   Can be defined also by the (top scope) variables $nagios_monitor
#   and $monitor
#
# [*monitor_tool*]
#   Define which monitor tools (ad defined in Example42 monitor module)
#   you want to use for nagios checks
#   Can be defined also by the (top scope) variables $nagios_monitor_tool
#   and $monitor_tool
#
# [*monitor_target*]
#   The Ip address or hostname to use as a target for monitoring tools.
#   Default is the fact $ipaddress
#   Can be defined also by the (top scope) variables $nagios_monitor_target
#   and $monitor_target
#
# [*puppi*]
#   Set to 'true' to enable creation of module data files that are used by puppi
#   Can be defined also by the (top scope) variables $nagios_puppi and $puppi
#
# [*puppi_helper*]
#   Specify the helper to use for puppi commands. The default for this module
#   is specified in params.pp and is generally a good choice.
#   You can customize the output of puppi commands for this module using another
#   puppi helper. Use the define puppi::helper to create a new custom helper
#   Can be defined also by the (top scope) variables $nagios_puppi_helper
#   and $puppi_helper
#
# [*debug*]
#   Set to 'true' to enable modules debugging
#   Can be defined also by the (top scope) variables $nagios_debug and $debug
#
# [*audit_only*]
#   Set to 'true' if you don't intend to override existing configuration files
#   and want to audit the difference between existing files and the ones
#   managed by Puppet.
#   Can be defined also by the (top scope) variables $nagios_audit_only
#   and $audit_only
#
# Default class params - As defined in nagios::params.
# Note that these variables are mostly defined and used in the module itself,
# overriding the default values might not affected all the involved components.
# Set and override them only if you know what you're doing.
# Note also that you can't override/set them via top scope variables.
#
# [*package*]
#   The name of nagios package
#
# [*service*]
#   The name of nagios service
#
# [*service_status*]
#   If the nagios service init script supports status argument
#
# [*process*]
#   The name of nagios process
#
# [*process_args*]
#   The name of nagios arguments. Used by puppi and monitor.
#   Used only in case the nagios process name is generic (java, ruby...)
#
# [*process_user*]
#   The name of the user nagios runs with. Used by puppi and monitor.
#
# [*config_dir*]
#   Main configuration directory. Used by puppi
#
# [*config_file*]
#   Main configuration file path
#
# [*config_file_mode*]
#   Main configuration file path mode
#
# [*config_file_owner*]
#   Main configuration file path owner
#
# [*config_file_group*]
#   Main configuration file path group
#
# [*config_file_init*]
#   Path of configuration file sourced by init script
#
# [*pid_file*]
#   Path of pid file. Used by monitor
#
# [*data_dir*]
#   Path of application data directory. Used by puppi
#
# [*log_dir*]
#   Base logs directory. Used by puppi
#
# [*log_file*]
#   Log file(s). Used by puppi
#
#
# == Examples
#
# You can use this class in 2 ways:
# - Set variables (at top scope level on in a ENC) and "include nagios"
# - Call nagios as a parametrized class
#
# See README for details.
#
#
# == Author
#   Alessandro Franceschi <al@lab42.it/>
#
class nagios (
  # $grouplogic            = params_lookup( 'grouplogic' ),
  $manual_dir_source       = params_lookup('manual_dir_source'),
  $manual_dir_purge        = params_lookup('manual_dir_purge'),
  $install_prerequisites   = params_lookup('install_prerequisites'),
  $nagiosadmin_password    = params_lookup('nagiosadmin_password'),
  $nagiosadmin_email       = params_lookup('nagiosadmin_email'),
  $nagiosadmins_members    = params_lookup('nagiosadmins_members'),
  $check_external_commands = params_lookup( 'check_external_commands' ),
  $plugins                 = params_lookup( 'plugins' ),
  $use_ssl                 = params_lookup( 'use_ssl' ),
  $cachedir                = params_lookup( 'cachedir' ),
  $resourcefile            = params_lookup( 'resourcefile' ),
  $statusfile              = params_lookup( 'statusfile' ),
  $commandfile             = params_lookup( 'commandfile' ),
  $resultpath              = params_lookup( 'resultpath' ),
  $retentionfile           = params_lookup( 'retentionfile' ),
  $p1file                  = params_lookup( 'p1file' ),
  $nrpepluginpackage       = params_lookup( 'nrpepluginpackage' ),
  $htpasswdfile            = params_lookup( 'htpasswdfile' ),
  $my_class                = params_lookup( 'my_class' ),
  $source                  = params_lookup( 'source' ),
  $source_dir              = params_lookup( 'source_dir' ),
  $source_dir_purge        = params_lookup( 'source_dir_purge' ),
  $template                = params_lookup( 'template' ),
  $service_autorestart     = params_lookup( 'service_autorestart' , 'global' ),
  $options                 = params_lookup( 'options' ),
  $version                 = params_lookup( 'version' ),
  $absent                  = params_lookup( 'absent' ),
  $disable                 = params_lookup( 'disable' ),
  $disableboot             = params_lookup( 'disableboot' ),
  $monitor                 = params_lookup( 'monitor' , 'global' ),
  $monitor_tool            = params_lookup( 'monitor_tool' , 'global' ),
  $monitor_target          = params_lookup( 'monitor_target' , 'global' ),
  $puppi                   = params_lookup( 'puppi' , 'global' ),
  $puppi_helper            = params_lookup( 'puppi_helper' , 'global' ),
  $debug                   = params_lookup( 'debug' , 'global' ),
  $audit_only              = params_lookup( 'audit_only' , 'global' ),
  $package                 = params_lookup( 'package' ),
  $service                 = params_lookup( 'service' ),
  $service_status          = params_lookup( 'service_status' ),
  $process                 = params_lookup( 'process' ),
  $process_args            = params_lookup( 'process_args' ),
  $process_user            = params_lookup( 'process_user' ),
  $config_dir              = params_lookup( 'config_dir' ),
  $config_file             = params_lookup( 'config_file' ),
  $config_file_mode        = params_lookup( 'config_file_mode' ),
  $config_file_owner       = params_lookup( 'config_file_owner' ),
  $config_file_group       = params_lookup( 'config_file_group' ),
  $config_file_init        = params_lookup( 'config_file_init' ),
  $pid_file                = params_lookup( 'pid_file' ),
  $data_dir                = params_lookup( 'data_dir' ),
  $log_dir                 = params_lookup( 'log_dir' ),
  $log_file                = params_lookup( 'log_file' )
  ) inherits nagios::params {

  $bool_install_prerequisites = any2bool($install_prerequisites)
  $bool_check_external_commands=any2bool($check_external_commands)
  $bool_source_dir_purge=any2bool($source_dir_purge)
  $bool_service_autorestart=any2bool($service_autorestart)
  $bool_absent=any2bool($absent)
  $bool_disable=any2bool($disable)
  $bool_disableboot=any2bool($disableboot)
  $bool_monitor=any2bool($monitor)
  $bool_puppi=any2bool($puppi)
  $bool_debug=any2bool($debug)
  $bool_audit_only=any2bool($audit_only)
  $bool_manual_dir_purge=any2bool($manual_dir_purge)
  $customconfigdir = "${config_dir}/auto.d"

  ### Definition of some variables used in the module
  $manage_package = $nagios::bool_absent ? {
    true  => 'absent',
    false => $nagios::version,
  }

  $manage_service_enable = $nagios::bool_disableboot ? {
    true    => false,
    default => $nagios::bool_disable ? {
      true    => false,
      default => $nagios::bool_absent ? {
        true  => false,
        false => true,
      },
    },
  }

  $manage_service_ensure = $nagios::bool_disable ? {
    true    => 'stopped',
    default =>  $nagios::bool_absent ? {
      true    => 'stopped',
      default => 'running',
    },
  }

  $manage_service_autorestart = $nagios::bool_service_autorestart ? {
    true    => Service[nagios],
    false   => undef,
  }

  $manage_file = $nagios::bool_absent ? {
    true    => 'absent',
    default => 'present',
  }

  if $nagios::bool_absent == true
  or $nagios::bool_disable == true
  or $nagios::bool_disableboot == true {
    $manage_monitor = false
  } else {
    $manage_monitor = true
  }

  $manage_audit = $nagios::bool_audit_only ? {
    true  => 'all',
    false => undef,
  }

  $manage_file_replace = $nagios::bool_audit_only ? {
    true  => false,
    false => true,
  }

  $manage_file_source = $nagios::source ? {
    ''        => undef,
    default   => $nagios::source,
  }

  $manage_file_content = $nagios::template ? {
    ''        => undef,
    default   => template($nagios::template),
  }

  ### Managed resources
  package { 'nrpe-plugin':
    ensure => $nagios::manage_package,
    name   => $nagios::nrpepluginpackage,
  }

  package { 'nagios':
    ensure => $nagios::manage_package,
    name   => $nagios::package,
  }

  service { 'nagios':
    ensure     => $nagios::manage_service_ensure,
    name       => $nagios::service,
    enable     => $nagios::manage_service_enable,
    hasstatus  => $nagios::service_status,
    pattern    => $nagios::process,
    require    => [ Package['nagios'] , Class['nagios::skel'] ] ,
  }

  file { 'nagios.conf':
    ensure  => $nagios::manage_file,
    path    => $nagios::config_file,
    mode    => $nagios::config_file_mode,
    owner   => $nagios::config_file_owner,
    group   => $nagios::config_file_group,
    require => Package['nagios'],
    notify  => $nagios::manage_service_autorestart,
    source  => $nagios::manage_file_source,
    content => $nagios::manage_file_content,
    replace => $nagios::manage_file_replace,
    audit   => $nagios::manage_audit,
  }

  # The whole nagios configuration directory can be recursively overriden
  if $nagios::source_dir {
    file { 'nagios.dir':
      ensure  => directory,
      path    => $nagios::config_dir,
      require => Package['nagios'],
      notify  => $nagios::manage_service_autorestart,
      source  => $nagios::source_dir,
      recurse => true,
      purge   => $nagios::bool_source_dir_purge,
      replace => $nagios::manage_file_replace,
      audit   => $nagios::manage_audit,
    }
  }

  # Include configuration directories and files
  include nagios::skel
  include nagios::target
  # Collects all the stored configs regarding nagios
  # Host/Service Checks aggregation policy is based on $::nagios_filemode
  case $::nagios_filemode {
    'concat': {
      # One file per host with all the relevant services in auto.d/hosts
      # Concatenated with puppetlabs-concat
      include concat::setup
      Concat <<| tag == "nagios_check_${nagios::target::magic_tag}" |>>
      Concat::Fragment <<| tag == "nagios_check_${nagios::target::magic_tag}" |>>
    }
    'pupmod-concat': {
      # One file per host with all the relevant services in auto.d/hosts
      # Concatenated with onyxpoint-pupmod-concat
      Concat_build <<| tag == "nagios_check_${nagios::target::magic_tag}" |>>
      Concat_fragment <<| tag == "nagios_check_${nagios::target::magic_tag}" |>>
    }
    default: {
      # One file per host auto.d/hosts
      # One file per service auto.d/services
      File <<| tag == "nagios_check_${nagios::target::magic_tag}" |>>
    }
  }


  ### Include custom class if $my_class is set
  if $nagios::my_class {
    include $nagios::my_class
  }


  ### Provide puppi data, if enabled ( puppi => true )
  if $nagios::bool_puppi == true {
    $classvars=get_class_args()
    puppi::ze { 'nagios':
      ensure    => $nagios::manage_file,
      variables => $classvars,
      helper    => $nagios::puppi_helper,
    }
  }


  ### Service monitoring, if enabled ( monitor => true )
  if $nagios::bool_monitor == true {
    monitor::process { 'nagios_process':
      process  => $nagios::process,
      service  => $nagios::service,
      pidfile  => $nagios::pid_file,
      user     => $nagios::process_user,
      argument => $nagios::process_args,
      tool     => $nagios::monitor_tool,
      enable   => $nagios::manage_monitor,
    }
  }


  ### Debugging, if enabled ( debug => true )
  if $nagios::bool_debug == true {
    file { 'debug_nagios':
      ensure  => $nagios::manage_file,
      path    => "${settings::vardir}/debug-nagios",
      mode    => '0640',
      owner   => 'root',
      group   => 'root',
      content => inline_template('<%= scope.to_hash.reject { |k,v| k.to_s =~ /(uptime.*|path|timestamp|free|.*password.*|.*psk.*|.*key)/ }.to_yaml %>'),
    }
  }

  ### Adding www-data to group nagios.
  ### www-data needs permission to nagios.cmd when executing external commands.
  if $::operatingsystem =~ /(?i:Debian|Ubuntu|Mint)/ {
    user { 'www-data':
      groups  => 'nagios',
      require => [ Package['nagios'] ],
    }
  }

  ### Prerequisites
  if $nagios::bool_install_prerequisites {
    include nagios::prerequisites
  }
}
