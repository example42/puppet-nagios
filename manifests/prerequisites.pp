# Class: nagios::prerequisites
#
# This class installs nagios prerequisites
#
# == Variables
#
# Refer to nagios class for the variables defined here.
#
# == Usage
#
# This class is not intended to be used directly.
# It's automatically included by nagios if the parameter
# install_prerequisites is set to true
# Note: This class contains resources provided by
# Example42 apache module
#
class nagios::prerequisites {

  apache::htpasswd { 'nagiosadmin':
    crypt_password => $nagios::nagiosadmin_password,
    htpasswd_file  => $nagios::htpasswdfile,
  }

}
