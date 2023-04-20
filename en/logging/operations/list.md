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

   To get a list of log groups, use the [list](../api-ref/LogGroup/list.md) REST API method for the [LogGroup](../api-ref/LogGroup/index.md) resource or the [LogGroupService/List](../api-ref/grpc/log_group_service.md#List) gRPC API call.

{% endlist %}
