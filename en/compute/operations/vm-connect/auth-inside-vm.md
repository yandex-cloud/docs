# Using {{ yandex-cloud }} from within a VM

This section describes how to use {{ yandex-cloud }} from within a [VM](../../concepts/vm.md) via the API or CLI.

{% include [what-for-to-use-sa-with-vm](../../../_includes/compute/what-for-to-use-sa-with-vm.md) %}

Yandex Cloud provides simplified API and CLI authentication from within a VM for service accounts. To authenticate:
1. If you do not have a service account yet, [create one](../../../iam/operations/sa/create.md) and [configure access permissions for it](../../../iam/operations/sa/assign-role-for-sa.md).
1. [Link the service account](#link-sa-with-instance) to your VM.
1. [Get authenticated from within your VM](#auth-inside-vm).

## Link your service account {#link-sa-with-instance}

Link your service account to an existing or new VM.

{% include [connect-sa-to-vm](../../../_includes/compute/connect-sa-to-vm.md) %}

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