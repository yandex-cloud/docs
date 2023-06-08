# Настроить запись логов L7-балансировщика

[Логи](../concepts/application-load-balancer.md#logging) L7-балансировщика можно отправлять в сервис [{{ cloud-logging-full-name }}](../../logging/).

## Включить запись логов {#enable-logs}

{% list tabs %}

- Консоль управления

  1. В [консоли управления]({{ link-console-main }}) выберите каталог, в котором находится балансировщик.
  1. Выберите сервис **{{ alb-name }}**.
  1. В списке выберите нужный балансировщик, нажмите ![image](../../_assets/horizontal-ellipsis.svg) и выберите **Редактировать**.
  1. В блоке **Настройки логов**:

      1. Включите опцию **Запись логов**.
      1. Выберите [лог-группу](../../logging/concepts/log-group.md) {{ cloud-logging-name }}, в которую будут записываться логи балансировщика.
      1. Нажмите кнопку **Добавить правило отбрасывания логов** и настройте его [параметры](../concepts/application-load-balancer.md#discard-logs-rules):

          * **HTTP-коды** — добавьте HTTP-коды.
          * **Классы HTTP-кодов** — добавьте классы HTTP-кодов.
          * **gRPC-коды** — добавьте gRPC-коды.
          * **Доля отбрасываемых логов** — добавьте процент отбрасываемых логов.
      
          Вы можете задать больше одного правила.
  1. Нажмите **Сохранить**.

- CLI

  {% include [cli-install](../../_includes/cli-install.md) %}

  {% include [default-catalogue](../../_includes/default-catalogue.md) %}

  1. Посмотрите описание команды CLI для управления логированием в балансировщике:

      ```bash
      yc alb load-balancer logging --help
      ```

  1. Включите логирование и установите параметры записи [логов](../logs-ref.md) в {{ cloud-logging-name }}:

      ```bash
      yc alb load-balancer logging <имя_балансировщика> \
        --enable
        --log-group-id <идентификатор_лог-группы> \
        --discard codes=[<HTTP-код>,<Класс_HTTP-кода>,<gRPC-код>],percent=<доля_отбрасываемых_логов>
      ```

      Где:

      * `--enable` — параметр для включения логирования.
      * `--log-group-id` — идентификатор [лог-группы](../../logging/concepts/log-group.md), в которую будут записываться логи балансировщика.
      * `--discard` — [правило отбрасывания логов](../concepts/application-load-balancer.md#discard-logs-rules). Параметры правила:
        * `codes` — HTTP-коды, классы HTTP-кодов или gRPC-коды.
        * `percent` — доля отбрасываемых логов в процентах.
            
        Вы можете задать больше одного правила.

      Результат:

      ```yaml
      done (42s)
      id: ds76g8b2op3fej1.....
      name: test-load-balancer
      folder_id: b1gu6g9ielh690a.....
      ...
      log_options:
        log_group_id: e23p9bfj2kyra3t.....
        discard_rules:
          - http_codes:
              - "200"
            http_code_intervals:
              - HTTP_2XX
            grpc_codes:
              - OK
            discard_percent: "70"
      ```

- {{ TF }}

  Если у вас еще нет {{ TF }},  [установите его и настройте провайдер {{ yandex-cloud }}](../../tutorials/infrastructure-management/terraform-quickstart.md#install-terraform).

  1. Добавьте к описанию балансировщика в конфигурационном файле блок `log_options`:

      ```hcl
      log_options {
        log_group_id = "<идентификатор_лог-группы>"
        discard_rule {
          http_codes          = ["200"]
          http_code_intervals = ["HTTP_2XX"]
          grpc_codes          = ["GRPC_OK"]
          discard_percent     = 75
        }
      }
      ```

      Где `log_options` — параметры записи [логов](../logs-ref.md) в {{ cloud-logging-name }}:
        * `log_group_id` — идентификатор [лог-группы](../../logging/concepts/log-group.md), в которую будут записываться логи балансировщика.
        * `discard_rule` — [правило отбрасывания логов](../concepts/application-load-balancer.md#discard-logs-rules):
          * `http_codes` — HTTP-коды.
          * `http_code_intervals` — классы HTTP-кодов.
          * `grpc_codes` — gRPC-коды.
          * `discard_percent` — доля отбрасываемых логов в процентах.

          Вы можете задать больше одного правила.
  1. Примените изменения:

      {% include [terraform-validate-plan-apply](../../_tutorials/terraform-validate-plan-apply.md) %}

  После этого в указанном балансировщике будет включено логирование. Проверить статус логирования и другие настройки балансировщика можно в [консоли управления]({{ link-console-main }}) или с помощью команды [CLI](../../cli/quickstart.md):

  ```bash
  yc alb load-balancer get <имя_балансировщика>
  ```

- API

  Чтобы включить запись логов, воспользуйтесь методом REST API [update](../api-ref/LoadBalancer/update.md) для ресурса [LoadBalancer](../api-ref/LoadBalancer/index.md) или вызовом gRPC API [LoadBalancerService/Update](../api-ref/grpc/load_balancer_service.md#Update).

{% endlist %}

## Изменить параметры записи логов {#update-logs}

{% list tabs %}

- Консоль управления

  1. В [консоли управления]({{ link-console-main }}) выберите каталог, в котором находится балансировщик.
  1. Выберите сервис **{{ alb-name }}**.
  1. В списке выберите нужный балансировщик, нажмите ![image](../../_assets/horizontal-ellipsis.svg) и выберите **Редактировать**.
  1. В блоке **Настройки логов**:
  
      1. Измените [лог-группу](../../logging/concepts/log-group.md) {{ cloud-logging-name }}, в которую будут записываться логи балансировщика.
      1. Измените [правила отбрасывания логов](../concepts/application-load-balancer.md#discard-logs-rules):

          * **HTTP-коды** — измените HTTP-коды.
          * **Классы HTTP-кодов** — измените классы HTTP-кодов.
          * **gRPC-коды** — измените gRPC-коды.
          * **Доля отбрасываемых логов** — измените процент отбрасываемых логов.

          Чтобы добавить еще одно правило, нажмите кнопку **Добавить правило отбрасывания логов**.

  1. Нажмите **Сохранить**.

- CLI

  {% include [cli-install](../../_includes/cli-install.md) %}

  {% include [default-catalogue](../../_includes/default-catalogue.md) %}

  1. Посмотрите описание команды CLI для управления логированием в балансировщике:

      ```bash
      yc alb load-balancer logging --help
      ```

  1. Измените параметры записи [логов](../logs-ref.md) в {{ cloud-logging-name }}:

      ```bash
      yc alb load-balancer logging <имя_балансировщика> \
        --log-group-id <идентификатор_лог-группы> \
        --discard codes=[<HTTP-код>,<Класс_HTTP-кода>,<gRPC-код>],percent=<доля_отбрасываемых_логов>
      ```

      Где:

      * `--log-group-id` — идентификатор [лог-группы](../../logging/concepts/log-group.md), в которую будут записываться логи балансировщика.
      * `--discard` — [правило отбрасывания логов](../concepts/application-load-balancer.md#discard-logs-rules). Параметры правила:
        * `codes` — HTTP-коды, классы HTTP-кодов или gRPC-коды.
        * `percent` — доля отбрасываемых логов в процентах.
            
        Вы можете задать больше одного правила.

      Результат:

      ```yaml
      done (42s)
      id: ds76g8b2op3fej1.....
      name: test-load-balancer
      folder_id: b1gu6g9ielh690a.....
      ...
      log_options:
        log_group_id: e23p9bfj2kyra3t.....
        discard_rules:
          - http_codes:
              - "200"
            http_code_intervals:
              - HTTP_2XX
            grpc_codes:
              - OK
            discard_percent: "70"
      ```

- {{ TF }}

  Если у вас еще нет {{ TF }},  [установите его и настройте провайдер {{ yandex-cloud }}](../../tutorials/infrastructure-management/terraform-quickstart.md#install-terraform).

  1. В конфигурационном файле с описанием балансировщика измените блок `log_options` с новыми настройками логирования:

      ```hcl
      log_options {
        log_group_id = "<идентификатор_лог-группы>"
        discard_rule {
          http_codes          = ["200"]
          http_code_intervals = ["HTTP_2XX"]
          grpc_codes          = ["GRPC_OK"]
          discard_percent     = 75
        }
      }
      ```

      Где `log_options` — параметры записи [логов](../logs-ref.md) в {{ cloud-logging-name }}:
        * `log_group_id` — идентификатор [лог-группы](../../logging/concepts/log-group.md), в которую будут записываться логи балансировщика.
        * `discard_rule` — [правило отбрасывания логов](../concepts/application-load-balancer.md#discard-logs-rules):
          * `http_codes` — HTTP-коды.
          * `http_code_intervals` — классы HTTP-кодов.
          * `grpc_codes` — gRPC-коды.
          * `discard_percent` — доля отбрасываемых логов в процентах.

          Вы можете задать больше одного правила.
  1. Примените изменения:

      {% include [terraform-validate-plan-apply](../../_tutorials/terraform-validate-plan-apply.md) %}

  После этого в указанном балансировщике будут изменены параметры логирования. Проверить настройки балансировщика можно в [консоли управления]({{ link-console-main }}) или с помощью команды [CLI](../../cli/quickstart.md):

  ```bash
  yc alb load-balancer get <имя_балансировщика>
  ```

- API

  Чтобы изменить параметры записи логов, воспользуйтесь методом REST API [update](../api-ref/LoadBalancer/update.md) для ресурса [LoadBalancer](../api-ref/LoadBalancer/index.md) или вызовом gRPC API [LoadBalancerService/Update](../api-ref/grpc/load_balancer_service.md#Update).

{% endlist %}

## Выключить запись логов {#disable-logging}

{% list tabs %}

- Консоль управления

  1. В [консоли управления]({{ link-console-main }}) выберите каталог, в котором находится балансировщик.
  1. Выберите сервис **{{ alb-name }}**.
  1. В списке выберите нужный балансировщик, нажмите ![image](../../_assets/horizontal-ellipsis.svg) и выберите **Редактировать**.
  1. В блоке **Настройки логов** выключите опцию **Запись логов**.
  1. Нажмите **Сохранить**.

- CLI

  {% include [cli-install](../../_includes/cli-install.md) %}

  {% include [default-catalogue](../../_includes/default-catalogue.md) %}

  1. Посмотрите описание команды CLI для управления логированием в балансировщике:

      ```bash
      yc alb load-balancer logging --help
      ```

  1. Выключите логирование:

      ```bash
      yc alb load-balancer logging <имя_балансировщика> --disable
      ```

      Где `--disable` — параметр для выключения логирования.

      Результат:

      ```yaml
      done (42s)
      id: ds76g8b2op3fej1.....
      name: test-load-balancer
      folder_id: b1gu6g9ielh690a.....
      ...
      log_options:
        disable: true
      ```

- {{ TF }}

  Если у вас еще нет {{ TF }}, [установите его и настройте провайдер {{ yandex-cloud }}](../../tutorials/infrastructure-management/terraform-quickstart.md#install-terraform).

  1. В конфигурационном файле с описанием балансировщика удалите блок `log_options`:

      ```hcl
      log_options {
      ...  
      }
      ```

  1. Примените изменения:

      {% include [terraform-validate-plan-apply](../../_tutorials/terraform-validate-plan-apply.md) %}

  После этого в указанном балансировщике будет выключено логирование. Проверить статус логирования и другие настройки балансировщика можно в [консоли управления]({{ link-console-main }}) или с помощью команды [CLI](../../cli/quickstart.md):

    ```bash
    yc alb load-balancer get <имя_балансировщика>
    ```

- API

  Чтобы выключить запись логов, воспользуйтесь методом REST API [update](../api-ref/LoadBalancer/update.md) для ресурса [LoadBalancer](../api-ref/LoadBalancer/index.md) или вызовом gRPC API [LoadBalancerService/Update](../api-ref/grpc/load_balancer_service.md#Update).

{% endlist %}