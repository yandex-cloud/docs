# Добавить метку контейнеру

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

- API

  Добавить метку контейнеру можно с помощью метода API [update](../containers/api-ref/Container/update.md).

- {{ TF }}

  {% include [terraform-definition](../../_tutorials/terraform-definition.md) %}

  Подробнее о {{ TF }} [читайте в документации](../../tutorials/infrastructure-management/terraform-quickstart.md#install-terraform).

  Чтобы добавить метку контейнеру, созданному с помощью {{ TF }}:

  1. Откройте файл конфигурации {{ TF }} и в ресурс `yandex_serverless_container` добавьте блок `labels`:

     ```hcl
     ...
     resource "yandex_serverless_container" "test-container" {
       name   = "my first container with description"
       memory = 256
       image {
          url = "{{ registry }}/yc/test-image:v1"
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
