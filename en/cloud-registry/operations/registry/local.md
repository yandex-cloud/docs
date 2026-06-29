---
title: Creating a local registry in {{ cloud-registry-full-name }}
description: '{{ cloud-registry-name }}Follow this guide to create a local registry in.'
---

# Creating a local registry

{% list tabs group=instructions %}

- Management console {#console}

    1. In the [management console]({{ link-console-main }}), select the [folder](../../../resource-manager/concepts/resources-hierarchy.md#folder) where you want to create a local registry.
    1. Navigate to **{{ ui-key.yacloud.iam.folder.dashboard.label_cloud-registry }}**.
    1. In the left-hand panel, select ![shapes-4](../../../_assets/console-icons/shapes-4.svg) **{{ ui-key.yacloud.cloud-registry.title_registries }}**.
    1. In the top-right corner, click **{{ ui-key.yacloud.cloud-registry.action_registry-create }}**.
    1. Select the registry format.
    1. In the **Registry type** field, select `Local`.
    1. If you set the registry format to:

        * `Docker`, specify an artifact immutability policy:

            * `Disabled`: Do not use the policy.
            * `Simple`: Prevent artifact overwriting.
            * `Full`: Prevent artifact overwriting, even after the artifact is deleted.

        * `Maven`, specify a versioning policy:

            * `Mixed`: A combination of `Release` and `Snapshot` for flexibility.
            * `Release`: For stable versions.
            * `Snapshot`: For development with frequent updates.

    1. Enter a name and description for the registry.
    1. Add labels in `key: value` format.
    1. Click **{{ ui-key.yacloud.common.create }}**.

- CLI {#cli}

    To create a local registry, run this command:

    ```
    yc cloud-registry registry create \
      --name <registry_name> \
      --description <registry_description> \
      --registry-kind <registry_format> \
      --registry-type local \
      --properties <registry_properties>
    ```

    Where:
    * `--name`: Registry name.
    * `--description`: Registry description.
    * `--registry-kind`: Registry format. Available formats: `maven`, `npm`, `docker`, `nuget`, `pypi`, and `binary`.
    * `--registry-type`: Registry [type](../../concepts/registry.md#registry-types).
    * `--properties`: Registry properties. Provide them as a string in `name1=value1,name2=value2` format. The available properties for local registries are as follows:

        * `immutable-artifacts-policy`: Artifact immutability policy. It is only supported for the `docker` registry format. Here are the available policy options:

            * `disabled`: Do not use the policy.
            * `simple`: Prevent artifact overwriting.
            * `full`: Prevent artifact overwriting, even after the artifact is deleted.

            The default value is `disabled`.

        * `version-policy`: Versioning policy. It is only supported for the `maven` registry format. Here are the available policy options:

            * `mixed`: A combination of `release` and `snapshot` for flexibility.
            * `release`: For stable versions.
            * `snapshot`: For development with frequent updates.

            The default value is `mixed`.

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

    To create a local registry, use the [create](../../api-ref/Registry/create.md) REST API method for the [Registry](../../api-ref/Registry/index.md) resource or the [RegistryService/Create](../../api-ref/grpc/Registry/create.md) gRPC API call.

    In the `type` field, specify `LOCAL`.

{% endlist %}
