```yaml
# ============================================================================
# RECEIVERS - Приемники данных телеметрии
# ============================================================================
receivers:
  # настраиваем на агенте порты для приема телеметрии в формате OpenTelemetry
  otlp:
    protocols:
      # gRPC endpoint (порт 4317) - рекомендуется для production
      grpc:
        endpoint: 0.0.0.0:4317
        # max_recv_msg_size_mib: 4  # Максимальный размер сообщения (по умолчанию 4MB)
        # max_concurrent_streams: 16  # Максимум одновременных стримов
      
      # HTTP endpoint (порт 4318) - для мониторинга приложений на JavaScript, а также в случае недоступности протокола gRPC
      http:
        endpoint: 0.0.0.0:4318

# ============================================================================
# PROCESSORS - Обработчики данных
# ============================================================================
processors:
  # Передает кумулятивные монотонные суммы как дельты, которые в {{ monium-name }} дифференцируются и пишутся с типом RATE. Требует дистрибутив otel-collector-contrib
  # cumulativetodelta:

  # Memory Limiter - защита от Out-of-Memory, рекомендуется в production для стабильности
  memory_limiter:
    check_interval: 1s
    limit_mib: 512        # Жесткий лимит памяти
    spike_limit_mib: 128  # Запас для всплесков

  # Resource - добавление атрибутов ресурса
  # resource:
  #   attributes:
  #     - key: deployment.environment
  #       value: production
  #       action: insert

  # Filter - фильтрация данных для исключения ненужной телеметрии
  # filter:
  #   traces:
  #     span:
  #       - 'attributes["http.url"] == "/health"'  # Исключить health checks
  #       - 'attributes["http.url"] == "/metrics"'
  #   metrics:
  #     metric:
  #       - 'name == "unwanted_metric"'
  #   logs:
  #     log_record:
  #       - 'severity_number < SEVERITY_NUMBER_INFO'  # Только INFO и выше

# ============================================================================
# EXPORTERS - Отправители данных
# ============================================================================
exporters:
  # Отправка в {{ monium-name }} по gRPC
  otlp_grpc/monium:
    endpoint: {{ api-host-monium }}:443
    compression: zstd  # Сжатие для экономии трафика (none | gzip | zstd)
    headers:
      Authorization: "Api-Key ${env:MONIUM_API_KEY}"
      x-monium-project: "${env:MONIUM_PROJECT}"
    sending_queue:
      batch:
    
    # Настройки повторных попыток при ошибках
    retry_on_failure:
      enabled: true
      initial_interval: 5s     # Первая попытка через 5 сек
      max_interval: 30s        # Максимальная задержка 30 сек
      max_elapsed_time: 300s   # Прекратить попытки через 5 мин

  # Отправка в {{ monium-name }} по HTTP
  # otlp_http/monium:
    # endpoint: https://{{ api-host-monium }}/otlp
    # compression: zstd  # Сжатие для экономии трафика (none | gzip | zstd)
    # headers:
      # Authorization: "Api-Key ${env:MONIUM_API_KEY}"
      # x-monium-project: "${env:MONIUM_PROJECT}"
    # sending_queue:
      # batch:

# ============================================================================
# EXTENSIONS - Расширения
# ============================================================================
extensions:

# ============================================================================
# SERVICE - Конфигурация пайплайнов
# ============================================================================
service:
  
  # Пайплайны обработки данных
  pipelines:
    # Поставка трейсов (удалите секцию, если трейсы не требуются)
    traces:
      receivers: [ otlp ]
      processors: [ memory_limiter ]
      exporters: [ otlp_grpc/monium ]

    # Поставка метрик (удалите секцию, если метрики не требуются)
    metrics:
      receivers: [ otlp ]
      processors: [ memory_limiter ]
      exporters: [ otlp_grpc/monium ]

    # Поставка логов (удалите секцию, если логи не требуются)
    logs:
      receivers: [ otlp ]
      processors: [ memory_limiter ]
      exporters: [ otlp_grpc/monium ]

  # Телеметрия самого OTel Collector
  telemetry:
    logs:
      level: info  # debug | info | warn | error    
    metrics:
      level: detailed  # none | basic | normal | detailed
      
      # Отправка телеметрии самого OTel Collector
      readers:
         - periodic:
             interval: 60000
             exporter:
               otlp:
                 protocol: http/protobuf
                 endpoint: http://${env:MY_POD_IP}:4318
```

{% cut "Для otel-collector версии 0.144 и раньше" %}

