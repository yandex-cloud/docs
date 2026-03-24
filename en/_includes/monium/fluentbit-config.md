**Via gRPC**

```yaml
pipeline:
  inputs:
    - name: opentelemetry
      listen: 127.0.0.1
      port: 4318

  outputs:
    - name: opentelemetry
      match: "*"
      host: {{ api-host-monium }}
      port: 443
      tls: on
      compress: zstd
      grpc: on
      header:
        - Authorization Api-Key ${MONIUM_API_KEY}
        - x-monium-project ${MONIUM_PROJECT}
```

**Via HTTP**

```yaml
pipeline:
  inputs:
    - name: opentelemetry
      listen: 127.0.0.1
      port: 4318

  outputs:
    - name: opentelemetry
      match: "*"
      host: {{ api-host-monium }}
      port: 443
      tls: on
      compress: zstd
      logs_uri: /otlp/v1/logs
      traces_uri: /otlp/v1/traces
      metrics_uri: /otlp/v1/metrics
      header:
        - Authorization Api-Key ${MONIUM_API_KEY}
        - x-monium-project ${MONIUM_PROJECT}
```
