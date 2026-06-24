1. [Get your cloud ready](#before-you-begin).
1. [Create a service account](#create-account).
1. [Create a {{ kms-short-name }} key](#create-key).
1. [Create a secret](#create-secret).
1. [Create a VM](#create-vm).
1. [Log in to Windows](#login-windows).

If you no longer need the resources you created, [delete them](#clear-out).


## Get your cloud ready {#before-you-begin}

{% include [before-you-begin](../../_tutorials/_tutorials_includes/before-you-begin.md) %}


### Required paid resources {#paid-resources}

{% include [paid-resources](../../_tutorials/_tutorials_includes/secure-password-script/paid-resources.md) %}


## Create a service account {#create-account}

{% list tabs group=instructions %}

- Management console {#console}

  1. In the [management console]({{ link-console-main }}), select the [folder](../../resource-manager/concepts/resources-hierarchy.md#folder) where you want to create your service account.
  1. Navigate to **{{ ui-key.yacloud.iam.folder.dashboard.label_iam }}**.
  1. Click **{{ ui-key.yacloud.iam.folder.service-accounts.button_add }}**.
  1. Enter the service account name, e.g., `win-secret-sa`.
  1. Click **{{ ui-key.yacloud.iam.folder.service-account.popup-robot_button_add }}**.

- CLI {#cli}

  {% include [default-catalogue](../../_includes/default-catalogue.md) %}

  To create a service account, run the command below, specifying `win-secret-sa` as the service account name:

  ```bash
  yc iam service-account create --name win-secret-sa
  ```

  Where `name` is the service account name.

  Result:

  ```text
  id: ajehr0to1g8b********
  folder_id: b1gv87ssvu49********
  created_at: "2024-03-15T09:03:11.665153755Z"
  name: win-secret-sa
  ```

- API {#api}

  To create a service account, use the [ServiceAccountService/Create](../../iam/api-ref/grpc/ServiceAccount/create.md) gRPC API call or the [create](../../iam/api-ref/ServiceAccount/create.md) REST API method for the `ServiceAccount` resource.

{% endlist %}
  
## Create a {{ kms-short-name }} key {#create-key}

1. Create an [encryption key](../../kms/concepts/key.md):

   {% list tabs group=instructions %}

   - Management console {#console}

     1. In the [management console]({{ link-console-main }}), select the [folder](../../resource-manager/concepts/resources-hierarchy.md#folder) to create your key pair in.
     1. Navigate to **{{ ui-key.yacloud.iam.folder.dashboard.label_kms }}**.
     1. In the left-hand panel, select ![image](../../_assets/console-icons/key.svg) **{{ ui-key.yacloud.kms.switch_symmetric-keys }}**.
     1. Click **{{ ui-key.yacloud.kms.symmetric-keys.button_empty-create }}** and specify its attributes:
         * **{{ ui-key.yacloud.common.name }}**: `win-secret-key`.
         * **{{ ui-key.yacloud.kms.symmetric-key.form.field_algorithm }}**: `AES-256`.
         * Keep the default values for all other parameters.
     1. Click **{{ ui-key.yacloud.common.create }}**.

     This will create a key and its first version; click the key in the list to open its attribute page.

   - CLI {#cli}

     Run this command:

     ```bash
     yc kms symmetric-key create \
       --name win-secret-key \
       --default-algorithm aes-256
     ```

     Where:

     * `--name`: Key name.
     * `--default-algorithm`: Encryption algorithm: `aes-128`, `aes-192`, or `aes-256`.

   - API {#api}

     Use the [create](../../kms/api-ref/SymmetricKey/create.md) REST API method for the [SymmetricKey](../../kms/api-ref/SymmetricKey/index.md) resource or the [SymmetricKeyService/Create](../../kms/api-ref/grpc/SymmetricKey/create.md) gRPC API call.

   {% endlist %}

1. Assign the `kms.keys.encrypterDecrypter` [role](../../iam/concepts/access-control/roles.md) to the `win-secret-sa` service account:

   {% list tabs group=instructions %}

   - Management console {#console}

     1. Navigate to the **{{ ui-key.yacloud.common.label_access-rights }}** tab on the key page.
     1. On the **Service account access permissions** page, find the `win-secret-sa` account in the list and click ![image](../../_assets/options.svg).
     1. Click **{{ ui-key.yacloud_components.acl.action.edit-roles }}**.
     1. In the dialog that opens, click **Add role** and select `kms.keys.encrypterDecrypter`.

   - CLI {#cli}

     Run this command:

     ```bash
     yc resource-manager folder add-access-binding <folder_ID> \
       --role kms.keys.encrypterDecrypter \
       --subject serviceAccount:<service_account_ID>
     ```

   - API {#api}

     To assign a role for a folder to a service account, use the [setAccessBindings](../../iam/api-ref/ServiceAccount/setAccessBindings.md) REST API method for the [ServiceAccount](../../iam/api-ref/ServiceAccount/index.md) resource or the [ServiceAccountService/SetAccessBindings](../../iam/api-ref/grpc/ServiceAccount/setAccessBindings.md) gRPC API call.

   {% endlist %}

## Create a secret {#create-secret}

Create a {{ lockbox-name }} secret to save usernames and passwords of Windows user accounts.

{% include [userpass-warn](../../_tutorials/_tutorials_includes/secure-password-script/userpass-warn.md) %}

{% list tabs group=instructions %}

- Management console {#console}

  1. Navigate to **{{ ui-key.yacloud.iam.folder.dashboard.label_lockbox }}**.
  1. Click **{{ ui-key.yacloud.lockbox.SecretsPage.button_create-secret }}**.
  1. In the **{{ ui-key.yacloud.common.name }}** field, specify the secret name: `win-secret`.
  1. In the **{{ ui-key.yacloud.lockbox.EncryptionInfoSection.title_kms-key }}** field, specify the `win-secret-key` key.
  1. In the **{{ ui-key.yacloud.lockbox.SecretVersionsList.label_key }}** field, enter the admin login: `Administrator`.
  1. In the **{{ ui-key.yacloud.lockbox.SecretVersionsList.label_value }}**, specify the administrator password.
  1. You can add more users if needed by clicking **{{ ui-key.yacloud.lockbox.SecretVersionsList.button_add-pair }}** and specifying their usernames and passwords.
  1. Click **{{ ui-key.yacloud.common.create }}**.

- CLI {#cli}

  1. Run this command:

      ```bash
      yc lockbox secret create \
        --name win-secret \
        --kms-key-id <key_ID> \
        --payload "[{'key': 'Administrator', 'text_value': '<administrator_password>'},{'key': 'user1', 'text_value': '<user_password>'}]" \
        --cloud-id <cloud_ID> \
        --folder-id <folder_ID>
      ```

      Where:

      * `--name`: Secret name (required).
      * `--kms-key-id`: {{ kms-short-name }} key ID.
      * `--description`: Secret description This is an optional setting.
      * `--payload`: Secret content in YAML or JSON format.
      * `--cloud-id`: [ID of the cloud](../../resource-manager/operations/cloud/get-id.md) where you want to create your secret.
      * `--folder-id`: [ID of the folder](../../resource-manager/operations/folder/get-id.md) where you want to create your secret.

- API {#api}

  To create a secret, use the [create](../../lockbox/api-ref/Secret/create.md) REST API method for the [Secret](../../lockbox/api-ref/Secret/index.md) resource or the [SecretService/Create](../../lockbox/api-ref/grpc/Secret/create.md) gRPC API call.

{% endlist %}

1. Assign the `lockbox.payloadViewer` [role](../../iam/concepts/access-control/roles.md) to the `win-secret-sa` service account:

   {% list tabs group=instructions %}

   - Management console {#console}

     1. Navigate to the **{{ ui-key.yacloud.common.label_access-rights }}** tab on the secret page.
     1. Navigate to the **{{ ui-key.yacloud.common.resource-acl.label_access-bindings }}** tab.
     1. Find the `win-secret-sa` account in the list and click ![image](../../_assets/options.svg).
     1. Click **{{ ui-key.yacloud_components.acl.action.edit-roles }}**.
     1. In the dialog that opens, click **Add role** and select `lockbox.payloadViewer`.

   - CLI {#cli}

     Run this command:

     ```bash
     yc resource-manager folder add-access-binding <folder_ID> \
       --role lockbox.payloadViewer \
       --subject serviceAccount:<service_account_ID>
     ```

   - API {#api}

   To assign a role for a folder to a service account, use the [setAccessBindings](../../iam/api-ref/ServiceAccount/setAccessBindings.md) REST API method for the [ServiceAccount](../../iam/api-ref/ServiceAccount/index.md) resource or the [ServiceAccountService/SetAccessBindings](../../iam/api-ref/grpc/ServiceAccount/setAccessBindings.md) gRPC API call.

   {% endlist %}

## Create a VM {#create-vm}

Create a Windows VM and add the administrator and user accounts to it.

1. Create the `init.ps1` file with the following code:

    ```text
    #ps1

    # logging
    Start-Transcript -Path "$ENV:SystemDrive\provision2.txt" -IncludeInvocationHeader -Force
    "Bootstrap script started" | Write-Host

    # SECRET'S ID:
    $SecretID = "<secret_id>"

    [Net.ServicePointManager]::SecurityProtocol = [Net.SecurityProtocolType]::Tls12
    $SecretURL = "https://payload.lockbox.{{ api-host }}/lockbox/v1/secrets/$SecretID/payload"

    "Secret ID is $SecretID"
    "Payload URL is $SecretURL"

    $YCToken = (Invoke-RestMethod -Headers @{'Metadata-Flavor'='Google'} -Uri "http://169.254.169.254/computeMetadata/v1/instance/service-accounts/default/token").access_token
    if (!$YCToken) {
        throw "Service Account doesn't connected to VM. Please, add Service account with roles lockbox.payloadViewer and kms.keys.encrypterDecrypter to VM and try again."
    }

    # Creating parameters for REST-invokations
    $Headers = @{
        Authorization="Bearer $YCToken"
    }

    $Params = @{
        Uri = $SecretURL
        Method = "GET"
        Headers = $Headers
    }

    # Getting secret via REST invoke
    $Secret = Invoke-RestMethod @Params
    $SecretAdministratorPlainTextPassword = $Secret.entries[0].textValue

    # inserting value's from terraform
    if (-not [string]::IsNullOrEmpty($SecretAdministratorPlainTextPassword)) {
        "Set local administrator password" | Write-Host
        $SecretAdministratorPassword = $SecretAdministratorPlainTextPassword | ConvertTo-SecureString -AsPlainText -Force
        # S-1-5-21domain-500 is a well-known SID for Administrator
        # https://docs.microsoft.com/en-us/troubleshoot/windows-server/identity/security-identifiers-in-windows
        $Administrator = Get-LocalUser | Where-Object -Property "SID" -like "S-1-5-21-*-500"
        $Administrator | Set-LocalUser -Password $SecretAdministratorPassword
    }

    # Creating new users if any
    if($Secret.entries.count -gt 1) {
        foreach($User in $Secret.entries[1..($Secret.entries.count-1)]){
            $SecretUserPassword = $User.textValue | ConvertTo-SecureString -AsPlainText -Force
            New-LocalUser -Name $User.key -Password $SecretUserPassword -FullName $User.key
            Add-LocalGroupMember -Group Users -Member $User.key
            Add-LocalGroupMember -Group "Remote Desktop Users" -Member $User.key
        }
    }

    "Bootstrap script ended" | Write-Host
    ```

1. Replace `<secret_id>` with the ID of the secret with user account data you created in the previous step.

1. Create a VM:

   {% list tabs group=instructions %}

   - Management console {#console}

     1. In the [management console]({{ link-console-main }}), select the [folder](../../resource-manager/concepts/resources-hierarchy.md#folder) where you want to create your VM.
     1. At the top right, click **{{ ui-key.yacloud.iam.folder.dashboard.button_add }}** and select `{{ ui-key.yacloud.iam.folder.dashboard.value_compute }}`.
     1. Under **{{ ui-key.yacloud.compute.instances.create.section_image }}**, select the Windows [image](../../compute/concepts/image.md).
     1. Under **{{ ui-key.yacloud.k8s.node-groups.create.section_allocation-policy }}**, select the [availability zone](../../overview/concepts/geo-scope.md) where your VM will reside.
     1. Under **{{ ui-key.yacloud.compute.instances.create.section_base }}**, specify the VM name, e.g., `win-test`.
     1. Under **{{ ui-key.yacloud.compute.instances.create.field_access-advanced }}**, specify the VM access credentials:
         * Select the `win-secret-sa` [service account](../../iam/concepts/index.md#sa).
         * Grant it access to the [serial console](../../compute/concepts/serial-console.md).
     1. Under **{{ ui-key.yacloud.common.metadata }}**:
         * In the **{{ ui-key.yacloud.component.key-values-input.label_key }}** field, specify `user-data`.
         * In the **{{ ui-key.yacloud.component.key-values-input.label_value }}** field, paste the contents of the `init.ps1` file.
     1. Click **{{ ui-key.yacloud.compute.instances.create.button_create }}**.

   - CLI {#cli}

     Run this command:

     ```bash
     yc compute instance create \
       --name win-test \
       --hostname windows10 \
       --zone {{ region-id }}-a \
       --create-boot-disk image-id=<image_ID> \
       --cores 2 \
       --core-fraction 100 \
       --memory 4 \
       --metadata-from-file user-data=init.ps1  \
       --network-interface subnet-name=<subnet_name>,nat-ip-version=ipv4 \
       --service-account-name win-secret-sa \
       --platform standard-v3
     ```

     Where:

     * `image_id`: Windows image ID.
     * `subnet_name`: Name of the subnet where your VM will get connected.

     {% include [cli-metadata-variables-substitution-notice](../../_includes/compute/create/cli-metadata-variables-substitution-notice.md) %}

   {% endlist %}


## Log in to Windows {#login-windows}

{% include [login-windows](../../_tutorials/_tutorials_includes/secure-password-script/login-windows.md) %}


## How to delete the resources you created {#clear-out}

To stop paying for the resources you created:
* [Delete](../../compute/operations/vm-control/vm-delete.md) the VM.
* [Delete](../../lockbox/operations/secret-delete.md) the secret.
* [Delete](../../kms/operations/key.md#delete) the key.
