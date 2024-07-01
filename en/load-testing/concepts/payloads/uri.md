# URI

Type of test data used for describing HTTP `GET` requests. Allows you to set different headers for different requests and specify request tags. Used in Pandora and Phantom load generators.

The test data type is specified when [creating a test](../../operations/create-test-bucket.md#create-test).

Data format:

```
[Header_name: header_value]
uri1
uri2 tag
```

You can add headers anywhere in the file. They are applied to all URIs specified after the header. The list loops until the required number of requests per second is reached.

## Configuring load generators

{% list tabs group=instructions %}

- Phantom {#phantom}

   When configuring the Phantom load generator using a YAML file, you can specify request headers and endpoints for load testing directly in the file:

   ```yaml
   phantom:
     address: 203.0.113.1:80
     load_profile:
       load_type: rps
       schedule: line(1, 10, 10m)
     header_http: "1.1"
     headers:
       - "[Host: www.target.example.com]"
       - "[Connection: close]"
     uris:
       - "/uri1"
       - "/buy"
       - "/sdfg?sdf=rwerf"
       - "/sdfbv/swdfvs/ssfsf"
   ```

   You can also list headers and endpoints in a separate text file. For this, in the YAML file, specify the `uri` type for the `ammo_type` parameter:

   - Configuration file:

   ```yaml
   phantom:
     address: 203.0.113.1:80
     load_profile:
       load_type: rps
       schedule: line(1, 10, 10m)
     header_http: "1.1"
     ammo_type: uri
     ammofile: ./ammo.txt
   ```

   - `ammo.txt` text file with headers and requests:

   ```
   [Connection: close]
   [Host: target.example.com]
   [Cookie: None]
   /?drg tag1
   /
   /buy tag2
   [Cookie: test]
   /buy/?rt=0&station_to=7&station_from=9
   ```

   Headers in square brackets can override each other. Thus, in the example above, the last endpoint will be used with the `test `cookie, unlike the preceding ones which will be used without it.

- Pandora {#pandora}

   When configuring the Pandora load generator using a YAML file, you can specify request headers and endpoints for load testing directly in the file:

   ```yaml
   pandora:
   enabled: true
   package: yandextank.plugins.Pandora
   config_content:
      pools:
      - id: HTTP
         gun:
            type: http
            target: 10.128.0.15:80
            ssl: false
         ammo:
            type: uri
            uris:
            - /index
            - /search
            headers:
            - '[Host: my.host]'
            - '[Connection: keep-alive]'
         result:
            type: phout
            destination: ./phout.log
         startup:
            type: once
            times: 1000
         rps:
            - type: line
            from: 1
            to: 1000
            duration: 60s
         discard_overflow: true
      log:
      level: error
      monitoring:
      expvar:
         enabled: true
         port: 1234
   ```

   You can also list headers and endpoints in a separate text file:

   ```
   config_content:
      pools:
      - id: HTTP
         ammo:
            type: uri
            file: ./ammo.uri
   ```

   For this, in the YAML file, specify the `uri` type for the `type` parameter in the `ammo` section.
   When uploading a file with test data via the management console, this is done automatically.


{% endlist %}