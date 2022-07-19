# Изменение алиаса

Алиас привязан к конкретному устройству, поэтому для изменения алиаса вам надо [узнать идентификатор или имя устройства](../device-list.md).

{% list tabs %}

- Консоль управления

   Чтобы изменить алиас:

   1. В [консоли управления]({{ link-console-main }}) выберите каталог, в котором вы хотите изменить алиас.
   1. Выберите сервис **{{ iot-short-name }}**.
   1. Выберите в списке нужный реестр.
   1. В левой части окна выберите раздел **Устройства**.
   1. Нажмите значок ![image](../../../../_assets/horizontal-ellipsis.svg) справа от имени нужного устройства, в выпадающем списке выберите **Редактировать**.
   1. Измените значения полей нужного алиаса.
   1. Нажмите кнопку **Сохранить**.

- CLI
    
    {% include [cli-install](../../../../_includes/cli-install.md) %}
    
    {% include [default-catalogue](../../../../_includes/default-catalogue.md) %}
    
    Измените алиасы устройства: 
    
    {% note warning %}
    
    Существующий набор `topic_aliases` полностью перезаписывается набором, переданным в запросе.
    
    {% endnote %}
    
    ```
    yc iot device update first  --topic-aliases 'events=$devices/areqjd6un3afc3cefcvm/events,commands=$devices/areqjd6un3afc3cefcvm/commands'
    ```
	
	  Результат:
	  ```
	  id: areqjd6un3afc3cefcvm
    registry_id: arenou2oj4ct42eq8g3n
    created_at: "2019-09-16T10:41:06.489Z"
    name: first
    topic_aliases:
      commands: $devices/areqjd6un3afc3cefcvm/commands
      events: $devices/areqjd6un3afc3cefcvm/events
    ```

- {{ TF }}

  {% include [terraform-definition](../../../../_tutorials/terraform-definition.md) %}
  
  Подробнее о {{ TF }} [читайте в документации](../../../../tutorials/infrastructure-management/terraform-quickstart.md#install-terraform).

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

      Более подробную информацию о параметрах ресурса `yandex_iot_core_device` в {{ TF }}, см. в [документации провайдера]({{ tf-provider-link }}/iot_core_device).
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