# A common pattern in Kubernetes is to have a service associated
# with a replication controller. This type provides some simple
# default assumptions and combines the definition of the controller
# and service into a single type.
define controller_service_pair(
  String $app,
  String $role,
  String $tier,
  Integer $port,
  $image = $app,
  Integer $replicas = 1,
  String $service_type = 'ClusterIP',
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
