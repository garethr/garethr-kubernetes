controller_service_pair { 'redis-master':
  app  => 'redis',
  role => 'master',
  tier => 'backend',
  port => 6379,
}
controller_service_pair { 'redis-slave':
  app      => 'redis',
  role     => 'slave',
  tier     => 'backend',
  port     => 6379,
  image    => 'gcr.io/google_samples/gb-redisslave:v1',
  replicas => 2,
}
controller_service_pair { 'frontend':
  app          => 'guestbook',
  role         => 'php-redis',
  tier         => 'frontend',
  port         => 80,
  image        => 'gcr.io/google_samples/gb-frontend:v3',
  replicas     => 3,
  service_type => 'LoadBalancer',
}
