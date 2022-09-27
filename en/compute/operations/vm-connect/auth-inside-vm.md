# Working with {{ yandex-cloud }} from inside a VM

This section describes how to work with {{ yandex-cloud }} from inside a VM via the API or CLI.

To automate operations with {{ yandex-cloud }} from inside a VM, we recommend using [service accounts](../../../iam/concepts/users/service-accounts.md). This is more secure since you don't need to save your OAuth token on a VM and can restrict access rights to a service account.

{{ yandex-cloud }} provides simplified authentication via the API and CLI from inside a VM for service accounts. To authenticate:

1. If you don't have a service account yet, [create one](../../../iam/operations/sa/create.md) and [configure access rights for it](../../../iam/operations/sa/assign-role-for-sa.md).
1. [Link the service account](#link-sa-with-instance) to a VM.
1. [Authenticate from inside a VM](#auth-inside-vm).


## Link your service account {#link-sa-with-instance}

Link your service account to an existing or new VM. You can only link one service account.

To link a service account to a VM, you must have permission to use this account. This permission is included in the [iam.serviceAccounts.user](../../../iam/concepts/access-control/roles.md#sa-user) and [editor](../../../iam/concepts/access-control/roles.md#editor) roles and higher.

### Linking to an existing VM {#link-with-exist-instance}

{% list tabs %}

- CLI

   {% include [cli-install](../../../_includes/cli-install.md) %}

   {% include [default-catalogue](../../../_includes/default-catalogue.md) %}

   Update the VM parameters by specifying the service account via the `--service-account-name` or `--service-account-id` option:

   ```
   yc compute instance update my-instance --service-account-name test
   ```
- API

   Use the [update](../../api-ref/Instance/update.md) method for the [Instance](../../api-ref/Instance/) resource. In the `serviceAccountId` property, specify the ID of the service account.

{% endlist %}

### Linking to a new VM {#link-with-new-instance}

{% list tabs %}

- Management console

   In the management console, you can link a service account that's in the same folder as the new VM. If the service account is in a different folder, use the CLI or API.

   To link your service account to a VM, specify it during [VM creation](../index.md#vm-create). You can select an existing service account or create a new one:

   ![image](../../../_assets/compute/connect-sa.png)

- CLI

   {% include [cli-install](../../../_includes/cli-install.md) %}

   {% include [default-catalogue](../../../_includes/default-catalogue.md) %}

   Create a VM and specify the service account using the `--service-account-name` or `--service-account-id` option:

   ```bash
   yc compute instance create \
     --name my-instance \
     --network-interface subnet-name=default,nat-ip-version=ipv4 \
     --ssh-key ~/.ssh/id_rsa.pub \
     --service-account-name my-robot
   ```
- API

   Use the [Create](../../api-ref/Instance/create.md) method for the [Instance](../../api-ref/Instance/) resource. In the `serviceAccountId` property, specify the ID of the service account.

{% endlist %}

## Authenticating from inside a VM {#auth-inside-vm}

To authenticate from inside a VM on behalf of the linked service account:

{% list tabs %}

- CLI

   1. Connect to the VM via [SSH](../vm-connect/ssh.md).
   1. {% include [cli-install](../../../_includes/cli-install.md) %}

   1. Create a new profile:

      ```
      yc config profile create my-robot-profile
      ```
   1. Configure your profile to run commands.

      {% include [add-folder](../../../_includes/cli-add-folder.md) %}

      You can also get an IAM token, for example, to authenticate with the API:

      ```
      yc iam create-token
      ```

      [Lifetime of an IAM token](../../../iam/concepts/authorization/iam-token.md#lifetime) in this case will be less than {{ iam-token-lifetime }}. Request an IAM token more often, like once per hour or with every operation. To find out the remaining lifetime of the token, use the API instructions.
- API

   1. Connect to the VM via [SSH](./ssh.md).
   1. Get an IAM token from metadata in Google Compute Engine format:

      ```bash
      curl -H Metadata-Flavor:Google http://169.254.169.254/computeMetadata/v1/instance/service-accounts/default/token
      
      {"access_token":"CggVAgAAA...","expires_in":39944,"token_type":"Bearer"}
      ```

      The IAM token will be returned in the `access_token` field of the response. The remaining lifetime of the IAM token is specified in the `expires_in` field.

   1. {% include [iam-token-usage](../../../_includes/iam-token-usage.md) %}

   Account for your IAM token lifetime or request the token more often, like once per hour or with every operation.

{% endlist %}
