{% list tabs %}

- Management console

  1. In the [management console]({{ link-console-main }}), go to the folder where you want to create a container.

  1. Open **{{ serverless-containers-name }}**.

  1. Click **Create container**.

  1. Enter a name and a description for the container. Name format:

      {% include [name-format](../../_includes/name-format.md) %}

  1. Click **Create**.

- CLI

  {% include [cli-install](../cli-install.md) %}

  {% include [default-catalogue](../default-catalogue.md) %}

  To create a container, run the command:

  ```
  yc serverless container create --name <container_name>
  ```

  Result:

  ```
  id: bba3fva6ka5g********
  folder_id: b1gqvft7kjk3********
  created_at: "2021-07-09T14:49:00.891Z"
  name: my-beta-container
  url: https://bba3fva6ka5g********.containers.yandexcloud.net/
  status: ACTIVE
  ```

{% endlist %}

