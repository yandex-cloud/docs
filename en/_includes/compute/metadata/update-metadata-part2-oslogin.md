To make sure users can [connect](../../../compute/operations/vm-connect/os-login.md) to the VM via [{{ oslogin }}](../../../organization/concepts/os-login.md), enable this option in the VM settings:

{% list tabs group=instructions %}

- Management console {#console}

  1. In the [management console]({{ link-console-main }}), select the folder this VM belongs to.
  1. From the list of services, select **{{ ui-key.yacloud.iam.folder.dashboard.label_compute }}**.
  1. In the left-hand panel, select ![image](../../../_assets/console-icons/server.svg) **{{ ui-key.yacloud.compute.instances_jsoza }}**.
  1. In the VM row, click ![image](../../../_assets/console-icons/ellipsis.svg) and select ![image](../../../_assets/console-icons/pencil.svg) **{{ ui-key.yacloud.common.edit }}**.
  1. Under **{{ ui-key.yacloud.compute.instances.create.section_access }}**, select **{{ ui-key.yacloud.compute.instance.access-method.field_os-login-access-method }}**.
  1. Click **{{ ui-key.yacloud.compute.instance.edit.button_update }}**.

- CLI {#cli}

  {% include [cli-install](../../cli-install.md) %}

  {% include [default-catalogue](../../default-catalogue.md) %}

  1. See the description of the CLI command for updating VM parameters:

     ```bash
     yc compute instance update --help
     ```

  1. Get a list of VMs in the default folder:

     {% include [compute-instance-list](../../../compute/_includes_service/compute-instance-list.md) %}

  1. Select `ID` or `NAME` of the VM, e.g., `first-instance`.

  1. Enable access via {{ oslogin }}:

     ```bash
     yc compute instance update first-instance \
       --metadata enable-oslogin=true
     ```

- API {#api}

  Use the `metadata` field to provide `enable-oslogin=true` in the [update](../../../compute/api-ref/Instance/update.md) REST API method for the [Instance](../../../compute/api-ref/Instance/) resource or in the [InstanceService/Update](../../../compute/api-ref/grpc/Instance/update.md) gRPC API call.

{% endlist %}

{% note info %}

{% include [metadata-keys](../metadata-keys.md) %}

{% endnote %}