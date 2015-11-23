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
