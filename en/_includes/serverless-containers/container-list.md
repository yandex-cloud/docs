{% list tabs group=instructions %}

- Management console {#console}

    1. In the [management console]({{ link-console-main }}), go to the folder where you want to view a list of containers.
    1. Select **{{ ui-key.yacloud.iam.folder.dashboard.label_serverless-containers }}**.

- CLI {#cli}

    {% include [cli-install](../../_includes/cli-install.md) %}

    {% include [default-catalogue](../../_includes/default-catalogue.md) %}

    To get a list of containers, run the following command:

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

- API {#api}

   To view a list of containers, use the [list](../../serverless-containers/containers/api-ref/Container/list.md) REST API method for the [Container](../../serverless-containers/containers/api-ref/Container/index.md) resource or the [ContainerService/List](../../serverless-containers/containers/api-ref/grpc/container_service.md#List) gRPC API call.

{% endlist %}
