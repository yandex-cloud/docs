# Secure password transmission to an initialization script

When creating a VM from an image with the Windows OS, you can use an initialization script. For example, you can set up login-password pairs for the administrator and other system users. To protect sensitive data, use {{ lockbox-name }} functionality instead of explicitly specifying settings in the script.

In this tutorial, you will create a VM with the Windows OS using an initialization script which will get login-password pairs of system users from {{ lockbox-name }}.

To create a VM and protect confidential information in the initialization script:

1. [Create a service account](#create-account).
1. [Create a {{ kms-short-name }} key](#create-key).
1. [Create a secret](#create-secret).
1. [Create a VM](#create-vm).
1. [Log in to the Windows OS](#login-windows).

If you no longer need the resources you created, [delete them](#clear-out).

## Getting started {#before-you-begin}

{% include [before-you-begin](../../_tutorials/_tutorials_includes/before-you-begin.md) %}

### Required paid resources {#paid-resources}

The infrastructure support cost includes:

* Fee for VMs (see the [{{ compute-full-name }} pricing](../../compute/pricing.md)).
* Fee for image use (depends on the image).
* Fee for using a {{ kms-short-name }} key (see the [{{ kms-short-name }} pricing](../../kms/pricing.md)).
* Fee for using a secret (see the [{{ lockbox-name }} pricing](../../lockbox/pricing.md)).

## Create a service account {#create-account}

{% list tabs group=instructions %}

- Management console {#console}

   1. In the [management console]({{ link-console-main }}), select a folder where you want to create your service account.
   1. In the **{{ ui-key.yacloud.iam.folder.switch_service-accounts }}** tab, click **{{ ui-key.yacloud.iam.folder.service-accounts.button_add }}**.
   1. Enter a name for the service account, e.g., `win-secret-sa`.
   1. Click **{{ ui-key.yacloud.iam.folder.service-account.popup-robot_button_add }}**.

- CLI {#cli}

   {% include [default-catalogue](../../_includes/default-catalogue.md) %}

   Run the command below to create a service account, specifying the `win-secret-sa` name:

   ```bash
   yc iam service-account create --name win-secret-sa
   ```

   In this command, replace `name` with the name of the service account.

   Result:

   ```yaml
   id: ajehr0to1g8b********
   folder_id: b1gv87ssvu49********
   created_at: "2024-03-15T09:03:11.665153755Z"
   name: win-secret-sa
   ```

- API {#api}

   To create a service account, use the [ServiceAccountService/Create](../../iam/api-ref/grpc/service_account_service.md#Create) gRPC API method or the [create](../../iam/api-ref/ServiceAccount/create.md) REST API method for the `ServiceAccount` resource.

{% endlist %}

## Create a {{ kms-short-name }} key {#create-key}

1. Create an [encryption key](../../kms/concepts/key.md):

   {% list tabs group=instructions %}

   - Management console {#console}

      1. In the [management console]({{ link-console-main }}), select the [folder](../../resource-manager/concepts/resources-hierarchy.md#folder) where you want to create your key.
      1. Select **{{ ui-key.yacloud.iam.folder.dashboard.label_kms }}**.
      1. In the left-hand panel, select ![image](../../_assets/console-icons/key.svg) **{{ ui-key.yacloud.kms.switch_symmetric-keys }}**.
      1. Click **{{ ui-key.yacloud.kms.symmetric-keys.button_empty-create }}** and specify the key attributes:
         * **{{ ui-key.yacloud.common.name }}**: `win-secret-key`.
         * **{{ ui-key.yacloud.kms.symmetric-key.form.field_algorithm }}**: `AES-256`.
         * Leave the other parameters at their default settings.
      1. Click **{{ ui-key.yacloud.common.create }}**.

      The key is created together with its first version: click the key in the list to open the page with its attributes.

   - CLI {#cli}

      Run this command:

      ```bash
      yc kms symmetric-key create \
        --name win-secret-key \
        --default-algorithm aes-256
      ```

      Where:

      * `--name`: Key name.
      * `--default-algorithm`: Encryption algorithm (`aes-128`, `aes-192`, or `aes-256`).

   - {{ TF }} {#tf}

      {% include [terraform-definition](../../_tutorials/_tutorials_includes/terraform-definition.md) %}

      {% include [terraform-install](../../_includes/terraform-install.md) %}

      {% include [terraform-key-create](../../_includes/kms/terraform-key-create.md) %}

   - API {#api}

      Use the [create](../../kms/api-ref/SymmetricKey/create.md) REST API method for the [SymmetricKey](../../kms/api-ref/SymmetricKey/index.md) resource or the [SymmetricKeyService/Create](../../kms/api-ref/grpc/symmetric_key_service.md#Create) gRPC API call.

   {% endlist %}

1. Assign the `kms.keys.encrypterDercrypter` [role](../../iam/concepts/access-control/roles.md) to the `win-secret-sa` service account:

   {% list tabs group=instructions %}

   - Management console {#console}

      1. Go to the **Access rights** tab on the key page.
      1. Go to the **{{ ui-key.yacloud.common.resource-acl.label_access-bindings }}** tab.
      1. Find the `win-secret-sa` account in the list and click ![image](../../_assets/options.svg).
      1. Click **{{ ui-key.yacloud.common.resource-acl.button_assign-binding }}**.
      1. Click **Add role** in dialog box that opens and select the `kms.keys.encrypterDercrypter` role.

   - CLI {#cli}

      Run this command:

      ```
      yc resource-manager folder add-access-binding <folder_ID> \
         --role kms.keys.encrypterDercrypter \
         --subject serviceAccount:<service_account_ID>
      ```

   - API {#api}

      To assign the service account a role for the folder, use the [setAccessBindings](../../iam/api-ref/ServiceAccount/setAccessBindings.md) REST API method for the [ServiceAccount](../../iam/api-ref/ServiceAccount/index.md) resource or the [ServiceAccountService/SetAccessBindings](../../iam/api-ref/grpc/service_account_service.md#SetAccessBindings) gRPC API call.

   {% endlist %}

## Create a secret {#create-secret}

Create a secret in {{ lockbox-name }} and use it to save login-password pairs of users for which accounts will be created in the Windows OS.

{% note warning %}

When choosing a password, make sure to comply with the password security requirements; otherwise, the account will not be created for the user.
The password must:

* Contain six or more characters.
* Not contain the account name.
* Contain characters from at least three of the following four groups:
   - Latin uppercase letters (A-Z)
   - Latin lowercase letters (a-z)
   - Digits (0-9)
   - Non-alphanumeric characters (!, ?, %, $, #, etc.)

{% endnote %}

{% list tabs group=instructions %}

- Management console {#console}

   1. In the [management console]({{ link-console-main }}), select the [folder](../../resource-manager/concepts/resources-hierarchy.md#folder) where you want to create your secret.
   1. In the list of services, select **{{ ui-key.yacloud.iam.folder.dashboard.label_lockbox }}**.
   1. Click **{{ ui-key.yacloud.lockbox.button_create-secret }}**.
   1. In the **{{ ui-key.yacloud.common.name }}** field, enter the secret name, `win-secret`.
   1. In the **{{ ui-key.yacloud.lockbox.forms.field_kms-key }}** field, specify the `win-secret-key` key.
   1. Under **{{ ui-key.yacloud.lockbox.forms.section_version }}**:
      * In the **{{ ui-key.yacloud.lockbox.forms.label_key }}** field, enter the login for the `Administrator` administrator.
      * In the **{{ ui-key.yacloud.lockbox.forms.label_value }}**, enter the administrator password.
   1. Add more users if needed. To do so, click **{{ ui-key.yacloud.lockbox.forms.button_add-pair }}** and enter the login and password for the next user.
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
      * `--name`: Secret name. This is a required parameter.
      * `--kms-key-id`: {{ kms-short-name }} key ID.
      * `--description`: Secret description. This is an optional parameter.
      * `--payload`: Contents of the secret as a YAML or JSON array.
      * `--cloud-id`: [ID of the cloud](../../resource-manager/operations/cloud/get-id.md) where you want to create your secret.
      * `--folder-id`: [ID of the folder](../../resource-manager/operations/folder/get-id.md) where your secret will be created.

- {{ TF }} {#tf}

   {% include [terraform-install](../../_includes/terraform-install.md) %}

   1. In the configuration file, describe the parameters of the resources you want to create:

      ```hcl
      resource "yandex_lockbox_secret" "win_secret" {
         name                = "<secret_name>"
         folder_id           = "<folder_ID>"
         kms_key_id          = "<encryption_key_ID>"
      }
      resource "yandex_lockbox_secret_version" "win_secret_version" {
        secret_id = yandex_lockbox_secret.win_secret.id
        entries {
          key        = "Administrator"
          text_value = "<administrator_password>"
        }
        entries {
          key        = "user1"
          text_value = "<user_password>"
        }
      }
      ```

      Where:
      * `name`: Secret name. This is a required parameter.
      * `folder_id`: [ID](../../resource-manager/operations/folder/get-id.md) of the [folder](../../resource-manager/concepts/resources-hierarchy.md#folder) where you want to create your secret. This is an optional parameter.
      * `kms_key_id`: ID of the [{{ kms-name }} encryption key](../../kms/concepts/key.md). The specified {{ kms-name }} key is used to encrypt your secret.
      * `entries`: Content of the secret.

      {% note warning %}

      To improve security, you should set the password in the configuration file using the environment variable.

      {% endnote %}

   1. Create resources:

      {% include [terraform-validate-plan-apply](../../_tutorials/_tutorials_includes/terraform-validate-plan-apply.md) %}

- API {#api}

   To create a secret, use the [create](../../lockbox/api-ref/Secret/create.md) REST API method for the [Secret](../../lockbox/api-ref/Secret/index.md) resource or the [SecretService/Create](../../lockbox/api-ref/grpc/secret_service.md#Create) gRPC API call.

{% endlist %}

1. Assign the `lockbox.payloadViewer` [role](../../iam/concepts/access-control/roles.md) to the `win-secret-sa` service account:

   {% list tabs group=instructions %}

   - Management console {#console}

      1. Go to the **Access rights** tab on the secret page.
      1. Go to the **{{ ui-key.yacloud.common.resource-acl.label_access-bindings }}** tab.
      1. Find the `win-secret-sa` account in the list and click ![image](../../_assets/options.svg).
      1. Click **{{ ui-key.yacloud.common.resource-acl.button_assign-binding }}**.
      1. Click **Add role** in the dialog box that opens and select the `kms.keys.encrypterDercrypter` role.

   - CLI {#cli}

      Run this command:

      ```
      yc resource-manager folder add-access-binding <folder_ID> \
         --role lockbox.payloadViewer \
         --subject serviceAccount:<service_account_ID>
      ```

   - API {#api}

      To assign the service account a role for the folder, use the [setAccessBindings](../../iam/api-ref/ServiceAccount/setAccessBindings.md) REST API method for the [ServiceAccount](../../iam/api-ref/ServiceAccount/index.md) resource or the [ServiceAccountService/SetAccessBindings](../../iam/api-ref/grpc/service_account_service.md#SetAccessBindings) gRPC API call.

   {% endlist %}

## Create a VM {#create-vm}

Create a VM with the Windows OS having the administrator and user accounts.

1. Create a file named `init.ps1` and save the following code in it:

   ```
   #ps1

   # logging
   Start-Transcript -Path "$ENV:SystemDrive\provision2.txt" -IncludeInvocationHeader -Force
   "Bootstrap script started" | Write-Host

   # SECRET'S ID:
   $SecretID = "<secret_id>"

   [Net.ServicePointManager]::SecurityProtocol = [Net.SecurityProtocolType]::Tls12
   $SecretURL = "https://payload.lockbox.api.cloud.yandex.net/lockbox/v1/secrets/$SecretID/payload"

   "Secret ID is $SecretID"
   "Payload URL is $SecretURL"

   $YCToken = (Invoke-RestMethod -Headers @{'Metadata-Flavor'='Google'} -Uri "http://169.254.169.254/computeMetadata/v1/instance/service-accounts/default/token").access_token
   if (!$YCToken) {
       throw "Service Account doesn't connected to VM. Please, add Service account with roles lockbox.payloadViewer and kms.key.encryptorDecryptor to VM and try again."
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

1. In the `init.ps1` file, replace the `<secret_id>` placeholder with the real ID of the secret where you saved the user accounts.

1. Create a VM:

   {% list tabs group=instructions %}

   - Management console {#console}

      1. In the [management console]({{ link-console-main }}), open the [folder](../../resource-manager/concepts/resources-hierarchy.md#folder) to create your VM in.
      1. At the top right, click **{{ ui-key.yacloud.iam.folder.dashboard.button_add }}**.
      1. In the list that opens, select **{{ ui-key.yacloud.iam.folder.dashboard.value_compute }}**.
      1. Under **{{ ui-key.yacloud.compute.instances.create.section_base }}**:
         * Enter a VM name, e.g., `win-test`.
         * Select an [availability zone](../../overview/concepts/geo-scope.md) to place your VM in.
      1. Under **{{ ui-key.yacloud.compute.instances.create.section_image }}** section, select an [image](../../compute/concepts/image.md) with the Windows OS.
      1. Under **{{ ui-key.yacloud.compute.instances.create.section_access }}**, specify the information required to access the instance:
         * Select the `win-secret-sa` [service account](../../iam/concepts/index.md#sa).
         * In the **{{ ui-key.yacloud.compute.instances.create.field_access-advanced }}** field, grant access to the [serial console](../../compute/operations/serial-console/index.md).
      1. Under **{{ ui-key.yacloud.common.metadata }}**:
         * In the field with the **Key** placeholder, enter `user-data`.
         * In the field with the **Value** placeholder, copy the contents of the `init.ps1` file.
      1. Click **{{ ui-key.yacloud.compute.instances.create.button_create }}**.

   - CLI {#cli}

      Run this command:

      ```
      yc compute instance create --name win-test --hostname windows10 --zone {{ region-id }}-a --create-boot-disk image-id=<imade_id> --cores 2 --core-fraction 100 --memory 4 --metadata-from-file user-data=init.ps1 --network-interface subnet-name=<subnet_name>,nat-ip-version=ipv4 --service-account-name win-test-sa --platform standard-v3
      ```

      Where:
      * imade_id: ID of the image with the Windows OS.
      * subnet_name: Subnet name in the folder where you want to place the VM.

   {% endlist %}


## Log in to the Windows OS {#login-windows}

To check that the data from the secret was successfully used to create users, log in to the VM's OS:

1. In the [management console]({{ link-console-main }}), select the folder the VM belongs to.
1. Select **{{ ui-key.yacloud.iam.folder.dashboard.label_compute }}**.
1. Select the `win-test` VM.
1. Go to the **{{ ui-key.yacloud.compute.instance.switch_console }}** tab.
1. Under **{{ ui-key.yacloud.compute.instance.switch_console }}**, select `COM2` and click **{{ ui-key.yacloud.compute.instance.console.connect }}**. The command line prompts you to enter commands:

   ```bash
   SAC>
   ```

1. View the list of open channels:

   ```bash
   SAC>ch
   Channel List

   (Use "ch -?" for information on using channels)

   # Status  Channel Name
   0 (AV)    SAC
   1 (AV)    Cmd0001
   ```

1. To switch to a channel, press **ESC** + **TAB** or run the command:

   ```bash
   SAC>ch -sn Cmd0001
   Name:                  Cmd0001
   Description:           Command
   Type:                  VT-UTF8
   Channel GUID:          e203fb79-d80d-11ea-87e3-c2679e14957d
   Application Type GUID: 63d02271-8aa4-11d5-bccf-00b0d014a2d0

   Press <esc><tab> for next channel.
   Press <esc><tab>0 to return to the SAC channel.
   Use any other key to view this channel.
   ```

1. Press **Enter** and specify the following in the given order:
   - Username.
   - Domain if the domain account is used for logging in. Otherwise, enter the hostname or leave empty.
   - Password.

   ```bash
   Please enter login credentials.
   Username: Administrator
   Domain:
   Password: ***************
   ```

1. If you log in successfully, an instance of the command line interpreter will start:

   ```bash
   C:\Windows\system32>
   ```

   If you log in successfully, it means that the data from the secret were used to create the VM.

## How to delete the resources you created {#clear-out}

To stop paying for the resources you created:
* [Delete](../../compute/operations/vm-control/vm-delete.md) the VM.
* [Delete](../../lockbox/operations/secret-delete.md) the secret.
* [Delete](../../kms/operations/key.md#delete) the key.
