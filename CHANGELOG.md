##2015-12-16 - Version 0.1.0

This is the initial release of the Kubernetes module.

##2016-02-8 - Version 0.1.1

* Bugfix for creating/deleting Kubernetes namespaces with the
  kubernetes_namespace type

##2016-03-22 - Version 0.2.0

* Verify module works with with OpenShift v3
* Support authentication with bearer tokens
* Move gem requirement into a Puppet feature
* Fix for passing in numbers
* Fixes for object comparison involving arrays of values

Thanks to @modax for much of the work in this release.

##2016-04-06 - Version 0.3.0

* Added an experimental Puppet command (puppet kubernetes convert)
  which converts standard Kubernetes YAML files into Puppet code

##2017-07-12 - Version 0.5.0

* Update resources to 1.7.0

##2017-07-12 - Version 0.5.1

* Resolve issue with namespaced monkey patch clashing with AIO gem
* Remove forked kubeclient configuration class as fixed upstream
