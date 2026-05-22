```yaml
# ============================================================================
# RECEIVERS: Receivers of telemetry data in OTLP format
# ============================================================================
receivers:
  # OTLP is a protocol for delivering telemetry from applications to {{ monium-name }}
  otlp:
    protocols:
      # gRPC endpoint (port 4317): Recommended for production use
      grpc:
        endpoint: 0.0.0.0:4317
        # max_recv_msg_size_mib: 4  # Maximum message size (4MB by default)
        # max_concurrent_streams: 16  # Maximum concurrent streams
      
      # HTTP endpoint (port 4318): Suitable for REST API
      http:
        endpoint: 0.0.0.0:4318

# ============================================================================
# PROCESSORS: Data processors
# ============================================================================
processors:
  
  # Batch: Groups data before sending it (required for production)
  batch:
    timeout: 10s          # Send every 10 seconds
    send_batch_size: 1024 # Or when there are 1024 elements
    # send_batch_max_size: 2048  # Maximum batch size
  
  # Providing monotonically increasing sums as a RATE-type metric.
  cumulativetodelta:

  # Memory Limiter: Prevents out-of-memory situations, recommended for production environments for stability
  memory_limiter:
    check_interval: 1s
    limit_mib: 512        # Hard memory limit
    spike_limit_mib: 128  # Margin for spikes

  # Resource: Adding resource attributes
  # resource:
  #   attributes:
  #     - key: deployment.environment   # In {{ monium-name }}, it is provided to the cluster parameter
  #       value: production
  #       action: insert

  # Filter: Filtering out redundant telemetry
  # filter:
  #   traces:
  #     span:
  #       - 'attributes["http.url"] == "/health"'  # Excluding health checks
  #       - 'attributes["http.url"] == "/metrics"'
  #   metrics:
  #     metric:
  #       - 'name == "unwanted_metric"'
  #   logs:
  #     log_record:
  #       - 'severity_number < SEVERITY_NUMBER_INFO'  # Only INFO and higher

# ============================================================================
# EXPORTERS: Data senders
# ============================================================================
exporters:
  # Sending to {{ monium-name }}
  otlp/monium:
    endpoint: {{ api-host-monium }}:443
    compression: zstd  # Compression to save traffic (none | gzip | snappy | zstd)
    headers:
      Authorization: "Api-Key ${env:MONIUM_API_KEY}"
      x-monium-project: "${env:MONIUM_PROJECT}"
    
    # Reattempt settings in case of errors
    retry_on_failure:
      enabled: true
      initial_interval: 5s     # First attempt in 5 seconds
      max_interval: 30s        # Maximum delay: 30 sec
      max_elapsed_time: 300s   # Stop retries after 5 minutes

# ============================================================================
# EXTENSIONS:
# ============================================================================
extensions:
  # Health Check: Health check endpoint
  health_check:
    endpoint: 0.0.0.0:13133
    path: /health

# ============================================================================
# SERVICE: Pipeline configuration
# ============================================================================
service:
  
  # Adding an extension for health check
  extensions: [health_check]
  
  # Data processing pipelines
  pipelines:
    # Trace delivery (delete this section if traces are not required)
    traces:
      receivers: [ otlp ]
      processors: [ memory_limiter, batch ]
      exporters: [ otlp/monium ]

    # Metric delivery (delete this section if metrics are not required)
    metrics:
      receivers: [ otlp ]
      processors: [ memory_limiter, batch, cumulativetodelta ]
      exporters: [ otlp/monium ]

    # Log delivery (delete this section if logs are not required)
    logs:
      receivers: [ otlp ]
      processors: [ memory_limiter, batch ]
      exporters: [ otlp/monium ]

  # Telemetry from OTel Collector
  telemetry:
    logs:
      level: info  # debug | info | warn | error    
    metrics:
      level: detailed  # none | basic | normal | detailed
      
      # Sending telemetry from OTel Collector
      # readers:
      #   - periodic:
      #       interval: 60000
      #       exporter:
      #         otlp:
      #           endpoint: ${env:MY_POD_IP}:4317
      #           protocol: grpc
      #           tls:
      #             insecure: true
```