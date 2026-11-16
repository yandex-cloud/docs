# Настроить запись логов L7-балансировщика

{% include [monium-logs-kz-note](../../_includes/application-load-balancer/monium-logs-kz-note.md) %}

Логи L7-балансировщика записываются в [{{ monium-logs-name }}](../../monium/logs/quickstart-resources.md) в [проект каталога](*monium-folder-project) с балансировщиком. Если вы ранее настраивали запись логов в {{ cloud-logging-name }}, идентификатор лог-группы можно оставить в конфигурации: теперь он игнорируется.

{% note info %}

Управление логированием в интерфейсе {{ alb-name }} пока недоступно. Используйте CLI, API или {{ TF }}. [Просматривать логи](application-load-balancer-get-logs.md) можно в интерфейсе {{ monium-name }}.

{% endnote %}

## Включить запись логов {#enable-logs}

{% list tabs group=instructions %}

- CLI {#cli}

  {% include [cli-install](../../_includes/cli-install.md) %}

  {% include [default-catalogue](../../_includes/default-catalogue.md) %}

  1. Посмотрите описание команды [CLI](../../cli/) для управления логированием в балансировщике:

     ```bash
     yc alb load-balancer logging --help
     ```

  1. Включите логирование и установите параметры записи [логов](../logs-ref.md) в {{ monium-logs-name }}:

     ```bash
     yc alb load-balancer logging <имя_балансировщика> \
       --enable \
       --discard 'codes=[200,3XX,GRPC_OK],percent=70'
     ```

     Где:
     
     * `--enable` — параметр для включения логирования.
     * `--discard` — необязательное [правило отбрасывания логов](../concepts/monitoring.md#discard-logs-rules). Параметры правила:
       
       * `codes` — HTTP-коды, классы HTTP-кодов или gRPC-коды.
       * `percent` — доля отбрасываемых логов в процентах.

       Повторите `--discard` для каждого правила. Переданный набор полностью заменяет прежние правила отбрасывания. В примере отбрасывается 70% записей с HTTP-кодом `200`, кодами класса `3XX` или gRPC-кодом `OK`.

     Результат:

     ```text
     done (42s)
     id: ds76g8b2op3f*********
     name: test-load-balancer
     ...
     log_options:
       discard_rules:
         - http_codes:
             - "200"
           http_code_intervals:
             - HTTP_3XX
           grpc_codes:
             - OK
           discard_percent: "70"
     ```

- {{ TF }} {#tf}

  {% include [terraform-definition](../../_tutorials/_tutorials_includes/terraform-definition.md) %}

  {% include [terraform-install](../../_includes/terraform-install.md) %}

  1. Добавьте к описанию балансировщика в конфигурационном файле блок `log_options`:

     ```hcl
     log_options {
       disable = false

       discard_rule {
         http_codes      = [200]
         discard_percent = 70
       }
     }
     ```

     Где `log_options` — параметры записи [логов](../logs-ref.md) в {{ monium-logs-name }}:
     
     * `disable = false` — включить запись логов.
     * `discard_rule` — [правило отбрасывания логов](../concepts/monitoring.md#discard-logs-rules):
       
       * `http_codes` — HTTP-коды.
       * `http_code_intervals` — классы HTTP-кодов.
       * `grpc_codes` — gRPC-коды.
       * `discard_percent` — доля отбрасываемых логов в процентах.

       Вы можете задать больше одного правила. Параметры блока описаны в [документации провайдера]({{ tf-provider-resources-link }}/alb_load_balancer).
  
  1. Примените изменения:

     {% include [terraform-validate-plan-apply](../../_tutorials/_tutorials_includes/terraform-validate-plan-apply.md) %}

      Проверьте настройки логирования командой CLI:

      ```bash
      yc alb load-balancer get <имя_балансировщика>
      ```

      {% include [Terraform timeouts](../../_includes/application-load-balancer/terraform-timeout-alb.md) %}

- API {#api}

  Чтобы включить запись логов, воспользуйтесь методом REST API [update](../api-ref/LoadBalancer/update.md) для ресурса [LoadBalancer](../api-ref/LoadBalancer/index.md) или вызовом gRPC API [LoadBalancerService/Update](../api-ref/grpc/LoadBalancer/update.md).

{% endlist %}

## Изменить параметры записи логов {#update-logs}

{% list tabs group=instructions %}

- CLI {#cli}

  1. Посмотрите описание команды CLI для управления логированием в балансировщике:

     ```bash
     yc alb load-balancer logging --help
     ```

  1. Измените параметры записи [логов](../logs-ref.md) в {{ monium-logs-name }}:

     ```bash
     yc alb load-balancer logging <имя_балансировщика> \
       --discard 'codes=[200,3XX,GRPC_OK],percent=70'
     ```

     Где:
     
     * `--discard` — [правило отбрасывания логов](../concepts/monitoring.md#discard-logs-rules). Параметры правила:
       
       * `codes` — HTTP-коды, классы HTTP-кодов или gRPC-коды.
       * `percent` — доля отбрасываемых логов в процентах.

       Повторите `--discard` для каждого правила. Переданный набор полностью заменяет прежние правила отбрасывания. В примере отбрасывается 70% записей с HTTP-кодом `200`, кодами класса `3XX` или gRPC-кодом `OK`.

     Результат:

     ```text
     done (42s)
     id: ds76g8b2op3f********
     name: test-load-balancer
     ...
     log_options:
       discard_rules:
         - http_codes:
             - "200"
           http_code_intervals:
             - HTTP_3XX
           grpc_codes:
             - OK
           discard_percent: "70"
     ```

- {{ TF }} {#tf}

  1. В конфигурационном файле с описанием балансировщика измените настройки логирования в блоке `log_options`:

     ```hcl
     log_options {
       disable = false

       discard_rule {
         http_codes      = [200]
         discard_percent = 70
       }
     }
     ```

     Где `log_options` — параметры записи [логов](../logs-ref.md) в {{ monium-logs-name }}:
     
     * `disable = false` — включить запись логов.
     * `discard_rule` — [правило отбрасывания логов](../concepts/monitoring.md#discard-logs-rules):
       
       * `http_codes` — HTTP-коды.
       * `http_code_intervals` — классы HTTP-кодов.
       * `grpc_codes` — gRPC-коды.
       * `discard_percent` — доля отбрасываемых логов в процентах.

       Вы можете задать больше одного правила. Параметры блока описаны в [документации провайдера]({{ tf-provider-resources-link }}/alb_load_balancer).
  1. Примените изменения:

     {% include [terraform-validate-plan-apply](../../_tutorials/_tutorials_includes/terraform-validate-plan-apply.md) %}

      Проверьте настройки логирования командой [CLI](../../cli/quickstart.md):

      ```bash
      yc alb load-balancer get <имя_балансировщика>
      ```

- API {#api}

  Чтобы изменить параметры записи логов, воспользуйтесь методом REST API [update](../api-ref/LoadBalancer/update.md) для ресурса [LoadBalancer](../api-ref/LoadBalancer/index.md) или вызовом gRPC API [LoadBalancerService/Update](../api-ref/grpc/LoadBalancer/update.md).

{% endlist %}

## Выключить запись логов {#disable-logging}

{% list tabs group=instructions %}

- CLI {#cli}

  1. Посмотрите описание команды CLI для управления логированием в балансировщике:

     ```bash
     yc alb load-balancer logging --help
     ```

  1. Выключите логирование:

     ```bash
     yc alb load-balancer logging <имя_балансировщика> --disable
     ```

     Где `--disable` — параметр для выключения логирования.

     Результат:

     ```text
     done (42s)
     id: ds76g8b2op3f********
     name: test-load-balancer
     ...
     log_options:
       disable: true
     ```

- {{ TF }} {#tf}

  1. В конфигурационном файле с описанием балансировщика установите `disable = true` в блоке `log_options`:

     ```hcl
     log_options {
       disable = true
     }
     ```

  1. Примените изменения:

     {% include [terraform-validate-plan-apply](../../_tutorials/_tutorials_includes/terraform-validate-plan-apply.md) %}

     Проверьте настройки логирования командой [CLI](../../cli/quickstart.md):

     ```bash
     yc alb load-balancer get <имя_балансировщика>
     ```

- API {#api}

  Чтобы выключить запись логов, воспользуйтесь методом REST API [update](../api-ref/LoadBalancer/update.md) для ресурса [LoadBalancer](../api-ref/LoadBalancer/index.md) или вызовом gRPC API [LoadBalancerService/Update](../api-ref/grpc/LoadBalancer/update.md).

{% endlist %}

[*monium-folder-project]: {% include notitle [folder-project](../../_popups/monium/folder-project.md) %}
