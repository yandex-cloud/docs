# Удалить приемник

{% list tabs group=instructions %}

- Консоль управления {#console}

  1. В [консоли управления]({{ link-console-main }}) перейдите в каталог, из которого хотите удалить [приемник](../../../concepts/eventrouter/rule.md#target).
  1. Перейдите в сервис **{{ ui-key.yacloud.iam.folder.dashboard.label_serverless-integrations }}**.
  1. На панели слева нажмите ![image](../../../../_assets/console-icons/object-align-center-vertical.svg) **{{ ui-key.yacloud.serverless-event-router.label_service }}**.
  1. Выберите нужную [шину](../../../concepts/eventrouter/bus.md).
  1. Перейдите на вкладку ![image](../../../../_assets/console-icons/target-dart.svg) **{{ ui-key.yacloud.serverless-event-router.label_rules }}**.
  1. В строке с нужным [правилом](../../../concepts/eventrouter/rule.md) нажмите ![image](../../../../_assets/console-icons/ellipsis.svg) и выберите ![image](../../../../_assets/console-icons/pencil.svg) **{{ ui-key.yacloud.common.edit }}**.
  1. Напротив названия приемника, который вы хотите удалить, нажмите ![image](../../../../_assets/console-icons/ellipsis.svg) и выберите **{{ ui-key.yacloud.common.delete }}**.
  1. Нажмите **{{ ui-key.yacloud.common.save }}**.

- CLI {#cli}

  Если у вас еще нет интерфейса командной строки {{ yandex-cloud }} (CLI), [установите и инициализируйте его](../../../../cli/quickstart.md#install).

  По умолчанию используется каталог, указанный при [создании](../../../../cli/operations/profile/profile-create.md) профиля CLI. Чтобы изменить каталог по умолчанию, используйте команду `yc config set folder-id <идентификатор_каталога>`. Также для любой команды вы можете указать другой каталог с помощью параметров `--folder-name` или `--folder-id`. Если вы обращаетесь к ресурсу по имени, поиск будет выполнен в каталоге по умолчанию. Если вы обращаетесь к ресурсу по идентификатору, поиск будет выполнен глобально — во всех каталогах с учетом прав доступа.

  Чтобы удалить [приемник](../../../concepts/eventrouter/rule.md#target) из [правила](../../../concepts/eventrouter/rule.md), обновите набор его приемников, удалив ненужные. Для этого выполните команду, указав в ней имя или идентификатор правила и список приемников, которые нужно оставить:

  {% note warning %}
  
  Существующий набор приемников полностью перезаписывается набором, переданным в запросе.
  
  {% endnote %}
  
  ```bash
  yc serverless eventrouter rule update <имя_или_идентификатор_правила> \
    --приемник_1 <параметр_1>=<значение_1>,...,<параметр_N>=<значение_N> \
    --приемник_2 <параметр_1>=<значение_1>,...,<параметр_N>=<значение_N> \
    ...
    --приемник_N <параметр_1>=<значение_1>,...,<параметр_N>=<значение_N>
  ```

  Пример команды с тремя приемниками:
  
  ```bash
  yc serverless eventrouter rule update my-rule \
    --logging-target log-group-id=e23di6hvn5fm********,service-account-id=ajelprpohp7r******** \
    --workflow-target workflow-id=dfq28ndgtojl********,service-account-id=ajelprpohp7r******** \
    --function-target function-id=d4e27bc01uu7********,function-tag=$latest,service-account-id=ajelprpohp7r********
  ```
  
  Результат:
  
  ```text
  id: f66h4vmpsvoh********
  bus_id: f66epjc9llqt********
  folder_id: b1g681qpemb4********
  cloud_id: b1gia87mbaom********
  created_at: "2025-03-02T07:57:22.064950Z"
  name: my-rule
  targets:
    - function:
        function_id: d4e27bc01uu7********
        service_account_id: oielprnahp7r********
        batch_settings:
          max_count: "1"
          max_bytes: "10000"
          cutoff: 60s
      retry_settings:
        retry_attempts: "3"
        maximum_age: 600s
      status: ENABLED
    - logging:
        log_group_id: e23di6hvn5fm********
        service_account_id: aj91prpohp6q********
      retry_settings:
        retry_attempts: "3"
        maximum_age: 600s
      status: ENABLED
    - workflow:
        workflow_id: dfq28ndgtojl********
        service_account_id: ajel4bnehp5s********
        batch_settings:
          max_count: "1"
          max_bytes: "10000"
          cutoff: 60s
      retry_settings:
        retry_attempts: "3"
        maximum_age: 600s
      status: ENABLED
  status: ENABLED
  ```

- {{ TF }} {#tf}

  [{{ TF }}](https://www.terraform.io/) позволяет быстро создать облачную инфраструктуру в {{ yandex-cloud }} и управлять ею с помощью файлов конфигураций. В файлах конфигураций хранится описание инфраструктуры на языке HCL (HashiCorp Configuration Language). При изменении файлов конфигураций {{ TF }} автоматически определяет, какая часть вашей конфигурации уже развернута, что следует добавить или удалить.
  
  {{ TF }} распространяется под лицензией [Business Source License](https://github.com/hashicorp/terraform/blob/main/LICENSE), а [провайдер {{ yandex-cloud }} для {{ TF }}](https://github.com/yandex-cloud/terraform-provider-yandex) — под лицензией [MPL-2.0](https://www.mozilla.org/en-US/MPL/2.0/).
  
  Подробную информацию о ресурсах провайдера смотрите в документации на сайте [{{ TF }}](https://www.terraform.io/docs/providers/yandex/index.html) или в [зеркале]({{ tf-docs-link }}).

  Если у вас еще нет {{ TF }}, [установите его и настройте провайдер {{ yandex-cloud }}](../../../../tutorials/infrastructure-management/terraform-quickstart.md#install-terraform).
  
  
  Чтобы управлять инфраструктурой с помощью {{ TF }} от имени сервисного аккаунта или пользовательских аккаунтов: аккаунта на Яндексе, федеративного аккаунта и локального пользователя, [аутентифицируйтесь](../../../../terraform/authentication.md) соответствующим способом.

  Чтобы удалить [приемник](../../../concepts/eventrouter/rule.md#target) из [правила](../../../concepts/eventrouter/rule.md):

  1. Откройте конфигурационный файл {{ TF }} и удалите блоки с описанием ненужных приемников.

      Пример описания правила в конфигурационном файле {{ TF }}:

      ```hcl
      resource "yandex_serverless_eventrouter_rule" "example_rule" {
        bus_id    = "<идентификатор_шины>"
        jq_filter = "<jq-шаблон>"

        ymq {
          queue_arn            = "<ARN_очереди>"
          service_account_id   = "<идентификатор_сервисного_аккаунта>"
        }

        workflow {
          workflow_id        = "<идентификатор_рабочего_процесса>"
          service_account_id = "<идентификатор_сервисного_аккаунта>"
        }

        yds {
          database           = "<путь_к_базе_данных>"
          stream_name        = "<имя_потока_данных>"
          service_account_id = "<идентификатор_сервисного_аккаунта>"
        }

        name        = "<имя_правила>"
        description = "<описание_правила>"

        labels = {
          <ключ_1> = "<значение_1>"
          <ключ_2> = "<значение_2>"
          ...
          <ключ_n> = "<значение_n>"
        }
      }
      ```

      Более подробную информацию о параметрах ресурса `yandex_serverless_eventrouter_rule` см. в [документации провайдера]({{ tf-provider-resources-link }}/serverless_eventrouter_rule).

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
      
         В терминале будет выведен список ресурсов с параметрами. На этом этапе изменения не будут внесены. Если в конфигурации есть ошибки, {{ TF }} на них укажет.
      1. Примените изменения конфигурации:
      
         ```bash
         terraform apply
         ```
      
      1. Подтвердите изменения: введите в терминале слово `yes` и нажмите **Enter**.

      {{ TF }} создаст все требуемые ресурсы. Проверить изменения можно в [консоли управления]({{ link-console-main }}) или с помощью команды [CLI](../../../../cli/index.md):

      ```bash
      yc serverless eventrouter rule list
      ```

- API {#api}

  Чтобы удалить [приемник](../../../concepts/eventrouter/rule.md#target) из [правила](../../../concepts/eventrouter/rule.md), воспользуйтесь методом REST API [Update](../../../eventrouter/api-ref/Rule/update.md) для ресурса [Rule](../../../eventrouter/api-ref/Rule/index.md) или вызовом gRPC API [Rule/Update](../../../eventrouter/api-ref/grpc/Rule/update.md).

{% endlist %}