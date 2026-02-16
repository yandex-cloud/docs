---
title: How to configure the VM metadata service
description: Follow this guide to configure the VM metadata service.
---

# Configuring parameters of the VM metadata service

You can configure parameters of the VM [metadata service](../../concepts/vm-metadata.md#metadata-formats) when [creating](../index.md#vm-create) or [updating](../vm-control/vm-update.md) the VM.

To configure metadata service parameters for a VM:

{% list tabs group=instructions %}

- CLI {#cli}

  {% include [cli-install](../../../_includes/cli-install.md) %}

  {% include [default-catalogue](../../../_includes/default-catalogue.md) %}

  1. View the description of the CLI command for updating VM parameters:

     ```bash
     yc compute instance update --help
     ```

  1. Get a list of VMs in the default folder:

     ```bash
     yc compute instance list
     ```

  1. Select `ID` or `NAME` of the VM you need.
  1. Define the metadata service settings:

     ```bash
     yc compute instance update <VM_ID> \
       --metadata-options gce-http-endpoint=enabled
     ```

     Where `--metadata-options` is the parameter defining the settings of the VM metadata service. The possible values are:
     * `gce-http-endpoint`: Allows you to access metadata using the Google Compute Engine format. It can be either `enabled` or `disabled`.
     * `gce-http-token`: Allows you to get the service account [IAM token](../../../iam/concepts/authorization/iam-token.md) for the VM using Google Compute Engine metadata. It can be either `enabled` or `disabled`.

     For more information, see [{#T}](../../concepts/vm-metadata.md#metadata-formats).

  To configure parameters of the VM metadata service when creating the VM, use the `--metadata-options` parameter in the `yc compute instance create` [command](../../../cli/cli-ref/compute/cli-ref/instance/create.md) in the same way.

- {{ TF }} {#tf}

  {% include [terraform-install](../../../_includes/terraform-install.md) %}

  {% include [terraform-definition](../../../_tutorials/_tutorials_includes/terraform-definition.md) %}

  1. Open the {{ TF }} configuration file and specify the `metadata_options` parameter in the VM description:

     ```hcl
     ...
     resource "yandex_compute_instance" "test-vm" {
       ... 
       metadata_options {
         gce_http_endpoint    = 0
         gce_http_token       = 0
       }
       ...
     }
     ...
     ```

     Where:
     * `yandex_compute_instance`: VM description:
       * `metadata_options`: Metadata parameters:
         * `gce_http_endpoint`: Allows you to access metadata using the Google Compute Engine format. Possible values: `0`, `1` for `enabled` and `2` for `disabled`.
         * `gce_http_token`: Allows you to get the service account [IAM token](../../../iam/concepts/authorization/iam-token.md) for the VM using Google Compute Engine metadata. Possible values: `0`, `1` for `enabled` and `2` for `disabled`.

       For more information, see [{#T}](../../concepts/vm-metadata.md#metadata-formats).

     For more information about the `yandex_compute_instance` resource parameters in {{ TF }}, see [this TF provider article]({{ tf-provider-resources-link }}/compute_instance).
  1. Create the resources:

     {% include [terraform-validate-plan-apply](../../../_tutorials/_tutorials_includes/terraform-validate-plan-apply.md) %}

     All the resources you need will then be created in the specified folder with the settings you defined. You can check the new resources and their settings using the [management console]({{ link-console-main }}) or this CLI command:

     ```bash
     yc compute instance get <VM_name>
     ```

- API {#api}

  When creating a VM, use the [create](../../api-ref/Instance/create.md) REST API method for the [Instance](../../api-ref/Instance/index.md) resource or the [InstanceService/Create](../../api-ref/grpc/Instance/create.md) gRPC API call.

  When updating a VM, use the [update](../../api-ref/Instance/update.md) REST API method for the [Instance](../../api-ref/Instance/index.md) resource or the [InstanceService/Update](../../api-ref/grpc/Instance/update.md) gRPC API call.

{% endlist %}