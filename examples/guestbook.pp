kubernetes_replication_controller { 'redis-master':
  ensure   => 'present',
  metadata => {
    'labels' => {'app' => 'redis', 'role' => 'master', 'tier' => 'backend'},
    'namespace' => 'default',
  },
  spec     => {
    'replicas' => 1,
    'template' => {
      'metadata' => {
        'labels' => {'app' => 'redis', 'role' => 'master', 'tier' => 'backend'},
      },
      'spec' => {
        'containers' => [
          {
            'image' => 'redis',
            'name' => 'master',
            'ports' => [
              {'containerPort' => 6379, 'protocol' => 'TCP'}
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
