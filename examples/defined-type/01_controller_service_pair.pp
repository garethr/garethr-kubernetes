define controller_service_pair(
  $app,
  $role,
  $tier,
  $port,
  $image = $app,
  $replicas = 1,
  $service_type = 'ClusterIP',
) {

  kubernetes_replication_controller { $title:
    ensure   => 'present',
    metadata => {
      'labels' => {'app' => $app, 'role' => $role, 'tier' => $tier},
      'namespace' => 'default',
    },
    spec     => {
      'replicas' => $replicas,
      'template' => {
        'metadata' => {
          'labels' => {'app' => $app, 'role' => $role, 'tier' => $tier},
        },
        'spec' => {
          'containers' => [
            {
              'env' => [{'name' => 'GET_HOSTS_FROM', 'value' => 'dns'}],
              'image' => $image,
              'name' => $role,
              'ports' => [
                {'containerPort' => $port, 'protocol' => 'TCP'}
              ],
              'resources' => {
                'requests' => {
                  'cpu' => '100m',
                  'memory' => '100Mi',
                }
              }
            }
          ]
        }
      }
    }
  }
  kubernetes_service { $title:
    ensure   => 'present',
    metadata => {
      'labels' => {'app' => $app, 'role' => $role, 'tier' => $tier},
      'namespace' => 'default',
    },
    spec      => {
      'type'  => $service_type,
      'ports' => [
        {'port' => $port, 'protocol' => 'TCP', 'targetPort' => $port}
      ],
      'selector' => {'app' => $app, 'role' => $role, 'tier' => $tier},
    }
  }
}



