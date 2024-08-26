# Удаление алиаса

Алиас привязан к конкретному устройству, поэтому для удаления алиаса вам надо [узнать идентификатор или имя устройства](../device-list.md).

{% list tabs group=instructions %}

- Консоль управления {#console}

   Чтобы удалить алиас:

   1. В [консоли управления]({{ link-console-main }}) выберите каталог, из которого вы хотите удалить алиас.
   1. Выберите сервис **{{ ui-key.yacloud.iam.folder.dashboard.label_iot-core }}**.
   1. Выберите в списке нужный реестр.
   1. В левой части окна выберите раздел **{{ ui-key.yacloud.iot.label_devices }}**.
   1. Справа от имени нужного устройства нажмите значок ![image](../../../../_assets/console-icons/ellipsis.svg), в выпадающем списке выберите **{{ ui-key.yacloud.common.edit }}**.
   1. Справа от удаляемого алиаса нажмите значок ![image](../../../../_assets/console-icons/xmark.svg).
   1. Нажмите кнопку **{{ ui-key.yacloud.common.save }}**.

- CLI {#cli}
    
    {% include [cli-install](../../../../_includes/cli-install.md) %}
    
    {% include [default-catalogue](../../../../_includes/default-catalogue.md) %}
    
    Удалите алиас: 
    
    ```bash
    yc iot device remove-topic-aliases arenak5ciqss******** --topic-aliases commands
    ```

	Результат:
	```bash
	id: arenak5ciqss********
    registry_id: arenou2oj4ct********
    created_at: "2019-09-16T12:32:48.911Z"
    name: second
    ``` 

- {{ TF }} {#tf}

  {% include [terraform-definition](../../../../_tutorials/_tutorials_includes/terraform-definition.md) %}
  
  {% include [terraform-install](../../../../_includes/terraform-install.md) %}

  Чтобы удалить алиас, созданный с помощью {{ TF }}:
  
  1. Откройте файл конфигурации {{ TF }} и удалите значение нужного алиаса в блоке `aliases`, во фрагменте с описанием устройства. Чтобы удалить все алиасы, удалите блок `aliases` целиком.

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

{% endlist %}