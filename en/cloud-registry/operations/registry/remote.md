---
title: Creating a remote registry in {{ cloud-registry-full-name }}
description: Follow this guide to create a remote registry in {{ cloud-registry-name }}.
---

# Creating a remote registry

{% note info %}

You can create a remote registry in any format except binary.

{% endnote %}

{% list tabs group=instructions %}

- Management console {#console}

    1. In the [management console]({{ link-console-main }}), select the [folder](../../../resource-manager/concepts/resources-hierarchy.md#folder) where you want to create a remote registry.
    1. Navigate to **{{ ui-key.yacloud.iam.folder.dashboard.label_cloud-registry }}**.
    1. In the left-hand panel, select ![shapes-4](../../../_assets/console-icons/shapes-4.svg) **{{ ui-key.yacloud.cloud-registry.title_registries }}**.
    1. In the top-right corner, click **{{ ui-key.yacloud.cloud-registry.action_registry-create }}**.
    1. Select the registry format.
    1. In the **Registry type** field, select `Remote`.
    1. Select the source type:

        * `Public`: Public source

            Registry format | Public source addresses
            --- | ---
            Maven | `Maven Central`<br/>`Gradle Plugin Portal`<br/>`Axiom`
            Npm | `Npm`
            Docker | `Docker Hub`
            NuGet| `NuGet`
            PyPI | `PyPI`<br/>`PyPI Test`


            {% note info %}

            The `Axiom` public source is available on request. To get access to `Axiom`, [create]({{ link-console-support }}/tickets/create) a request to support.

            {% endnote %}


        * `Custom`: [Custom](../../concepts/registry.md#custom-registry) source.

            Specify your custom source address.

    1. Select the authorization type:

        {% note info %}

        Authorization is is supported for custom sources and the `Docker Hub` public source. `Docker Hub` only supports the `Basic` authorization type.

        {% endnote %}

        * `None`: Without authorization.

        * `Basic`: Authorization by username and password.

        * `Bearer`: Authorization by Bearer token.

    1. If you selected `Basic` or `Bearer` authorization:

        1. [Create](../../../lockbox/operations/secret-create.md) a {{ lockbox-full-name }} secret. Under **{{ ui-key.yacloud.lockbox.SecretVersionsList.label_key }}**, specify `value`. In the **{{ ui-key.yacloud.lockbox.SecretVersionsList.label_value }}** field, specify the following:

            * Password, if using `Basic` authorization.
            * Bearer token, if using `Bearer` authorization.

        1. Grant access to the contents of the secret to the {{ cloud-registry-name }} [service agent](../../../iam/concepts/service-control.md#service-agent) by assigning it the `lockbox.payloadViewer` [role](../../../lockbox/security/index.md#lockbox-payloadViewer) for this secret.

            Currently, you can only grant this access using the [{{ yandex-cloud }} CLI](../../../cli/quickstart.md) command by specifying the ID of the {{ lockbox-full-name }} secret containing the password or Bearer token and the [ID of the cloud](../../../organization/operations/organization-get-id.md) you are creating the registry in:

            ```bash
            yc lockbox secret add-access-binding \
              --id <secret_ID> \
              --role lockbox.payloadViewer \
              --agent cloud-registry:data-plane \
              --cloud-id <cloud_ID>
            ```

        1. In the registry settings, specify the username (if using `Basic` authorization) and the ID of the {{ lockbox-full-name }} secret you created.

    1. Enter a name and description for the registry.
    1. Add labels in `key: value` format.
    1. Click **{{ ui-key.yacloud.common.create }}**.

- CLI {#cli}

    To create a remote registry, run this command:

    ```
    yc cloud-registry registry create \
      --name <registry_name> \
      --description <registry_description> \
      --registry-kind <registry_format> \
      --registry-type remote \
      --properties <registry_properties>
    ```

    Where:
    * `--name`: Registry name.
    * `--description`: Registry description.
    * `--registry-kind`: Registry format. Available formats: `maven`, `npm`, `docker`, `nuget`, and `pypi`.
    * `--registry-type`: Registry [type](../../concepts/registry.md#registry-types).
    * `--properties`: Registry properties. Provide them as a string in `name1=value1,name2=value2` format. The available properties for remote registries are as follows:

        * `source`: Source registry. You can specify a public source or a [custom](../../concepts/registry.md#custom-registry) one. Available public sources:

            Registry format | Public source addresses
            --- | ---
            `maven` | `@maven-central`<br/>`@gradle-plugin-portal`<br/>`@axiom`
            `npm` | `@npmjs`
            `docker` | `@docker-hub`
            `nuget` | `@nuget`
            `pypi` | `@pypi`<br/>`@pypi-test`

            {% note info %}

            The `@axiom` public source is available on request. To get access to `@axiom`, [create]({{ link-console-support }}/tickets/create) a request to support.

            {% endnote %}

        * `authorizationType`: Authorization type. Available authorization types: `none`, `basic`, and `bearer`. The default value is `none`.

            {% note info %}

            Authorization is supported for custom sources and the `@docker-hub` public source. `@docker-hub` only supports the `basic` authorization type.

            {% endnote %}

            If you selected `basic` or `bearer` `authorizationType`:

            1. [Create](../../../lockbox/operations/secret-create.md) a {{ lockbox-full-name }} secret. Set the `key` parameter to `value` and define the key value as follows:

                * Enter the password if `authorizationType` is set to `basic`.
                * Specify the bearer token if `authorizationType` is set to `bearer`.

            1. Grant access to the contents of the secret to the {{ cloud-registry-name }} [service agent](../../../iam/concepts/service-control.md#service-agent) by assigning it the `lockbox.payloadViewer` [role](../../../lockbox/security/index.md#lockbox-payloadViewer) for this secret.

                Run the command below, specifying the ID of the {{ lockbox-full-name }} secret containing the password or bearer token and the [ID of the cloud](../../../organization/operations/organization-get-id.md) you are creating the registry in:

                ```bash
                yc lockbox secret add-access-binding \
                  --id <secret_ID> \
                  --role lockbox.payloadViewer \
                  --agent cloud-registry:data-plane \
                  --cloud-id <cloud_ID>
                ```

        * `authorizationSecretId`: ID of the user secret that stores the password or bearer token. It is required if `authorizationType` is set to `basic` or `bearer`.
        * `authorizationUsername`: Username. It is required if `authorizationType` is `basic`.

    Result:

    ```
    done (3s)
    id: cn1fsnc2dak********
    folder_id: b1gc1t4cb638********
    name: my-first-registry
    kind: DOCKER
    type: REMOTE
    status: ACTIVE
    description: docker
    created_at: "2024-11-30T16:11:12.901356Z"
    modified_at: "2024-11-30T16:11:16.243323Z"
    ```

- API {#api}

    To create a remote registry, use the [create](../../api-ref/Registry/create.md) REST API method for the [Registry](../../api-ref/Registry/index.md) resource or the [RegistryService/Create](../../api-ref/grpc/Registry/create.md) gRPC API call.

    In the `type` field, specify `REMOTE`.

{% endlist %}