```yaml
# ============================================================================
# RECEIVERS - Приемники данных телеметрии
# ============================================================================
receivers:
  # настраиваем на агенте порты для приема телеметрии в формате OpenTelemetry
  otlp:
    protocols:
      # gRPC endpoint (порт 4317) - рекомендуется для production
      grpc:
        endpoint: 0.0.0.0:4317
        # max_recv_msg_size_mib: 4  # Максимальный размер сообщения (по умолчанию 4MB)
        # max_concurrent_streams: 16  # Максимум одновременных стримов
      
      # HTTP endpoint (порт 4318) - для мониторинга приложений на JavaScript, а также в случае недоступности протокола gRPC
      http:
        endpoint: 0.0.0.0:4318

# ============================================================================
# PROCESSORS - Обработчики данных
# ============================================================================
processors:
  # Batch - группирует данные перед отправкой (обязательно для production)
  batch:
    timeout: 10s          # Отправлять каждые 10 секунд
    send_batch_size: 1024 # Или когда накопится 1024 элемента
    # send_batch_max_size: 2048  # Максимальный размер батча

  # Передает кумулятивные монотонные суммы как дельты, которые в {{ monium-name }} дифференцируются и пишутся с типом RATE. Требует дистрибутив otel-collector-contrib или производные от него
  # cumulativetodelta:

  # Memory Limiter - защита от Out-of-Memory, рекомендуется в production для стабильности
  memory_limiter:
    check_interval: 1s
    limit_mib: 512        # Жесткий лимит памяти
    spike_limit_mib: 128  # Запас для всплесков

  # Resource - добавление атрибутов ресурса
  # resource:
  #   attributes:
  #     - key: deployment.environment
  #       value: production
  #       action: insert

  # Filter - фильтрация данных для исключения ненужной телеметрии
  # filter:
  #   traces:
  #     span:
  #       - 'attributes["http.url"] == "/health"'  # Исключить health checks
  #       - 'attributes["http.url"] == "/metrics"'
  #   metrics:
  #     metric:
  #       - 'name == "unwanted_metric"'
  #   logs:
  #     log_record:
  #       - 'severity_number < SEVERITY_NUMBER_INFO'  # Только INFO и выше

# ============================================================================
# EXPORTERS - Отправители данных
# ============================================================================
exporters:
  # Отправка в {{ monium-name }} по gRPC
  otlp/monium:
    endpoint: {{ api-host-monium }}:443
    compression: zstd  # Сжатие для экономии трафика (none | gzip | zstd)
    headers:
      Authorization: "Api-Key ${env:MONIUM_API_KEY}"
      x-monium-project: "${env:MONIUM_PROJECT}"
    
    # Настройки повторных попыток при ошибках
    retry_on_failure:
      enabled: true
      initial_interval: 5s     # Первая попытка через 5 сек
      max_interval: 30s        # Максимальная задержка 30 сек
      max_elapsed_time: 300s   # Прекратить попытки через 5 мин

  # Отправка в {{ monium-name }} по HTTP
  # otlphttp/monium:
    # endpoint: https://{{ api-host-monium }}/otlp
    # compression: zstd  # Сжатие для экономии трафика (none | gzip | zstd)
    # headers:
      # Authorization: "Api-Key ${env:MONIUM_API_KEY}"
      # x-monium-project: "${env:MONIUM_PROJECT}"

# ============================================================================
# EXTENSIONS - Расширения
# ============================================================================
extensions:

# ============================================================================
# SERVICE - Конфигурация пайплайнов
# ============================================================================
service:
  
  # Пайплайны обработки данных
  pipelines:
    # Поставка трейсов (удалите секцию, если трейсы не требуются)
    traces:
      receivers: [ otlp ]
      processors: [ memory_limiter, batch ]
      exporters: [ otlp/monium ]

    # Поставка метрик (удалите секцию, если метрики не требуются)
    metrics:
      receivers: [ otlp ]
      processors: [ memory_limiter, batch ]
      exporters: [ otlp/monium ]

    # Поставка логов (удалите секцию, если логи не требуются)
    logs:
      receivers: [ otlp ]
      processors: [ memory_limiter, batch ]
      exporters: [ otlp/monium ]

  # Телеметрия самого OTel Collector
  telemetry:
    logs:
      level: info  # debug | info | warn | error    
    metrics:
      level: detailed  # none | basic | normal | detailed
      
      # Отправка телеметрии самого OTel Collector
      readers:
         - periodic:
             interval: 60000
             exporter:
               otlp:
                 protocol: http/protobuf
                 endpoint: http://${env:MY_POD_IP}:4318
```

{% endcut %}