# Управление паролями реестра

Чтобы начать обмен данными и командами между устройствами и реестрами, необходимо [авторизоваться](../../concepts/authorization.md). В данном разделе описано, как управлять паролями реестра для соответствующего способа авторизации.

{% include [pass-priority-note](../../../_includes/iot-core/pass-priority-note.md) %}

* [Добавить пароль](#create-or-add)
* [Посмотреть список паролей](#list)
* [Удалить пароль](#delete)

## Добавить пароль реестру {#create-or-add}

Вы можете добавить пароль уже созданному реестру или задать его при создании реестра с помощью параметра `--password`.

{% include [read-pass](../../../_includes/iot-core/read-pass.md) %}

### Добавить пароль уже созданному реестру {#add}  

{% list tabs %}

- Консоль управления

   Чтобы добавить пароль уже созданному реестру:

   1. В [консоли управления]({{ link-console-main }}) выберите каталог, в котором вы хотите добавить пароль уже созданному реестру.
   1. Выберите сервис **{{ ui-key.yacloud.iam.folder.dashboard.label_iot-core }}**.
   1. Выберите в списке нужный реестр.
   1. В блоке **{{ ui-key.yacloud.iot.label_passwords }}** нажмите кнопку **{{ ui-key.yacloud.iot.button_add-password }}**.
   1. В поле **{{ ui-key.yacloud.common.password }}** введите пароль, который вы будете использовать для доступа к реестру.<br/>Для создания пароля можно воспользоваться [генератором паролей](https://passwordsgenerator.net/).<br/>Не забудьте сохранить пароль, он вам понадобится.
   1. Нажмите кнопку **{{ ui-key.yacloud.common.add }}**.

- CLI
  
    {% include [cli-install](../../../_includes/cli-install.md) %}

    Чтобы добавить пароль: 
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
    1. Добавьте пароль реестру:
    
        ```
        yc iot registry password add --registry-name my-registry --password Passw0rdForRegistry
        ```
		
		Результат:
		```
		registry_id: arenou2oj4ct********
        id: areuu2hgsv6k********
        created_at: "2019-12-16T15:32:46.655139Z"
        ```

- {{ TF }}

  {% include [terraform-definition](../../../_tutorials/terraform-definition.md) %}
  
  {% include [terraform-install](../../../_includes/terraform-install.md) %}

  Чтобы добавить пароль реестру, созданному с помощью {{ TF }}:

  1. Опишите в конфигурационном файле параметры ресурсов, которые необходимо создать:

     * `yandex_iot_core_registry` — параметры реестра:
       * `name` — имя реестра.
       * `description` — описание реестра.
       * `passwords` — список паролей реестра для авторизации с помощью [логина и пароля](../../concepts/authorization.md#log-pass).

      Пример структуры ресурса в конфигурационном файле:

      ```hcl
      resource "yandex_iot_core_registry" "my_registry" {
        name        = "test-registry"
        description = "test registry for terraform provider documentation"
      ...
        passwords = [
          "<пароль_1>",
          "<пароль_2>"
        ]
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

      Проверить пароли реестра можно в [консоли управления]({{ link-console-main }}) или с помощью команды [CLI](../../../cli/quickstart.md):

      ```bash
      yc iot registry password list --registry-name <имя_реестра>
      ```

- API

  Чтобы добавить пароль реестру, воспользуйтесь методом REST API [addPassword](../../api-ref/Registry/addPassword.md) для ресурса [Registry](../../api-ref/Registry/index.md) или вызовом gRPC API [RegistryService/AddPassword](../../api-ref/grpc/registry_service.md#AddPassword).

{% endlist %}

### Задать пароль реестру при создании {#create}

{% list tabs %}

- Консоль управления

   Как задать пароль реестру при создании, читайте в разделе [{#T}](../registry/registry-create.md).

- CLI
  
    {% include [cli-install](../../../_includes/cli-install.md) %}
    
    {% include [default-catalogue](../../../_includes/default-catalogue.md) %}
    
    Создайте реестр с паролем:       
    
    ```
    yc iot registry create --name registry-with-pass --password Passw0rdForDevice
    ```
	
	Результат:
	```
	done (1s)
    id: areg96c8loru********
    folder_id: b1g88tflru0e********
    created_at: "2019-12-16T15:34:25.563Z"
    name: registry-with-pass
    status: ACTIVE
    log_group_id: ckghhil3b5o9********
    ```

- {{ TF }}

   Как задать пароль реестру при создании, читайте в разделе [{#T}](../registry/registry-create.md).

- API

  Чтобы задать пароль реестру при создании, воспользуйтесь методом REST API [create](../../api-ref/Registry/create.md) для ресурса [Registry](../../api-ref/Registry/index.md) или вызовом gRPC API [RegistryService/Create](../../api-ref/grpc/registry_service.md#Create).

{% endlist %}  

## Получить список паролей реестра {#list}

{% list tabs %}

- Консоль управления

   Чтобы просмотреть список паролей реестра:

   1. В [консоли управления]({{ link-console-main }}) выберите каталог, в котором вы хотите получить список паролей реестра.
   1. Выберите сервис **{{ ui-key.yacloud.iam.folder.dashboard.label_iot-core }}**.
   1. Выберите в списке нужный реестр.
   1. На странице **{{ ui-key.yacloud.common.overview }}** перейдите к разделу **{{ ui-key.yacloud.iot.label_passwords }}**.

- CLI
  
    {% include [cli-install](../../../_includes/cli-install.md) %}
    
    {% include [default-catalogue](../../../_includes/default-catalogue.md) %}
    
    Чтобы получить список паролей:  
    1. Получите список реестров в каталоге: 
    
        ```
        yc iot registry list
		```
		
		Результат:
		```
        +----------------------+--------------------+
        |          ID          |        NAME        |
        +----------------------+--------------------+
        | areg96c8loru******** | registry-with-pass |
        | arenou2oj4ct******** | my-registry        |
        +----------------------+--------------------+
        ```
    1. Получите список паролей реестра: 
    
        ```
        yc iot registry password list --registry-name registry-with-pass
        ```
		
		Результат:
		```
		+----------------------+---------------------+
        |          ID          |     CREATED AT      |
        +----------------------+---------------------+
        | are0gffs957e******** | 2019-12-16 15:34:25 |
        +----------------------+---------------------+
        ```

- API

  Чтобы получить список паролей реестра, воспользуйтесь методом REST API [listPasswords](../../api-ref/Registry/listPasswords.md) для ресурса [Registry](../../api-ref/Registry/index.md) или вызовом gRPC API [RegistryService/ListPasswords](../../api-ref/grpc/registry_service.md#ListPasswords).

{% endlist %}     
   
## Удалить пароль реестра {#delete}

{% list tabs %}

- Консоль управления

   Чтобы удалить пароль реестра:

   1. В [консоли управления]({{ link-console-main }}) выберите каталог, в котором вы хотите удалить пароль реестра.
   1. Выберите сервис **{{ ui-key.yacloud.iam.folder.dashboard.label_iot-core }}**.
   1. Выберите в списке нужный реестр.
   1. В строке с нужным паролем нажмите значок ![image](../../../_assets/horizontal-ellipsis.svg), в выпадающем списке выберите **{{ ui-key.yacloud.common.delete }}**.
   1. В открывшемся окне нажмите кнопку **{{ ui-key.yacloud.common.delete }}**.

- CLI
  
    {% include [cli-install](../../../_includes/cli-install.md) %}
    
    {% include [default-catalogue](../../../_includes/default-catalogue.md) %}
    
    Чтобы удалить пароль:  
    1. Получите список паролей реестра: 
    
        ```
        yc iot registry password list --registry-name registry-with-pass
        ```
		
		Результат:
		```
		+----------------------+---------------------+
        |          ID          |     CREATED AT      |
        +----------------------+---------------------+
        | are0gffs957e******** | 2019-12-16 15:34:25 |
        +----------------------+---------------------+
        ```
    1. Удалите пароль: 
    
        ```
        yc iot registry password delete --registry-name registry-with-pass --password-id are0gffs957egmoksgf4
        ```
    1. Убедитесь, что пароль действительно удален: 
        
        ```
        yc iot registry password list --registry-name registry-with-pass
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

  Чтобы удалить пароль реестра, созданного с помощью {{ TF }}:

  1. Откройте файл конфигурации {{ TF }} и удалите значение пароля в блоке `passwords`, во фрагменте с описанием реестра. Чтобы удалить все пароли, удалите блок `passwords` целиком.

      Пример описания реестра в конфигурации {{ TF }}:

      ```hcl
      resource "yandex_iot_core_registry" "my_registry" {
        name        = "test-registry"
        description = "test registry for terraform provider documentation"
      ...
        passwords = [
          "<пароль_1>",
          "<пароль_2>"
        ]
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

      Проверить пароли реестра можно в [консоли управления]({{ link-console-main }}) или с помощью команды [CLI](../../../cli/quickstart.md):

      ```bash
      yc iot registry password list --registry-name <имя_реестра>
      ```

- API

  Чтобы удалить пароль реестра, воспользуйтесь методом REST API [deletePassword](../../api-ref/Registry/deletePassword.md) для ресурса [Registry](../../api-ref/Registry/index.md) или вызовом gRPC API [RegistryService/DeletePassword](../../api-ref/grpc/registry_service.md#DeletePassword).

{% endlist %}       