---
title: Creating a {{ cloud-registry-full-name }} registry
description: Follow this guide to create a {{ cloud-registry-name }} registry.
---

# Creating a registry

{% list tabs group=instructions %}

- Management console {#console}

    1. In the [management console]({{ link-console-main }}), select the [folder](../../../resource-manager/concepts/resources-hierarchy.md#folder) you want to create a registry in.
    1. In the list of services, select **{{ ui-key.yacloud.iam.folder.dashboard.label_cloud-registry }}**.
    1. In the left-hand panel, select ![shapes-4](../../../_assets/console-icons/shapes-4.svg) **{{ ui-key.yacloud.cloud-registry.title_registries }}**.
    1. In the top-right corner, click **{{ ui-key.yacloud.cloud-registry.action_registry-create }}**.
    1. Select the registry format.
    1. Configure the registry format:

        1. In the **Registry type** field, select the preferred registry [type](../../concepts/registry.md#registry-types):

            * `Local`: [Local registry](../../concepts/registry.md#local-registry). This type is available for all registry formats.
            * `Remote`: [Remote](../../concepts/registry.md#remote-registry) registry. This type is available for the `Maven`, `Npm`, and `Docker` formats.
            * `Virtual`: [Virtual](../../concepts/registry.md#virtual-registry) registry. This type is available for the `Maven`, `Npm`, and `Docker` formats.
        1. If you select `Maven` for format and `Local` for type, select a version policy in the **Version policy** field:

            * `Release`: For stable versions.
            * `Snapshot`: For development with frequent updates.
            * `Mixed`: A combination of `Release` and `Snapshot` for flexibility.
        1. If you select `Remote` for type, select the remote registry's address:

            * For `Maven`, the available repositories are `Maven Central` and `Axiom`.

                {% note info %}

                You get access to `Axiom` on request. To activate access to `Axiom`, [create]({{ link-console-support }}/tickets/create) a request to support.

                {% endnote %}

            * For `Npm`, you can only use the `Npm` repository.
            * For `Docker`, you can only use the `Docker Hub` repository. You have to specify authentication data for `Docker Hub`.

                * Grant access to the contents of the {{ lockbox-full-name }} [secret](../../../lockbox/concepts/secret.md) to the {{ cloud-registry-name }} [service agent](../../../iam/concepts/service-control.md#service-agent) by assigning it the `lockbox.payloadViewer` [role](../../../lockbox/security/index.md#lockbox-payloadViewer) for this secret.

                    Currently, you can only grant this access using the [{{ yandex-cloud }} CLI](../../../cli/quickstart.md) command by specifying the ID of the {{ lockbox-full-name }} secret containing the token or password and the [ID of the cloud](../../../organization/operations/organization-get-id.md) you are creating the registry in:

                    ```bash
                    yc lockbox secret add-access-binding \
                      --id <secret_ID> \
                      --role lockbox.payloadViewer \
                      --agent cloud-registry:data-plane \
                      --cloud-id <cloud_ID>
                    ```
                * Get authenticated in `Docker Hub` using an [access token](https://docs.docker.com/security/for-developers/access-tokens/). For do this, select the `Basic` authentication option, specify the username, and, in the **Secret ID in Lockbox** field, select the {{ lockbox-full-name }} secret whose `value` key stores the token.
        1. If you selected the `Virtual` registry type, use the ![plus](../../../_assets/console-icons/plus.svg) **Add registry** button in the **Registries** field to add local and/or remote registries to the virtual registry by specifying their IDs.

            You can look up the registry ID in the management console on the registry info page.
    1. Enter a name and description for the registry.
    1. Click **{{ ui-key.yacloud.common.create }}**.

- CLI {#cli}

    To create a registry, run this command:

    ```
    yc cloud-registry registry create \
      --name <registry_name> \
      --description <registry_description> \
      --registry-kind <registry_format> \
      --registry-type <registry_type> \
      --properties <registry_properties>
    ```

    Where:
    * `--name`: Registry name.
    * `--description`: Registry description.
    * `--registry-kind`: Registry format. The available values are `maven`, `npm`, and `docker`.
    * `--registry-type`: Registry [type](../../concepts/registry.md#registry-types). The available values are `local`, `remote`, and `virtual`.
    * `--properties`: Registry properties. Provide them as a string in `name1=value1,name2=value2` format. Available properties:
        * For `local` registries:
            * `versionPolicy`: Version policy for a registry in `maven` format. Possible values: `mixed`, `release`, and `snapshot`. The default value is `mixed`.
        * For `remote` registries:
            * `source`: Source registry. The possible values depend on the registry format, e.g., `@maven-central` for `maven` or `@npmjs` for `npm`.
            * `authorizationType`: Authorization type. Possible values: `none` and `basic`. The default value is `none`. Available only for a registry in `docker` format.
            * `authorizationSecretId`: ID of the user secret that stores the token or password. It is required if the `authorizationType` is `basic`. Available only for a registry in `docker` format.
            * `authorizationUsername`: Username. It is required if the `authorizationType` is `basic`. Available only for a registry in `docker` format.
        * For `virtual` registries:
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
    type: LOCAL
    status: ACTIVE
    description: docker
    created_at: "2024-11-30T16:11:12.901356Z"
    modified_at: "2024-11-30T16:11:16.243323Z"
    ```

- API {#api}

    To create a registry, use the [create](../../api-ref/Registry/create.md) REST API method for the [Registry](../../api-ref/Registry/index.md) resource or the [RegistryService/Create](../../api-ref/grpc/Registry/create.md) gRPC API call.

{% endlist %}
