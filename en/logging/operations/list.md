# Getting a list of log groups

{% list tabs %}

- Management console

   In the [management console]({{ link-console-main }}), change to the folder containing your log group and select **{{ cloud-logging-name }}**.

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

- API

   You can retrieve a list of log groups using the API [list](../api-ref/LogGroup/list.md) method.

{% endlist %}
