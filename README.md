####Table of Contents

1. [Overview](#overview)
2. [Description - What the module does and why it is useful](#module-description)
3. [Setup](#setup)
  * [Requirements](#requirements)
  * [Installing the kubernetes module](#installing-the-kubernetes-module)
4. [Getting Started with kubernetes](#getting-started-with-kubernetes)
5. [Usage - Configuration options and additional functionality](#usage)
6. [Reference - An under-the-hood peek at what the module is doing and how](#reference)
  * [Types](#types)
7. [Known Issues](#known-issues)
8. [Limitations - OS compatibility, etc.](#limitations)

## Overview

## Description

## Setup

### Requirements

* [Kubeclient](https://github.com/abonas/kubeclient) and
  [Hocon](https://github.com/puppetlabs/ruby-hocon) ruby gems

### Installing the Kubernetes module

1. Install the required gems with this command:

  ~~~
  /opt/puppet/bin/gem install kubeclient hocon --no-ri --no-rdoc
  ~~~

  If you are running Puppet Enterprise 2015.2.0 or later you need to use the updated path:

  ~~~
  /opt/puppetlabs/puppet/bin/gem install kubeclient hocon --no-ri --no-rdoc
  ~~~

#### Configuring credentials

1. Set the following environment variables specific to your vSphere
   installation:

  * Required Settings:

      ~~~
      export KUBERNETES_MASTER='your-host'
      ~~~

   Alternatively, you can provide the information in a configuration
file. Store this as `kubernetes.conf` in the relevant
[confdir](https://docs.puppetlabs.com/puppet/latest/reference/dirs_confdir.html). This should be:

   * nix Systems: `/etc/puppetlabs/puppet`
   * Windows: `C:\ProgramData\PuppetLabs\puppet\etc`
   * non-root users: `~/.puppetlabs/etc/puppet`

   The file format is:

      ~~~
      kubernetes: {
        master: "your-host"
      }
      ~~~

    Note that you can use either the environment variables or the config file. If both are present the environment variables will be used. You **cannot** have some settings in environment variables and others in the config file.

2. Finally install the module with:

  `puppet module install garethr-kubernetes`


## Getting started with Kubernetes

This module allows for describing resources in Kubernetes (like Pods,
Services and ReplicationControllers) using the Puppet DSL. To create a
new Pod for example:

~~~puppet
kubernetes_pod { 'garethr':
  ensure   => present,
  metadata => {
    namespace => 'default',
  },
  spec     => {
    containers => [{
      name  => 'container-name',
      image => 'nginx',
    },{
      name  => 'container-name-2',
      image => 'nginx',
    }]
  },
}
~~~

## Usage

###List and manage Kubernetes resources

In addition to creating and managing resources this module supports listing and interactive management of resources via `puppet resource`. For example:

`puppet resource kubernetes_node`

Or

`puppet resource kubernetes_service`

You can use this to describe the state of your Kubernetes cluster and
export the results to a file, which can then be used to maintain that
state over time.

###Delete resources

You can also delete the resources we created above by setting the `ensure`
property to `absent` in the manifest or using `puppet resouce` like so:

    puppet resource kubernetes_pod garethr ensure=absent

###More usage examples

The module examples folder contains additional usage examples:

##Reference

###Types

##Limitations

This module is a proof of concept, demonstrating both the power of
auto-generating Puppet types and providers from Swagger specifications
and of managing higher level tools like Kubernetes with Puppet. It
likely has several bugs and rough edges.

## Development

Much of the code for this module is auto-generated using the
[puppet-swagger-generator](https://github.com/garethr/puppet-swagger-generator)
project. This means modifications to the types and providers should be
done there, rather than within this project. Files which are
auto-generated should have a suitable comment indicating as such.
