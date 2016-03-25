[![Puppet
Forge](http://img.shields.io/puppetforge/v/garethr/kubernetes.svg)](https://forge.puppetlabs.com/garethr/kubernetes)
[![Build
Status](https://secure.travis-ci.org/garethr/garethr-kubernetes.png)](http://travis-ci.org/garethr/garethr-kubernetes)
[![Documentation
Status](http://img.shields.io/badge/docs-puppet--strings-lightgrey.svg)](https://garethr.github.io/garethr-kubernetes)
[![Puppet Forge
Downloads](http://img.shields.io/puppetforge/dt/garethr/kubernetes.svg)](https://forge.puppetlabs.com/garethr/kubernetes)

1. [Overview](#overview)
2. [Description - What the module does and why it is useful](#description)
3. [Setup](#setup)
  * [Requirements](#requirements)
  * [Installing the Kubernetes module](#installing-the-kubernetes-module)
4. [Getting Started with Kubernetes](#getting-started-with-kubernetes)
5. [Usage - Configuration options and additional functionality](#usage)
6. [Reference - An under-the-hood peek at what the module is doing and how](#reference)
  * [Types](#types)
7. [Limitations - OS compatibility, etc.](#limitations)

## Overview

The garethr-kubernetes module allows you to use the Puppet DSL for managing Pods,
ReplicationControllers, Services and more in Kubernetes. It doesn't install the various
Kubernetes components.

## Description

The module allows for defining Kubernetes resources in Puppet, and then
for Puppet to create or update those resources. This improves on the
basic YAML file approach in a few ways:

* The Puppet language supports logic and abstractions, allowing for
  the crafting of business specific user interfaces and avoiding
  repetition
* Modifications can be made to the Puppet code and Puppet will handle
  updating the relevant resources, without having to describe the full
  state of the resource
* Puppet supports relationships between resources, so you can enforce
  ordering where necessary

The user interface of the Puppet code however follows the API/YAML
format exactly. This allows for a familiar interface for anyone used to
the Kubernetes API, at the same time as providing a low level building
block for creating higher level types.

## Setup

Note that the following assumes you have a Kubernetes cluster up and
running.

### Requirements

* [Kubeclient](https://github.com/abonas/kubeclient) ruby gem
* Ruby 2.x, Kubeclient won't work with 1.8.7 or 1.9.x

### Installing the Kubernetes module

Install the required gems with this command:

    /opt/puppetlabs/puppet/bin/gem install activesupport -v 4.1.14
    /opt/puppetlabs/puppet/bin/gem install kubeclient --no-ri --no-rdoc

#### Configuring credentials

You can provide the required information in a standard kubectl configuration
file. Store this as `kubernetes.conf` in the relevant
[confdir](https://docs.puppetlabs.com/puppet/latest/reference/dirs_confdir.html).
This should be:

   * nix Systems: `/etc/puppetlabs/puppet`
   * Windows: `C:\ProgramData\PuppetLabs\puppet\etc`
   * non-root users: `~/.puppetlabs/etc/puppet`

If you have a working kubectl setup you can export the file using the
following command:

    kubectl config view --raw=true

Finally install the module with:

    puppet module install garethr-kubernetes

## Getting started with Kubernetes

This module allows for describing resources in Kubernetes (like Pods,
Services and ReplicationControllers) using the Puppet DSL. To create a
new Pod for example:

```puppet
kubernetes_pod { 'sample-pod':
  ensure   => present,
  metadata => {
    namespace => 'default',
  },
  spec     => {
    containers => [{
      name  => 'container-name',
      image => 'nginx',
    }]
  },
}
```

## Usage

### List and manage Kubernetes resources

In addition to creating and managing resources this module supports listing
and interactive management of resources via `puppet resource`. For example:

    puppet resource kubernetes_node

Or:

    puppet resource kubernetes_service

You can use this to describe the state of your Kubernetes cluster and
export the results to a file, which can then be used to maintain that
state over time.

### Delete resources

You can also delete the resources we created above by setting the `ensure`
property to `absent` in the manifest or using `puppet resouce` like so:

    puppet resource kubernetes_pod sample-pod ensure=absent

### More usage examples

The module examples folder contains additional usage examples:

## Reference

### Types

* kubernetes_pod
* kubernetes_service
* kubernetes_replication_controller
* kubernetes_node
* kubernetes_event
* kubernetes_endpoint
* kubernetes_namespace
* kubernetes_secret
* kubernetes_resource_quota
* kubernetes_limit_range
* kubernetes_peristent_volume
* kubernetes_persistent_volume_claim
* kubernetes_component_status
* kubernetes_service_account
* kubernetes_config_map

## Limitations

This module is a proof of concept, demonstrating both the power of
auto-generating Puppet types and providers from Swagger specifications
and of managing higher level tools like Kubernetes with Puppet. It
likely has several bugs and rough edges at the moment. Please report
those on GitHub.

## Development

Much of the code for this module is auto-generated using the
[puppet-swagger-generator](https://github.com/garethr/puppet-swagger-generator)
project. This means modifications to the types and providers should be
done there, rather than within this project. Files which are
auto-generated should have a suitable comment indicating as such.
