# Отправка логов через Fluent Bit

{% include [about-agent](../../../_includes/monium/about-agent.md) %}

Fluent Bit оптимально использовать в следующих случаях:

* Много разных форматов логов и модифицированных парсеров.
* Приложение работает в кластере {{ k8s }}.
* Требуется собирать логи централизованно с помощью одного агента с хоста системы.
* Логи поставляются через файлы.

В остальных случаях рекомендуется использовать OTel Collector.

## Fluent-bit

Для отправки логов используйте [Fluent Bit](https://fluentbit.io/) версии 4.0 и выше с выходом `opentelemetry`.

Настраивайте конфигурацию в формате YAML, так как отправку Resource Attributes можно настроить только в этом формате.

Авторизация на запись реализована [**через `ApiKey`**](../../../iam/concepts/authorization/api-key.md) — укажите его в заголовке `Authorization: ApiKey` в выходе `opentelemetry`.

В заголовке `x-monium-project: [ProjectID]` укажите идентификатор проекта {{ monium-name }} — `folder__<идентификатор_каталога>`.

{% cut "Пример конфигурации для отправки логов из Docker-контейнера" %}

```yaml
pipeline:
  inputs:
    - name: tail
      path: /var/log/fluent/query.log
      parser: logging
      tag: ycp_query
      processors:
        logs:
          - name: opentelemetry_envelope

          - name: content_modifier
            context: otel_resource_attributes
            action: upsert
            key: service.name
            value: query
          - name: content_modifier
            context: otel_resource_attributes
            action: upsert
            key: cluster
            value: default
          - name: content_modifier
            context: otel_resource_attributes
            action: upsert
            key: host
            value: compute-cloud-host.yandex.net

  outputs:
    - name: opentelemetry
      match: ycp_query
      host: {{ api-host-monium }}
      port: 443
      logs_body_key: msg
      logs_trace_id_message_key: 'trace.id'
      logs_span_id_message_key: 'span.id'
      logs_body_key_attributes: true
      logs_severity_text_message_key: levelStr
      header: Authorization Api-Key ${API_KEY}
      header: x-monium-project ${PROJECT_ID}
      tls: on
      tls.verify: off
```
{% endcut %}

{% cut "Пример конфигурации с распространенными парсерами" %}

```yaml
pipeline:
  inputs:
    - name:              tail
      path:              /var/log/containers/*.log
      db:                /var/log/fluent/fluent-bit/flb_kube.db
      parser:            docker
      docker_mode:       on
      mem_buf_limit:     50mb
      skip_long_lines:   on
      refresh_interval:  10
      tag_regex:         '^.*_(?:[^_]+)_(?<container_name>.+)-(?:[a-z0-9]{64})\.log$'
      tag:               kube.<container_name>
      path_key:          source

  filters:
    - name: rewrite_tag
      match: 'kube.*'
      rule: $source ^.*_(?:[^_]+)_(.+)-(?:[a-z0-9]{64})\.log$ $1.log false
      emitter_name: query_emitter

    - name: aws
      match: query.log
      hostname: true
      private_ip: true

    - name: modify
      match: query.log
      hard_rename:
        - az zone
        - ec2_instance_id instance_id
        - private_ip ip

    - name:  parser
      match: query.log
      key_name: log
      parser: json
      reserve_data: on
      preserve_key: on
      unescape_key: on

    - name: modify
      match: query.log
      rename:
        - '@timestamp timestamp'

    - name: record_modifier
      match: query.log
      record: stream_name query
      remove_key: log

  outputs:
    - name: file
      match: query.log
      format: plain
      path: /var/log/fluent
```
{% endcut %}

{% cut "Распространенные парсеры" %}

```yaml
parsers:
  - name: apache
    format: regex
    regex:  '^(?<host>[^ ]*) [^ ]* (?<user>[^ ]*) \[(?<time>[^\]]*)\] "(?<method>\S+)(?: +(?<path>[^\"]*?)(?: +\S*)?)?" (?<code>[^ ]*) (?<size>[^ ]*)(?: "(?<referer>[^\"]*)" "(?<agent>[^\"]*)")?$'
    time_key: time
    time_format: '%d/%b/%Y:%H:%M:%S %z'

  - name:   apache2
    format: regex
    regex:  '^(?<host>[^ ]*) [^ ]* (?<user>[^ ]*) \[(?<time>[^\]]*)\] "(?<method>\S+)(?: +(?<path>[^ ]*) +\S*)?" (?<code>[^ ]*) (?<size>[^ ]*)(?: "(?<referer>[^\"]*)" "(?<agent>.*)")?$'
    time_key: time
    time_format: '%d/%b/%Y:%H:%M:%S %z'

  - name:   apache_error
    format: regex
    regex:  '^\[[^ ]* (?<time>[^\]]*)\] \[(?<level>[^\]]*)\](?: \[pid (?<pid>[^\]]*)\])?( \[client (?<client>[^\]]*)\])? (?<message>.*)$'

  - name:   nginx
    format: regex
    regex: '^(?<remote>[^ ]*) (?<host>[^ ]*) (?<user>[^ ]*) \[(?<time>[^\]]*)\] "(?<method>\S+)(?: +(?<path>[^\"]*?)(?: +\S*)?)?" (?<code>[^ ]*) (?<size>[^ ]*)(?: "(?<referer>[^\"]*)" "(?<agent>[^\"]*)")'
    time_key: time
    time_format: '%d/%b/%Y:%H:%M:%S %z'

  - name:        k8s-nginx-ingress # https://rubular.com/r/IhIbCAIs7ImOkc
    format:      regex
    regex:       '^(?<host>[^ ]*) - (?<user>[^ ]*) \[(?<time>[^\]]*)\] "(?<method>\S+)(?: +(?<path>[^\"]*?)(?: +\S*)?)?" (?<code>[^ ]*) (?<size>[^ ]*) "(?<referer>[^\"]*)" "(?<agent>[^\"]*)" (?<request_length>[^ ]*) (?<request_time>[^ ]*) \[(?<proxy_upstream_name>[^ ]*)\] (\[(?<proxy_alternative_upstream_name>[^ ]*)\] )?(?<upstream_addr>[^ ]*) (?<upstream_response_length>[^ ]*) (?<upstream_response_time>[^ ]*) (?<upstream_status>[^ ]*) (?<reg_id>[^ ]*).*$'
    time_key:     time
    time_format: '%d/%b/%Y:%H:%M:%S %z'

  - name:   json
    format: json
    time_key: time
    time_format: '%d/%b/%Y:%H:%M:%S %z'

  - name:         docker
    format:       json
    time_key:     time
    time_format:  '%Y-%m-%dT%H:%M:%S.%L'
    time_keep:    on
    # --
    # Since Fluent Bit v1.2, if you are parsing Docker logs and using
    # the Kubernetes filter, it's not longer required to decode the
    # 'log' key.
    #
    # Command      |  Decoder | Field | Optional Action
    # =============|==================|=================
    #Decode_Field_As    json     log

  - name:        docker-daemon
    format:      regex
    regex:       'time="(?<time>[^ ]*)" level=(?<level>[^ ]*) msg="(?<msg>[^ ].*)"'
    time_key:     time
    time_format: '%Y-%m-%dT%H:%M:%S.%L'
    time_keep:   on

  - name:        syslog-rfc5424
    format:      regex
    regex:       '^\<(?<pri>[0-9]{1,5})\>1 (?<time>[^ ]+) (?<host>[^ ]+) (?<ident>[^ ]+) (?<pid>[-0-9]+) (?<msgid>[^ ]+) (?<extradata>(\[(.*?)\]|-)) (?<message>.+)$'
    time_key:     time
    time_format: '%Y-%m-%dT%H:%M:%S.%L%z'
    time_keep:   on

  - name:        syslog-rfc3164-local
    format:      regex
    regex:       '^\<(?<pri>[0-9]+)\>(?<time>[^ ]* {1,2}[^ ]* [^ ]*) (?<ident>[a-zA-Z0-9_\/\.\-]*)(?:\[(?<pid>[0-9]+)\])?(?:[^\:]*\:)? *(?<message>.*)$'
    time_key:     time
    time_format: '%b %d %H:%M:%S'
    time_keep:   on

  - name:        syslog-rfc3164
    format:      regex
    regex:       '/^\<(?<pri>[0-9]+)\>(?<time>[^ ]* {1,2}[^ ]* [^ ]*) (?<host>[^ ]*) (?<ident>[a-zA-Z0-9_\/\.\-]*)(?:\[(?<pid>[0-9]+)\])?(?:[^\:]*\:)? *(?<message>.*)$/'
    time_key:     time
    time_format: '%b %d %H:%M:%S'
    time_keep:   on

    # https://rubular.com/r/3fVxCrE5iFiZim
  - name:    envoy
    format:  regex
    regex: '^\[(?<start_time>[^\]]*)\] "(?<method>\S+)(?: +(?<path>[^\"]*?)(?: +\S*)?)? (?<protocol>\S+)" (?<code>[^ ]*) (?<response_flags>[^ ]*) (?<bytes_received>[^ ]*) (?<bytes_sent>[^ ]*) (?<duration>[^ ]*) (?<x_envoy_upstream_service_time>[^ ]*) "(?<x_forwarded_for>[^ ]*)" "(?<user_agent>[^\"]*)" "(?<request_id>[^\"]*)" "(?<authority>[^ ]*)" "(?<upstream_host>[^ ]*)"'
    time_format: '%Y-%m-%dT%H:%M:%S.%L%z'
    time_keep:   on
    time_key:  start_time

    # http://rubular.com/r/tjUt3Awgg4
  - name: cri
    format: regex
    regex: '^(?<time>[^ ]+) (?<stream>stdout|stderr) (?<logtag>[^ ]*) (?<message>.*)$'
    time_key:    time
    time_format: '%Y-%m-%dT%H:%M:%S.%L%z'

  - name:    kube-custom
    format:  regex
    regex:   '(?<tag>[^.]+)?\.?(?<pod_name>[a-z0-9](?:[-a-z0-9]*[a-z0-9])?(?:\.[a-z0-9]([-a-z0-9]*[a-z0-9])?)*)_(?<namespace_name>[^_]+)_(?<container_name>.+)-(?<docker_id>[a-z0-9]{64})\.log$'

  - name: remove-line-break
    format: 'regex'
    regex: '^(?<log2>.*)\n$'

  - name:         yc-access
    format:       json
    time_key:     timestamp
    time_format:  '%Y-%m-%dT%H:%M:%S%z'
    time_keep:    on

  - name:     logging
    format:   json
    time_key: time
    time_format: '%Y-%m-%dT%H:%M:%S.%L'
    time_keep: on
```
{% endcut %}
