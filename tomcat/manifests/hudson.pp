# Class: puppetlabs-tomcat::hudson
#
#   This class models the Hudson Continuous Integration
#   service in Puppet.
#
#   http://hudson-ci.org/
#
#   This management strategy is to deploy the war file
#   into ${TOMCAT_HOME:=/usr/tomcat}/webapps
#
#   Jeff McCune <jeff@puppetlabs.com>
#   2010-08-05
#
# Parameters:
#
# Actions:
#
#   Manages /usr/tomcat/webapps/hudson.war
#
# Requires:
#
#   Service["tomcat"], File["/usr/tomcat"]
#   which are provided by provided by class { "puppetlabs-tomcat": }
#
# Sample Usage:
#
#   include "puppetlabs-tomcat::hudson"
#
class puppetlabs-tomcat::hudson inherits puppetlabs-tomcat {
	$module = "puppetlabs-tomcat"
	$class  = "${module}::hudson"
# JJM Look for files on the node filesystem first.
  $p1 = "${prefix}/${module}/files"
# JJM Look for files on the puppetmaster second.
  $p2 = "puppet:///modules/${module}"
# Our installer media.
  $hudson_version = "1.369"
  $installer = "hudson-${hudson_version}.war"

  File { owner => "0", group => "0", mode  => "0644" }

	file {
		"/usr/tomcat/webapps/hudson.war":
      source => [ "${p1}/${installer}", "${p2}/${installer}" ],
      notify => Service["tomcat"];
	}
}