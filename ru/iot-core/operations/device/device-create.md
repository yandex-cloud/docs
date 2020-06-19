# Создание устройства

{% list tabs %}

- CLI
  
  {% include [cli-install](../../../_includes/cli-install.md) %}
  
  1. [Посмотрите список реестров](../registry/registry-list.md#registry-list), в которых можно создать устройство, или [создайте новый реестр](../registry/registry-create.md).
  
  1. Создайте устройство:
  
      ```
      $ yc iot device create --registry-name my-registry --name my-device
  
      id: b9135goeh1uc1s2i07nm
      registry_id: b91ki3851hab9m0l68je
      created_at: "2019-05-28T16:08:30.938Z"
      name: my-device
      ```
  
     {% include [name-format](../../../_includes/name-format.md) %}
  
  1. Проверьте, что устройство создалось:
  
      ```
      $ yc iot device list --registry-name  my-registry
      +----------------------+-----------+
      |          ID          |   NAME    |
      +----------------------+-----------+
      | b9135goeh1uc1s2i07nm | my-device |
      +----------------------+-----------+
      ```

- Terraform 

   {% include [terraform-definition](../../../solutions/_solutions_includes/terraform-definition.md) %}

   Если у вас ещё нет Terraform, [установите его и настройте провайдер Яндекс.Облака](../../../solutions/infrastructure-management/terraform-quickstart.md#install-terraform).  
   
   {% note info %}

   Чтобы добавить сертификаты устройству, [подготовьте](../certificates/create-certificates.md) их заранее.

   {% endnote %}

   Чтобы создать устройство: 
   
   1. [Посмотрите список реестров](../registry/registry-list.md#registry-list), в которых можно создать устройство, или [создайте новый реестр](../registry/registry-create.md).

   1. Опишите в конфигурационном файле параметры ресурса, который необходимо создать:
      
      * `yandex_iot_core_device` — параметры устройства:
        * `registry_id` — идентификатор реестра, в котором создается устройство.
        * `name` — имя устройства.
        * `description` — описание устройства.
        * `aliases` — алиасы топиков. Подробнее см. [Создание алиаса](../device/alias/alias-create.md)
        * `passwords` — список паролей для авторизации с помощью [логина и пароля](../../concepts/authorization.md#log-pass).
        * `certificates` — список сертификатов для авторизации с помощью [сертификатов](../../concepts/authorization.md#certs).
             
      Пример структуры ресурса в конфигурационном файле:
      
      ```
      resource "yandex_iot_core_device" "my_device" {
        registry_id = "<идентификатор реестра>"
        name        = "test-device"
        description = "test device for terraform provider documentation"
        
        aliases = {
          "some-alias1/subtopic" = "$devices/{id}/events/somesubtopic",
          "some-alias2/subtopic" = "$devices/{id}/events/aaa/bbb",
        }
        
        passwords = [
          "<пароль>",
        ]
        
        certificates = [
          file("<путь к файлу c сертификатом>")
        ]
      }
      ```
      
      Более подробную информацию о ресурсах, которые вы можете создать с помощью Terraform, см. в [документации провайдера](https://www.terraform.io/docs/providers/yandex/index.html).
      
   2. Проверьте корректность конфигурационных файлов.
      
      1. В командной строке перейдите в папку, где вы создали конфигурационный файл.
      2. Выполните проверку с помощью команды:
         ```
         $ terraform plan
         ```
      Если конфигурация описана верно, в терминале отобразится список создаваемых ресурсов и их параметров. Если в конфигурации есть ошибки, Terraform на них укажет. 
         
   3. Разверните облачные ресурсы.

      1. Если в конфигурации нет ошибок, выполните команду:
         ```
         $ terraform apply
         ```
      2. Подтвердите создание ресурсов.
      
      После этого в указанном каталоге будут созданы все требуемые ресурсы. Проверить появление ресурсов и их настройки можно в [консоли управления]({{ link-console-main }}).



{% endlist %}
