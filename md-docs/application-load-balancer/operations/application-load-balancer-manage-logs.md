# Настроить запись логов L7-балансировщика

[Логи](../concepts/monitoring.md#logging) [L7-балансировщика](../concepts/application-load-balancer.md) можно отправлять в сервис [Yandex Cloud Logging](../../logging/index.md).

## Включить запись логов {#enable-logs}

{% list tabs group=instructions %}

- Консоль управления {#console}

  1. В [консоли управления](https://console.yandex.cloud) выберите [каталог](../../resource-manager/concepts/resources-hierarchy.md#folder), в котором находится балансировщик.
  1. [Перейдите](../../console/operations/select-service.md#select-service) в сервис **Application Load Balancer**.
  1. В списке выберите нужный балансировщик, нажмите ![image](../../_assets/console-icons/ellipsis.svg) и выберите **Редактировать**.
  1. В блоке **Настройки логов**:
     1. Включите опцию **Запись логов**.
     1. Выберите [лог-группу](../../logging/concepts/log-group.md) Cloud Logging, в которую будут записываться логи балансировщика.
     1. Нажмите кнопку **Добавить правило отбрасывания логов** и настройте его [параметры](../concepts/application-load-balancer.md#discard-logs-rules):
        * **HTTP-коды** — добавьте HTTP-коды.
        * **Классы HTTP-кодов** — добавьте классы HTTP-кодов.
        * **gRPC-коды** — добавьте gRPC-коды.
        * **Доля отбрасываемых логов** — добавьте процент отбрасываемых логов.

        Вы можете задать больше одного правила.
  1. Нажмите **Сохранить**.

- CLI {#cli}

  Если у вас еще нет интерфейса командной строки Yandex Cloud (CLI), [установите и инициализируйте его](../../cli/quickstart.md#install).

  По умолчанию используется каталог, указанный при [создании](../../cli/operations/profile/profile-create.md) профиля CLI. Чтобы изменить каталог по умолчанию, используйте команду `yc config set folder-id <идентификатор_каталога>`. Также для любой команды вы можете указать другой каталог с помощью параметров `--folder-name` или `--folder-id`. Если вы обращаетесь к ресурсу по имени, поиск будет выполнен в каталоге по умолчанию. Если вы обращаетесь к ресурсу по идентификатору, поиск будет выполнен глобально — во всех каталогах с учетом прав доступа.

  1. Посмотрите описание команды [CLI](../../cli/index.md) для управления логированием в балансировщике:

     ```bash
     yc alb load-balancer logging --help
     ```

  1. Включите логирование и установите параметры записи [логов](../logs-ref.md) в Cloud Logging:

     ```bash
     yc alb load-balancer logging <имя_балансировщика> \
       --enable \
       --log-group-id <идентификатор_лог-группы> \
       --discard codes=[<HTTP-код>,<класс_HTTP-кода>,<gRPC-код>],percent=<доля_отбрасываемых_логов>
     ```

     Где:
     * `--enable` — параметр для включения логирования.
     * `--log-group-id` — идентификатор [лог-группы](../../logging/concepts/log-group.md), в которую будут записываться логи балансировщика.
     * `--discard` — [правило отбрасывания логов](../concepts/application-load-balancer.md#discard-logs-rules). Параметры правила:
       * `codes` — HTTP-коды, классы HTTP-кодов или gRPC-коды.
       * `percent` — доля отбрасываемых логов в процентах.

       Вы можете задать больше одного правила.

     Результат:

     ```text
     done (42s)
     id: ds76g8b2op3f*********
     name: test-load-balancer
     ...
     log_options:
       log_group_id: e23p9bfj2kyr********
       discard_rules:
         - http_codes:
             - "200"
           http_code_intervals:
             - HTTP_2XX
           grpc_codes:
             - OK
           discard_percent: "70"
     ```

- Terraform {#tf}

  Если у вас еще нет Terraform, [установите его и настройте провайдер Yandex Cloud](../../tutorials/infrastructure-management/terraform-quickstart.md#install-terraform).

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

     Где `log_options` — параметры записи [логов](../logs-ref.md) в Cloud Logging:
     * `log_group_id` — идентификатор [лог-группы](../../logging/concepts/log-group.md), в которую будут записываться логи балансировщика.
     * `discard_rule` — [правило отбрасывания логов](../concepts/application-load-balancer.md#discard-logs-rules):
       * `http_codes` — HTTP-коды.
       * `http_code_intervals` — классы HTTP-кодов.
       * `grpc_codes` — gRPC-коды.
       * `discard_percent` — доля отбрасываемых логов в процентах.

       Вы можете задать больше одного правила.
  1. Примените изменения:

     1. В терминале перейдите в директорию с конфигурационным файлом.
     1. Проверьте корректность конфигурации с помощью команды:
     
        ```bash
        terraform validate
        ```
     
        Если конфигурация является корректной, появится сообщение:
     
        ```bash
        Success! The configuration is valid.
        ```
     
     1. Выполните команду:
     
        ```bash
        terraform plan
        ```
     
        В терминале будет выведен список ресурсов с параметрами. На этом этапе изменения не будут внесены. Если в конфигурации есть ошибки, Terraform на них укажет.
     1. Примените изменения конфигурации:
     
        ```bash
        terraform apply
        ```
     
     1. Подтвердите изменения: введите в терминале слово `yes` и нажмите **Enter**.

      После этого в указанном балансировщике будет включено логирование. Проверить статус логирования и другие настройки балансировщика можно в [консоли управления](https://console.yandex.cloud) или с помощью команды CLI:

      ```bash
      yc alb load-balancer get <имя_балансировщика>
      ```

      {% note warning "Ограничения по времени" %}
      
      Провайдер Terraform ограничивает время на выполнение операций с балансировщиками Application Load Balancer 10 минутами.
      
      Операции, которые длятся дольше указанного времени, прерываются.
      
      {% cut "Как изменить эти ограничения?" %}
      
      Добавьте к описанию балансировщика блок `timeouts`, например:
      
      ```hcl
      resource "yandex_alb_load_balancer" "<имя_балансировщика>" {
        ...
        timeouts {
          create = "60m"
          update = "60m"
          delete = "60m"
        }
      }
      ```
      
      {% endcut %}
      
      {% endnote %}

- API {#api}

  Чтобы включить запись логов, воспользуйтесь методом REST API [update](../api-ref/LoadBalancer/update.md) для ресурса [LoadBalancer](../api-ref/LoadBalancer/index.md) или вызовом gRPC API [LoadBalancerService/Update](../api-ref/grpc/LoadBalancer/update.md).

{% endlist %}

## Изменить параметры записи логов {#update-logs}

{% list tabs group=instructions %}

- Консоль управления {#console}

  1. В [консоли управления](https://console.yandex.cloud) выберите каталог, в котором находится балансировщик.
  1. [Перейдите](../../console/operations/select-service.md#select-service) в сервис **Application Load Balancer**.
  1. В списке выберите нужный балансировщик, нажмите ![image](../../_assets/console-icons/ellipsis.svg) и выберите **Редактировать**.
  1. В блоке **Настройки логов**:
     1. Измените лог-группу Cloud Logging, в которую будут записываться логи балансировщика.
     1. Измените [правила отбрасывания логов](../concepts/application-load-balancer.md#discard-logs-rules):
        * **HTTP-коды** — измените HTTP-коды.
        * **Классы HTTP-кодов** — измените классы HTTP-кодов.
        * **gRPC-коды** — измените gRPC-коды.
        * **Доля отбрасываемых логов** — измените процент отбрасываемых логов.

        Чтобы добавить еще одно правило, нажмите кнопку **Добавить правило отбрасывания логов**.
  1. Нажмите **Сохранить**.

- CLI {#cli}

  Если у вас еще нет интерфейса командной строки Yandex Cloud (CLI), [установите и инициализируйте его](../../cli/quickstart.md#install).

  По умолчанию используется каталог, указанный при [создании](../../cli/operations/profile/profile-create.md) профиля CLI. Чтобы изменить каталог по умолчанию, используйте команду `yc config set folder-id <идентификатор_каталога>`. Также для любой команды вы можете указать другой каталог с помощью параметров `--folder-name` или `--folder-id`. Если вы обращаетесь к ресурсу по имени, поиск будет выполнен в каталоге по умолчанию. Если вы обращаетесь к ресурсу по идентификатору, поиск будет выполнен глобально — во всех каталогах с учетом прав доступа.

  1. Посмотрите описание команды CLI для управления логированием в балансировщике:

     ```bash
     yc alb load-balancer logging --help
     ```

  1. Измените параметры записи [логов](../logs-ref.md) в Cloud Logging:

     ```bash
     yc alb load-balancer logging <имя_балансировщика> \
       --log-group-id <идентификатор_лог-группы> \
       --discard codes=[<HTTP-код>,<класс_HTTP-кода>,<gRPC-код>],percent=<доля_отбрасываемых_логов>
     ```

     Где:
     * `--log-group-id` — идентификатор [лог-группы](../../logging/concepts/log-group.md), в которую будут записываться логи балансировщика.
     * `--discard` — [правило отбрасывания логов](../concepts/application-load-balancer.md#discard-logs-rules). Параметры правила:
       * `codes` — HTTP-коды, классы HTTP-кодов или gRPC-коды.
       * `percent` — доля отбрасываемых логов в процентах.

       Вы можете задать больше одного правила.

     Результат:

     ```text
     done (42s)
     id: ds76g8b2op3f********
     name: test-load-balancer
     ...
     log_options:
       log_group_id: e23p9bfj2kyr********
       discard_rules:
         - http_codes:
             - "200"
           http_code_intervals:
             - HTTP_2XX
           grpc_codes:
             - OK
           discard_percent: "70"
     ```

- Terraform {#tf}

  Если у вас еще нет Terraform, [установите его и настройте провайдер Yandex Cloud](../../tutorials/infrastructure-management/terraform-quickstart.md#install-terraform).

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

     Где `log_options` — параметры записи [логов](../logs-ref.md) в Cloud Logging:
     * `log_group_id` — идентификатор [лог-группы](../../logging/concepts/log-group.md), в которую будут записываться логи балансировщика.
     * `discard_rule` — [правило отбрасывания логов](../concepts/application-load-balancer.md#discard-logs-rules):
       * `http_codes` — HTTP-коды.
       * `http_code_intervals` — классы HTTP-кодов.
       * `grpc_codes` — gRPC-коды.
       * `discard_percent` — доля отбрасываемых логов в процентах.

       Вы можете задать больше одного правила.
  1. Примените изменения:

     1. В терминале перейдите в директорию с конфигурационным файлом.
     1. Проверьте корректность конфигурации с помощью команды:
     
        ```bash
        terraform validate
        ```
     
        Если конфигурация является корректной, появится сообщение:
     
        ```bash
        Success! The configuration is valid.
        ```
     
     1. Выполните команду:
     
        ```bash
        terraform plan
        ```
     
        В терминале будет выведен список ресурсов с параметрами. На этом этапе изменения не будут внесены. Если в конфигурации есть ошибки, Terraform на них укажет.
     1. Примените изменения конфигурации:
     
        ```bash
        terraform apply
        ```
     
     1. Подтвердите изменения: введите в терминале слово `yes` и нажмите **Enter**.

      После этого в указанном балансировщике будут изменены параметры логирования. Проверить настройки балансировщика можно в [консоли управления](https://console.yandex.cloud) или с помощью команды [CLI](../../cli/quickstart.md):

      ```bash
      yc alb load-balancer get <имя_балансировщика>
      ```

      {% note warning "Ограничения по времени" %}
      
      Провайдер Terraform ограничивает время на выполнение операций с балансировщиками Application Load Balancer 10 минутами.
      
      Операции, которые длятся дольше указанного времени, прерываются.
      
      {% cut "Как изменить эти ограничения?" %}
      
      Добавьте к описанию балансировщика блок `timeouts`, например:
      
      ```hcl
      resource "yandex_alb_load_balancer" "<имя_балансировщика>" {
        ...
        timeouts {
          create = "60m"
          update = "60m"
          delete = "60m"
        }
      }
      ```
      
      {% endcut %}
      
      {% endnote %}

- API {#api}

  Чтобы изменить параметры записи логов, воспользуйтесь методом REST API [update](../api-ref/LoadBalancer/update.md) для ресурса [LoadBalancer](../api-ref/LoadBalancer/index.md) или вызовом gRPC API [LoadBalancerService/Update](../api-ref/grpc/LoadBalancer/update.md).

{% endlist %}

## Выключить запись логов {#disable-logging}

{% list tabs group=instructions %}

- Консоль управления {#console}

  1. В [консоли управления](https://console.yandex.cloud) выберите каталог, в котором находится балансировщик.
  1. [Перейдите](../../console/operations/select-service.md#select-service) в сервис **Application Load Balancer**.
  1. В списке выберите нужный балансировщик, нажмите ![image](../../_assets/console-icons/ellipsis.svg) и выберите **Редактировать**.
  1. В блоке **Настройки логов** выключите опцию **Запись логов**.
  1. Нажмите **Сохранить**.

- CLI {#cli}

  Если у вас еще нет интерфейса командной строки Yandex Cloud (CLI), [установите и инициализируйте его](../../cli/quickstart.md#install).

  По умолчанию используется каталог, указанный при [создании](../../cli/operations/profile/profile-create.md) профиля CLI. Чтобы изменить каталог по умолчанию, используйте команду `yc config set folder-id <идентификатор_каталога>`. Также для любой команды вы можете указать другой каталог с помощью параметров `--folder-name` или `--folder-id`. Если вы обращаетесь к ресурсу по имени, поиск будет выполнен в каталоге по умолчанию. Если вы обращаетесь к ресурсу по идентификатору, поиск будет выполнен глобально — во всех каталогах с учетом прав доступа.

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

- Terraform {#tf}

  Если у вас еще нет Terraform, [установите его и настройте провайдер Yandex Cloud](../../tutorials/infrastructure-management/terraform-quickstart.md#install-terraform).

  1. В конфигурационном файле с описанием балансировщика удалите блок `log_options`:

     ```hcl
     log_options {
     ...
     }
     ```

  1. Примените изменения:

     1. В терминале перейдите в директорию с конфигурационным файлом.
     1. Проверьте корректность конфигурации с помощью команды:
     
        ```bash
        terraform validate
        ```
     
        Если конфигурация является корректной, появится сообщение:
     
        ```bash
        Success! The configuration is valid.
        ```
     
     1. Выполните команду:
     
        ```bash
        terraform plan
        ```
     
        В терминале будет выведен список ресурсов с параметрами. На этом этапе изменения не будут внесены. Если в конфигурации есть ошибки, Terraform на них укажет.
     1. Примените изменения конфигурации:
     
        ```bash
        terraform apply
        ```
     
     1. Подтвердите изменения: введите в терминале слово `yes` и нажмите **Enter**.

     После этого в указанном балансировщике будет выключено логирование. Проверить статус логирования и другие настройки балансировщика можно в [консоли управления](https://console.yandex.cloud) или с помощью команды [CLI](../../cli/quickstart.md):

     ```bash
     yc alb load-balancer get <имя_балансировщика>
     ```

     {% note warning "Ограничения по времени" %}
     
     Провайдер Terraform ограничивает время на выполнение операций с балансировщиками Application Load Balancer 10 минутами.
     
     Операции, которые длятся дольше указанного времени, прерываются.
     
     {% cut "Как изменить эти ограничения?" %}
     
     Добавьте к описанию балансировщика блок `timeouts`, например:
     
     ```hcl
     resource "yandex_alb_load_balancer" "<имя_балансировщика>" {
       ...
       timeouts {
         create = "60m"
         update = "60m"
         delete = "60m"
       }
     }
     ```
     
     {% endcut %}
     
     {% endnote %}

- API {#api}

  Чтобы выключить запись логов, воспользуйтесь методом REST API [update](../api-ref/LoadBalancer/update.md) для ресурса [LoadBalancer](../api-ref/LoadBalancer/index.md) или вызовом gRPC API [LoadBalancerService/Update](../api-ref/grpc/LoadBalancer/update.md).

{% endlist %}