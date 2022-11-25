{% list tabs %}

- Консоль управления

	1. В [консоли управления]({{ link-console-main }}) перейдите в каталог, в котором хотите создать контейнер.
	1. Выберите сервис **{{ serverless-containers-name }}**.
	1. Нажмите кнопку **Создать контейнер**.
	1. Введите имя и описание контейнера. Формат имени:

		{% include [name-format](../../_includes/name-format.md) %}

    1. Нажмите кнопку **Создать**.


- CLI

	{% include [cli-install](../cli-install.md) %}
    
    {% include [default-catalogue](../default-catalogue.md) %}

	Чтобы создать контейнер, выполните команду:

	```
	yc serverless container create --name <имя_контейнера>
	```

	Результат:

	```
	id: bba3fva6ka5g********
	folder_id: b1gqvft7kjk3********
	created_at: "2021-07-09T14:49:00.891Z"
	name: my-beta-container
	url: https://bba3fva6ka5g********.containers.yandexcloud.net/
	status: ACTIVE
	```

- API

   Cоздать контейнер можно с помощью метода API [create](../../serverless-containers/containers/api-ref/Container/create.md).

- {{ TF }}

  {% include [terraform-definition](../../_tutorials/terraform-definition.md) %}

  Если у вас ещё нет {{ TF }}, [установите его и настройте провайдер {{ yandex-cloud }}](../../tutorials/infrastructure-management/terraform-quickstart.md#install-terraform).

  Чтобы создать контейнер и его [ревизию](../../serverless-containers/operations/manage-revision.md):

  {% note info %}

  {% include [revision-service-account-note](revision-service-account-note.md) %}

  {% endnote %}

  1. Опишите в конфигурационном файле параметры ресурсов, которые необходимо создать:

     * `name` — имя контейнера. Обязательный параметр. Требования к имени:

       {% include [name-format](../../_includes/name-format.md) %}

     * `memory` — объем памяти в МБ, выделенный контейнеру. По умолчанию — 128 МБ.
     * `service_account_id` — идентификатор [сервисного аккаунта](../../iam/concepts/users/service-accounts.md).
     * `url` — URL [Docker-образа](../../container-registry/concepts/docker-image.md) в {{ container-registry-name }}.

     Пример структуры конфигурационного файла:

     
     ```hcl
     provider "yandex" {
       token     = "<OAuth>"
       cloud_id  = "<идентификатор облака>"
       folder_id = "<идентификатор каталога>"
       zone      = "{{ region-id }}-a"
     }
     
     resource "yandex_serverless_container" "test-container" {
        name               = "<имя контейнера>"
        memory             = <объем памяти>
        service_account_id = "<идентификатор сервисного аккаунта>"
        image {
            url = "<URL Docker-образа>"
        }
     }
     ```



     Более подробную информацию о параметрах ресурса `yandex_serverless_container` в {{ TF }}, см. в [документации провайдера]({{ tf-provider-link }}/serverless_container).

  1. Проверьте корректность конфигурационных файлов.

     1. В командной строке перейдите в папку, где вы создали конфигурационный файл.
     1. Выполните проверку с помощью команды:

        ```
        terraform plan
        ```

     Если конфигурация описана верно, в терминале отобразится список создаваемых ресурсов и их параметров. Если в конфигурации есть ошибки, {{ TF }} на них укажет. 

  1. Разверните облачные ресурсы.

     1. Если в конфигурации нет ошибок, выполните команду:

        ```
        terraform apply
        ```

     1. Подтвердите создание ресурсов: введите в терминал слово `yes` и нажмите **Enter**.

     После этого в указанном каталоге будут созданы все требуемые ресурсы. Проверить появление ресурсов и их настройки можно в [консоли управления]({{ link-console-main }}) или с помощью команды [CLI](../../cli/):

     ```
     yc serverless container list 
     ```


{% endlist %}
