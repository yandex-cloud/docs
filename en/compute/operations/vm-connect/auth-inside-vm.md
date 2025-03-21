# Using {{ yandex-cloud }} from within a VM

This section describes how to use {{ yandex-cloud }} from within a [VM](../../concepts/vm.md) via the API or CLI.

To automate working with {{ yandex-cloud }} from within a VM, we recommend using [service accounts](../../../iam/concepts/users/service-accounts.md). This is more secure since you do not need to keep your [OAuth token](../../../iam/concepts/authorization/oauth-token.md) on the VM and can restrict access permissions for your service account.

Yandex Cloud provides simplified API and CLI authentication from within a VM for service accounts. To authenticate:
1. If you do not have a service account yet, [create one](../../../iam/operations/sa/create.md) and [configure access permissions for it](../../../iam/operations/sa/assign-role-for-sa.md).
1. [Link the service account](#link-sa-with-instance) to your VM.
1. [Get authenticated from within your VM](#auth-inside-vm).

## Link your service account {#link-sa-with-instance}

Link your service account to an existing or new VM. You can only link a single service account.

To link a service account to a VM, you need a permission to use this account. This permission comes with the [iam.serviceAccounts.user](../../../iam/security/index.md#iam-serviceAccounts-user) and [editor](../../../iam/roles-reference.md#editor) roles or higher.

### Linking to an existing VM {#link-with-exist-instance}

{% list tabs group=instructions %}

- Management console {#console}

  1. In the [management console]({{ link-console-main }}), select the [folder](../../../resource-manager/concepts/resources-hierarchy.md#folder) the VM belongs to.
  1. In the list of services, select **{{ ui-key.yacloud.iam.folder.dashboard.label_compute }}**.
  1. Click the VM name.
  1. In the top-right corner of the page, click ![image](../../../_assets/console-icons/pencil.svg) **{{ ui-key.yacloud.compute.instance.overview.button_action-edit }}**.
  1. Under **{{ ui-key.yacloud.compute.instances.create.section_additional }}**, select an existing service account or create a new one.
  1. Click **{{ ui-key.yacloud.compute.instance.edit.button_update }}**.

- CLI {#cli}

  {% include [cli-install](../../../_includes/cli-install.md) %}

  {% include [default-catalogue](../../../_includes/default-catalogue.md) %}

  Update the VM parameters by specifying the service account using `--service-account-name` or `--service-account-id`:

  ```bash
  yc compute instance update my-instance --service-account-name test
  ```

- API {#api}

  Use the [update](../../api-ref/Instance/update.md) REST API method for the [Instance](../../api-ref/Instance/) resource or the [InstanceService/Update](../../api-ref/grpc/Instance/update.md) gRPC API call. Specify the service account ID in your request.

{% endlist %}

### Linking to a new VM {#link-with-new-instance}

{% list tabs group=instructions %}

- Management console {#console}

  In the management console, you can link a service account to a virtual machine. This service account must be in the same [folder](../../../resource-manager/concepts/resources-hierarchy.md#folder) as the VM. If the service account is in a different folder, use the CLI or API.

  To link a service account to a VM, select it under **{{ ui-key.yacloud.compute.instances.create.section_additional }}** in the **{{ ui-key.yacloud.compute.instances.create.field_service-account }}** field when [creating the VM](../index.md#vm-create). You can select an existing service account or create a new one.

- CLI {#cli}

  {% include [cli-install](../../../_includes/cli-install.md) %}

  {% include [default-catalogue](../../../_includes/default-catalogue.md) %}

  Create a VM by specifying the service account using `--service-account-name` or `--service-account-id`:

  ```bash
  yc compute instance create \
    --name my-instance \
    --network-interface subnet-name=default,nat-ip-version=ipv4 \
    --ssh-key ~/.ssh/id_ed25519.pub \
    --service-account-name my-robot
  ```

- API {#api}

  Use the [create](../../api-ref/Instance/create.md) REST API method for the [Instance](../../api-ref/Instance/) resource or the [InstanceService/Create](../../api-ref/grpc/Instance/create.md) gRPC API call. Specify the service account ID in your request.

{% endlist %}

## Authentication from within a VM {#auth-inside-vm}

To get authenticated from within your VM using the linked service account:

{% list tabs group=instructions %}

- CLI {#cli}

  1. [Connect](../vm-connect/ssh.md) to the VM over SSH.

  1. {% include [cli-install](../../../_includes/cli-install.md) %}

  1. Create a new profile:

     ```bash
     yc config profile create my-robot-profile
     ```

  1. Configure your profile to run commands.

     {% include [add-folder](../../../_includes/cli-add-folder.md) %}

     You can also get a [{{ iam-short-name }} token](../../../iam/concepts/authorization/iam-token.md), e.g., to get authenticated with the API:

     ```bash
     yc iam create-token
     ```

     The [lifetime of an {{ iam-short-name }} token](../../../iam/concepts/authorization/iam-token.md#lifetime) in this case will be less than {{ iam-token-lifetime }}. Request an {{ iam-short-name }} token more often, e.g., every hour. To learn the remaining token lifetime, follow the steps for the API.

- API {#api}

  1. Connect to the VM [over SSH](../vm-connect/ssh.md).
  1. Get an {{ iam-short-name }} token from metadata in Google Compute Engine format:

     ```bash
     curl \
       --header Metadata-Flavor:Google http://169.254.169.254/computeMetadata/v1/instance/service-accounts/default/token
     ```

     Result:

     ```
     {"access_token":"CggVAgAAA...","expires_in":39944,"token_type":"Bearer"}
     ```

     The response will return an {{ iam-short-name }} token in the `access_token` field. The remaining lifetime of the {{ iam-short-name }} token is specified in the `expires_in` field.

  1. {% include [iam-token-usage](../../../_includes/iam-token-usage.md) %}

    Keep track of the {{ iam-short-name }} token lifetime or request a new token more often, e.g., every hour.

{% endlist %}