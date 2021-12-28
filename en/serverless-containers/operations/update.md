# Updating a container

You can update a [container name or description](#update-name) and [manage container labels](#manage-label). To change the operation parameters of a container, [create a new revision of the container](./manage-revision.md).

{% include [function-list-note](../../_includes/serverless-containers/container-list-note.md) %}

## Updating a container's name or description {#update-name}

{% list tabs %}

- Management console

  1. In the [management console]({{ link-console-main }}), go to the folder where the container is located.
  1. Open **{{ serverless-containers-name }}**.
  1. Select the container.
  1. Click **Edit**.
  1. Update a container's name or description Name format:

      {% include [name-format](../../_includes/name-format.md) %}

  1. Click **Save**.

- CLI

  {% include [cli-install](../../_includes/cli-install.md) %}

  {% include [default-catalogue](../../_includes/default-catalogue.md) %}

  To update:
  * A container name, run the command:
      ```
      yc serverless container \
         --name <container_name> \
         --new-name <new_container_name>
      ```

  * A container description, run the command:
      ```
      yc serverless container \
         --name <container_name> \
         --description <new_container_description>
      ```

  Result:

  ```
  id: flh7r96juaqq********
  folder_id: aoek6qrs8tjh********
  created_at: "2021-08-17T07:53:10.219Z"
  name: my-beta-container
  description: my beta container description
  url: https://flh7r96juaqq********.containers.cloud-preprod.yandex.net/
  status: ACTIVE
  ```

{% endlist %}

## Managing container labels {#manage-label}

You can perform the following actions with container labels:

* [Add a label](#add-label)
* [Update a label](#update-label)
* [Delete a label](#remove-label)

### Adding a label {#add-label}

{% list tabs %}

- CLI

    {% include [cli-install](../../_includes/cli-install.md) %}

    {% include [default-catalogue](../../_includes/default-catalogue.md) %}

    To add a label to a container, run the command:

    ```
    yc serverless container add-labels <container_name> --labels <key>=<value>
    ```

    Result:

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

{% endlist %}

### Updating a label {#update-label}

{% list tabs %}

- CLI

    To update a container label, run the command:

    {% note warning %}

    The existing set of `labels` is completely replaced by the set transmitted.

    {% endnote %}

    ```
    yc serverless container update <container_name> --labels <key>=<value>
    ```

    Result:

    ```
    id: flh7r96juaqq********
    folder_id: aoek6qrs8tjh********
    created_at: "2021-08-17T07:53:10.219Z"
    name: my-beta-container
    description: my beta container description
    labels:
      new_label: new_test
    url: https://flh7r96juaqq********.containers.cloud-preprod.yandex.net/
    status: ACTIVE
    ```

{% endlist %}

### Deleting a label {#remove-label}

{% list tabs %}

- CLI

    To delete a container label, run the command:

    ```
    yc serverless container remove-labels <container_name> --labels <key>
    ```

    Result:

    ```
    id: flh7r96juaqq********
    folder_id: aoek6qrs8tjh********
    created_at: "2021-08-17T07:53:10.219Z"
    name: my-beta-container
    description: my beta container description
    url: https://flh7r96juaqq********.containers.cloud-preprod.yandex.net/
    status: ACTIVE
    ```

{% endlist %}
