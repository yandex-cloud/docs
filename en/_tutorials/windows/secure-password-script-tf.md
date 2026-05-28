1. [Get your cloud ready](#before-you-begin).
1. [Create the infrastructure](#deploy).
1. [Log in to Windows](#login-windows).

If you no longer need the resources you created, [delete them](#clear-out).


## Get your cloud ready {#before-you-begin}

{% include [before-you-begin](../../_tutorials/_tutorials_includes/before-you-begin.md) %}

### Required paid resources {#paid-resources}

{% include [paid-resources](../../_tutorials/_tutorials_includes/secure-password-script/paid-resources.md) %}


## Create an infrastructure {#deploy}

{% include [terraform-definition](../_tutorials_includes/terraform-definition.md) %}

To create your infrastructure via {{ TF }}:

1. [Install {{ TF }}](../../tutorials/infrastructure-management/terraform-quickstart.md#install-terraform), [obtain authentication credentials](../../tutorials/infrastructure-management/terraform-quickstart.md#get-credentials), and specify the source for installing the {{ yandex-cloud }} provider. For details, see [{#T}](../../tutorials/infrastructure-management/terraform-quickstart.md#configure-provider), step 1.
1. Set up your infrastructure description files:

   {% list tabs group=infrastructure_description %}

   - Ready-made configuration {#ready}

     1. Clone the repository containing the configuration files.

        ```bash
        git clone https://github.com/yandex-cloud-examples/yc-secured-password.git
        ```

     1. Navigate to the repository directory. It should now contain the following files:
        * `yc-secured-password.tf`: New infrastructure configuration.
        * `script.tpl`: Script template for creating administrator and user accounts.
        * `yc-secured-password.auto.tfvars`: User data file.

   - Manually {#manual}

     1. Create a folder for configuration files.
     1. In the folder, create:
        1. `yc-secured-password.tf` configuration file:

           {% cut "yc-secured-password.tf" %}

           {% include [yc-secured-password-win-tf](../../_tutorials/_tutorials_includes/secure-password-script/yc-secured-password-win-tf.md) %}

           {% endcut %}

        1. `script.tpl`: Script template for creating administrator and user accounts:

           {% cut "script.tpl" %}

           ```hcl
           #ps1

           # logging
           Start-Transcript -Path "$ENV:SystemDrive\provision2.txt" -IncludeInvocationHeader -Force
           "Bootstrap script started" | Write-Host

           # SECRET'S ID:
           $SecretID = "${MYSECRET_ID}"

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

           {% endcut %}

        1. `yc-secured-password.auto.tfvars` user data file:

           ```hcl
           zone         = "<availability_zone>"
           folder_id    = "<folder_ID>"
           admin_pass   = "<administrator_password>"
           username     = "<username>"
           user_pass    = "<user_password>"
           image_family = "<image_family>"
           ```

   {% endlist %}

   For more information about {{ TF }} resource properties, see the relevant provider guides:

   * [Cloud network](../../vpc/concepts/network.md): [yandex_vpc_network]({{ tf-provider-resources-link }}/vpc_network). 
   * [Subnet](../../vpc/concepts/network.md#subnet): [yandex_vpc_subnet]({{ tf-provider-resources-link }}/vpc_subnet).
   * [Security group](../../vpc/concepts/security-groups.md): [yandex_vpc_security_group]({{ tf-provider-resources-link }}/vpc_security_group).
   * [Service account](../../iam/concepts/users/service-accounts.md): [yandex_iam_service_account]({{ tf-provider-resources-link }}/iam_service_account).
   * [Assigning permissions](../../iam/concepts/access-control/index.md#access-bindings): [yandex_resourcemanager_folder_iam_member]({{ tf-provider-resources-link }}/resourcemanager_folder_iam_member).
   * [Symmetric encryption key](../../kms/concepts/key.md): [yandex_kms_symmetric_key]({{ tf-provider-resources-link }}/kms_symmetric_key)
   * [Secret]({{ tf-provider-resources-link }}/lockbox_secret): [yandex_lockbox_secret](../../lockbox/concepts/secret.md).
   * [Secret version](../../lockbox/concepts/secret.md#version): [yandex_lockbox_secret_version_hashed]({{ tf-provider-resources-link }}/lockbox_secret_version_hashed).
   * [Image](../../compute/concepts/image.md): [yandex_compute_image]({{ tf-provider-resources-link }}/compute_image)
   * [Disk](../../compute/concepts/disk.md): [yandex_compute_disk]({{ tf-provider-resources-link }}/compute_disk)
   * [VM instance](../../compute/concepts/vm.md): [yandex_compute_instance]({{ tf-provider-resources-link }}/compute_instance).

1. In the `yc-secured-password.auto.tfvars` file, specify these custom settings:
   * `zone`: [Availability zone](../../overview/concepts/geo-scope.md).
   * `folder_id`: [Folder ID](../../resource-manager/operations/folder/get-id.md).
   * `admin_pass`: Admin password.

       {% include [userpass-warn](../../_tutorials/_tutorials_includes/secure-password-script/userpass-warn.md) %}

   * `username`: Username.
   * `user_pass`: Password.
   * `image_family`: Family of one of the VM [images](../../compute/concepts/image.md) with the required OS version.

1. Create the resources:

   {% include [terraform-validate-plan-apply](../_tutorials_includes/terraform-validate-plan-apply.md) %}

After creating the infrastructure, [log in to the Windows OS](#login-windows).


## Log in to Windows {#login-windows}

{% include [login-windows](../../_tutorials/_tutorials_includes/secure-password-script/login-windows.md) %}


## How to delete the resources you created {#clear-out}

To stop incurring charges for the resources you created:

1. Open the `yc-secured-password.tf` file and delete your infrastructure description from it.
1. Apply the changes:

    {% include [terraform-validate-plan-apply](../_tutorials_includes/terraform-validate-plan-apply.md) %}
