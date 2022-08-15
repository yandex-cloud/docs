{% list tabs %}

- Management console

  1. In the [management console]({{ link-console-main }}), go to the folder where you want to view a list of containers.
  1. Select **{{ serverless-containers-name }}**.

- CLI

  {% include [cli-install](../../_includes/cli-install.md) %}

  {% include [default-catalogue](../../_includes/default-catalogue.md) %}

  To get a list of containers, run the command:

  ```
  yc serverless container list
  ```

  Result:

  ```
  +----------------------+--------------------+-----------------------+--------+
  |          ID          |        NAME        |      FOLDER ID        | STATUS |
  +----------------------+--------------------+-----------------------+--------+
  | b097d9ous3ge******** | my-beta-container   | aoek49ghmknn******** | ACTIVE |
  +----------------------+--------------------+-----------------------+--------+
  ```

{% endlist %}