{% list tabs %}

- Management console

   1. In the [management console]({{ link-console-main }}), select the folder with your container.
   1. Select **{{ serverless-containers-name }}**.
   1. Select the container to get a list of revisions for.
   1. Under **Revisions**, you can find the list of container revisions and their details.

- CLI

   {% include [cli-install](../../_includes/cli-install.md) %}

   {% include [default-catalogue](../../_includes/default-catalogue.md) %}

   To get a list of container revisions, run the command:

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

   You can get a list of container revisions using the [listRevisions](../../serverless-containers/containers/api-ref/Container/listRevisions.md) API method.

{% endlist %}