# Управление паролями устройства

Чтобы начать обмен данными и командами между устройствами и реестрами, необходимо [авторизоваться](../../concepts/authorization.md). В данном разделе описано, как управлять паролями устройства для соответствующего способа авторизации.

{% include [pass-priority-note](../../../_includes/iot-core/pass-priority-note.md) %}

* [Добавить пароль](#create-or-add)
* [Посмотреть список паролей](#list)
* [Удалить пароль](#delete)

## Добавить пароль устройству {#create-or-add}

Вы можете добавить пароль уже созданному устройству или задать его при создании устройства с помощью параметра `--password`.

{% include [read-pass](../../../_includes/iot-core/read-pass.md) %}

### Добавить пароль уже созданному устройству {#add}  

{% list tabs %}

- Консоль управления

   Чтобы добавить пароль уже созданному устройству:

   1. В [консоли управления]({{ link-console-main }}) выберите каталог, в котором вы хотите добавить пароль уже созданному устройству.
   1. Выберите сервис **{{ ui-key.yacloud.iam.folder.dashboard.label_iot-core }}**.
   1. Выберите в списке реестр с нужным устройством.
   1. В левой части окна выберите раздел **{{ ui-key.yacloud.iot.label_devices }}**.
   1. Выберите в списке нужное устройство.
   1. В блоке **{{ ui-key.yacloud.iot.label_passwords }}** нажмите кнопку **{{ ui-key.yacloud.iot.button_add-password }}**.
   1. В поле **{{ ui-key.yacloud.common.password }}** введите пароль, который вы будете использовать для доступа к устройству.<br/>Для создания пароля можно воспользоваться [генератором паролей](https://passwordsgenerator.net/).<br/>Не забудьте сохранить пароль, он вам понадобится.
   1. Нажмите кнопку **{{ ui-key.yacloud.common.add }}**.

- CLI
  
    {% include [cli-install](../../../_includes/cli-install.md) %}

    Чтобы добавить пароль: 
    1. Получите список устройств в реестре: 
    
        ```
        yc iot device --registry-name my-registry list
        ```
		
		Результат:
		```
		+----------------------+--------+
        |          ID          |  NAME  |
        +----------------------+--------+
        | arenak5ciqss******** | second |
        | areqjd6un3af******** | first  |
        +----------------------+--------+
        ```    
    1. Добавьте пароль устройству:
    
        ```
        yc iot device password add --device-name first --password Passw0rdForDevice
        ```
		
		Результат:
		```
		device_id: areqjd6un3af********
        id: areqjd6un3af********
        created_at: "2019-12-16T15:11:36.892167Z"
        ```

- {{ TF }}

  {% include [terraform-definition](../../../_tutorials/terraform-definition.md) %}
  
  {% include [terraform-install](../../../_includes/terraform-install.md) %}

  Чтобы добавить пароль устройству, созданному с помощью {{ TF }}:
  
  1. Опишите в конфигурационном файле параметры ресурса, которые необходимо создать:

     * `yandex_iot_core_device` — параметры устройства:
       * `registry_id` — [идентификатор реестра](../registry/registry-list.md#registry-list), в котором создано устройство.
       * `name` — [имя устройства](../device/device-list.md#device-list).
       * `description` — описание устройства.
       * `passwords` — список паролей для авторизации с помощью [логина и пароля](../../concepts/authorization.md#log-pass).

      Пример структуры ресурса в конфигурационном файле:

      ```hcl
      resource "yandex_iot_core_device" "my_device" {
        registry_id = "<идентификатор_реестра>"
        name        = "<имя_устройства>"
        description = "test device for terraform provider documentation"
      ...
        passwords = [
          "<пароль>",
        ]
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

      Проверить пароли устройства можно в [консоли управления]({{ link-console-main }}) или с помощью команды [CLI](../../../cli/quickstart.md):

      ```bash
      yc iot device password list --device-name <имя_устройства>
      ```

- API

  Чтобы добавить пароль устройству, воспользуйтесь методом REST API [addPassword](../../api-ref/Device/addPassword.md) для ресурса [Device](../../api-ref/Device/index.md) или вызовом gRPC API [DeviceService/AddPassword](../../api-ref/grpc/device_service.md#AddPassword).

{% endlist %}

### Задать пароль устройству при создании {#create}

{% list tabs %}

- Консоль управления

   Как задать пароль устройству при создании, читайте в разделе [{#T}](../device/device-create.md).

- CLI
  
    {% include [cli-install](../../../_includes/cli-install.md) %}
    
    {% include [default-catalogue](../../../_includes/default-catalogue.md) %}
    
    Чтобы задать пароль при создании:
    1. Получите список реестров в каталоге: 
        
        ```
        yc iot registry list
		```
		
		Результат:
		```
        +----------------------+-------------------+
        |          ID          |       NAME        |
        +----------------------+-------------------+
        | arenou2oj4ct******** | my-registry       |
        +----------------------+-------------------+
        ```
    1. Создайте устройство с паролем:       
    
        ```
        yc iot device create --registry-name my-registry --name device-with-pass --password Passw0rdForDevice
        ```
		
		Результат:
		```
		id: arepomfambsg********
        registry_id: arenou2oj4ct********
        created_at: "2019-12-16T15:18:39.358922Z"
        name: device-with-pass
        ```

- {{ TF }}

   Как задать пароль устройству при создании, читайте в разделе [{#T}](../device/device-create.md).

- API

  Чтобы задать пароль устройству при создании, воспользуйтесь методом REST API [create](../../api-ref/Device/create.md) для ресурса [Device](../../api-ref/Device/index.md) или вызовом gRPC API [DeviceService/Create](../../api-ref/grpc/device_service.md#Create).

{% endlist %}  

## Получить список паролей устройства {#list}

{% list tabs %}

- Консоль управления

   Чтобы просмотреть список паролей устройства:

   1. В [консоли управления]({{ link-console-main }}) выберите каталог, в котором вы хотите получить список паролей устройства.
   1. Выберите сервис **{{ ui-key.yacloud.iam.folder.dashboard.label_iot-core }}**.
   1. Выберите в списке реестр с нужным устройством.
   1. В левой части окна выберите раздел **{{ ui-key.yacloud.iot.label_devices }}**.
   1. Выберите в списке нужное устройство.
   1. На странице **{{ ui-key.yacloud.common.overview }}** перейдите к разделу **{{ ui-key.yacloud.iot.label_passwords }}**.

   В разделе **{{ ui-key.yacloud.iot.label_passwords }}** отобразится список паролей устройства.

- CLI
  
    {% include [cli-install](../../../_includes/cli-install.md) %}
    
    {% include [default-catalogue](../../../_includes/default-catalogue.md) %}
    
    Чтобы получить список паролей:  
    1. Получите список устройств в реестре: 
    
        ```
        yc iot device --registry-name my-registry list
        ```
		
		Результат:
		```
		+----------------------+------------------+
        |          ID          |       NAME       |
        +----------------------+------------------+
        | arenak5ciqss******** | second           |
        | arepomfambsg******** | device-with-pass |
        | areqjd6un3af******** | first            |
        +----------------------+------------------+
        ```
    1. Получите список паролей устройства: 
    
        ```
        yc iot device password list --device-name device-with-pass
        ```
		
		Результат:
		```
		+----------------------+---------------------+
        |          ID          |     CREATED AT      |
        +----------------------+---------------------+
        | areuin5t7pnd******** | 2019-12-16 15:18:39 |
        +----------------------+---------------------+
        ```

- API

  Чтобы получить список паролей устройства, воспользуйтесь методом REST API [listPasswords](../../api-ref/Device/listPasswords.md) для ресурса [Device](../../api-ref/Device/index.md) или вызовом gRPC API [DeviceService/ListPasswords](../../api-ref/grpc/device_service.md#ListPasswords).

{% endlist %}     
   
## Удалить пароль устройства {#delete}

{% list tabs %}

- Консоль управления

   Чтобы удалить пароль устройства:

   1. В [консоли управления]({{ link-console-main }}) выберите каталог, в котором вы хотите удалить пароль устройства.
   1. Выберите сервис **{{ ui-key.yacloud.iam.folder.dashboard.label_iot-core }}**.
   1. Выберите в списке реестр с нужным устройством.
   1. В левой части окна выберите раздел **{{ ui-key.yacloud.iot.label_devices }}**.
   1. Выберите в списке нужное устройство.
   1. В строке с нужным паролем нажмите значок ![image](../../../_assets/horizontal-ellipsis.svg), в выпадающем списке выберите **{{ ui-key.yacloud.common.delete }}**.
   1. В открывшемся окне нажмите кнопку **{{ ui-key.yacloud.common.delete }}**.

- CLI
  
    {% include [cli-install](../../../_includes/cli-install.md) %}
    
    {% include [default-catalogue](../../../_includes/default-catalogue.md) %}
    
    Чтобы удалить пароль:  
    1. Получите список паролей устройства: 
    
        ```
        yc iot device password list --device-name device-with-pass
        ```
		
		Результат:
		```
		+----------------------+---------------------+
        |          ID          |     CREATED AT      |
        +----------------------+---------------------+
        | areuin5t7pnd******** | 2019-12-16 15:18:39 |
        +----------------------+---------------------+
        ```
    1. Удалите пароль: 
        ```
        yc iot device password delete --device-name device-with-pass --password-id areuin5t7pnd********
        ```
    1. Убедитесь, что пароль действительно удален: 
        
        ```
        yc iot device password list --device-name device-with-pass
        ```
		
		Результат:
		```
		+----+------------+
        | ID | CREATED AT |
        +----+------------+
        +----+------------+
        ```

- {{ TF }}

  {% include [terraform-definition](../../../_tutorials/terraform-definition.md) %}
  
  {% include [terraform-install](../../../_includes/terraform-install.md) %}

  Чтобы удалить пароль устройства, созданного с помощью {{ TF }}:
  
  1. Откройте файл конфигурации {{ TF }} и удалите значение нужного пароля в блоке `passwords`, во фрагменте с описанием устройства. Чтобы удалить все пароли, удалите блок `passwords` целиком.

      Пример описания устройства в конфигурации {{ TF }}:

      ```hcl
      resource "yandex_iot_core_device" "my_device" {
        registry_id = "<идентификатор_реестра>"
        name        = "<имя_устройства>"
        description = "test device for terraform provider documentation"
      ...
        passwords = [
          "<пароль>",
        ]
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

      Проверить пароли устройства можно в [консоли управления]({{ link-console-main }}) или с помощью команды [CLI](../../../cli/quickstart.md):

      ```bash
      yc iot device password list --device-name <имя_устройства>
      ```

- API

  Чтобы удалить пароль устройства, воспользуйтесь методом REST API [deletePassword](../../api-ref/Device/deletePassword.md) для ресурса [Device](../../api-ref/Device/index.md) или вызовом gRPC API [DeviceService/DeletePassword](../../api-ref/grpc/device_service.md#DeletePassword).

{% endlist %}