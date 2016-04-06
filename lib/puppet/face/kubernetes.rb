require 'puppet/face'
require 'erb'
require 'yaml'

Puppet::Face.define(:kubernetes, '0.1.0') do
  copyright 'Puppet Labs', 2016
  license   'Apache 2 license'
  summary "Interact with Kubernetes from the Puppet CLI"
  action :convert do
    summary "Convert a specified kubernetes YAML file into Puppet"
    description <<-DESC
      The Puppet Kubernetes module allows for managing resources
      (like pods, services and replication controllers) in Kubernetes
      using the Puppet DSL. But you may already have some Kubernetes YAML
      files. This command allows for converting them to Puppet, making
      using the module with existing content easier.
    DESC

    returns 'Puppet code on stdout for use with the Kubernetes module'

    arguments '<file>'

    examples <<-EXAMPLE
      $ puppet kubernetes convert some-kubernetes-config.yaml

      If you would like to create a file you can then run, simply
      redirect the output like so:

      $ puppet kubernetes convert some-kubernetes-config.yaml > config.pp
    EXAMPLE

    when_invoked do |file_name, options|
      fail "#{file_name} does not exist" unless File.file?(file_name)

      YAML.load_stream(File.open(file_name)).collect do |data|

        resource_name = data['kind'].
          gsub(/([a-z\d])([A-Z])/,'\1_\2').
          downcase

        template = <<-TEMPLATE
kubernetes_<%= resource_name %> { '<%= data['metadata']['name'] %>':
  ensure => present,
  metadata => {
<% data['metadata'].tap { |metadata| metadata.delete('name') }.each do |key, value| %>
    <%= key %> => <% if value.is_a? String %>'<%= value %>'<% else %><%= value.to_s.gsub('"', "'") %><% end %>,
<% end %>
  },
  spec => {
<% data['spec'].each do |key, value| %>
    <%= key %> => <% if value.is_a? String %>'<%= value %>'<% else %><%= value.to_s.gsub('"', "'") %><% end %>,
<% end %>
  },
}
        TEMPLATE

        renderer = ERB.new(template)
        renderer.result(binding).gsub(/^$\n/, '')
      end
    end

    when_rendering :console do |return_value, file, options|
      return_value
    end
  end
end
