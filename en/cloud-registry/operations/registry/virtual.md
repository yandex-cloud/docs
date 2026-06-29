---
title: Creating a virtual registry in {{ cloud-registry-full-name }}
description: Follow this guide to create a virtual registry in {{ cloud-registry-name }}.
---

# Creating a virtual registry

{% list tabs group=instructions %}

- Management console {#console}

    1. In the [management console]({{ link-console-main }}), select the [folder](../../../resource-manager/concepts/resources-hierarchy.md#folder) where you want to create a virtual registry.
    1. Navigate to **{{ ui-key.yacloud.iam.folder.dashboard.label_cloud-registry }}**.
    1. In the left-hand panel, select ![shapes-4](../../../_assets/console-icons/shapes-4.svg) **{{ ui-key.yacloud.cloud-registry.title_registries }}**.
    1. In the top-right corner, click **{{ ui-key.yacloud.cloud-registry.action_registry-create }}**.
    1. Select the registry format.
    1. In the **Registry type** field, select `Virtual`.
    1. Under **Registries**, use the ![plus](../../../_assets/console-icons/plus.svg) **Add registry** button to add local and/or remote registries to the virtual registry by specifying their IDs. You can look up the registry ID in the management console on the registry info page.

        In the **Registry access** field, select:

        * `Read only` to grant read-only access to the added registries.
        * `Read and upload` to grant both read and upload access to the registries. You can only use one registry for uploads. Specify it in the **Deployment registry** field.

    1. Enter a name and description for the registry.
    1. Add labels in `key: value` format.
    1. Click **{{ ui-key.yacloud.common.create }}**.

- CLI {#cli}

    To create a virtual registry, run this command:

    ```
    yc cloud-registry registry create \
      --name <registry_name> \
      --description <registry_description> \
      --registry-kind <registry_format> \
      --registry-type virtual \
      --properties <registry_properties>
    ```

    Where:
    * `--name`: Registry name.
    * `--description`: Registry description.
    * `--registry-kind`: Registry format. Available formats: `maven`, `npm`, `docker`, `nuget`, `pypi`, and `binary`.
    * `--registry-type`: Registry [type](../../concepts/registry.md#registry-types).
    * `--properties`: Registry properties. Provide them as a string in `name1=value1,name2=value2` format. Available properties for virtual registries are as follows:

        * `registryIds`: List of local and remote registry IDs in the order of their traversal. Provide in `registryIds=registry1;registry2` format.
        * `readOnly`: Permission to push artifacts to the registry. Possible values: `true` to deny or `false` to allow pushing.
        * `deploymentRegistryId`: ID of the registry to push artifacts to. It is required if `readOnly` is `false`.

    Result:

    ```
    done (3s)
    id: cn1fsnc2dak********
    folder_id: b1gc1t4cb638********
    name: my-first-registry
    kind: DOCKER
    type: VIRTUAL
    status: ACTIVE
    description: docker
    created_at: "2024-11-30T16:11:12.901356Z"
    modified_at: "2024-11-30T16:11:16.243323Z"
    ```

- API {#api}

    To create a virtual registry, use the [create](../../api-ref/Registry/create.md) REST API method for the [Registry](../../api-ref/Registry/index.md) resource or the [RegistryService/Create](../../api-ref/grpc/Registry/create.md) gRPC API call.

    In the `type` field, specify `VIRTUAL`.

{% endlist %}
