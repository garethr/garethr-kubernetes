kubernetes_pod { 'sample-pod':
  ensure   => present,
  metadata => {
    namespace => 'default',
  },
  spec     => {
    containers => [{
      name  => 'container-name',
      image => 'nginx',
    }],
  },
}
