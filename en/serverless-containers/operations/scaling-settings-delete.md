---
title: Deleting container scaling settings
description: Follow this guide to delete container scaling settings.
---

# Deleting container scaling settings

{% list tabs group=instructions %}

- Management console {#console}

    1. In the [management console]({{ link-console-main }}), select the folder with your container.
    1. [Go](../../console/operations/select-service.md#select-service) to **{{ ui-key.yacloud.iam.folder.dashboard.label_serverless-containers }}**.
    1. Select the container.
    1. Navigate to the **{{ ui-key.yacloud.serverless-containers.label_editor }}** tab.
    1. Under **{{ ui-key.yacloud.serverless-containers.section_parameters }}**, specify:
       * **{{ ui-key.yacloud.serverless-containers.label_min-instances }}**: `0`.
       * **{{ ui-key.yacloud.serverless-containers.label_zone-instances-limit }}**: `0`.
       * **{{ ui-key.yacloud.serverless-containers.label_zone-requests-limit }}**: `0`.
    1. Click **{{ ui-key.yacloud.serverless-containers.button_deploy-revision }}**.

- CLI {#cli}

    {% include [cli-install](../../_includes/cli-install.md) %}

    {% include [default-catalogue](../../_includes/default-catalogue.md) %}

    To delete scaling settings, create a new container revision without specifying scaling settings:

    ```bash
    yc serverless container revision deploy \
      --container-id <container_ID> \
      --image <Docker_image_URL> \
      --service-account-id <service_account_ID>
    ```

    Where:
    * `--container-id`: Container ID. To find out the ID, [get](list.md) the list of containers.
    * `--image`: [Docker image](../../container-registry/concepts/docker-image.md) URL.
    * `--service-account-id`: [ID of the service account](../../iam/operations/sa/get-id.md) authorized to download the image.

    Result:

    ```
    done (2s)
    id: bbam2cv903iv********
    container_id: bbab5i36nvda********
    created_at: "2026-04-01T13:31:11.459Z"
    image:
      image_url: cr.yandex/crpp35hht729********/ubuntu:hello
      image_digest: sha256:f6f34c6cf5f56e594e9828274592f1cc4d9383b1689057ccaf188d41********
    resources:
      memory: "134217728"
      cores: "1"
      core_fraction: "100"
    execution_timeout: 3s
    concurrency: "1"
    service_account_id: aje07l4q4vmo********
    status: ACTIVE
    log_options:
      folder_id: b1gc1t4cb638********
    runtime:
      http: {}
    metadata_options: {}
    ```

    To learn more about the command, see the [CLI reference](../../cli/cli-ref/serverless/cli-ref/container/revision/deploy.md).

- API {#api}

  To delete container scaling settings, use the [deployRevision](../containers/api-ref/Container/deployRevision.md) REST API method for the [Container](../containers/api-ref/Container/index.md) resource or the [ContainerService/DeployRevision](../containers/api-ref/grpc/Container/deployRevision.md) gRPC API call.

{% endlist %}

{% include [scaling](../../_includes/serverless-containers/see-also-scaling.md) %}
