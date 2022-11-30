# Using personal licenses for Microsoft products

{{ yandex-cloud }} allows you to use your own Microsoft product licenses on [dedicated hosts](../compute/concepts/dedicated-host.md). In this case, the license relationships only regulate you as a client and Microsoft as a license vendor. You are fully responsible for complying with Microsoft license [terms and conditions](https://www.microsoft.com/en-us/licensing/product-licensing/products).

When using Microsoft license products in {{ yandex-cloud }}, the cost of license is deducted from the cost of VM usage. You need to settle all the matters pertaining to the licenses with your supplier.

{% note info %}

Information in this article isn't legally binding and is provided for reference only.

{% endnote %}

## What licenses can I use {#which-licenses}

Possible licenses in {{ yandex-cloud }} depend on the license terms and conditions of a given Microsoft product. BYOL (Bring Your Own License) is possible if the license was purchased under one of the following agreements:

* Microsoft Enterprise Agreement (EA) or Microsoft Enterprise Subscription Agreement.
* Microsoft Server and Cloud Enrollment (SCE) Agreement.
* Microsoft Enterprise Subscription Agreement (EAS).
* Microsoft Products and Services Agreement (MPSA).
* Microsoft Open, Open Value, and Open Value Subscription.
* Microsoft Enrollment for Education Solutions (EES).

{% note info %}

Licenses purchased under Microsoft Cloud Solution Provider (CSP) don't fit for BYOL.

{% endnote %}

Note that the list of licenses may change and not be exhaustive. Make sure to contact Microsoft for the up-to-date list of license programs suitable for BYOL in cloud environments.

## How do I transfer licenses {#how-to-bring-licenses}

1. [Import the necessary image](#how-to-import).
1. [Create a group of dedicated hosts](#create-host-group).
1. [Create a virtual machine on the dedicated host from the imported image](#create-vm).
1. [Make sure the VM is up and running and activate your license](#test-vm).

### Import the necessary image {#how-to-import}

You can import the image using the [{{ compute-name }} REST API](../compute/api-ref/Image/create).

1. Execute a query like:

   {% list tabs %}

   - Bash

      ```bash
      curl -H "Authorization: Bearer `yc iam create-token`" -H "accept: application/json" -X POST https://compute.api.cloud.yandex.net/compute/v1/images -d '{"folderId": "<ID of your folder>", "name": "<image name>", "description": "<image description>", "os": {"type": "WINDOWS"}, "pooled": false, "uri": "<link to image in Object Storage>"}'
      ```

   - PowerShell

      ```powershell
      function Create-YCImage {
        param(
          [ValidateNotNullOrEmpty()]
          [string]$folderId = "",

          [ValidateNotNullOrEmpty()]
          [string]$name = "",

          [string]$description = "",

          [ValidateNotNullOrEmpty()]
          [string]$os_type = "WINDOWS",

          [int64]$minDiskSizeGb = 50GB,

          [ValidateNotNullOrEmpty()]
          [string]$uri = ""
        )

        $body = @"
      {
        "folderId": "$folderId",
        "name": "$name",
        "description": "$description",
        "os.type": "$os_type",
        "minDiskSize": "$minDiskSizeGb",
        "os": {
          "type": "$os_type"
        },
        "uri": "$uri"
      }
      "@

        Invoke-WebRequest `
          -Method POST `
          -URI https://compute.api.cloud.yandex.net/compute/v1/images `
          -header @{ "Authorization" = "Bearer $(& yc iam create-token)" } `
          -ContentType 'Application/json' `
          -body $body
      }


      $folderId = "<ID of your folder>"

      Create-YCImage `
        -folderId $folderId `
        -name "<image name>" `
        -uri "<link to image in Object Storage>"

      ```

   {% endlist %}

1. Open the [management console]({{ link-console-cloud }}), choose the folder whose ID you specified in the `folderId` parameter in the first step.
1. Go to {{ compute-name }} and select the **Images** tab.
1. Find the image to be imported, it's in the `Creating` status. Wait for the status to change from `Creating` to `Ready`.

### Create a group of dedicated hosts {#create-host-group}

You can only use your own licenses on VMs created on dedicated hosts. Contact your account manager for a quota for a dedicated host group. Note that the minimum number of vCPU cores on dedicated hosts is 128, and you pay for all of them.

Create a group of dedicated hosts [according to the instructions](../compute/operations/dedicated-host/create-host-group.md).

### Create a VM from your image on the dedicated host {#create-vm}

1. Prepare a file with metadata named `metadata.yaml` and set the administrator's password there:

   ```powershell
   #ps1
   $MyAdministratorPlainTextPassword = '<administrator password>'

   if (-not [string]::IsNullOrEmpty($MyAdministratorPlainTextPassword)) {
       $MyAdministratorPassword = $MyAdministratorPlainTextPassword | ConvertTo-SecureString -AsPlainText -Force
       # S-1-5-21domain-500 is a well-known SID for Administrator
       # https://docs.microsoft.com/en-us/troubleshoot/windows-server/identity/security-identifiers-in-windows
       $MyAdministrator = Get-LocalUser | Where-Object -Property "SID" -like "S-1-5-21-*-500"
       $MyAdministrator | Set-LocalUser -Password $MyAdministratorPassword
   }
   ```

   Note that the password must meet Windows password [complexity requirements](https://docs.microsoft.com/en-us/windows/security/threat-protection/security-policy-settings/password-must-meet-complexity-requirements).

1. On the dedicated host, create a VM with the boot disk from the imported image. Specify the ID of the dedicated host in the `--host-id` parameter. You can create a VM only using the CLI, API, or Terraform. Run the command:

   {% list tabs %}

   - CLI

      ```bash
      yc compute instance create \
      --host-id <ID of dedicated host> \
      --name 'win-test' \
      --folder-id <folder ID> \
      --cores <number of vCPUs> \
      --core-fraction 100 \
      --memory <amount of RAM, GB> \
      --network-interface subnet-id=<subnet ID>,nat-ip-version=ipv4 \
      --create-boot-disk image-id=<ID of imported image> \
      --zone <availability zone> \
      --metadata-from-file user-data=metadata.yaml
      ```

   {% endlist %}

## Test the VM {#test-vm}

Wait 5–10 minutes. Connect to the created VM [using RDP](../compute/operations/vm-connect/rdp.md) with the password specified in `metadata.yaml`. Start PowerShell and run the following command:

```powershell
Unregister-ScheduledTask userdata -Confirm:$false
```

If you don't execute this command and change the VM password, after the VM restart, the new password is reset to the password from `metadata.yaml`.

After that you can activate your license.
