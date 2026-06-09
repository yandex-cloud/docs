# Изменение алиаса

{% note warning %}

Сервис {{ iot-full-name }} больше не доступен для новых пользователей. 

Текущие пользователи могут создавать ресурсы до 1 ноября 2026 года. После сервис перейдет в режим read-only, а 1 декабря 2026 года — прекратит работу. Подробнее о сроках и порядке закрытия читайте на странице [Закрытие сервиса](../../../sunset.md).

{% endnote %}

Алиас привязан к конкретному устройству, поэтому для изменения алиаса вам надо [узнать идентификатор или имя устройства](../device-list.md).

{% list tabs group=instructions %}

- Консоль управления {#console}

   Чтобы изменить алиас:

   1. В [консоли управления]({{ link-console-main }}) выберите каталог, в котором вы хотите изменить алиас.
   1. Перейдите в сервис **{{ ui-key.yacloud.iam.folder.dashboard.label_iot-core }}**.
   1. Выберите в списке нужный реестр.
   1. В левой части окна выберите раздел **{{ ui-key.yacloud.iot.label_devices }}**.
   1. Нажмите значок ![image](../../../../_assets/console-icons/ellipsis.svg) справа от имени нужного устройства, в выпадающем списке выберите **{{ ui-key.yacloud.common.edit }}**.
   1. Измените значения полей нужного алиаса.
   1. Нажмите кнопку **{{ ui-key.yacloud.common.save }}**.

- CLI {#cli}
    
    Если у вас еще нет интерфейса командной строки {{ yandex-cloud }} (CLI), [установите и инициализируйте его](../../../../cli/quickstart.md#install).
    
    По умолчанию используется каталог, указанный при [создании](../../../../cli/operations/profile/profile-create.md) профиля CLI. Чтобы изменить каталог по умолчанию, используйте команду `yc config set folder-id <идентификатор_каталога>`. Также для любой команды вы можете указать другой каталог с помощью параметров `--folder-name` или `--folder-id`. Если вы обращаетесь к ресурсу по имени, поиск будет выполнен в каталоге по умолчанию. Если вы обращаетесь к ресурсу по идентификатору, поиск будет выполнен глобально — во всех каталогах с учетом прав доступа.
    
    Измените алиасы устройства: 
    
    {% note warning %}
    
    Существующий набор `topic_aliases` полностью перезаписывается набором, переданным в запросе.
    
    {% endnote %}
    
    ```bash
    yc iot device update first --topic-aliases 'events=$devices/areqjd6un3af********/events,commands=$devices/areqjd6un3af********/commands'
    ```

    Результат:
    ```text
    id: areqjd6un3af********
    registry_id: arenou2oj4ct********
    created_at: "2019-09-16T10:41:06.489Z"
    name: first
    topic_aliases:
      commands: $devices/areqjd6un3af********/commands
      events: $devices/areqjd6un3af********/events
    ```

- {{ TF }} {#tf}

  [{{ TF }}](https://www.terraform.io/) позволяет быстро создать облачную инфраструктуру в {{ yandex-cloud }} и управлять ею с помощью файлов конфигураций. В файлах конфигураций хранится описание инфраструктуры на языке HCL (HashiCorp Configuration Language). При изменении файлов конфигураций {{ TF }} автоматически определяет, какая часть вашей конфигурации уже развернута, что следует добавить или удалить.
  
  {{ TF }} распространяется под лицензией [Business Source License](https://github.com/hashicorp/terraform/blob/main/LICENSE), а [провайдер {{ yandex-cloud }} для {{ TF }}](https://github.com/yandex-cloud/terraform-provider-yandex) — под лицензией [MPL-2.0](https://www.mozilla.org/en-US/MPL/2.0/).
  
  Подробную информацию о ресурсах провайдера смотрите в документации на сайте [{{ TF }}](https://www.terraform.io/docs/providers/yandex/index.html) или в [зеркале]({{ tf-docs-link }}).
  
  Если у вас еще нет {{ TF }}, [установите его и настройте провайдер {{ yandex-cloud }}](../../../../tutorials/infrastructure-management/terraform-quickstart.md#install-terraform).
  
  
  Чтобы управлять инфраструктурой с помощью {{ TF }} от имени сервисного аккаунта или пользовательских аккаунтов: аккаунта на Яндексе, федеративного аккаунта и локального пользователя, [аутентифицируйтесь](../../../../terraform/authentication.md) соответствующим способом.

  Чтобы изменить алиас, созданный с помощью {{ TF }}:
  
  1. Откройте файл конфигурации {{ TF }} и измените значение алиаса в блоке `aliases`, во фрагменте с описанием устройства.

      Пример описания устройства в конфигурации {{ TF }}:

      ```hcl
      resource "yandex_iot_core_device" "my_device" {
        registry_id = "<идентификатор_реестра>"
        name        = "<имя_устройства>"
        description = "test device for terraform provider documentation"

        aliases = {
          "some-alias1/subtopic" = "$devices/{id}/events/somesubtopic",
          "some-alias2/subtopic" = "$devices/{id}/events/aaa/bbb",
        }
      ...
      }
      ```

      Более подробную информацию о параметрах ресурса `yandex_iot_core_device` в {{ TF }}, см. в [документации провайдера]({{ tf-provider-resources-link }}/iot_core_device).
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

      Проверить алиасы устройства можно в [консоли управления]({{ link-console-main }}) или с помощью команды [CLI](../../../../cli/quickstart.md):

      ```bash
      yc iot device get <имя_устройства>
      ```

- API {#api}

  Чтобы изменить алиас, воспользуйтесь методом REST API [update](../../../api-ref/Device/update.md) для ресурса [Device](../../../api-ref/Device/index.md) или вызовом gRPC API [DeviceService/Update](../../../api-ref/grpc/Device/update.md).

{% endlist %}