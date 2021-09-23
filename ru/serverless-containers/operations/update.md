# Изменение контейнера

Вы можете изменить [имя или описание контейнера](#update-name), а также [управлять метками контейнера](#manage-label). Для изменения параметров работы контейнера необходимо [создать новую ревизию контейнера](./manage-revision.md).

Для обращения к контейнеру используйте его имя или уникальный идентификатор. Чтобы узнать их, [получите список контейнеров](./list.md) в каталоге.

## Изменить имя или описание контейнера {#update-name}

{% list tabs %}

- Консоль управления

	1. В [консоли управления]({{ link-console-main }}) перейдите в каталог, в котором находится контейнер.
	1. Откройте сервис **{{ serverless-containers-name }}**.
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

{% endlist %}