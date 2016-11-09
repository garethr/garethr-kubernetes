Kubernetes_replication_controller {
  ensure   => 'absent',
}

Kubernetes_service {
  ensure   => 'absent',
}

kubernetes_replication_controller { 'redis-master': }
kubernetes_service { 'redis-master': }
kubernetes_replication_controller { 'redis-slave': }
kubernetes_service { 'redis-slave': }
