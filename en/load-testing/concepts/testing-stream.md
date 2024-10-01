# Testing threads

A [load generator](load-generator.md) creates parallel _testing threads_. Operations within threads are performed sequentially, that is, after a request is created, a response is awaited. The thread where a response is awaited is unavailable for new requests. To ensure the required load, a generator uses the following threads.

You can track thread utilization on a chart in the [report](reports.md).

The maximum number of requests per second depends on the number of testing threads and the total request response time in a given second:

   ```text
   RPS_max = number of testing threads / (total request response time in a given second)
   ```

   Where `RPS_max` is the maximum number of requests per second.

By default, Phantom creates 1000 testing threads.

Pandora creates 1000 testing threads unless you filled in the **Testing threads** field when configuring via the form. However, if the configuration file was used and the number of testing threads was not specified, Pandora will terminate with an error.

If you need to set the number of threads, configure it in the [management console]({{ link-console-main }}).

You can calculate the required number of testing threads using this formula:

   ```text
   Number of testing threads = RPS x (average response time in seconds)
   ```

   Where `RPS` is the number of requests per second.
   
> For example, to ensure a load of 200 requests per second at an average response time of 50 ms, you need to create 10 testing threads.

## Sample configuration file {#config_example}

An example of configuring testing threads to generate 200 requests per second over 5 minutes:

{% list tabs group=load_generator %}

- Pandora {#pandora}

    ```yaml
    pandora:
      enabled: true
      package: yandextank.plugins.Pandora
      config_content:
        pools:
          - id: HTTP
            gun:
              type: http
              target: localhost:80
            ammo:
              file: /tmp/ammofile
              type: uri
            result:
              type: phout
              destination: ./phout.log
            startup:
              type: once
              times: 10         # Number of threads
            rps:
              - duration: 300s # Test duration
                type: step # Load type
                ops: 200        # Number of requests per second
        log:
          level: error
        monitoring:
          expvar:
            enabled: true
            port: 1234
	```

- Phantom {#phantom}

    ```yaml
	phantom:
      enabled: true
      package: yandextank.plugins.Phantom
      address: localhost:80
      ammo_type: uri
      instances: 10             # Number of threads
      load_profile:
        load_type: rps
        schedule: const(200,5m) # Load schedule: 200 requests per second over 5 minutes
      uris: ['/']
	```

{% endlist %}
