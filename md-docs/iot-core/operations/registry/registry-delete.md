# Удаление реестра

{% note warning %}

Сервис {{ iot-full-name }} больше не доступен для новых пользователей. 

Текущие пользователи могут создавать ресурсы до 1 ноября 2026 года. После сервис перейдет в режим read-only, а 1 декабря 2026 года — прекратит работу. Подробнее о сроках и порядке закрытия читайте на странице [Закрытие сервиса](../../sunset.md).

{% endnote %}

{% note warning %}

Удалить можно только пустой реестр. Не забудьте [удалить устройства из реестра](../device/device-delete.md) перед началом операции.

{% endnote %}

Для обращения к [реестру](../../concepts/index.md#registry) используйте его уникальный идентификатор или имя. Как узнать уникальный идентификатор или имя реестра, читайте в разделе [{#T}](registry-list.md).

{% list tabs group=instructions %}

- Консоль управления {#console}

   Чтобы удалить реестр:

   1. В [консоли управления]({{ link-console-main }}) выберите каталог, из которого вы хотите удалить реестр.
   1. Перейдите в сервис **{{ ui-key.yacloud.iam.folder.dashboard.label_iot-core }}**.
   1. Справа от имени удаляемого реестра нажмите значок ![image](../../../_assets/console-icons/ellipsis.svg), в выпадающем списке выберите **{{ ui-key.yacloud.common.delete }}**.
   1. В открывшемся окне нажмите кнопку **{{ ui-key.yacloud.common.delete }}**.

- CLI {#cli}

  Если у вас еще нет интерфейса командной строки {{ yandex-cloud }} (CLI), [установите и инициализируйте его](../../../cli/quickstart.md#install).

  1. Удалите реестр:

      ```bash
      yc iot registry delete my-registry
      ```

  1. Проверьте, что реестр удален:

      ```bash
      yc iot registry list
	    ```

	  Результат:
	  ```text
      +----+------+
      | ID | NAME |
      +----+------+
      +----+------+
      ```

- {{ TF }} {#tf}

  [{{ TF }}](https://www.terraform.io/) позволяет быстро создать облачную инфраструктуру в {{ yandex-cloud }} и управлять ею с помощью файлов конфигураций. В файлах конфигураций хранится описание инфраструктуры на языке HCL (HashiCorp Configuration Language). При изменении файлов конфигураций {{ TF }} автоматически определяет, какая часть вашей конфигурации уже развернута, что следует добавить или удалить.
  
  {{ TF }} распространяется под лицензией [Business Source License](https://github.com/hashicorp/terraform/blob/main/LICENSE), а [провайдер {{ yandex-cloud }} для {{ TF }}](https://github.com/yandex-cloud/terraform-provider-yandex) — под лицензией [MPL-2.0](https://www.mozilla.org/en-US/MPL/2.0/).
  
  Подробную информацию о ресурсах провайдера смотрите в документации на сайте [{{ TF }}](https://www.terraform.io/docs/providers/yandex/index.html) или в [зеркале]({{ tf-docs-link }}).

  Если у вас еще нет {{ TF }}, [установите его и настройте провайдер {{ yandex-cloud }}](../../../tutorials/infrastructure-management/terraform-quickstart.md#install-terraform).
  
  
  Чтобы управлять инфраструктурой с помощью {{ TF }} от имени сервисного аккаунта или пользовательских аккаунтов: аккаунта на Яндексе, федеративного аккаунта и локального пользователя, [аутентифицируйтесь](../../../terraform/authentication.md) соответствующим способом.

  Чтобы удалить реестр, созданный с помощью {{ TF }}:

  1. Откройте файл конфигурации {{ TF }} и удалите фрагмент с описанием реестра.

      Пример описания реестра в конфигурации {{ TF }}:

      ```hcl
      resource "yandex_iot_core_registry" "my_registry" {
        name        = "test-registry"
        description = "test registry for terraform provider documentation"
        }
      ...
      }
      ```

      Более подробную информацию о параметрах ресурса `yandex_iot_core_registry` в {{ TF }}, см. в [документации провайдера]({{ tf-provider-resources-link }}/iot_core_registry).
  1. В командной строке перейдите в папку, где вы отредактировали конфигурационный файл.
  1. Проверьте корректность конфигурационного файла с помощью команды:

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

      Проверить изменения можно в [консоли управления]({{ link-console-main }}) или с помощью команды [CLI](../../../cli/quickstart.md):

      ```bash
      yc iot registry list
      ```

- API {#api}

  Чтобы удалить реестр, воспользуйтесь методом REST API [delete](../../api-ref/Registry/delete.md) для ресурса [Registry](../../api-ref/Registry/index.md) или вызовом gRPC API [RegistryService/Delete](../../api-ref/grpc/Registry/delete.md).

{% endlist %}