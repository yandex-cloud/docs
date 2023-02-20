# Изменить имя контейнера

{% list tabs %}

- Консоль управления

  1. В [консоли управления]({{ link-console-main }}) перейдите в каталог, в котором находится контейнер.
  1. Выберите сервис **{{ serverless-containers-name }}**.
  1. Выберите контейнер.
  1. Нажмите кнопку **Редактировать**.
  1. Измените имя контейнера. Формат имени:

      {% include [name-format](../../_includes/name-format.md) %}

  1. Нажмите кнопку **Сохранить**.

- CLI

  {% include [cli-install](../../_includes/cli-install.md) %}

  {% include [default-catalogue](../../_includes/default-catalogue.md) %}

  {% include [note](../../_includes/serverless-containers/sc-list-note.md) %}

  Чтобы изменить имя контейнера, выполните команду:

  ```
  yc serverless container \
    --name <имя_контейнера> \
    --new-name <новое_имя_контейнера>
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

- API

  Изменить имя контейнера можно с помощью метода API [update](../containers/api-ref/Container/update.md).


- {{ TF }}

  {% include [terraform-definition](../../_tutorials/terraform-definition.md) %}

  Подробнее о {{ TF }} [читайте в документации](../../tutorials/infrastructure-management/terraform-quickstart.md#install-terraform).

  Чтобы изменить имя контейнера, созданного с помощью {{ TF }}:

  1. Откройте файл конфигурации {{ TF }} и измените значение поля `name` в описании ресурса `yandex_serverless_container`:

     ```hcl
     ...
     resource "yandex_serverless_container" "test-container" {
       name               = "my-conrainer"
       description        = "my first container with description"
       memory             = 256
       service_account_id = "ajec........34ova"
       image {
           url = "{{ registry }}/yc/test-image:v1"
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
