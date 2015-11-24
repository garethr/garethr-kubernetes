kubernetes_service { 'redis-master':
  ensure   => 'present',
  metadata => {
    'labels' => {'app' => 'redis', 'role' => 'master', 'tier' => 'backend'},
    'namespace' => 'default',
  },
  spec     => {
    'ports' => [
      {'port' => 6379, 'protocol' => 'TCP', 'targetPort' => 6379}
    ],
    'selector' => {
      'app' => 'redis',
      'role' => 'master',
      'tier' => 'backend'
    },
  },
}
