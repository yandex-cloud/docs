{% list tabs %}

- Management console

    1. In the [management console]({{ link-console-main }}), select the folder with your container.
    1. Select **{{ serverless-containers-name }}**.
    1. Select the container to get a list of revisions for.
    1. Under **Revisions**, you can find the list of container revisions and their details.

- CLI

    {% include [cli-install](../cli-install.md) %}

    {% include [default-catalogue](../default-catalogue.md) %}

    {% include [note](./sc-list-note.md) %}

    To get a list of container revisions, run this command:

    ```
    yc serverless container revision list --container-name <container_name>
    ```

    Result:

    ```
    +----------------------+----------------------+--------------------------------------------+---------------------+
    |          ID          |     CONTAINER ID     |                   IMAGE                    |     CREATED AT      |
    +----------------------+----------------------+--------------------------------------------+---------------------+
    | bbaq84v92qqc******** | bbab5i36nvda******** | {{ registry }}/crpp35hht729********/ubuntu:test | 2021-09-09 11:22:28 |
    | bba5eosk5sod******** | bbab5i36nvda******** | {{ registry }}/crpp35hht729********/ubuntu:test | 2021-09-09 10:13:04 |
    +----------------------+----------------------+--------------------------------------------+---------------------+
    ```

- API

   To get a list of container revisions, use the [listRevisions](../../serverless-containers/containers/api-ref/Container/listRevisions.md) REST API method for the [Container](../../serverless-containers/containers/api-ref/Container/index.md) resource or the [ContainerService/ListRevisions](../../serverless-containers/containers/api-ref/grpc/container_service.md#ListRevisions) gRPC API call.

{% endlist %}