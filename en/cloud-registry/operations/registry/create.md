---
title: Creating a {{ cloud-registry-full-name }} registry
description: Follow this guide to create a {{ cloud-registry-name }} registry.
---

# Creating a registry

{% list tabs group=instructions %}

- Management console {#console}

    1. In the [management console]({{ link-console-main }}), select the folder to create a registry in.
    1. In the list of services, select **{{ cloud-registry-name }}**.
    1. Go to the **Registries** tab.
    1. In the top-right corner, click **Create registry**.
    1. Select the registry format.
    1. If you selected Maven as registry format, specify a version policy:
        * `Release`: For stable versions.
        * `Snapshot`: For development with frequent updates.
        * `Mixed`: A combination of `Release` and `Snapshot` for flexibility.
    1. Enter a name and description for the registry.
    1. Click **Create**.

- CLI {#cli}

    To create a registry, run this command:

    ```
    yc cloud-registry registry create \
      --name <registry_name> \
      --description <registry_description> \
      --registry-kind <registry_format> \
      --registry-type <registry_location>
    ```

    Where:
    * `--name`: Registry name.
    * `--description`: Registry description.
    * `--registry-kind`: Registry format. The available values are `maven`, `npm`, and `docker`.
    * `--registry-type`: Registry location. Possible value: `local`.

    Result:

    ```
    done (3s)
    id: cn1fsnc2dak********
    folder_id: b1gc1t4cb638********
    name: my-first-registry
    kind: DOCKER
    type: LOCAL
    status: ACTIVE
    description: docker
    created_at: "2024-11-30T16:11:12.901356Z"
    modified_at: "2024-11-30T16:11:16.243323Z"
    ```

- API {#api}

    To create a registry, use the [create](../../api-ref/Registry/create.md) REST API method for the [Registry](../../api-ref/Registry/index.md) resource or the [RegistryService/Create](../../api-ref/grpc/Registry/create.md) gRPC API call.

{% endlist %}
