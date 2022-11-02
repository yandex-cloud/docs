# Изменение контейнера

Вы можете изменить [имя или описание контейнера](#update-name), а также [управлять метками контейнера](#manage-label). Для изменения параметров работы контейнера необходимо [создать новую ревизию контейнера](./manage-revision.md).

{% include [serverless-containers-list-note](../../_includes/serverless-containers/container-list-note.md) %}

## Изменить имя или описание контейнера {#update-name}

{% list tabs %}

- Консоль управления

	1. В [консоли управления]({{ link-console-main }}) перейдите в каталог, в котором находится контейнер.
	1. Выберите сервис **{{ serverless-containers-name }}**.
	1. Выберите контейнер.
	1. Нажмите кнопку **Редактировать**.
	1. Измените имя или описание контейнера. Формат имени:

		{% include [name-format](../../_includes/name-format.md) %}

    1. Нажмите кнопку **Сохранить**.

- CLI

    {% include [cli-install](../../_includes/cli-install.md) %}

    {% include [default-catalogue](../../_includes/default-catalogue.md) %}

	Чтобы изменить:
	* имя контейнера, выполните команду:	
		```
		yc serverless container \
		  --name <имя_контейнера> \
		  --new-name <новое_имя_контейнера>
		```
	* описание контейнера, выполните команду:
		```
		yc serverless container \
		  --name <имя_контейнера> \
		  --description <новое_описание_контейнера>
		```

	Результат:

	```
	id: flh7r96juaqq********
	folder_id: aoek6qrs8tjh********
	created_at: "2021-08-17T07:53:10.219Z"
	name: my-beta-container
	description: my beta container description
	url: https://flh7r96juaqq********.containers.cloud-preprod.yandex.net/
	status: ACTIVE
	```

- {{ TF }}

  {% include [terraform-definition](../../_tutorials/terraform-definition.md) %}

  Подробнее о {{ TF }} [читайте в документации](../../tutorials/infrastructure-management/terraform-quickstart.md#install-terraform).

  Чтобы изменить имя или описание контейнера, созданного с помощью {{ TF }}:

  1. Откройте файл конфигурации {{ TF }} и измените значения полей `name` и `description` в описании ресурса `yandex_serverless_container`:

     ```hcl
     ...
     resource "yandex_serverless_container" "test-container" {
       name               = "my-conrainer"
       description        = "my first container with description"
       memory             = 256
       service_account_id = "ajec........34ova"
       image {
           url = "cr.yandex/yc/test-image:v1"
       }
     }
     ...
     ```

	 Более подробную информацию о параметрах ресурса `yandex_serverless_container` в {{ TF }}, см. в [документации провайдера]({{ tf-provider-link }}/serverless_container).

  1. Проверьте конфигурацию командой:
     ```
     terraform validate
     ```
     
     Если конфигурация является корректной, появится сообщение:
     
     ```
     Success! The configuration is valid.
     ```

  1. Выполните команду:
     ```
     terraform plan
     ```
  
     В терминале будет выведен список ресурсов с параметрами. На этом этапе изменения не будут внесены. Если в конфигурации есть ошибки, {{ TF }} на них укажет.

  1. Примените изменения конфигурации:
     ```
     terraform apply
     ```
     
  1. Подтвердите изменения: введите в терминал слово `yes` и нажмите **Enter**.

  Проверить изменение контейнера можно в [консоли управления]({{ link-console-main }}) или с помощью команды [CLI](../../cli/):

  ```
  yc serverless container get <идентификатор_контейнера>|<имя_контейнера>
  ```

{% endlist %}

## Управлять метками контейнера {#manage-label}

Вы можете выполнять следующие действия с метками контейнера:

- [Добавить](#add-label)
- [Изменить](#update-label)
- [Удалить](#remove-label)

### Добавить метку {#add-label}

{% list tabs %}

- CLI
  
    {% include [cli-install](../../_includes/cli-install.md) %}

    {% include [default-catalogue](../../_includes/default-catalogue.md) %}
    
    Чтобы добавить метку контейнеру, выполните команду:

    ```
    yc serverless container add-labels <имя_контейнера> --labels <ключ>=<значение>
    ```

    Результат:

    ```     
    id: flh7r96juaqq********
    folder_id: aoek6qrs8tjh********
    created_at: "2021-08-17T07:53:10.219Z"
    name: my-beta-container
    description: my beta container description
    labels:
      label: test
    url: https://flh7r96juaqq********.containers.cloud-preprod.yandex.net/
    status: ACTIVE
    ```

- {{ TF }}

  {% include [terraform-definition](../../_tutorials/terraform-definition.md) %}

  Подробнее о {{ TF }} [читайте в документации](../../tutorials/infrastructure-management/terraform-quickstart.md#install-terraform).

  Чтобы добавить метки в контейнер, созданный с помощью {{ TF }}:

  1. Откройте файл конфигурации {{ TF }} и в ресурс `yandex_serverless_container` добавьте блок `labels`:

     ```hcl
     ...
     resource "yandex_serverless_container" "test-container" {
       name   = "my first container with description"
       memory = 256
       image {
          url = "cr.yandex/yc/test-image:v1"
       }
       labels = {
          label1 = "test"
       }
     }
     ...
     ```

	 Более подробную информацию о параметрах ресурса `yandex_serverless_container` в {{ TF }}, см. в [документации провайдера]({{ tf-provider-link }}/serverless_container).

  1. Проверьте конфигурацию командой:
     ```
     terraform validate
     ```
     
     Если конфигурация является корректной, появится сообщение:
     
     ```
     Success! The configuration is valid.
     ```

  1. Выполните команду:
     ```
     terraform plan
     ```
  
     В терминале будет выведен список ресурсов с параметрами. На этом этапе изменения не будут внесены. Если в конфигурации есть ошибки, {{ TF }} на них укажет.

  1. Примените изменения конфигурации:
     ```
     terraform apply
     ```
     
  1. Подтвердите изменения: введите в терминал слово `yes` и нажмите **Enter**.

  Проверить создание меток для контейнера можно в [CLI](../../cli/):

  ```
  yc serverless container get <идентификатор_контейнера>|<имя_контейнера>
  ```

{% endlist %}

### Изменить метку {#update-label}

{% list tabs %}

- CLI
    
    Чтобы изменить метку контейнера, выполните команду:
  
    {% note warning %}
    
    Существующий набор `labels` полностью перезаписывается набором, переданным в запросе.
    
    {% endnote %}

    ```
    yc serverless container update <имя_контейнера> --labels <ключ>=<значение>
    ```

    Результат:

    ```
    id: flh7r96juaqq********
	folder_id: aoek6qrs8tjh********
	created_at: "2021-08-17T07:53:10.219Z"
	name: my-beta-container
	description: my beta container description
	labels:
	  new_label: new_test
	url: https://flh7r96juaqq********.containers.cloud-preprod.yandex.net/
	status: ACTIVE
    ```

- {{ TF }}

  {% include [terraform-definition](../../_tutorials/terraform-definition.md) %}

  Подробнее о {{ TF }} [читайте в документации](../../tutorials/infrastructure-management/terraform-quickstart.md#install-terraform).

  Чтобы изменить метку контейнера, созданного с помощью {{ TF }}:

  1. Откройте файл конфигурации {{ TF }} и в ресурсе `yandex_serverless_container` измените блок `labels`:

     ```hcl
     ...
     resource "yandex_serverless_container" "test-container" {
       name   = "my first container with description"
       memory = 256
       image {
          url = "cr.yandex/yc/test-image:v1"
       }
       labels = {
          label1 = "new-label"
       }
     }
     ...
     ```

	 Более подробную информацию о параметрах ресурса `yandex_serverless_container` в {{ TF }}, см. в [документации провайдера]({{ tf-provider-link }}/serverless_container).

  1. Проверьте конфигурацию командой:
     ```
     terraform validate
     ```
     
     Если конфигурация является корректной, появится сообщение:
     
     ```
     Success! The configuration is valid.
     ```

  1. Выполните команду:
     ```
     terraform plan
     ```
  
     В терминале будет выведен список ресурсов с параметрами. На этом этапе изменения не будут внесены. Если в конфигурации есть ошибки, {{ TF }} на них укажет.

  1. Примените изменения конфигурации:
     ```
     terraform apply
     ```
     
  1. Подтвердите изменения: введите в терминал слово `yes` и нажмите **Enter**.

  Проверить изменение метки для контейнера можно в [CLI](../../cli/):

  ```
  yc serverless container get <идентификатор_контейнера>|<имя_контейнера>
  ```

{% endlist %}

### Удалить метку {#remove-label}

{% list tabs %}

- CLI
    
    Чтобы удалить метку контейнера, выполните команду:

    ```
    yc serverless container remove-labels <имя_контейнера> --labels <ключ>
    ```

    Результат:

    ```
    id: flh7r96juaqq********
    folder_id: aoek6qrs8tjh********
    created_at: "2021-08-17T07:53:10.219Z"
    name: my-beta-container
    description: my beta container description
    url: https://flh7r96juaqq********.containers.cloud-preprod.yandex.net/
    status: ACTIVE
    ```
    
- {{ TF }}

  {% include [terraform-definition](../../_tutorials/terraform-definition.md) %}

  Подробнее о {{ TF }} [читайте в документации](../../tutorials/infrastructure-management/terraform-quickstart.md#install-terraform).

  Чтобы удалить метку контейнера, созданнго с помощью {{ TF }}:

  1. Откройте файл конфигурации {{ TF }} и в ресурсе `yandex_serverless_container` удалите метку в блоке `labels`:
     ```hcl
     ...
     resource "yandex_serverless_container" "test-container" {
       name   = "my first container with description"
       memory = 256
       image {
          url = "cr.yandex/yc/test-image:v1"
       }
       labels = {
          label1 = "new-label"
       }
     }
     ...
     ```

	 Более подробную информацию о параметрах ресурса `yandex_serverless_container` в {{ TF }}, см. в [документации провайдера]({{ tf-provider-link }}/serverless_container).

  1. Проверьте конфигурацию командой:
     ```
     terraform validate
     ```
     
     Если конфигурация является корректной, появится сообщение:
     
     ```
     Success! The configuration is valid.
     ```

  1. Выполните команду:
     ```
     terraform plan
     ```
  
     В терминале будет выведен список ресурсов с параметрами. На этом этапе изменения не будут внесены. Если в конфигурации есть ошибки, {{ TF }} на них укажет.

  1. Примените изменения конфигурации:
     ```
     terraform apply
     ```
     
  1. Подтвердите изменения: введите в терминал слово `yes` и нажмите **Enter**.

  Проверить удаление метки для контейнера можно в [CLI](../../cli/):

  ```
  yc serverless container get <идентификатор_контейнера>|<имя_контейнера>
  ```

{% endlist %}