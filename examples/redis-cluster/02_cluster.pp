define redis_cluster(
  Integer $size = 2,
) {
  controller_service_pair { "${title}-master":
    app   => $title,
    role  => 'master',
    tier  => 'backend',
    port  => 6379,
    image => 'redis',
  }
  controller_service_pair { "${title}-slave":
    app      => $title,
    role     => 'slave',
    tier     => 'backend',
    port     => 6379,
    image    => 'gcr.io/google_samples/gb-redisslave:v1',
    replicas => $size,
  }
}
