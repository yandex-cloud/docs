# Requirements for data encryption and key and secret management

## 4. Data encryption and key management {#data-encryption-and-key-management}


{{ yandex-cloud }} provides built-in encryption features for a number of services. It is the customer's responsibility to enable encryption in these services and implement encryption in other components for processing critical data. Data encryption and encryption key management are performed by [{{ kms-name }}](../../../kms/) ({{ kms-short-name }}).

{{ yandex-cloud }} APIs support cipher suites in specific TLS versions that are compliant with PCI DSS and other standards.

### At-rest encryption {#at-rest}

By default, all user data at rest is encrypted at the {{ yandex-cloud }} level. Encryption at the {{ yandex-cloud }} level implements one of the best practices for protecting user data and is performed using {{ yandex-cloud }} keys.

If your corporate information security policy specifies key size and [rotation](../../../kms/operations/key.md#rotate) frequency requirements, you can encrypt data using your own keys. You can do this by using {{ kms-short-name }} and its integration with other {{ yandex-cloud }} services or by implementing Data plane encryption yourself.

{{ yandex-cloud }} provides at-rest encryption for the following services:
* {{ compute-name }} (VM disk encryption)
* {{ objstorage-name }} (bucket encryption)
* {{ managed-k8s-name }} (secret encryption)

**Searching for encrypted VM disks:**

{% list tabs group=instructions %}

- Performing a check via the CLI {#cli}

  1. See what organizations are available to you and write down the ID you need:

     ```bash
     yc organization-manager organization list
     ```

  1. Run this command to search for encrypted disks:

      {% cut "**Bash**" %}

      ```bash
      export ORG_ID=<organization_ID>
      CLOUDS=$(yc resource-manager cloud list --organization-id=${ORG_ID} --format=json | jq -r '.[].id')

      echo "Encrypted disks:"
      for CLOUD_ID in $CLOUDS
        do
        FOLDERS=$(yc resource-manager folder list --cloud-id=$CLOUD_ID --format=json | jq -r '.[].id')
        for FOLDER_ID in $FOLDERS
        do
          DISKS=$(yc compute disk list --folder-id $FOLDER_ID --format=json | jq -r '.[] | select(.kms_key.key_id)' | jq -r '.id')

          if [[ -n "$DISKS" ]]; then
            for DISK in $DISKS
            do
              DISKDATA=$(yc compute disk get --id $DISK --folder-id $FOLDER_ID --format=json)
              VM_ID=$(echo $DISKDATA| jq -r '.instance_ids[]')

              VMDATA=""

              if [[ -n "$VM_ID" ]]; then
                VMDATA=$(yc compute instance get --id $VM_ID --folder-id $FOLDER_ID --format=json)
              fi

              echo "------------"
              echo "CLOUD_ID:" $CLOUD_ID
              echo "FOLDER_ID:" $FOLDER_ID
              echo "DISK_ID: "$(echo $DISKDATA | jq -r '.id')
              echo "DISK_NAME: "$(echo $DISKDATA | jq -r '.name')
              echo "DISK_TYPE: "$(echo $DISKDATA | jq -r '.type_id')
              echo "DISK_ZONE: "$(echo $DISKDATA | jq -r '.zone_id')
              echo "DISK_SIZE: "$(echo $DISKDATA | jq -r '.size')
              echo "DISK_KEY: "$(echo $DISKDATA | jq -r '.kms_key')

              if [[ -n "$VMDATA" ]]; then
                echo "VM_ID: "$(echo $VMDATA | jq -r '.id')
                echo "VM_NAME: "$(echo $VMDATA | jq -r '.name')
                echo "VM_STATUS: "$(echo $VMDATA | jq -r '.status')
              fi
              echo "------------"
            done
          fi
        done
      done
      ```

      {% endcut %}

      {% cut "**PowerShell**" %}

      ```powershell
      $ORG_ID = "<organization_ID>"

      $Clouds = yc resource-manager cloud list --organization-id=$ORG_ID --format=json | ConvertFrom-Json | Select @{n="CloudID";e={$_.id}}, created_at, @{n="CloudName";e={$_.name}}, organization_id

      $EncryptedVMs = @()
      $VMDisks = @()

      foreach ($Cloud in $Clouds) {
        $Folders = yc resource-manager folder list --cloud-id $Cloud.CloudID --format=json | ConvertFrom-Json

        foreach($Folder in $Folders) {
          $FolderDiskList = yc compute disk list --folder-id $Folder.id --format=json | ConvertFrom-Json | where{$_.kms_key}

          foreach($Disk in $FolderDiskList) {
            $VMData = $null

            if($Disk.instance_ids) {
              $VMData = yc compute instance get --id $Disk.instance_ids --folder-id $Folder.id --format=json | ConvertFrom-Json
            }

            $EncryptedVMs += $Disk | Select @{n="CloudID";e={$Cloud.CloudID}}, @{n="CloudName";e={$Cloud.CloudName}}, @{n="FolderID";e={$Folder.id}}, @{n="FolderName";e={$Folder.name}}, @{n="DiskID";e={$_.id}}, @{n="DiskName";e={$_.name}}, @{n="DiskType";e={$_.type_id}}, zone_id, @{n="DiskSize";e={$_.size/1GB}}, kms_key, @{n="VMID";e={$VMData.id}}, @{n="VMName";e={$VMData.name}}, @{n="VMStatus";e={$VMData.status}}
          }
        }
      }

      $EncryptedVMs
      ```

      {% endcut %}

{% endlist %}

Check the list of returned encrypted disks. If the list matches your threat model, no additional actions are required. If you find that some disks are missing from the list, follow the steps below:

{% list tabs group=instructions %}

- Management console {#console}

  1. In the [management console]({{ link-console-main }}), select the folder containing the disk.
  1. From the list of services, select **{{ ui-key.yacloud.iam.folder.dashboard.label_compute }}**.
  1. In the left-hand panel, select ![image](../../../_assets/console-icons/hard-drive.svg) **{{ ui-key.yacloud.compute.disks_ddfdb }}** and find the disk you want to encrypt in the list.

      If the disk is attached to a VM and the VM is on, it is recommended to turn it off.
  1. [Create](../../../compute/operations/disk-control/create-snapshot.md) a snapshot of the disk.
  1. Create a new encrypted disk from the snapshot:

      1. Click **{{ ui-key.yacloud.compute.disks.button_create }}**.
      1. In the dialog that opens:
          1. Name the disk in the **{{ ui-key.yacloud.compute.instances.create-disk.field_name }}** field.
          1. Specify the preferred [availability zone](../../../overview/concepts/geo-scope.md) in the **{{ ui-key.yacloud.compute.disk-form.field_zone }}** field.
          1. In the **{{ ui-key.yacloud.compute.instances.create-disk.field_source }}** field, go `{{ ui-key.yacloud.compute.instances.create-disk.value_source-snapshot }}` and select the snapshot you created earlier.
          1. In the **{{ ui-key.yacloud.compute.disk-form.field_type }}** field, specify the preferred [disk type](../../../compute/concepts/disk.md#disks-types).
          1. Under **{{ ui-key.yacloud.compute.disk-form.section_encryption }}**, enable **{{ ui-key.yacloud.compute.disk-form.label_disk-encryption }}** and select or create a {{ kms-short-name }} [encryption key](../../../kms/concepts/key.md).
          1. Click **{{ ui-key.yacloud.compute.disks.create.button_create }}**.
  1. After you create an encrypted disk, attach it to the VM instead of the unencrypted one.

{% endlist %}

#### 4.1 At-rest encryption with a {{ kms-short-name }} key is enabled in {{ objstorage-full-name }} {#storage-kms}

To protect critical data in {{ objstorage-full-name }}, we recommend using bucket server-side encryption with {{ kms-full-name }} keys. This encryption method protects against accidental or intentional publication of the bucket content on the web. For more information, see [Encryption](../../../storage/concepts/encryption.md) in the {{ objstorage-name }} documentation.

{% list tabs group=instructions %}

- Performing a check in the management console {#console}

  1. In the management console, select the cloud or folder to check the buckets in.
  1. In the list of services, select **{{ objstorage-name }}**.
  1. Go to the bucket settings.
  1. Go to the **Encryption** tab.
  1. Make sure that encryption is enabled and the {{ kms-short-name }} encryption key is specified.
  1. If encryption is enabled, the recommendation is fulfilled. Otherwise, proceed to "Guides and solutions to use".

- Performing a check via the CLI {#cli}

  1. [Configure](../../../storage/tools/aws-cli.md) the AWS CLI to work with a cloud.
  1. Run the command below to check whether encryption is enabled:

     ```bash
     aws --endpoint-url=https://{{ s3-storage-host }}/ \
     s3api get-bucket-encryption \
     --bucket <bucket_name>
     ```

  1. If encryption is enabled, the recommendation is fulfilled. Otherwise, proceed to "Guides and solutions to use".

{% endlist %}

**Guides and solutions to use:**

Configure bucket encryption using the [guide](../../../storage/operations/buckets/encrypt.md).

### Encryption in transit {#in-transit}

In most cases, you can only connect to {{ yandex-cloud }} services over HTTPS. However, some scenarios allow data plane access to services over HTTP, without connection encryption at the application level. In all these scenarios, the user can choose the protocol to be used for data plane operations in the service settings: HTTP or HTTPS, and specify their own TLS certificate if HTTPS is selected.

{% note info %}

When working with (or connecting to) {{ yandex-cloud }} APIs, make sure to use TLS 1.2 or higher, since its prior versions are vulnerable.

For example, by using the gRPC interfaces of {{ yandex-cloud }}, you can enforce TLS 1.2 or higher. That's because gRPC is based on HTTP/2 where TLS 1.2 is the minimum supported TLS version.

Support for legacy TLS protocols in {{ yandex-cloud }} services will [gradually be discontinued](../../../security/security-bulletins/index.md).

{% endnote %}

{{ yandex-cloud }} allows you to use your own TLS certificates for the following services:
* {{ objstorage-name }}
* {{ alb-name }}
* {{ api-gw-name }}
* {{ cdn-name }}

#### 4.2 HTTPS for static website hosting is enabled in {{ objstorage-full-name }} {#storage-https}

[{{ objstorage-name }}](../../../storage/) supports secure connections over HTTPS. You can upload your own security certificate if a connection to your {{ objstorage-name }} website requires HTTPS access. Integration with [{{ certificate-manager-name }}](../../../certificate-manager/) is also supported. See the instructions in the {{ objstorage-name }} documentation:
* [Configuring HTTPS](../../../storage/operations/hosting/certificate.md)
* [Bucket](../../../storage/concepts/bucket.md)

When using [{{ objstorage-name }}](../../../storage/), make sure that support for TLS protocols below version 1.2 is disabled at the client level. Use the [`aws:securetransport`](../../../storage/s3/api-ref/policy/conditions.md) bucket policy to make sure running without TLS is disabled for the bucket.

{% list tabs group=instructions %}

- Performing a check in the management console {#console}

  1. In the [management console]({{ link-console-main }}), select **{{ ui-key.yacloud.iam.folder.dashboard.label_storage }}** from the list of services and go to the bucket in question.
  1. In the left-hand panel, select ![image](../../../_assets/console-icons/persons-lock.svg) **{{ ui-key.yacloud.storage.bucket.switch_security }}**.
  1. Select the **{{ ui-key.yacloud.storage.bucket.switch_https }}** tab.
  1. Make sure you have enabled access over HTTPS and specified a TLS certificate.
  1. If access over HTTPS is enabled, the recommendation is fulfilled. Otherwise, proceed to "Guides and solutions to use".

- Performing a check via the CLI {#cli}

  Run the command below by specifying the bucket name:

  ```bash
  yc storage bucket get-https <bucket_name>
  ```

  If the command returns a certificate ID in the `certificate_id` field, it means access over HTTPS is enabled and the recommendation is fulfilled. Otherwise, proceed to "Guides and solutions to use".

{% endlist %}

**Guides and solutions to use:**

[Enable](../../../storage/operations/hosting/certificate.md) access over HTTPS if the bucket is used to host a static website.

#### 4.3 {{ alb-full-name }} uses HTTPS {#alb-https}

[{{ alb-name }}](../../../application-load-balancer/) supports an HTTPS listener with a [certificate](../../../certificate-manager/concepts/imported-certificate.md) uploaded from {{ certificate-manager-name }}. See [listener setup description](../../../application-load-balancer/concepts/application-load-balancer.md#listener) in the {{ alb-full-name }} documentation.

{% list tabs group=instructions %}

- Performing a check in the management console {#console}
 
  1. In the management console, select the cloud or folder to check the load balancers in.
  1. In the list of services, select **{{ alb-name }}**.
  1. Go to the load balancer settings.
  1. Make sure that **HTTPS** is specified for the load balancer.
  1. If HTTPS is specified, the recommendation is fulfilled. Otherwise, proceed to "Guides and solutions to use".

- Performing a check via the CLI {#cli}

  1. See what organizations are available to you and write down the ID you need:

     ```bash
     yc organization-manager organization list
     ```

  1. Run the command below to output the list of all load balancers without HTTPS:

      {% cut "**Bash**" %}

      ```bash
      export ORG_ID=<organization_ID>
      CLOUDS=$(yc resource-manager cloud list --organization-id=${ORG_ID} --format=json | jq -r '.[].id')
      for CLOUD_ID in $CLOUDS
      do
        FOLDERS=$(yc resource-manager folder list --cloud-id=$CLOUD_ID --format=json | jq -r '.[].id')
        for FOLDER_ID in $FOLDERS
        do
          yc application-load-balancer load-balancer list --folder-id $FOLDER_ID --format=json | jq -r '.[] | select(.listeners[0].tls | not)' | jq -r '.'
        done
      done
      ```

      {% endcut %}

      {% cut "**PowerShell**" %}

      ```powershell
      $ORG_ID = "<organization_ID>"

      $Clouds = yc resource-manager cloud list --organization-id $ORG_ID --format=json | ConvertFrom-Json | Select @{n="CloudID";e={$_.id}}, created_at, @{n="CloudName";e={$_.name}}, organization_id

      $ALBWithoutTLS = @()

      foreach ($Cloud in $Clouds) {
        $Folders = yc resource-manager folder list --cloud-id $Cloud.CloudID --format=json | ConvertFrom-Json

        foreach($Folder in $Folders) {
          $ALBWithoutTLS += yc application-load-balancer load-balancer list --folder-id $Folder.id --format=json | ConvertFrom-Json | where{!$_.listeners.tls}
        }
      }

      $ALBWithoutTLS
      ```

      {% endcut %}

  1. If an empty list is output, the recommendation is fulfilled. Otherwise, proceed to "Guides and solutions to use".

{% endlist %}

**Guides and solutions to use:**

Enable an HTTPS listener using [this guide](../../../application-load-balancer/tutorials/tls-termination/index.md).

#### 4.4 {{ api-gw-full-name }} uses HTTPS and its own domain {#api-gateway-https}

[{{ api-gw-name }}](../../../api-gateway/) supports secure connections over HTTPS. You can link your own domain and upload your own security certificate to access your [API gateway](../../../api-gateway/concepts/index.md) over HTTPS.

{% list tabs group=instructions %}

- Performing a check in the management console {#console}

  1. In the management console, select the cloud or folder to check the gateways in.
  1. In the list of services, select **{{ api-gw-name }} → Gateway settings → Domains**.
  1. Make sure the domain and certificate are enabled.
  1. If the domain and certificate are active, the recommendation is fulfilled. Otherwise, proceed to "Guides and solutions to use".

- Performing a check via the CLI {#cli}

  1. See what organizations are available to you and write down the ID you need:

     ```bash
     yc organization-manager organization list
     ```

  1. Run the command below to output the list of all API gateways without any domains and certificates enabled:

     ```bash
     export ORG_ID=<organization ID>
     for CLOUD_ID in $(yc resource-manager cloud list --organization-id=${ORG_ID} --format=json | jq -r '.[].id');
     do for FOLDER_ID in $(yc resource-manager folder list --cloud-id=$CLOUD_ID --format=json | jq -r '.[].id'); 
     do for APIGW in $(yc serverless api-gateway list --folder-id=$FOLDER_ID --format=json | jq -r '.[].id'); \
     do yc serverless api-gateway get --id $APIGW --format json | jq -r '. | select(.attached_domains[0].certificate_id | not)' | jq -r '.id'
     done;
     done;
     done
     ```

  1. If an empty list is output, the recommendation is fulfilled. Otherwise, proceed to "Guides and solutions to use".

{% endlist %}

**Guides and solutions to use:**

1. In the management console, select the cloud or folder to enable domains and certificates in.
1. In the list of services, select **{{ api-gw-name }} → Gateway settings → Domains**.
1. Enable the domains and certificates.

#### 4.5 {{ cdn-full-name }} uses HTTPS and its own SSL certificate {#cdn-https}

[{{ cdn-name }}](../../../cdn/) supports secure connections to origins over HTTPS. You can also upload your own security certificate to access your [CDN resource](../../../cdn/concepts/resource.md) over HTTPS.

{% list tabs group=instructions %}

- Performing a check in the management console {#console}

  1. In the management console, select the cloud or folder to check the resources in.
  1. In the list of services, select **{{ cdn-name }}**.
  1. Go to the resource settings, the **Additional** tab.
  1. Make sure the **Origin request protocol** field is set to **HTTPS**.
  1. Make sure the **Certificate** field specifies your own certificate or a **Let’s encrypt** certificate.
  1. If HTTPS and your own certificate are specified, the recommendation is fulfilled. Otherwise, proceed to "Guides and solutions to use".

- Performing a check via the CLI {#cli}

  1. See what organizations are available to you and write down the ID you need:

     ```bash
     yc organization-manager organization list
     ```

  1. Run the command below to output the list of all resources without any certificates and HTTPS to origins enabled:

     ```bash
     export ORG_ID=<organization ID>
     for CLOUD_ID in $(yc resource-manager cloud list --organization-id=${ORG_ID} --format=json | jq -r '.[].id');
     do for FOLDER_ID in $(yc resource-manager folder list --cloud-id=$CLOUD_ID --format=json | jq -r '.[].id'); 
     do for CDN in $(yc cdn resource list --folder-id=$FOLDER_ID --format=json | jq -r '.[].id'); \
     do yc cdn resource get --id $CDN --format json | jq -r '. | select(.origin_protocol=="HTTPS" and .ssl_certificate.type=="CM" | not)' | jq -r '.id' 
     done;
     done;
     done
     ```

  1. If an empty list is output, the recommendation is fulfilled. Otherwise, proceed to "Guides and solutions to use".

{% endlist %}

**Guides and solutions to use:**

[Enable](../../../cdn/operations/resources/configure-basics.md) a certificate and HTTPS using the instructions.

### Providing encryption on your own {#self-encryption}

**When using services without built-in encryption, it is the customer's responsibility to ensure that critical data is encrypted.**

#### 4.6 For critical data, MDB encryption with {{ kms-short-name }} is used {#self-data-kms}

If data encryption is required, make sure to encrypt data at the application level prior to writing it to a database, for example, using [{{ kms-short-name }}](../../../kms/operations/symmetric-encryption.md) and an add-on, such as `pgcrypto`.

{% list tabs group=instructions %}

- Manual check {#manual}

  Make sure that the stored data is encrypted.

- Performing a check via the CLI {#cli}

  To get a list of all extensions set in a database, run this command:

     ```bash
     yc managed-postgresql database get <database_name> --cluster-id <managed_postgre_cluster_id> --format=json | jq -r '.extensions | .[].name'
     ```

  If the command output contains the `pgcrypto` string, the database has an extension for application-level data encryption enabled.

{% endlist %}

**Guides and solutions to use:**

See [{#T}](../../../managed-greenplum/operations/extensions/pgcrypto.md) for instructions on how to encrypt data in {{ mpg-full-name }} and {{ mgp-full-name }} using `pgcrypto`.

#### 4.7 Data encryption at the application level is used {#self-data-app}

For client-side encryption before uploading data to a {{ objstorage-full-name }} bucket, you can use the following approaches:
* Integrating {{ objstorage-name }} with the {{ kms-name }} service for client-side encryption. For more information, see "Recommended cryptographic libraries".
* Using third-party client-side encryption libraries prior to sending data to {{ objstorage-name }}. If you use third-party data encryption libraries and your own key management methods, make sure your operation scheme, algorithms, and key lenghts comply with regulatory requirements.

For client-side encryption, we recommend that you use the following libraries:
* AWS Encryption SDK and its [{{ kms-short-name }} integration](../../../kms/tutorials/encrypt/aws-encryption-sdk.md).
* Google Tink and its [{{ kms-short-name }} integration](../../../kms/tutorials/encrypt/google-tink.md).
* [{{ yandex-cloud }} SDK](../../../kms/tutorials/encrypt/sdk.md) with any other cryptographic library compatible with PCI DSS or any standards used in your company.

For a comparison of libraries, see the {{ kms-short-name }} documentation, [Which encryption method should I choose?](../../../kms/tutorials/encrypt/).

{% list tabs group=instructions %}

- Manual check {#manual}

  Make sure that the stored data is encrypted.

{% endlist %}

#### 4.8 Encryption of disks and virtual machine snapshots is used {#managed-vm-kms}

By default, all data on {{ compute-full-name }} disks is encrypted at the storage database level using a system key. This protects your data from being compromised in the event of a physical theft of disks from {{ yandex-cloud }} data centers. 

We also recommend encrypting disks and [disk snapshots](../../../compute/concepts/snapshot.md) using {{ kms-full-name }} custom [symmetric keys](../../../kms/concepts/key.md). This approach allows you to:
* Protect against the potential threats of data isolation breach and compromise at the virtual infrastructure level.
* Control the encryption and lifecycle of {{ kms-short-name }} keys, as well as manage them. For more information, see [{#T}](../../../kms/operations/key.md).
* Improve access control to the data on your disk by setting permissions for {{ kms-short-name }} keys. For more information, see [{#T}](../../../kms/operations/key-access.md).
* Use {{ at-full-name }} to track encryption and decryption operations performed using your {{ kms-short-name }} key. For more information, see [{#T}](../../../kms/concepts/index.md#keys-audit).

You can encrypt the following types of disks:
* Network SSD (`network-ssd`)
* Network HDD (`network-hdd`)
* Non-replicated SSD (`network-ssd-nonreplicated`)
* Ultra high-speed network storage with three replicas (SSD) (`network-ssd-io-m3`)

{% list tabs group=instructions %}

- Manual check {#manual}

  When [creating a disk](../../../compute/operations/disk-create/empty.md), make sure to enable **{{ ui-key.yacloud.compute.disk-form.label_disk-encryption }}**.

{% endlist %}

**Guides and solutions to use:**

[Encrypt](../../../compute/operations/disk-control/disk-encrypt.md) the disk of your {{ compute-full-name }} VM.

### Managing keys {#keys}

We recommend using [{{ kms-name }}](../../../kms/tutorials/encrypt/sdk.md) for data encryption and key management. Made to protect data in the {{ yandex-cloud }} infrastructure, {{ kms-short-name }} can also encrypt and decrypt any of your data.

{{ kms-short-name }} uses AES-GCM encryption mode. You can select the key length: 128/192/256 and set up the preferred key rotation period.

#### 4.9 {{ kms-name }} keys are stored in a hardware security module (HSM) {#keys-hsm}

In production environments, we recommend using separate keys whose every cryptographic operation will only be handled inside a HSM. For more information, see [Hardware security module (HSM)](../../../kms/concepts/hsm.md).

To use the HSM, when creating a key, select AES-256 HSM as the algorithm type. The HSM will handle all operations with this key internally, and no additional actions are required.

We recommend using HSMs for {{ kms-short-name }} keys to enhance the security level.

{% list tabs group=instructions %}

- Performing a check in the management console {#console}

  1. In the management console, select the cloud or folder to check the keys in.
  1. In the list of services, select **{{ kms-name }}**.
  1. Go to the **Keys** tab.
  1. Make sure the **Encryption algorithm** field is set to **AES-256 HSM**.
  1. If AES-256 HSM is specified, the recommendation is fulfilled. Otherwise, proceed to "Guides and solutions to use".

- Performing a check via the CLI {#cli}

  1. See what organizations are available to you and write down the ID you need:

     ```bash
     yc organization-manager organization list
     ```

  1. Run the command below to output the list of all of your organization's {{ kms-short-name }} keys and their encryption algorithms:

     ```bash
     export ORG_ID=<organization ID>
     for CLOUD_ID in $(yc resource-manager cloud list --organization-id=${ORG_ID} --format=json | jq -r '.[].id');
     do for FOLDER_ID in $(yc resource-manager folder list --cloud-id=$CLOUD_ID --format=json | jq -r '.[].id'); 
     do yc kms symmetric-key list --folder-id=$FOLDER_ID --format json | jq -r '.[] | "KEY_ID " + .id + "FOLDER_ID " + .folder_id + "ALGORITM_ID " + .default_algorithm' 
     done;
     done
     ```

  1. If the encryption algorithm contains AES-256 HSM, the recommendation is fulfilled. Otherwise, proceed to "Guides and solutions to use".

{% endlist %}

**Guides and solutions to use:**

[Set](../../../kms/operations/symmetric-encryption.md) the encryption algorithm for {{ kms-short-name }} keys to AES-256 HSM.

#### 4.10 Permissions to manage keys in {{ kms-short-name }} are granted to controlled users {#keys-controlled-users}

To access the {{ kms-short-name }} service, you need an [IAM token](../../../iam/concepts/authorization/iam-token.md).

To automate operations with {{ kms-short-name }}, we recommend that you create a [service account](../../../iam/concepts/users/service-accounts.md) and run commands and scripts under it. If you use VMs, get an IAM token for your service account using the mechanism of [assigning a service account](../../../compute/operations/vm-connect/auth-inside-vm.md) to your VM. For other ways to get an IAM token for your service account, see the {{ iam-short-name }} documentation, [Getting an IAM token for a service account](../../../iam/operations/iam-token/create-for-sa.md).

We recommend that you grant granular permissions for specific keys in the {{ kms-short-name }} service to your users and service accounts. For more information, see the {{ kms-short-name }} documentation, [Access management in {{ kms-name }}](../../../kms/security/).

For more information about security measures for access control, see [Authentication and access control](../../../security/standard/authentication.md).

To check the {{ kms-short-name }} key access permissions, check who has access permissions for:
* Organization, cloud, or folder (such permissions as `admin`, `editor`, `kms.admin`, `kms.editor`, or `kms.keys.encrypterDecrypter`)
* Keys (`kms.keys.encrypterDecrypter` and `kms.editor`)

{% list tabs group=instructions %}

- Performing a check in the management console {#console}
 
  1. In the management console, select the cloud or folder to check the key access permissions in.
  1. Click the **Access permissions** tab.
  1. Make sure the `admin`, `editor`, `kms.admin`, `kms.editor`, and `kms.keys.encrypterDecrypter` roles are only granted to controlled users.
  1. You can check the actual key access permissions only via the CLI.

- Performing a check via the CLI {#cli}

  1. See what organizations are available to you and write down the ID you need:

     ```bash
     yc organization-manager organization list
     ```

  1. Run the command below to search for accounts at the organization level:

     ```bash
     export ORG_ID=<organization ID>
     yc organization-manager organization list-access-bindings --id=${ORG_ID} --format=json | jq -r '.[] | select(.role_id=="admin" or .role_id=="editor" or .role_id=="kms.admin" or .role_id=="kms.editor" or .role_id=="kms.keys.encrypterDecrypter")'
     ```

  1. If there are no accounts in the list, the recommendation is fulfilled. Otherwise, proceed to "Guides and solutions to use".

  1. Find accounts with roles assigned at the cloud level:

     ```bash
     export ORG_ID=<organization ID>
     for CLOUD_ID in $(yc resource-manager cloud list --organization-id=${ORG_ID} --format=json | jq -r '.[].id');
     do yc resource-manager cloud list-access-bindings --id=$CLOUD_ID --format=json | jq -r '.[] | select(.role_id=="admin" or .role_id=="editor" or .role_id=="kms.admin" or .role_id=="kms.editor" or .role_id=="kms.keys.encrypterDecrypter")'
     done
     ```

  1. If there are no accounts in the list, the recommendation is fulfilled. Otherwise, proceed to "Guides and solutions to use".

  1. Run the command below to search for accounts with primitive roles assigned at the level of all folders in your clouds:

     ```bash
     export ORG_ID=<organization ID>
     for CLOUD_ID in $(yc resource-manager cloud list --organization-id=${ORG_ID} --format=json | jq -r '.[].id');
     do for FOLDER_ID in $(yc resource-manager folder list --cloud-id=$CLOUD_ID --format=json | jq -r '.[].id'); \
     do yc resource-manager folder list-access-bindings --id=$FOLDER_ID --format=json | jq -r '.[] | select(.role_id=="admin" or .role_id=="editor" or .role_id=="kms.admin" or .role_id=="kms.editor" or .role_id=="kms.keys.encrypterDecrypter")' && echo $FOLDER_ID
     done;
     done
     ```

  1. If there are no accounts in the list, the recommendation is fulfilled. Otherwise, proceed to "Guides and solutions to use".

  1. Find accounts with roles assigned at the key level:

     ```bash
     export ORG_ID=<organization ID>
     for CLOUD_ID in $(yc resource-manager cloud list --organization-id=${ORG_ID} --format=json | jq -r '.[].id');
     do for FOLDER_ID in $(yc resource-manager folder list --cloud-id=$CLOUD_ID --format=json | jq -r '.[].id'); 
     do for KEY in $(yc kms symmetric-key list --folder-id=$FOLDER_ID --format=json | jq -r '.[].id'); \
     do yc kms symmetric-key list-access-bindings --id $KEY --format json 
     done;
     done;
     done
     ```

{% endlist %}

**Guides and solutions to use:**

Check out who is granted access to {{ kms-short-name }} keys.

#### 4.11 For {{ kms-short-name }} keys, rotation is enabled {#keys-rotation}

To improve the security of your infrastructure, we recommend that you categorize your encryption keys into two groups:
* Keys for services that process critical data but do not store it, such as {{ message-queue-name }} or {{ sf-name }}.
* Keys for services storing critical data, e.g., Managed Services for Databases.

For the first group, we recommend that you set up automatic key rotation with a rotation period longer than the data processing period in these services. When the rotation period expires, the old key versions must be deleted. In the case of automatic rotation and the deletion of old key versions, previously processed data cannot be restored and decrypted.

For data storage services, we recommend that you either manually rotate keys or use automatic key rotation, depending on your internal procedures for processing critical data.

A secure value for AES-GCM mode is encryption using 4294967296 (= 2<sup>32</sup>) blocks. Having reached this number of encrypted blocks, you need to create a new DEK version. For more information about the AES-GCM operating mode, see the [NIST materials](https://nvlpubs.nist.gov/nistpubs/Legacy/SP/nistspecialpublication800-38d.pdf).

{% note info %}

Destroying any version of a key means destroying all data encrypted with it. You can protect a key against deletion by setting the deletionProtection parameter. However, it does not protect against deleting individual versions.

{% endnote %}

For more information about key rotation, see the {{ kms-short-name }} documentation, [Key version](../../../kms/concepts/version.md).

{% list tabs group=instructions %}

- Performing a check in the management console {#console}

  1. In the management console, select the cloud or folder to check the keys in.
  1. In the list of services, select **{{ kms-name }}**.
  1. Go to the key settings.
  1. Find the **Rotation period** parameter.
  1. If the parameter is set to any value different from **No rotation**, the recommendation is fulfilled. Otherwise, proceed to "Guides and solutions to use".

- Performing a check via the CLI {#cli}

  1. See what organizations are available to you and write down the ID you need:

     ```bash
     yc organization-manager organization list
     ```

  1. Run the command below to output the list of all of your organization's {{ kms-short-name }} keys and their encryption algorithms:

     ```bash
     export ORG_ID=<organization ID>
     for CLOUD_ID in $(yc resource-manager cloud list --organization-id=${ORG_ID} --format=json | jq -r '.[].id');
     do for FOLDER_ID in $(yc resource-manager folder list --cloud-id=$CLOUD_ID --format=json | jq -r '.[].id'); 
     do yc kms symmetric-key list --folder-id=$FOLDER_ID --format=json | jq -r '.[] | select(.rotation_period | not)' | jq -r '.id' 
     done;
     done
     ```

  1. If an empty list is output, the recommendation is fulfilled. Otherwise, proceed to "Guides and solutions to use".

{% endlist %}

**Guides and solutions to use:**

Set the key rotation period.

#### 4.12 The deletion protection is enabled for {{ kms-short-name }} keys {#keys-deletion-protection}

Deleting a {{ kms-short-name }} key always means destroying data. Therefore, make sure to protect the keys against accidental deletion. {{ kms-short-name }} has the necessary feature.

{% list tabs group=instructions %}

- Performing a check in the management console {#console}

  1. In the management console, select the cloud or folder to check the keys in.
  1. In the list of services, select **{{ kms-name }}**.
  1. Go to the key settings.
  1. Find the **Deletion protection** parameter.
  1. If it is set to **Yes**, the recommendation is fulfilled. Otherwise, proceed to "Guides and solutions to use".

- Performing a check via the CLI {#cli}

  1. See what organizations are available to you and write down the ID you need:

     ```bash
     yc organization-manager organization list
     ```

  1. Run the command below to output the list of all KMS keys without protection against deletion:

     ```bash
     export ORG_ID=<organization ID>
     for CLOUD_ID in $(yc resource-manager cloud list --organization-id=${ORG_ID} --format=json | jq -r '.[].id');
     do for FOLDER_ID in $(yc resource-manager folder list --cloud-id=$CLOUD_ID --format=json | jq -r '.[].id'); 
     do yc kms symmetric-key list --folder-id=$FOLDER_ID --format=json | jq -r '.[] | select(.deletion_protection | not)' | jq -r '.id' 
     done;
     done
     ```

  1. If an empty list is output, the recommendation is fulfilled. Otherwise, proceed to "Guides and solutions to use".

{% endlist %}

**Guides and solutions to use:**

Enable deletion protection.

### Managing secrets {#secrets}

Critical data and access secrets (authentication tokens, API keys, and encryption keys, etc.) should not be used in plain text in code, cloud object names and descriptions, VM metadata, etc. Use secret storage services instead, e.g., {{ lockbox-short-name }} or HashiCorp Vault.

#### 4.13 The organization uses {{ lockbox-full-name }} for secure secret storage {#secrets-lockbox}

Critical data and access secrets (authentication tokens, API keys, and encryption keys, etc.) should not be used in plain text in code, cloud object names and descriptions, VM metadata, etc. Use secret storage services instead, e.g., {{ lockbox-short-name }}.

{{ lockbox-short-name }} securely stores secrets in an encrypted form only. Encryption is performed using {{ kms-short-name }}. For secret access control, use service roles.

You can learn how to use the service in the [{{ lockbox-short-name }} documentation](../../../lockbox/).

{% note info %}

When working in {{ TF }}, we recommend using a script to [fill in](https://terraform-provider.yandexcloud.net/Resources/lockbox_secret_version) the contents of a secret. This ensures that its contents do not remain in the `.tfstate` file.

{% endnote %}

{% list tabs group=instructions %}

- Performing a check in the management console {#console}

  1. In the management console, select the cloud or folder to check the secrets in.
  1. In the list of services, select **{{ lockbox-short-name }}**.
  1. Make sure that at least one {{ lockbox-short-name }} secret is used.
  1. If {{ lockbox-short-name }} is used, the recommendation is fulfilled. Otherwise, proceed to "Guides and solutions to use".

- Performing a check via the CLI {#cli}

  1. See what organizations are available to you and write down the ID you need:

     ```bash
     yc organization-manager organization list
     ```

  1. Run the command below to search for at least one {{ lockbox-short-name }} secret:
 
     ```bash
     export ORG_ID=<organization ID>
     for CLOUD_ID in $(yc resource-manager cloud list --organization-id=${ORG_ID} --format=json | jq -r '.[].id');
     do for FOLDER_ID in $(yc resource-manager folder list --cloud-id=$CLOUD_ID --format=json | jq -r '.[].id'); 
     do yc lockbox secret list --folder-id=$FOLDER_ID --format=json 
     done;
     done
     ```

  1. If an empty list is output, the recommendation is fulfilled. Otherwise, proceed to "Guides and solutions to use".

{% endlist %}

**Guides and solutions to use:**

Keep secrets in {{ lockbox-short-name }}.

#### 4.14 For {{ serverless-containers-name }} and {{ sf-name }}, {{ lockbox-short-name }} secrets are used {#secrets-serverless-functions}

When working with {{ serverless-containers-name }} or {{ sf-name }}, it is often necessary to use a secret (such as a token or password).

If you specify secret information in environment variables, it can be viewed by any cloud user with permissions to view and use a function, which causes information security risks.

We recommend using Serverless integration with {{ lockbox-short-name }} for that. You can use a specific secret from {{ lockbox-full-name }} and a service account with access rights to this secret to use it in a function or container. 

Make sure that the secrets are used as described above. 

{% list tabs group=instructions %}

- Performing a check in the management console {#console}

  1. In the management console, select the cloud or folder to check the functions in.
  1. In the list of services, select **{{ sf-name }}**.
  1. Go to the function settings, the **Editor** tab.
  1. Find the **{{ lockbox-short-name }} secrets** parameter.
  1. If the parameters of each object specify **{{ lockbox-short-name }}** secrets or there are no environment variables with secret data, the recommendation is fulfilled. Otherwise, proceed to "Guides and solutions to use".

- Performing a check via the CLI {#cli}

  1. Run the command below to search for all the cloud functions that use no {{ lockbox-short-name }} secrets and make sure that these functions use no secret data in environment variables:

     ```bash
     export ORG_ID=<organization ID>
     for CLOUD_ID in $(yc resource-manager cloud list --organization-id=${ORG_ID} --format=json | jq -r '.[].id');
     do for FOLDER_ID in $(yc resource-manager folder list --cloud-id=$CLOUD_ID --format=json | jq -r '.[].id'); 
     do for VER in $(yc serverless function version list --folder-id=$FOLDER_ID --format=json | jq -r '.[].id'); \
     do yc serverless function version get $VER --format=json | jq -r '. | select(.secrets | not)' | jq -r '.id' 
     done;
     done;
     done
     ```

  1. If an empty list is output, the recommendation is fulfilled. Otherwise, proceed to "Guides and solutions to use".

{% endlist %}

**Guides and solutions to use:**

Delete secret data from env and use the {{ lockbox-short-name }} integration functionality:
* [{#T}](../../../serverless-containers/operations/lockbox-secret-transmit.md).
* [{#T}](../../../functions/operations/function/lockbox-secret-transmit.md).

#### 4.15 When working with {{ coi }}, secret encryption is used {#secrets-coi}

{{ kms-short-name }} supports the encryption of secrets used in a {{ TF }} configuration, e.g., for transferring secrets to a VM in encrypted form. See [Encrypting secrets in {{ TF-full }}](../../../kms/tutorials/terraform-secret.md) in the {{ kms-short-name }} documentation. It is not safe to openly provide secrets through environment variables, because they are displayed in the VM properties.

**Guides and solutions to use:**

[Encrypting secrets in {{ TF }} to transfer them to a VM from a {{ coi }}](https://github.com/yandex-cloud-examples/yc-encrypt-coi-secrets).

For other recommendations on how to use {{ TF }} safely, see [Secure configuration: {{ TF }}](../../../security/standard/virtualenv-safe-config.md#tf-using).

#### 4.16 There is a guide for cloud administrators on handling compromised secrets {#secrets-scanning}

In {{ yandex-cloud }}, the [Secret Scanning Service](../../../security/operations/search-secrets.md) is enabled for everyone by default.
It detects structured cloud secrets that are available in the public domain in the following sources:

* Public GitHub repositories
* Yandex search index
* Helm charts in the {{ k8s }} marketplace

The following cloud secrets are detected:

* {{ yandex-cloud }} Session Cookie
* {{ yandex-cloud }} {{ iam-short-name }} token
* {{ yandex-cloud }} API Key
* Yandex Passport OAuth token
* {{ yandex-cloud }} AWS API compatible Access Secret
* {{ yandex-cloud }} {{ captcha-name }} Server Key
* {{ lockbox-short-name }} structured secrets

The service automatically notifies a customer of any found secrets belonging to their infrastructure:

* By email
* Using {{ at-full-name }} [events](../../../audit-trails/concepts/events.md)

**Guides and solutions to use:**

Make sure that:

* [Contact information of the person in charge of an organization is valid](../../../security/standard/authentication.md#org-contacts).
* [{{ at-full-name }} is enabled at the organization level](../../../security/standard/audit-logs.md#audit-trails).
* The administrator has read the [guide](../../../security/operations/search-secrets.md#secret-is-leaked) to follow if secrets are compromised.