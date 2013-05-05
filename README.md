# Puppet module: nagios

This is a Puppet module for nagios based on the second generation layout ("NextGen") of Example42 Puppet Modules.

Made by Alessandro Franceschi / Lab42

Official site: http://www.example42.com

Official git repository: http://github.com/example42/puppet-nagios

Released under the terms of Apache 2 License.

This module requires functions provided by the Example42 Puppi module (you need it even if you don't use and install Puppi)

For detailed info about the logic and usage patterns of Example42 modules check the DOCS directory on Example42 main modules set.

## USAGE - Basic management

* Install nagios with default settings

        class { 'nagios': }

* Install a specific version of nagios package

        class { 'nagios':
          version => '1.0.1',
        }

* Disable nagios service.

        class { 'nagios':
          disable => true
        }

* Remove nagios package

        class { 'nagios':
          absent => true
        }

* Enable auditing without without making changes on existing nagios configuration files

        class { 'nagios':
          audit_only => true
        }

* Debian (and derivatives) users must set the top scope variable `nagios_customconfigdir` to point to the Nagios configuration directory. At the moment, this directory is not parameterized based on operating system

        $nagios_customconfigdir = '/etc/nagios3/auto.d'
        class { 'nagios': }


## USAGE - Overrides and Customizations
* Use custom sources for main config file 

        class { 'nagios':
          source => [ "puppet:///modules/lab42/nagios/nagios.conf-${hostname}" , "puppet:///modules/lab42/nagios/nagios.conf" ], 
        }


* Use custom source directory for the whole configuration dir

        class { 'nagios':
          source_dir       => 'puppet:///modules/lab42/nagios/conf/',
          source_dir_purge => false, # Set to true to purge any existing file not present in $source_dir
        }

* Use custom template for main config file. Note that template and source arguments are alternative. 

        class { 'nagios':
          template => 'example42/nagios/nagios.conf.erb',
        }

* Automatically include a custom subclass

        class { 'nagios':
          my_class => 'nagios::example42',
        }


## USAGE - Example42 extensions management 
* Activate puppi (recommended, but disabled by default)

        class { 'nagios':
          puppi    => true,
        }

* Activate puppi and use a custom puppi_helper template (to be provided separately with a puppi::helper define ) to customize the output of puppi commands 

        class { 'nagios':
          puppi        => true,
          puppi_helper => 'myhelper', 
        }

* Activate automatic monitoring (recommended, but disabled by default). This option requires the usage of Example42 monitor and relevant monitor tools modules

        class { 'nagios':
          monitor      => true,
          monitor_tool => [ 'nagios' , 'monit' , 'munin' ],
        }

* Activate automatic firewalling. This option requires the usage of Example42 firewall and relevant firewall tools modules

        class { 'nagios':       
          firewall      => true,
          firewall_tool => 'iptables',
          firewall_src  => '10.42.0.0/24',
          firewall_dst  => $ipaddress_eth0,
        }


[![Build Status](https://travis-ci.org/example42/puppet-nagios.png?branch=master)](https://travis-ci.org/example42/puppet-nagios)
