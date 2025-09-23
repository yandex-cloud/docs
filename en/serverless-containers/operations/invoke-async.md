---
title: Invoking a container asynchronously in {{ serverless-containers-full-name }}
description: Follow this guide to configure and run an asynchronous invocation for a container in {{ serverless-containers-name }}.
---

# Invoking a container asynchronously

{% include [note-preview](../../_includes/note-preview.md) %}

## Setting up asynchronous invocation {#async}

{% list tabs group=instructions %}

- Management console {#console}

  1. In the [management console]({{ link-console-main }}), select the [folder](../../resource-manager/concepts/resources-hierarchy.md#folder) with your [container](../concepts/container.md).
  1. Select **{{ ui-key.yacloud.iam.folder.dashboard.label_serverless-containers }}**.
  1. Select the container whose [revision](../concepts/container.md#revision) you want to create.
  1. Navigate to the **{{ ui-key.yacloud.serverless-containers.label_editor }}** tab.
  1. Under **Asynchronous invocation**:

      1. Enable asynchronous invocation.
      1. Specify a service account with the `serverless-containers.containerInvoker` [role](../security/index.md#serverless-containers-containerinvoker) for asynchronous invocations.

  1. Click **{{ ui-key.yacloud.serverless-containers.button_deploy-revision }}**.

- CLI {#cli}

    {% include [cli-install](../../_includes/cli-install.md) %}

    {% include [default-catalogue](../../_includes/default-catalogue.md) %}

    To set up asynchronous invocation, run the following command:

    ```bash
    yc serverless container revision deploy \
      --container-name <container_name> \
      --image <Docker_image_URL> \
      --service-account-id <service_account_ID> \
      --async-service-account-id <ID_of_service_account_for_asynchronous_invocations>
    ```


    Where:

    * `--service-account-id`: [ID of the service account](../../iam/operations/sa/get-id.md) with the `serverless-containers.editor` [role](../security/index.md#serverless-containers-editor) or higher.
    * `--async-service-account-id`: ID of the service account with the `serverless-containers.containerInvoker` [role](../security/index.md#serverless-containers-containerinvoker) for asynchronous invocations.

    Result:

    ```text
    done (6s)
    id: bba1r76l8f73********
    container_id: bbado1g2mtqj********
    created_at: "2025-09-08T12:03:32.797Z"
    image:
      image_url: cr.yandex/crpmfvcgnl26********/ubuntu:hello
      image_digest: sha256:96ab2d89a82fcfc63e24b9ef26de8b3b11ed1043cec41d4359a8de8b********
    resources:
      memory: "134217728"
      cores: "1"
      core_fraction: "100"
    execution_timeout: 3s
    concurrency: "1"
    service_account_id: ajelprpohp7r********
    status: ACTIVE
    log_options:
      folder_id: b1g681qpemb4********
    runtime:
      http: {}
    async_invocation_config:
      service_account_id: ajeaim70pe1u********
    ```

- {{ TF }} {#tf}

  {% include [terraform-definition](../../_tutorials/_tutorials_includes/terraform-definition.md) %}

  {% include [terraform-install](../../_includes/terraform-install.md) %}

  To set up asynchronous invocation:

  1. Open the {{ TF }} configuration file and add the `async_invocation` section to the container description:

      ```hcl
      resource "yandex_serverless_container" "test-container" {
        name               = "<container_name>"
        memory             = "<RAM_size>"
        execution_timeout  = "<execution_timeout>"
        service_account_id = "<service_account_ID>"

        image {
          url = <container_image_path>
        }

        async_invocation {
          service_account_id = "<service_account_ID>"
        }
      }
      ```

      Where:

      * `async_invocation`: Asynchronous invocation parameters:

          * `service_account_id`: Service account with the `serverless-containers.containerInvoker` [role](../security/index.md#serverless-containers-containerinvoker).

      For more information about `yandex_serverless_container` properties, see the [relevant provider documentation]({{ tf-provider-resources-link }}/serverless_container).

  1. Apply the changes:

      {% include [terraform-validate-plan-apply](../../_tutorials/_tutorials_includes/terraform-validate-plan-apply.md) %}

  You can check the container's update and settings using the [management console]({{ link-console-main }}) or this [CLI](../../cli/quickstart.md) command:

  ```bash
  yc serverless serverless-container revision get <container_revision_ID>
  ```

- API {#api}

  To configure asynchronous invocation, use the [deployRevision](../containers/api-ref/Container/deployRevision.md) REST API method for the [Container](../containers/api-ref/Container/index.md) resource or the [ContainerService/DeployRevision](../containers/api-ref/grpc/Container/deployRevision.md) gRPC API call.

{% endlist %}


## Invoke the container {#invoke}

When [invoking](invoke.md) the container over HTTP, specify the `X-Ycf-Container-Integration-Type: async` header.


## See also {#see-also}

* [{#T}](../concepts/invoke-async.md)
