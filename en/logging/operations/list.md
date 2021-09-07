# Getting a list of log groups

{% list tabs %}

- Management console

  1. In the [management console]({{ link-console-main }}), go to the folder where the log group is located.
  1. Open **{{ cloud-logging-name }}**.
  1. Click the **Groups** tab.

- CLI

  {% include [cli-install](../../_includes/cli-install.md) %}

  {% include [default-catalogue](../../_includes/default-catalogue.md) %}

  To get a list of log groups in the folder, run the command:

  ```
  yc logging group list
  ```

  Result:

  ```
  +----------------------+---------+----------------------+--------+
  |          ID          |  NAME   |      FOLDER ID       | STATUS |
  +----------------------+---------+----------------------+--------+
  | af36gk8qv2********** | default | aoek6qrs8t********** | ACTIVE |
  +----------------------+---------+----------------------+--------+
  ```

{% endlist %}
