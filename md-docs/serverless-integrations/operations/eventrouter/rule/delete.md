# Удалить правило

{% note info %}

Удалить правило невозможно, если включена защита от удаления. Перед удалением [отключите](update.md) защиту.

{% endnote %}

{% list tabs group=instructions %}

- Консоль управления {#console}

  1. В [консоли управления](https://console.yandex.cloud) перейдите в каталог, в котором хотите удалить [правило](../../../concepts/eventrouter/rule.md).
  1. Перейдите в сервис **Serverless Integrations**.
  1. На панели слева нажмите ![image](../../../../_assets/console-icons/object-align-center-vertical.svg) **EventRouter**.
  1. Выберите нужную [шину](../../../concepts/eventrouter/bus.md).
  1. Перейдите на вкладку ![image](../../../../_assets/console-icons/target-dart.svg) **Правила**.
  1. В строке с нужным правилом нажмите ![image](../../../../_assets/console-icons/ellipsis.svg) и выберите ![image](../../../../_assets/console-icons/trash-bin.svg) **Удалить**.
  1. В открывшемся окне нажмите **Удалить**.

- CLI {#cli}

  Если у вас еще нет интерфейса командной строки Yandex Cloud (CLI), [установите и инициализируйте его](../../../../cli/quickstart.md#install).

  По умолчанию используется каталог, указанный при [создании](../../../../cli/operations/profile/profile-create.md) профиля CLI. Чтобы изменить каталог по умолчанию, используйте команду `yc config set folder-id <идентификатор_каталога>`. Также для любой команды вы можете указать другой каталог с помощью параметров `--folder-name` или `--folder-id`. Если вы обращаетесь к ресурсу по имени, поиск будет выполнен в каталоге по умолчанию. Если вы обращаетесь к ресурсу по идентификатору, поиск будет выполнен глобально — во всех каталогах с учетом прав доступа.

  1. Посмотрите описание команды CLI для удаления [правила](../../../concepts/eventrouter/rule.md):

      ```bash
      yc serverless eventrouter rule delete --help
      ```

  1. Получите список правил:
     
     ```bash
     yc serverless eventrouter rule list
     ```
     
     Результат:
     
     ```text
     +----------------------+-------+----------------------+----------------------+---------+---------------------+
     |          ID          | NAME  |        BUS ID        |      FOLDER ID       | TARGETS | DELETION PROTECTION |
     +----------------------+-------+----------------------+----------------------+---------+---------------------+
     | f66ir9eeie4e******** | rule1 | f662ctjn8vo6******** | b1geoelk7fld******** | Logging | false               |
     | f66q0kq19n2q******** | rule2 | f662ctjn8vv4******** | b1geoelk7fld******** | YMQ     | false               |
     +----------------------+-------+----------------------+----------------------+---------+---------------------+
     ```
  1. Удалите правило:

      ```bash
      yc serverless eventrouter rule delete <имя_или_идентификатор_правила>
      ```

      Результат:

      ```text
      done (1s)
      ```

- Terraform {#tf}

  [Terraform](https://www.terraform.io/) позволяет быстро создать облачную инфраструктуру в Yandex Cloud и управлять ею с помощью файлов конфигураций. В файлах конфигураций хранится описание инфраструктуры на языке HCL (HashiCorp Configuration Language). При изменении файлов конфигураций Terraform автоматически определяет, какая часть вашей конфигурации уже развернута, что следует добавить или удалить.
  
  Terraform распространяется под лицензией [Business Source License](https://github.com/hashicorp/terraform/blob/main/LICENSE), а [провайдер Yandex Cloud для Terraform](https://github.com/yandex-cloud/terraform-provider-yandex) — под лицензией [MPL-2.0](https://www.mozilla.org/en-US/MPL/2.0/).
  
  Подробную информацию о ресурсах провайдера смотрите в документации на сайте [Terraform](https://www.terraform.io/docs/providers/yandex/index.html) или в [зеркале](../../../../terraform/index.md).

  Если у вас еще нет Terraform, [установите его и настройте провайдер Yandex Cloud](../../../../tutorials/infrastructure-management/terraform-quickstart.md#install-terraform).
  
  
  Чтобы управлять инфраструктурой с помощью Terraform от имени сервисного аккаунта или пользовательских аккаунтов: аккаунта на Яндексе, федеративного аккаунта и локального пользователя, [аутентифицируйтесь](../../../../terraform/authentication.md) соответствующим способом.

  Чтобы удалить [правило](../../../concepts/eventrouter/rule.md):

  1. Откройте файл конфигурации Terraform и удалите фрагмент с описанием ресурса `yandex_serverless_eventrouter_rule`:

      ```hcl
      resource "yandex_serverless_eventrouter_rule" "example_rule" {
        bus_id      = "<идентификатор_правила>"
        name        = "<имя_правила>"
        description = "<описание_правила>"

        labels = {
          <ключ_1> = "<значение_1>"
          <ключ_2> = "<значение_2>"
          ...
          <ключ_n> = "<значение_n>"
        }

        jq_filter = "<jq-шаблон>"
      
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

      Проверить изменения можно в [консоли управления](https://console.yandex.cloud) или с помощью команды [CLI](../../../../cli/index.md):

      ```bash
      yc serverless eventrouter rule list
      ```

- API {#api}

  Чтобы удалить [правило](../../../concepts/eventrouter/rule.md), воспользуйтесь методом REST API [Delete](../../../eventrouter/api-ref/Rule/delete.md) для ресурса [Rule](../../../eventrouter/api-ref/Rule/index.md) или вызовом gRPC API [Rule/Delete](../../../eventrouter/api-ref/grpc/Rule/delete.md).

{% endlist %}