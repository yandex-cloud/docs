[Документация Yandex Cloud](../../index.md) > [Yandex Application Load Balancer](../index.md) > [Пошаговые инструкции](index.md) > L7-балансировщики > Настроить запись логов L7-балансировщика

# Настроить запись логов L7-балансировщика



Логи L7-балансировщика записываются в [Monium Logs](../../monium/logs/quickstart-resources.md) в [проект каталога](*monium-folder-project) с балансировщиком. Если вы ранее настраивали запись логов в Cloud Logging, идентификатор лог-группы можно оставить в конфигурации: теперь он игнорируется.

{% note info %}

Управление логированием в интерфейсе Application Load Balancer пока недоступно. Используйте CLI, API или Terraform. [Просматривать логи](application-load-balancer-get-logs.md) можно в интерфейсе Monium.

{% endnote %}

## Включить запись логов {#enable-logs}

{% list tabs group=instructions %}

- CLI {#cli}

  Если у вас еще нет интерфейса командной строки Yandex Cloud (CLI), [установите и инициализируйте его](../../cli/quickstart.md#install).

  По умолчанию используется каталог, указанный при [создании](../../cli/operations/profile/profile-create.md) профиля CLI. Чтобы изменить каталог по умолчанию, используйте команду `yc config set folder-id <идентификатор_каталога>`. Также для любой команды вы можете указать другой каталог с помощью параметров `--folder-name` или `--folder-id`.
  
  Если вы обращаетесь к ресурсу по имени, поиск будет выполнен в каталоге по умолчанию. Если вы обращаетесь к ресурсу по идентификатору, поиск будет выполнен глобально — во всех каталогах с учетом прав доступа.

  1. Посмотрите описание команды [CLI](../../cli/index.md) для управления логированием в балансировщике:

     ```bash
     yc alb load-balancer logging --help
     ```

  1. Включите логирование и установите параметры записи [логов](../logs-ref.md) в Monium Logs:

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

- Terraform {#tf}

  [Terraform](https://www.terraform.io/) позволяет быстро создать облачную инфраструктуру в Yandex Cloud и управлять ею с помощью файлов конфигураций. В файлах конфигураций хранится описание инфраструктуры на языке HCL (HashiCorp Configuration Language). При изменении файлов конфигураций Terraform автоматически определяет, какая часть вашей конфигурации уже развернута, что следует добавить или удалить.
  
  Terraform распространяется под лицензией [Business Source License](https://github.com/hashicorp/terraform/blob/main/LICENSE), а [провайдер Yandex Cloud для Terraform](https://github.com/yandex-cloud/terraform-provider-yandex) — под лицензией [MPL-2.0](https://www.mozilla.org/en-US/MPL/2.0/).
  
  Подробная информация о ресурсах провайдера в документации на сайте [Terraform](https://www.terraform.io/docs/providers/yandex/index.html) или в [зеркале](../../terraform/index.md).

  Если у вас еще нет Terraform, [установите его и настройте провайдер Yandex Cloud](../../tutorials/infrastructure-management/terraform-quickstart.md#install-terraform).
  
  
  Чтобы управлять инфраструктурой с помощью Terraform от имени сервисного аккаунта или пользовательских аккаунтов: аккаунта на Яндексе, федеративного аккаунта и локального пользователя, [аутентифицируйтесь](../../terraform/authentication.md) соответствующим способом.

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

     Где `log_options` — параметры записи [логов](../logs-ref.md) в Monium Logs:
     
     * `disable = false` — включить запись логов.
     * `discard_rule` — [правило отбрасывания логов](../concepts/monitoring.md#discard-logs-rules):
       
       * `http_codes` — HTTP-коды.
       * `http_code_intervals` — классы HTTP-кодов.
       * `grpc_codes` — gRPC-коды.
       * `discard_percent` — доля отбрасываемых логов в процентах.

       Вы можете задать больше одного правила. Параметры блока описаны в [документации провайдера](../../terraform/resources/alb_load_balancer.md).
  
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
     
        В терминале будет выведен список планируемых изменений: ресурсы и/или выходные переменные. На этом этапе изменения не будут внесены. Если в конфигурации есть ошибки, Terraform на них укажет.
     1. Примените изменения конфигурации:
     
        ```bash
        terraform apply
        ```
     
     1. Подтвердите изменения: введите в терминале слово `yes` и нажмите **Enter**.

      Проверьте настройки логирования командой CLI:

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

- CLI {#cli}

  1. Посмотрите описание команды CLI для управления логированием в балансировщике:

     ```bash
     yc alb load-balancer logging --help
     ```

  1. Измените параметры записи [логов](../logs-ref.md) в Monium Logs:

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

- Terraform {#tf}

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

     Где `log_options` — параметры записи [логов](../logs-ref.md) в Monium Logs:
     
     * `disable = false` — включить запись логов.
     * `discard_rule` — [правило отбрасывания логов](../concepts/monitoring.md#discard-logs-rules):
       
       * `http_codes` — HTTP-коды.
       * `http_code_intervals` — классы HTTP-кодов.
       * `grpc_codes` — gRPC-коды.
       * `discard_percent` — доля отбрасываемых логов в процентах.

       Вы можете задать больше одного правила. Параметры блока описаны в [документации провайдера](../../terraform/resources/alb_load_balancer.md).
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
     
        В терминале будет выведен список планируемых изменений: ресурсы и/или выходные переменные. На этом этапе изменения не будут внесены. Если в конфигурации есть ошибки, Terraform на них укажет.
     1. Примените изменения конфигурации:
     
        ```bash
        terraform apply
        ```
     
     1. Подтвердите изменения: введите в терминале слово `yes` и нажмите **Enter**.

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

- Terraform {#tf}

  1. В конфигурационном файле с описанием балансировщика установите `disable = true` в блоке `log_options`:

     ```hcl
     log_options {
       disable = true
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
     
        В терминале будет выведен список планируемых изменений: ресурсы и/или выходные переменные. На этом этапе изменения не будут внесены. Если в конфигурации есть ошибки, Terraform на них укажет.
     1. Примените изменения конфигурации:
     
        ```bash
        terraform apply
        ```
     
     1. Подтвердите изменения: введите в терминале слово `yes` и нажмите **Enter**.

     Проверьте настройки логирования командой [CLI](../../cli/quickstart.md):

     ```bash
     yc alb load-balancer get <имя_балансировщика>
     ```

- API {#api}

  Чтобы выключить запись логов, воспользуйтесь методом REST API [update](../api-ref/LoadBalancer/update.md) для ресурса [LoadBalancer](../api-ref/LoadBalancer/index.md) или вызовом gRPC API [LoadBalancerService/Update](../api-ref/grpc/LoadBalancer/update.md).

{% endlist %}

[*monium-folder-project]: Для каждого каталога Yandex Cloud автоматически создается проект Monium с идентификатором `folder__<идентификатор_каталога>`. По умолчанию выбран проект текущего каталога. [Идентификатор каталога](../../resource-manager/operations/folder/get-id.md) можно скопировать в консоли управления или получить с помощью CLI.