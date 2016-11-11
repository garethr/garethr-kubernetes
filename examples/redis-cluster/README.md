This example uses Puppet's defined type feature to reduce the amount of
repeted code, and to create a higher-level interface for creating
Kubernetes resources. This gets the guestbook example down to just
describing the 3 pairs of controllers/services like so:

```puppet
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
```

You can run this example locally using `puppet apply` from the top
directory of the repository. Note that you need to run against the
directory, not a specific `pp` file as puppet needs to load the
defined type too.

```
puppet apply examples/defined-type --test
```

This example makes use of newer features of Puppet available in Puppet
4. If you are using an older version you should be able to run it by
explicitly enabling the new parser:

```
puppet apply examples/defined-type --test --parser=future
```
