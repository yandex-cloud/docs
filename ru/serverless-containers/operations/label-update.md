---
title: "Изменить метку контейнера"
description: "Следуя данной инструкции, вы сможете изменить метку контейнера."
---

# Изменить метку контейнера

{% list tabs group=instructions %}

- CLI {#cli}
    
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
    url: https://flh7r96juaqq********.{{ serverless-containers-host }}/
    status: ACTIVE
    ```

- {{ TF }} {#tf}

  {% include [terraform-definition](../../_tutorials/_tutorials_includes/terraform-definition.md) %}

  {% include [terraform-install](../../_includes/terraform-install.md) %}

  Чтобы изменить метку контейнера, созданного с помощью {{ TF }}:

  1. Откройте файл конфигурации {{ TF }} и в ресурсе `yandex_serverless_container` измените блок `labels`:

     ```hcl
     ...
     resource "yandex_serverless_container" "test-container" {
       name   = "my first container with description"
       memory = 256
       image {
          url = "{{ registry }}/yc/test-image:v1"
       }
       labels = {
          label1 = "new-label"
       }
     }
     ...
     ```

	 Более подробную информацию о параметрах ресурса `yandex_serverless_container` в {{ TF }}, см. в [документации провайдера]({{ tf-provider-resources-link }}/serverless_container).

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
  yc serverless container get <имя_или_идентификатор_контейнера>
  ```

- API {#api}

  Чтобы изменить метку контейнера, воспользуйтесь методом REST API [update](../containers/api-ref/Container/update.md) для ресурса [Container](../containers/api-ref/Container/index.md) или вызовом gRPC API [ContainerService/Update](../containers/api-ref/grpc/container_service.md#Update).

{% endlist %}
