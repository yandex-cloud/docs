# Virtual environment configuration requirements

## 3. Secure virtual environment configuration {#virtualenv-safe-config}


This section recommends customers on how to configure secure {{ yandex-cloud }} services and employ additional virtual environment data protection tools.

### Overview {#general}

#### 3.1 Antivirus protection is used {#antivirus}

Make sure to provide anti-malware protection within your scope of responsibility. You can use a variety of solutions from our partners in [{{ marketplace-full-name }}](/marketplace).
[Antivirus solution images](/marketplace/products/kaspersky/kaspersky-linux-hybrid-cloud-security-byol) are available in {{ marketplace-full-name }}. License types and other required information are available in the product descriptions.

{% list tabs group=instructions %}

- Manual check {#manual}

  Make sure that critical systems are protected with antivirus solutions.

{% endlist %}

**Guides and solutions to use**:

Follow the vendor guide to install the AV solution.

#### 3.2 The serial console is either controlled or not used {#serial-console}

On VMs, access to the serial console is disabled by default. For risks of using the serial console, see [{#T}](../../../compute/operations/serial-console/index.md) in the {{ compute-full-name }} documentation.

When working with a serial console:

* Make sure that critical data is not output to the serial console.
* If SSH access to the serial console is enabled, make sure that both the credentials management routine and the password used to log in to the operating system locally are as per the regulatory standards. For example, in an infrastructure for storing payment card data, passwords must meet the PCI DSS requirements: they must contain both letters and numbers, be at least 7 characters long, and be changed at least once every 90 days.

{% note info %}

According to the PCI DSS standard, access to a VM via a serial console is considered "non-console", and {{ yandex-cloud }} uses TLS encryption for it.

{% endnote %}

We do not recommend using access to the serial console unless it is absolutely necessary.

{% list tabs group=instructions %}

- Performing a check in the management console {#console}

  1. In the management console, select the folder to check the VMs in.
  1. In the list of services, select **{{ compute-name }}**.
  1. Open the settings of all the necessary VMs.
  1. Under **Access**, find the **Additional** parameter.
  1. **Serial console access** must be disabled.
  1. If it is disabled for all the VMs, the recommendation is fulfilled. Otherwise, proceed to "Guides and solutions to use".

- Performing a check via the CLI {#cli}

  1. See what organizations are available to you and write down the ID you need:
    
     ```bash
     yc organization-manager organization list
     ```

  1. Find a VM with access to the serial console enabled:

     ```bash
     export ORG_ID=<organization ID>
     for CLOUD_ID in $(yc resource-manager cloud list --organization-id=${ORG_ID} --format=json | jq -r '.[].id');
     do for FOLDER_ID in $(yc resource-manager folder list --cloud-id=$CLOUD_ID --format=json | jq -r '.[].id'); 
     do for VM_ID in $(yc compute instance list --folder-id=$FOLDER_ID --format=json | jq -r '.[].id'); do echo "VM_ID: " && yc compute instance get --id=$VM_ID --full --format=json | jq -r '. | select(.metadata."serial-port-enable"=="1")' | jq -r '.id' && echo "FOLDER_ID: " $FOLDER_ID && echo "-----"
     done;
     done;
     done
     ```

  1. If an empty value is set in VM_ID next to FOLDER_ID, the recommendation is fulfilled. Otherwise, proceed to "Guides and solutions to use".

{% endlist %}

**Guides and solutions to use:**

If you don't intend to use serial console on the VM, disable it.

#### 3.3 A benchmark image is used for VM deployment {#standard-image}

When deploying virtual machines, we recommend:

* Preparing a VM image whose system settings correspond to your information security policy. You can create an image using Packer. See [{#T}](../../../tutorials/infrastructure-management/packer-quickstart.md).
* Use this image to create a virtual machine or [instance group](../../../compute/concepts/instance-groups/index.md).
* Look up the virtual machine's information to check that it was created using this image.

{% list tabs group=instructions %}

- Performing a check in the management console {#console}

  1. In the management console, select the folder to check the VMs in.
  1. In the list of services, select **{{ compute-name }}**.
  1. Go to the **Disks** tab.
  1. Open the settings of all disks.
  1. Under **Source**, find the **Identifier** parameter.
  1. If every disk displays the ID of your benchmark image, the recommendation is fulfilled. Otherwise, proceed to "Guides and solutions to use".

- Performing a check via the CLI {#cli}

  1. See what organizations are available to you and write down the ID you need:

     ```bash
     yc organization-manager organization list
     ```

  1. Run the command below to search for the VM disks that do not contain the ID of your benchmark image:

     ```bash
     export ORG_ID=<organization ID>
     export IMAGE_ID=<ID of your benchmark image>
     for CLOUD_ID in $(yc resource-manager cloud list --organization-id=${ORG_ID} --format=json | jq -r '.[].id');
     do for FOLDER_ID in $(yc resource-manager folder list --cloud-id=$CLOUD_ID --format=json | jq -r '.[].id'); 
     do for DISK_ID in $(yc compute disk list --folder-id=$FOLDER_ID --format=json | jq -r '.[].id'); \
     do echo "DISK_ID: " && yc compute disk get --id=$DISK_ID \
     --format=json | jq -r --arg IMAGE_ID $IMAGE_ID '. | select(."source_image_id"==$IMAGE_ID | not)' | jq -r '.id' && echo "FOLDER_ID: " $FOLDER_ID && echo "-----"
     done;
     done;
     done
     ```

  1. If an empty value is set in DISK_ID next to FOLDER_ID, the recommendation is fulfilled. Otherwise, proceed to "Guides and solutions to use".

{% endlist %}

**Guides and solutions to use:**

1. Find out why these VM disks use an image different from the benchmark one.
1. Recreate the VMs with the appropriate image.

#### 3.4 {{ TF }} is used in accordance with best information security practices {#tf-using}

With {{ TF }}, you can manage a cloud infrastructure using configuration files. If you change the files, {{ TF }} will automatically detect which part of your configuration is already deployed, and what should be added or removed. For more information, see [{#T}](../../../tutorials/infrastructure-management/terraform-quickstart.md).

We do not recommend using private information in {{ TF }} configuration files, such as passwords, secrets, personal data, payment system data, etc. Instead, you should use services to store and use secrets in the configuration, such as: [HashiCorp Vault](/marketplace/products/yc/vault-yckms) from {{ marketplace-name }} or [Lockbox](/services/lockbox) (to transfer secrets to the target object without using {{ TF }}).

If you still need to enter private information in the configuration, you should take the following security measures:

* Use [sensitive = true](https://www.terraform.io/docs/language/values/outputs.html#sensitive-suppressing-values-in-cli-output) for private information to exclude it from the console output of the `terraform plan` and `terraform apply` commands.
* Use [terraformremotestate](https://www.terraform.io/docs/language/state/remote.html). We recommend [uploading](../../../tutorials/infrastructure-management/terraform-state-storage.md) a {{ TF }} state to {{ objstorage-name }} and [setting up](https://github.com/yandex-cloud-examples/yc-terraform-state) configuration locks using {{ ydb-name }} to prevent simultaneous edits by administrators.
* Use the [mechanism for transferring secrets to {{ TF }} via env](https://www.terraform.io/docs/cli/config/environment-variables.html#tf_var_name) instead of plain text or use built-in KeyManagementService features for [encrypting data in {{ TF }}](../../../kms/tutorials/terraform-secret.md) using a separate file with private data. [Learn more about this technique](https://blog.gruntwork.io/a-comprehensive-guide-to-managing-secrets-in-your-terraform-code-1d586955ace1#3073).

For more information about {{ objstorage-name }} security, see [{{ objstorage-name }}](#objstorage) below.

{% note info %}

When a configuration is deployed, you can delete the configuration file with private data.

{% endnote %}

Scan your Terraform manifests using [Checkov](https://github.com/bridgecrewio/checkov) with {{ yandex-cloud }} support.

* [Example: Scanning .tf files with Checkov](https://github.com/yandex-cloud/yc-solution-library-for-security/tree/master/terraform-sec/checkov-yc)
* [Example: Storing a {{ TF }} state in {{ objstorage-name }}](https://github.com/yandex-cloud-examples/yc-terraform-state).

{% list tabs group=instructions %}

- Manual check {#manual}

  Collect data about using the {{ TF }} best security practices from different points.

{% endlist %}

#### 3.5 Integrity control is performed {#integrity-control}

##### 3.5.1 File integrity control {#file-integrity-control}

Numerous information security standards require integrity control of critical files. To do this, you can use free host-based solutions:

* [Wazuh](https://documentation.wazuh.com/current/learning-wazuh/detect-fs-changes.html)
* [Osquery](https://osquery.readthedocs.io/en/stable/deployment/file-integrity-monitoring/)

Paid solutions are also available in Yandex Cloud marketplace, such as [Kaspersky Security](/marketplace/products/kaspersky/kaspersky-linux-hybrid-cloud-security-byol).

{% list tabs group=instructions %}

- Manual check {#manual}

  Collect data about using integrity control from different points.

{% endlist %}

##### 3.5.2 VM runtime environment integrity control {#vm-integrity-control}

If you need to control a VM runtime environment (e.g., for access from the VM to a secure repository only when run in the {{ yandex-cloud }} CLI cloud), there is the [identity document](../../../compute/concepts/metadata/identity-document.md) mechanism. When you create a VM, an identity document that stores information about the VM is generated. It contains the IDs of the VM, [{{ marketplace-full-name }}](/marketplace) product, disk image, etc. This document is signed with a {{ yandex-cloud }} certificate. The document and its [signature](../../../compute/concepts/metadata/identity-document.md#signed-identity-documents) are available to VM processes through the metadata service. Thus, the processes identify the VM runtime environment, disk image, etc., to restrict access to the resources under monitoring.

{% list tabs group=instructions %}

- Manual check {#manual}

  Make sure that critical VMs have identity documents signed.

{% endlist %}

#### 3.6 Side-channel attack protection principles are followed {#side-chanel-protection}

To ensure the best protection against CPU level side-channel attacks (such as Spectre or Meltdown):

* Use full-core virtual machines (instances with a CPU share of 100%).
* Install updates for your operating system and kernel that ensure side-channel attack protection (for example, [Kernelpage-tableisolation for Linux](https://en.wikipedia.org/wiki/Kernel_page-table_isolation) or applications built using [Retpoline](https://en.wikipedia.org/wiki/Spectre_%28security_vulnerability%29)).

We recommend that you use [dedicated hosts](../../../compute/concepts/dedicated-host.md) for the most security-critical resources.

[Learn more](https://www.youtube.com/watch?v=VSP_cp6vDQQ&list=PL1x4ET76A10a9Jr6six11s0kRxeQ3fgom&index=17) about side-channel attack protection in cloud environments.

#### 3.7 The corporate {{ yandex-cloud }} users have the {{ yandex-cloud }} Certified Security Specialist certification {#security-specialist-certificate}

The {{ yandex-cloud }} Certified Security Specialist certification exam evaluates the competencies of {{ yandex-cloud }} users involved in information security and cloud system protection.

**Guides and solutions to use**:

1. See the [description of competencies](https://yandex.cloud/ru/certification/security-specialist-competencies) tested during the {{ yandex-cloud }} Certified Security Specialist exam.
1. Study the [materials](https://yandex.cloud/ru/certification/security-specialist-prerequisites) to help you pass the exam.
1. Fill out [this form](https://yandex.cloud/ru/certification#certification-security-form) to sign up for the exam.

### {{ objstorage-full-name }} {#objstorage}

#### 3.8 There is no public access to the {{ objstorage-name }} bucket {#bucket-access}

We recommend assigning minimum roles for a bucket using {{ iam-short-name }} and supplementing or itemizing them using a bucket policy (for example, to restrict access to the bucket by IP, grant granular permissions for objects, and so on).

Access to {{ objstorage-name }} resources is verified at three levels:

* [{{ iam-short-name }} verification](../../../iam/concepts)
* [Bucket policy](../../../storage/concepts/policy.md)
* [Access Control Lists (ACLs)](../../../storage/concepts/acl.md)

**Verification procedure:**

1. If a request passes the {{ iam-short-name }} check, the next step is the bucket policy check.
1. Bucket policy rules are checked in the following order:

   1. If the request meets at least one of the Deny rules, access is denied.
   1. If the request meets at least one of the Allow rules, access will be allowed.
   1. If the request does not meet any of the rules, access will be denied.

1. If the request fails the {{ iam-short-name }} or bucket policy check, access verification is performed based on an object's ACL.

In {{ iam-short-name }}, a bucket inherits the same access permissions as those of the folder and cloud where it is located. For more information, see [{#T}](../../../storage/concepts/acl.md#inheritance). Therefore, we recommend that you only assign the minimum required roles to certain buckets or objects in {{ objstorage-name }}.

Bucket policies are used for additional data protection, for example, to restrict access to a bucket by IP, issue granular permissions to objects, and so on.

With ACLs, you can grant access to an object bypassing {{ iam-short-name }} verification and bucket policies. We recommend setting strict ACLs for buckets.

 [Example of a secure {{ objstorage-name }} configuration: {{ TF }}](https://github.com/yandex-cloud-examples/yc-s3-secure-bucket)

{% list tabs group=instructions %}

- Performing a check in the management console {#console}

  1. In the management console, select the cloud or folder to check the buckets in.
  1. From the list of services, select **{{ objstorage-name }}**.
  1. Click the three dots next to each bucket and check its ACL for `allUsers` and `allAuthenticatedUsers`.
  1. Open the bucket and check the ACL of each of its objects for `allUsers` and `allAuthenticatedUsers`.
  1. Check that the object **Read access** section has the **Public** parameter enabled. Otherwise, proceed to "Guides and solutions to use".

- Performing a check via the CLI {#cli}

  1. [Configure](../../../storage/tools/aws-cli.md) the AWS CLI to work with a cloud.
  1. Run the command below to check the bucket ACL for `allUsers` and `allAuthenticatedUsers`:

     ```bash
     aws --endpoint-url=https://{{ s3-storage-host }} s3api get-bucket-acl  <name of your bucket>
     ```

{% endlist %}

**Guides and solutions to use:** 

If public access is enabled, [remove](../../../iam/operations/roles/revoke.md) it or perform access control (grant permission to access public data consciously).

#### 3.9 {{ objstorage-name }} uses bucket policies {#bucket-policy}

[Bucket policies](../../../storage/concepts/policy.md) set permissions for actions with buckets, objects, and object groups. A policy applies when a user makes a request to a resource. As a result, the request is either executed or rejected.

Bucket policy [examples](../../../storage/concepts/policy.md#config-examples):

* Policy that only enables object download from a specified range of IP addresses.
* Policy that prohibits downloading objects from the specified IP address.
* Policy that provides different users with full access only to certain folders, with each user being able to access their own.
* Policy that gives each user and service account full access to a folder named the same as the user ID or service account ID.

We recommend making sure that your {{ objstorage-name }} bucket uses at least one policy.

{% list tabs group=instructions %}

- Performing a check in the management console {#console}

  1. In the management console, select the cloud or folder to check the bucket policies in.
  1. In the list of services, select {{ objstorage-name }}.
  1. Go to **Bucket policy**.
  1. Make sure that at least one policy is enabled. Otherwise, proceed to "Guides and solutions to use".

- Performing a check via the CLI {#cli}

  1. [Configure](../../../storage/tools/aws-cli.md) the AWS CLI to work with a cloud.
  1. Run the command below to check the bucket ACL for `allUsers` and `allAuthenticatedUsers`:

     ```bash
     aws --endpoint-url=https://{{ s3-storage-host }} s3api get-bucket-policy --bucket <name of your bucket>
     ```

{% endlist %}

**Guides and solutions to use:**

[Enable](../../../storage/concepts/policy.md#config-examples) the required policy.

#### 3.10 The **Object lock** feature is enabled in {{ objstorage-name }} {#object-lock}

When processing critical data in buckets, you must ensure that data is protected from deletion and that versions are backed up. This can be achieved by versioning and lifecycle management mechanisms, as well as by using object locks.

Bucket versioning allows keeping a version history of an object. Each version is a complete copy of an object and occupies space in {{ objstorage-name }}. Using version control protects your data from both accidental user actions and application faults.

If you delete or modify an object with versioning enabled, the action will create a new object version with a new ID. In the case of deletion, the object becomes unreadable, but its version is kept and can be restored.

For more information about setting up versioning, see the {{ objstorage-name }} documentation, [Bucket versioning](../../../storage/concepts/versioning.md).

For more information about lifecycles, see the {{ objstorage-name }} documentation, [Bucket object lifecycles](../../../storage/concepts/lifecycles.md) and [Bucket object lifecycle configuration](../../../storage/s3/api-ref/lifecycles/xml-config.md).

In addition, to protect object versions against deletion, use [object locks](../../../storage/concepts/object-lock.md). For more information about object lock types and how to enable them, see the documentation.

The storage period of critical data in a bucket is determined by the customer's information security requirements and the information security standards. For example, the PCI DSS standard states that audit logs should be stored for at least one year and be available online for at least three months.

{% list tabs group=instructions %}

- Performing a check in the management console {#console}

  1. In the management console, select the cloud or folder to check the buckets in.
  1. From the list of services, select **{{ objstorage-name }}**.
  1. Open the settings of all buckets.
  1. Go to the **Versioning** tab and make sure it is enabled. Otherwise, proceed to "Guides and solutions to use".

- Performing a check via the CLI {#cli}

  1. [Configure](../../../storage/tools/aws-cli.md) the AWS CLI to work with a cloud.
  1. Run the command below to check whether versioning is enabled:

     ```bash
     aws --endpoint https://{{ s3-storage-host }} \
     s3api get-bucket-versioning \
     --bucket <name of your bucket>
     ```

  1. Run the command below to check whether versioning is enabled:

     ```bash
     aws --endpoint-url=https://{{ s3-storage-host }}/ \
     s3api get-object-lock-configuration \
     --bucket <name of your bucket>
     ```

{% endlist %}

**Guides and solutions to use:**

If public access is enabled, remove it or use access control (by only enabling it when necessary and if approved).

#### 3.11 Logging of actions with buckets is enabled in {{ objstorage-name }} {#bucket-logs}

When using {{ objstorage-name }} to store critical data, be sure to enable logging of actions with buckets. For more information, see the {{ objstorage-name }} documentation, [Logging actions with a bucket](../../../storage/concepts/server-logs.md).

This makes sure that data-plane logs with the following objects are written: PUT, DELETE, GET, POST, OPTIONS, HEAD.

You can request log data [writing](../../../audit-trails/concepts/events.md#objstorage) (except for bucket object read events) in {{ at-short-name }}. You can use the `traffic` metric in [{{ monitoring-short-name }}](../../../storage/metrics.md) to view the amount of outgoing traffic from the bucket. In the future, all logs will be written to {{ at-short-name }}.

You can also analyze {{ objstorage-name }} logs in {{ datalens-short-name }}. For more information, see [Analyzing {{ objstorage-name }} logs using {{ datalens-short-name }}](../../../tutorials/datalens/storage-logs-analysis.md).

**Guides and solutions to use:**

You can check if logging is enabled only via {{ TF }}/API by following [this guide](../../../storage/operations/buckets/enable-logging.md).

#### 3.12 Cross-Origin Resource Sharing (CORS) is configured in {{ objstorage-name }} {#cors}

If you need [cross-domain requests](https://en.wikipedia.org/wiki/Cross-origin_resource_sharing) to objects in buckets, you should configure the Cross-Origin Resource Sharing (CORS) policy in accordance with your corporate information security requirements. For more information, see the {{ objstorage-name }} documentation, [CORS configuration of buckets](../../../storage/s3/api-ref/cors/xml-config.md).

{% list tabs group=instructions %}

- Performing a check in the management console {#console}

  1. In the management console, select the cloud or folder to check the buckets in.
  1. From the list of services, select **{{ objstorage-name }}**.
  1. Open the settings of all buckets.
  1. Go to the **CORS** tab and make sure that the configuration is set up. Otherwise, proceed to "Guides and solutions to use".

{% endlist %}

**Guides and solutions to use:**

[Set up](../../../storage/s3/api-ref/cors/xml-config.md) CORS. 

#### 3.13 {{ sts-full-name }} is used to get access keys to {{ objstorage-name }} {#use-sts-for-storage-keys}

[{{ sts-full-name }}](../../../iam/concepts/authorization/sts.md): {{ iam-full-name }} component used to get _temporary access keys_ compatible with [AWS S3 API](../../../storage/s3/index.md).

Temporary access keys as an authentication method are only supported in [{{ objstorage-full-name }}](../../../storage/index.yaml).

With temporary keys, you can set up granular access to [buckets](../../../storage/concepts/bucket.md) for multiple users with a single [service account](../../../iam/concepts/users/service-accounts.md). The service account permissions must include all the permissions you want to grant using temporary keys.

A temporary access key is created based on a [static key](../../../iam/concepts/authorization/access-key.md), but, unlike it, it has a limited lifetime and access permissions. Access permissions and lifetime are set for each temporary key individually. The maximum key lifetime is 12 hours.

To set up access permissions for the key, you need an [access policy](../../../storage/security/policy.md) in JSON format based on [this schema](../../../storage/s3/api-ref/policy/scheme.md).

Temporary {{ sts-name }} keys inherit the access permissions of the service account but are limited by the access policy. If you set up a temporary key's access policy to allow operations not allowed for the service account, such operations will not be performed.

**Guides and solutions to use:**

[Create](../../../iam/operations/sa/create-sts-key.md) a temporary access key using {{ sts-name }}.

#### 3.14 Pre-signed URLs are generated for isolated cases of access to specific objects in {{ objstorage-name }} private buckets {#use-presigned-urls}

{{ objstorage-name }} incorporates several access management mechanisms. To learn how these mechanisms interact, see [{#T}](../../../storage/security/overview.md).

With pre-signed URLs, any web user can perform various operations in Object Storage, such as:
* Downloading an object
* Uploading an object
* Creating a bucket

[A pre-signed URL](../../../storage/concepts/pre-signed-urls.md) is a URL containing request authorization data in its parameters. Pre-signed URLs can be created by users with static access keys.

We recommend using pre-signed URLs to users who are not authorized in the [cloud](../../../resource-manager/concepts/resources-hierarchy.md#cloud) but need access to specific objects in the bucket. This way you follow the principle of least privilege and avoid opening access to all the objects in the bucket.

**Guides and solutions to use:**

[Create](../../../storage/concepts/pre-signed-urls.md#creating-presigned-url) a pre-signed URL and communicate it to the user.

### Managed Services for Databases {#managed-databases}

#### 3.15 A security group is assigned in managed databases {#db-security-group}

We recommend prohibiting internet access to databases that contain critical data, in particular PCI DSS data or private data. Configure security groups to only allow connections to the DBMS from particular IP addresses. To do this, follow the steps in [Creating a security group](../../../vpc/operations/security-group-create.md). You can specify a security group in the cluster settings or when creating the cluster in the network settings section.

{% list tabs group=instructions %}

- Performing a check in the management console {#console}

  1. In the management console, select the cloud or folder to check the databases in.
  1. In the list of services, select a service or services with managed databases.
  1. In the object settings, find the **Security group** parameter and make sure that at least one security group is assigned.
  1. If the parameters of each object have at least one security group set, the recommendation is fulfilled. Otherwise, proceed to "Guides and solutions to use".

- Performing a check via the CLI {#cli}

  1. Run the command below to search for Managed PostgreSQL DBs with no SG:

     ```bash
     export ORG_ID=<organization ID>
     for CLOUD_ID in $(yc resource-manager cloud list --organization-id=${ORG_ID} --format=json | jq -r '.[].id');
     do for FOLDER_ID in $(yc resource-manager folder list --cloud-id=$CLOUD_ID --format=json | jq -r '.[].id'); 
     do for DB_ID in $(yc managed-postgresql cluster list --folder-id=$FOLDER_ID --format=json | jq -r '.[].id'); do yc managed-postgresql cluster get --id=$DB_ID --format=json | jq -r '. | select(.security_group_ids | not)' | jq -r '.id' 
     done;
     done;
     done
     ```

  1. The output should return an empty string. Otherwise, proceed to "Guides and solutions to use".

- Checking if managed databases have SGs {#db-check}

  1. Run the command below to search for Managed MySQL DBs with no SG:

     ```bash
     export ORG_ID=<organization ID>
     for CLOUD_ID in $(yc resource-manager cloud list --organization-id=${ORG_ID} --format=json | jq -r '.[].id');
     do for FOLDER_ID in $(yc resource-manager folder list --cloud-id=$CLOUD_ID --format=json | jq -r '.[].id'); 
     do for DB_ID in $(yc managed-mysql cluster list --folder-id=$FOLDER_ID --format=json | jq -r '.[].id'); do yc managed-mysql cluster get --id=$DB_ID --format=json | jq -r '. | select(.security_group_ids | not)' | jq -r '.id' 
     done;
     done;
     done
     ```

  1. The output should return an empty string. Otherwise, proceed to "Guides and solutions to use".

{% endlist %}

**Guides and solutions to use:**

If any databases without security groups are found, assign them or enable the **Default security group** [functionality](../../../vpc/concepts/security-groups.md#default-security-group.md).

#### 3.16 No public IP address is assigned in managed databases {#db-ip}

Assigning a public IP to a managed database raises information security risks. We do not recommend assigning an external IP unless it is absolutely necessary.

{% list tabs group=instructions %}

- Performing a check in the management console {#console}

  1. In the management console, select the cloud or folder to check the databases in.
  1. In the list of services, select a service or services with managed databases.
  1. In the object settings, go to the **Hosts** tab.
  1. If the parameters of each object have the **Public access** option disabled, the recommendation is fulfilled. Otherwise, proceed to "Guides and solutions to use".

- Performing a check via the CLI {#cli}

  1. See what organizations are available to you and write down the ID you need:

     ```bash
     yc organization-manager organization list
     ```

  1. Run the command below to search for managed DB clusters with public IPs:

     ```bash
     export ORG_ID=<organization ID>
     for CLOUD_ID in $(yc resource-manager cloud list --organization-id=${ORG_ID} --format=json | jq -r '.[].id');
     do for FOLDER_ID in $(yc resource-manager folder list --cloud-id=$CLOUD_ID --format=json | jq -r '.[].id'); 
     do for DB_ID in $(yc managed-mysql cluster list --folder-id=$FOLDER_ID --format=json | jq -r '.[].id'); do yc managed-mysql hosts list --cluster-id=$DB_ID --format=json | jq -r '.[] | select(.assign_public_ip)' | jq -r '.cluster_id' 
     done;
     done;
     done
     ```

  1. If an empty string is output, the recommendation is fulfilled. Otherwise, proceed to "Guides and solutions to use".

{% endlist %}

**Guides and solutions to use:** 

Disable public access if it is not required.

#### 3.17 The deletion protection feature is enabled {#deletetion-protection}

In {{ yandex-cloud }} managed databases, you can enable deletion protection. The deletion protection feature safeguards the cluster against accidental deletion by a user. Even with cluster deletion protection enabled, one can still connect to the cluster manually and delete the data.

{% list tabs group=instructions %}

- Performing a check in the management console {#console}

  1. In the management console, select the cloud or folder to check the databases in.
  1. In the list of services, select a service or services with managed databases.
  1. In the object settings, go to the **Advanced settings** tab.
  1. If the parameters of each object have the **Deletion protection** option enabled, the recommendation is fulfilled. Otherwise, proceed to "Guides and solutions to use".

- Performing a check via the CLI {#cli}

  1. See what organizations are available to you and write down the ID you need:

     ```bash
     yc organization-manager organization list
     ```

  1. Run the command below to search for managed DB clusters with deletion protection disabled:

     ```bash
     export ORG_ID=<organization ID>
     for CLOUD_ID in $(yc resource-manager cloud list --organization-id=${ORG_ID} --format=json | jq -r '.[].id');
     do for FOLDER_ID in $(yc resource-manager folder list --cloud-id=$CLOUD_ID --format=json | jq -r '.[].id'); 
     do for DB_ID in $(yc managed-mysql cluster list --folder-id=$FOLDER_ID --format=json | jq -r '.[].id'); do yc managed-mysql cluster get --id=$DB_ID --format=json | jq -r '. | select(.deletion_protection | not)' | jq -r '.id' 
     done;
     done;
     done
     ```

  1. The output should return an empty string. Otherwise, proceed to "Guides and solutions to use".

{% endlist %}

**Guides and solutions to use:**

1. In the management console, select the cloud or folder to enable deletion protection in.
1. In the list of services, select a service or services with managed databases.
1. In the object settings, go to the **Advanced settings** tab.
1. In the object parameters, enable **Deletion protection**.

#### 3.18 The setting for access from {{ datalens-short-name }} is not active if not needed {#db-datalens-access}

Do not enable access to databases containing critical data from the management console, [{{ datalens-short-name }}](../../../datalens), or other services unless you have to. Access from {{ datalens-short-name }} may be required for data analysis and visualization. For such access, the {{ yandex-cloud }} service network is used, with authentication and TLS encryption. You can enable and disable access from {{ datalens-short-name }} or other services in the cluster settings or when creating it in the advanced settings section.

{% list tabs group=instructions %}

- Performing a check in the management console {#console}

  1. In the management console, select the cloud or folder to check the databases in.
  1. In the list of services, select a service or services with managed databases.
  1. In the object settings, go to the **Advanced settings** tab.
  1. If the parameters of each object have **Access from {{ datalens-short-name }}** disabled, the recommendation is fulfilled. Otherwise, proceed to "Guides and solutions to use".

- Performing a check via the CLI {#cli}

  1. See what organizations are available to you and write down the ID you need:

     ```bash
     yc organization-manager organization list
     ```

  1. Find managed DB clusters with enabled access from {{ datalens-short-name }}:

     ```bash
     export ORG_ID=<organization ID>
     for CLOUD_ID in $(yc resource-manager cloud list --organization-id=${ORG_ID} --format=json | jq -r '.[].id');
     do for FOLDER_ID in $(yc resource-manager folder list --cloud-id=$CLOUD_ID --format=json | jq -r '.[].id'); 
     do for DB_ID in $(yc managed-mysql cluster list --folder-id=$FOLDER_ID --format=json | jq -r '.[].id'); do yc managed-mysql cluster get --id=$DB_ID --format=json | jq -r '. | select(.config.access.data_lens)' | jq -r '.id' 
     done;
     done;
     done
     ```

  1. The output should return an empty string. Otherwise, proceed to "Guides and solutions to use".

{% endlist %}

**Guides and solutions to use:**

1. In the management console, select the cloud or folder to disable access from {{ datalens-short-name }} in.
1. In the list of services, select a service or services with managed databases.
1. In the object settings, go to the **Advanced settings** tab.
1. In the object parameters, disable **Access from {{ datalens-short-name }}**.

#### 3.19 Access from the management console is disabled in managed databases {#db-console-access}

You may need access to the database from the management console to send [SQL queries](../../../managed-postgresql/operations/web-sql-query.md) to the database and visualize the data structure.

We recommend that you enable this type of access only if needed, because it raises information security risks. In normal mode, use a standard DB connection as a DB user.

{% list tabs group=instructions %}

- Performing a check in the management console {#console}

  1. In the management console, select the cloud or folder to check the databases in.
  1. In the list of services, select a service or services with managed databases.
  1. In the object settings, go to the **Advanced settings** tab.
  1. If the parameters of each object have **Access from the management console** disabled, the recommendation is fulfilled. Otherwise, proceed to "Guides and solutions to use".

- Performing a check via the CLI {#cli}

  1. See what organizations are available to you and write down the ID you need:

     ```bash
     yc organization-manager organization list
     ```

  1. Run the command below to search for managed DB clusters with access from the management console enabled:

      {% cut "**Bash**" %}

      ```bash
      export ORG_ID=<organization_ID>

      # MySQL
      for CLOUD_ID in $(yc resource-manager cloud list --organization-id=${ORG_ID} --format=json | jq -r '.[].id');
      do for FOLDER_ID in $(yc resource-manager folder list --cloud-id=$CLOUD_ID --format=json | jq -r '.[].id'); 
      do yc managed-mysql cluster list --folder-id=$FOLDER_ID --format=json | jq -r '. | select(.config.access.web_sql)' | jq -r '.id' 
      done;
      done

      # PostgreSQL
      for CLOUD_ID in $(yc resource-manager cloud list --organization-id=${ORG_ID} --format=json | jq -r '.[].id');
      do for FOLDER_ID in $(yc resource-manager folder list --cloud-id=$CLOUD_ID --format=json | jq -r '.[].id'); 
      do yc managed-postgresql cluster list --folder-id=$FOLDER_ID --format=json | jq -r '. | select(.config.access.web_sql)' | jq -r '.id' 
      done;
      done

      # ClickHouse
      for CLOUD_ID in $(yc resource-manager cloud list --organization-id=${ORG_ID} --format=json | jq -r '.[].id');
      do for FOLDER_ID in $(yc resource-manager folder list --cloud-id=$CLOUD_ID --format=json | jq -r '.[].id'); 
      do yc managed-clickhouse cluster list --folder-id=$FOLDER_ID --format=json | jq -r '. | select(.config.access.web_sql)' | jq -r '.id' 
      done;
      done

      # Redis
      for CLOUD_ID in $(yc resource-manager cloud list --organization-id=${ORG_ID} --format=json | jq -r '.[].id');
      do for FOLDER_ID in $(yc resource-manager folder list --cloud-id=$CLOUD_ID --format=json | jq -r '.[].id'); 
      do yc managed-redis cluster list --folder-id=$FOLDER_ID --format=json | jq -r '. | select(.config.access.web_sql)' | jq -r '.id' 
      done;
      done

      # MongoDB
      for CLOUD_ID in $(yc resource-manager cloud list --organization-id=${ORG_ID} --format=json | jq -r '.[].id');
      do for FOLDER_ID in $(yc resource-manager folder list --cloud-id=$CLOUD_ID --format=json | jq -r '.[].id'); 
      do yc managed-mongodb cluster list --folder-id=$FOLDER_ID --format=json | jq -r '. | select(.config.access.web_sql)' | jq -r '.id' 
      done;
      done
      ```

      {% endcut %}

      {% cut "**PowerShell**" %}

      ```powershell
      $ORG_ID = "<organization_ID>"

      $Clouds = yc resource-manager cloud list --organization-id=${ORG_ID} --format=json | ConvertFrom-Json | Select @{n="CloudID";e={$_.id}}, created_at, @{n="CloudName";e={$_.name}}, organization_id

      $MDBClusters = @()

      foreach ($Cloud in $Clouds) {
          $Folders = yc resource-manager folder list --cloud-id $Cloud.CloudID --format=json | ConvertFrom-Json

          foreach($Folder in $Folders) {
              # Getting Postgre
              $MDBName = "Managed PostgreSQL"
              $MDBClusters += yc managed-postgresql cluster list --folder-id $Folder.id --format=json | ConvertFrom-Json | where {$_.config.access.web_sql -eq $True} | Select @{n="CloudID";e={$Cloud.CloudID}}, @{n="CloudName";e={$Cloud.CloudName}}, @{n="FolderID";e={$Folder.id}}, @{n="FolderName";e={$Folder.name}}, @{n="MDB";e={$MDBName}}, @{n="ClusterID";e={$_.id}}, @{n="ClusterName";e={$_.name}}, @{n="ClusterEnv";e={$_.environment}}, @{n="ClusterStatus";e={$_.status}}, network_id, health, @{n="WebSQLAccess";e={$_.config.access.web_sql}}

              # Getting MySQL
              $MDBName = "Managed MySQL"
              $MDBClusters += yc managed-mysql cluster list --folder-id $Folder.id --format=json | ConvertFrom-Json | where {$_.config.access.web_sql -eq $True} | Select @{n="CloudID";e={$Cloud.CloudID}}, @{n="CloudName";e={$Cloud.CloudName}}, @{n="FolderID";e={$Folder.id}}, @{n="FolderName";e={$Folder.name}}, @{n="MDB";e={$MDBName}}, @{n="ClusterID";e={$_.id}}, @{n="ClusterName";e={$_.name}}, @{n="ClusterEnv";e={$_.environment}}, @{n="ClusterStatus";e={$_.status}}, network_id, health, @{n="WebSQLAccess";e={$_.config.access.web_sql}}

              # Getting ClickHouse
              $MDBName = "Managed ClickHouse"
              $MDBClusters += yc managed-clickhouse cluster list --folder-id $Folder.id --format=json | ConvertFrom-Json | where {$_.config.access.web_sql -eq $True} | Select @{n="CloudID";e={$Cloud.CloudID}}, @{n="CloudName";e={$Cloud.CloudName}}, @{n="FolderID";e={$Folder.id}}, @{n="FolderName";e={$Folder.name}}, @{n="MDB";e={$MDBName}}, @{n="ClusterID";e={$_.id}}, @{n="ClusterName";e={$_.name}}, @{n="ClusterEnv";e={$_.environment}}, @{n="ClusterStatus";e={$_.status}}, network_id, health, @{n="WebSQLAccess";e={$_.config.access.web_sql}} 

              # Getting Redis
              $MDBName = "Managed Redis"
              $MDBClusters += yc managed-redis cluster list --folder-id $Folder.id --format=json | ConvertFrom-Json | where {$_.config.access.web_sql -eq $True} | Select @{n="CloudID";e={$Cloud.CloudID}}, @{n="CloudName";e={$Cloud.CloudName}}, @{n="FolderID";e={$Folder.id}}, @{n="FolderName";e={$Folder.name}}, @{n="MDB";e={$MDBName}}, @{n="ClusterID";e={$_.id}}, @{n="ClusterName";e={$_.name}}, @{n="ClusterEnv";e={$_.environment}}, @{n="ClusterStatus";e={$_.status}}, network_id, health, @{n="WebSQLAccess";e={$_.config.access.web_sql}} 

              # Getting MongoDB
              $MDBName = "Managed MongoDB"
              $MDBClusters += yc managed-mongodb cluster list --folder-id $Folder.id --format=json | ConvertFrom-Json | where {$_.config.access.web_sql -eq $True} | Select @{n="CloudID";e={$Cloud.CloudID}}, @{n="CloudName";e={$Cloud.CloudName}}, @{n="FolderID";e={$Folder.id}}, @{n="FolderName";e={$Folder.name}}, @{n="MDB";e={$MDBName}}, @{n="ClusterID";e={$_.id}}, @{n="ClusterName";e={$_.name}}, @{n="ClusterEnv";e={$_.environment}}, @{n="ClusterStatus";e={$_.status}}, network_id, health, @{n="WebSQLAccess";e={$_.config.access.web_sql}} 
          }
      }

      $MDBClusters
      ```

      {% endcut %}

  1. If an empty string is output, the recommendation is fulfilled. Otherwise, proceed to "Guides and solutions to use".

{% endlist %}

**Guides and solutions to use:** 

1. In the management console, select the cloud or folder to disable access from the management console in.
1. In the list of services, select a service or services with managed databases.
1. In the object settings, go to the **Advanced settings** tab.
1. In the object parameters, disable **Access from console**.

### {{ sf-full-name }} {#functions}

#### 3.20 {{ serverless-containers-short-name }}/{{ sf-name }} uses the {{ vpc-short-name }} internal network {#vpc-functions}

By default, the function is launched in the isolated IPv4 network with the enabled NAT gateway. For this reason, only public IPv4 addresses are available. You cannot fix the address.

Networking between two functions, as well as between functions and user resources, is limited:

* Incoming connections are not supported. For example, you cannot access the internal components of a function over the network, even if you know the IP address of its instance.
* Outgoing connections are supported via TCP, UDP, and ICMP. For example, a function can access a {{ compute-full-name }} VM or a {{ ydb-full-name }} DB on the user's network.
* Function is cross-zoned: you cannot explicitly specify a subnet or select an availability zone to run a function.

If necessary, you can specify a cloud network in the function settings. In which case:

* The function will be executed in the specified cloud network. 
* While being executed, the function will get an IP address in the relevant subnet and access to all the network resources.
* The function will have access not only to the internet but also to user resources located in the specified network, such as databases, virtual machines, etc. 
* The function will have an IP address within the `198.19.0.0/16` range when accessing user resources.

You can only specify a single network for functions, containers, and API gateways that reside in the same cloud. 

{% list tabs group=instructions %}

- Performing a check in the management console {#console}

  1. In the management console, select the cloud or folder to check the functions in.
  1. In the list of services, select {{ sf-name }}.
  1. Open all the functions.
  1. In the object settings, go to the **Edit function version** tab.
  1. If the parameters of each object have **Network — {{ vpc-short-name }}** set, the recommendation is fulfilled. Otherwise, proceed to "Guides and solutions to use".

- Performing a check via the CLI {#cli}

  1. Run the command below to search for any cloud functions that have no network settings specified in {{ vpc-short-name }}:

     ```bash
     export ORG_ID=<organization ID>
     for CLOUD_ID in $(yc resource-manager cloud list --organization-id=${ORG_ID} --format=json | jq -r '.[].id');
     do for FOLDER_ID in $(yc resource-manager folder list --cloud-id=$CLOUD_ID --format=json | jq -r '.[].id'); 
     do for VER in $(yc serverless function version list --folder-id=$FOLDER_ID --format=json | jq -r '.[].id'); \
     do yc serverless function version get $VER --format=json | jq -r '. | select(.connectivity.network_id | not)' | jq -r '.id' 
     done;
     done;
     done
     ```

  1. If an empty string is output, the recommendation is fulfilled. Otherwise, proceed to "Guides and solutions to use".

{% endlist %}

**Guides and solutions to use:** 

1. Select the cloud or folder to check the functions in.
1. Select **{{ sf-name }}** in the list of services.
1. Open the function.
1. In the object settings, go to the **Edit function version** tab.
1. Set **Network — {{ vpc-short-name }}**.

For more information about tracking function versions, see [{#T}](../../../functions/concepts/backup.md).

#### 3.21 Functions are configured in terms of access control, secret and environment variable management, and DBMS connection {#function-access-and-env}

In cases where the use of public functions is not explicitly required, we recommend that you use private functions. For more information about setting up access to functions, see [Managing function access permissions](../../../functions/operations/function/function-public.md). We recommend using private functions and assigning rights to invoke functions to specific cloud users.

A [service account](../../../iam/concepts/users/service-accounts.md) is an account that can be used by programs or functions to manage resources in {{ yandex-cloud }}. If the function version was created with a service account, you can [get](../../../functions/operations/function-sa.md) an IAM token for service account from the function invocation context.

Make sure to assign [roles](../../../iam/concepts/access-control/roles.md) to the service account. A role is a set of permissions to perform operations with the cloud's resources. A function automatically inherits roles assigned for a folder, cloud, or organization. However, they do not appear in the list of assigned roles.

Do not store secrets and sensitive data in the function code and environment variables. Use [{{ lockbox-full-name }}](../../../lockbox/index.yaml) to store and rotate secrets. You can transmit a {{ lockbox-name }} secret to a function in the environment variable.

For the function to get access to the secret, edit its parameters to specify a service account with the following roles assigned:

* `lockbox.payloadViewer` [for a secret](../../../lockbox/operations/secret-access.md).
* `kms.keys.encrypterDecrypter` [for an encryption key](../../../kms/operations/key-access.md) if the secret was created using a [{{ kms-full-name }}](../../../kms/index.yaml) encryption key.

A {{ lockbox-name }} secret provided to a function is cached in {{ sf-name }}. After you revoke a service account's access to a secret, the function may continue to store the secret for up to 5 minutes.

Transmitting secrets creates a new function version. You cannot transmit secrets to an existing function version. 

You can add other environment variables when creating a function version. The maximum size of environment variables, including their names, is limited to 4 KB.

You cannot calculate environment variables. Environment variable values are string constants. You can only calculate these within function code. You can retrieve environment variables using standard programming language tools.

You can access the DB cluster hosts from the function only via the [SSL protocol](https://ru.wikipedia.org/wiki/SSL), with the help of a [DB connection](../../../functions/operations/database-connection.md#connect), or by specifying a cloud network in the function settings. Use a service account with a role assigned and enable access for functions on the DBMS side.

**Guides and solutions to use:**

* [Disable](../../../functions/operations/function/function-private.md) public access to a function.
* [View](../../../functions/operations/function/role-list.md) a list of roles assigned to a function.
* [Get](../../../functions/operations/function-sa.md) a service account IAM token using a function.
* [Revoke](../../../functions/operations/function/role-revoke.md) a role assigned to a function.
* [Connect](../../../functions/operations/database-connection.md) to a database from a function.

For more information about roles and resources you can assign roles for in {{ sf-name }}, see [{#T}](../../../functions/security/index.md).

#### 3.22 Aspects of time synchronization in {{ sf-name }} are addressed {#ntp-functions}

{{ sf-name }} does not guarantee time synchronization prior to or during execution of requests by functions. To get a function log with exact timestamps on the {{ sf-name }} side, use a cloud logging service. For more information on function logging, see [{#T}](../../../functions/concepts/logs.md).

#### 3.23 Aspects of header management in {{ sf-name }} are addressed {#http-functions}

If the function is called to process an HTTP request, the returned result should be a JSON document containing the HTTP response code, response headers, and response content. {{ sf-name }} automatically processes this JSON document and returns data in a standard HTTP response to the user. It is the customer's responsibility to manage the response headers according to the regulatory requirements and the threat model. For more information on how to process an HTTP request, refer to the {{ sf-name }} manual, [Invoking a function in {{ sf-name }}](../../../functions/concepts/function-invoke.md).

You can run a function by specifying the `?integration=raw` string query parameter. When invoked this way, a function cannot parse or set HTTP headers:

* HTTPS request body content is provided as the first argument (without converting to a JSON structure).
* HTTPS request body content is the same as the function's response (without converting and checking the structure); the HTTP response status is `200`.

The request must be a JSON structure which contains:

* `httpMethod`: HTTP method: `DELETE`, `GET`, `HEAD`, `OPTIONS`, `PATCH`, `POST`, or `PUT`.
* `headers`: Dictionary of strings with HTTP request headers and their values. If the same header is provided multiple times, the dictionary contains the last provided value.
* `multiValueHeaders`: Dictionary with HTTP request headers and lists of their values. It contains the same keys as the `headers` dictionary; however, if any of the headers was repeated multiple times, its list will contain all the values provided for this header. If the header was provided only once, it gets included into this dictionary and its list will contain only one value.
* `queryStringParameters`: Dictionary with the query parameters. If the same parameter is specified multiple times, the dictionary will contain the last specified value.
* `multiValueQueryStringParameters`: Dictionary with the list of all specified values for each query parameter. If the same parameter is specified multiple times, the dictionary will contain all the specified values.
* `requestContext`: Request context.

For the purpose of debugging a function, you can use special requests that return the JSON structure of the request and the result you need for debugging. For more information, see [function debugging](../../../functions/concepts/function-invoke.md#example).

### {{ ydb-name }} {#ydb-access}

#### 3.24 Recommendations for using confidential data in {{ ydb-short-name }} are followed {#ydb-confidential-data}

It is prohibited to use confidential data for names of databases, tables, columns, folders, and so on. Do not send critical data, e.g., payment card details, to {{ ydb-name }} (both Dedicated and Serverless) in plain text. Prior to sending data, be sure to encrypt it at the application level. For this you can use the KMS service or any other method compliant with the regulator standard. For data where the storage period is known in advance, we recommend that you configure the [Time To Live]({{ ydb.docs }}/concepts/ttl) option.

#### 3.25 Recommendations for SQL injection protection in {{ ydb-short-name }} are followed {#ydb-sql-injection}

When working with the database, use [parameterized prepared statements]({{ ydb.docs }}/reference/ydb-sdk/example/#param-queries) to protect against SQL injection. If the application dynamically generates query templates, you must prevent the injection of untrusted user input into the SQL query template.

#### 3.26 There is no public access for {{ ydb-short-name }} {#ydb-public}

When accessing the database in dedicated mode, we recommend that you use it inside {{ vpc-short-name }} and disable public access to it from the internet. In serverless mode, the database can be accessed from the internet. You must therefore take this into account when modeling threats to your infrastructure. For more information about the operating modes, see the [Serverless and dedicated modes](../../../ydb/concepts/serverless-and-dedicated.md) section in the {{ ydb-name }} documentation.

When setting up database permissions, use the principle of least privilege.

{% list tabs group=instructions %}

- Performing a check in the management console {#console}

  1. In the management console, select the cloud or folder to check the database in. 
  1. In the list of services, select **{{ ydb-name }}**.
  1. Open all the databases.
  1. In the database settings, go to the **Network** tab.
  1. If the parameters of each object have the **Public IP addresses** option disabled, the recommendation is fulfilled. Otherwise, proceed to "Guides and solutions to use".

- Performing a check via the CLI {#cli}

  1. See what organizations are available to you and write down the ID you need:

     ```bash
     yc organization-manager organization list
     ```

  1. Run the command below to search for managed DB clusters with public IPs:

     ```bash
     export ORG_ID=<organization ID>
     for CLOUD_ID in $(yc resource-manager cloud list --organization-id=${ORG_ID} --format=json | jq -r '.[].id');
     do for FOLDER_ID in $(yc resource-manager folder list --cloud-id=$CLOUD_ID --format=json | jq -r '.[].id'); 
     do for DB_ID in $(yc managed-mysql cluster list --folder-id=$FOLDER_ID --format=json | jq -r '.[].id'); do yc managed-mysql hosts list --cluster-id=$DB_ID --format=json | jq -r '.[] | select(.assign_public_ip)' | jq -r '.cluster_id' 
     done;
     done;
     done
     ```

  1. The output should return an empty string. Otherwise, proceed to "Guides and solutions to use".

{% endlist %}

**Guides and solutions to use:** 

Disable public access if it is not required.

#### 3.27 {{ ydb-short-name }} backup recommendations are followed {#ydb-backup}

When creating [on-demand backups](../../../ydb/pricing/serverless.md), make sure that the backup data is properly protected.

When creating backups on demand in {{ objstorage-name }}, follow the recommendations in the {{ objstorage-name }} subsection above (for example, use the built-in bucket encryption feature).

### {{ container-registry-full-name }} {#container-registry}

#### 3.28 ACL by IP address is set up for {{ container-registry-full-name }} {#acl-container-registry}

We recommend that you limit access to your {{ container-registry-short-name }} to specific IPs.

{% list tabs group=instructions %}

- Performing a check in the management console {#console}

  1. In the management console, select the cloud or folder to check the registry in.
  1. In the list of services, select **{{ container-registry-short-name }}**.
  1. In the settings of the specific registry, go to the **Access for IP address** tab.
  1. If specific IPs to allow access for are set in the parameters, the recommendation is fulfilled. Otherwise, proceed to "Guides and solutions to use".

- Performing a check via the CLI {#cli}

  1. See what organizations are available to you and write down the ID you need:

     ```bash
     yc organization-manager organization list
     ```

  1. Run the command below to search for CRs that are not filtered by IP:

      {% cut "**Bash**" %}

      ```bash
      export ORG_ID=<organization_ID>
      for CLOUD_ID in $(yc resource-manager cloud list --organization-id=${ORG_ID} --format=json | jq -r '.[].id');
      do for FOLDER_ID in $(yc resource-manager folder list --cloud-id=$CLOUD_ID --format=json | jq -r '.[].id'); 
      do for CR in $(yc container registry list --folder-id=$FOLDER_ID --format=json | jq -r '.[].id'); do yc container registry list-ip-permissions --id=$CR --format=json | jq -r '.[] | select(.ip)' | jq -r '.action' && echo $CR "IF ACTION PULL/PUSH exist before CR then OK"
      done;
      done;
      done
      ```

      {% endcut %}

      {% cut "**PowerShell**" %}

      ```powershell
      $ORG_ID = "<organization_ID>"

      $Clouds = yc resource-manager cloud list --organization-id $ORG_ID --format=json | ConvertFrom-Json | Select @{n="CloudID";e={$_.id}}, created_at, @{n="CloudName";e={$_.name}}, organization_id

      $CRIPPermissions = @()

      foreach ($Cloud in $Clouds) {
        $Folders = yc resource-manager folder list --cloud-id $Cloud.CloudID --format=json | ConvertFrom-Json

        foreach($Folder in $Folders) {
          $CRList = yc container registry list --folder-id $Folder.id --format=json | ConvertFrom-Json

          if($CRList) {
            foreach($CR in $CRList) {
              $IPPermissions = yc container registry list-ip-permissions --id $CR.id --format=json | ConvertFrom-Json

              if($IPPermissions) {
                $CRIPPermissions += $CR | Select @{n="CloudID";e={$Cloud.CloudID}}, @{n="CloudName";e={$Cloud.CloudName}}, @{n="FolderID";e={$Folder.id}}, @{n="FolderName";e={$Folder.name}}, @{n="CRID";e={$_.id}}, @{n="CRName";e={$_.name}}, @{n="CRStatus";e={$_.status}},@{n="Lables";e={$_.labels}},@{n="IPPermissionsList";e={$IPPermissions}}
              }
            }
          }
        }
      }

      $CRIPPermissions
      ```

      {% endcut %}

  1. If PULL/PUSH is output before each registry ID, the recommendation is fulfilled. Otherwise, proceed to "Guides and solutions to use".

{% endlist %}

**Guides and solutions to use:**

Specify the IP addresses for registry access.

#### 3.29 Requirements for application protection in {{ container-registry-full-name }} are met {#app-container-registry}

##### 3.29.1. Docker images are scanned when uploaded to {{ container-registry-full-name }} {#upload-policy}

{% include [scan-docker-upload.md](scan-docker-upload.md) %}

**Guides and solutions to use:**

[Guide on scanning Docker images on push](../../../container-registry/operations/scanning-docker-image.md#automatically).

##### 3.29.2 Docker images stored in {{ container-registry-name }} are regularly scanned {#periodic-scan}

{% include [scan-docker-periodic](scan-docker-periodic.md) %}

##### 3.29.3 Artifact integrity is ensured {#pipeline-artifacts-cosign}

{% include [artifacts-cosign](artifacts-cosign.md) %}

### {{ cos-full-name }} {#container-solution}

#### 3.30 Privileged containers are not used in {{ cos-full-name }} {#vip-containers}

We do not recommend that you use privileged containers to run loads that process untrusted user input. Privileged containers should be used for the purposes of administering VMs or other containers.

{% list tabs group=instructions %}

- Performing a check in the management console {#console}

  1. In the management console, select the cloud or folder to check the VMs in.
  1. In the list of services, select **{{ compute-short-name }}**.
  1. Open the settings of a specific VM with a **Container Optimized Image**.
  1. In the Docker container's **Settings**, find the **Privileged mode** parameter.
  1. If it is disabled, the recommendation is fulfilled. Otherwise, proceed to "Guides and solutions to use".

- Performing a check via the CLI {#cli}

  1. See what organizations are available to you and write down the ID you need:

     ```bash
     yc organization-manager organization list
     ```

  1. Run the command below to search for CRs that are not filtered by IP:

     ```bash
     export ORG_ID=<organization ID>
     for CLOUD_ID in $(yc resource-manager cloud list --organization-id=${ORG_ID} --format=json | jq -r '.[].id');
     do for FOLDER_ID in $(yc resource-manager folder list --cloud-id=$CLOUD_ID --format=json | jq -r '.[].id'); 
     do for VM_ID in $(yc compute instance list --folder-id=$FOLDER_ID --format=json | jq -r '.[].id'); \
     do yc compute instance get --id=$VM_ID --full --format=json | jq -r '. | select(.metadata."docker-container-declaration")| .metadata."docker-container-declaration" | match("privileged: true") | .string' && echo $VM_ID
     done;
     done;
     done
     ```

  1. If there is no `privileged: true` in front of each VM ID, the recommendation is fulfilled. Otherwise, proceed to "Guides and solutions to use".

{% endlist %}

**Guides and solutions to use:**

1. In the management console, select the cloud or folder to check the VMs in.
1. In the list of services, select **{{ compute-short-name }}**.
1. Open the settings of a specific VM with a **Container Optimized Image**.
1. In the Docker container's Settings, disable the **Privileged mode** parameter.

#### 3.31 The {{ certificate-manager-full-name }} certificate is valid for at least 30 days {#certificate-validity}

You can use {{ certificate-manager-full-name }} to manage TLS certificates for your API gateways in the API Gateway, as well as your websites and buckets in {{ objstorage-name }}. {{ alb-name }} is integrated with {{ certificate-manager-short-name }} for storing and installing certificates. We recommend that you use {{ certificate-manager-short-name }} to obtain your certificates and rotate them automatically.

When using TLS in your application, we recommend that you limit the list of your trusted root certificate authorities (root CA).

When using certificate pinning, keep in mind that Let's Encrypt certificates are [valid for 90 days](https://letsencrypt.org/docs/faq/#what-is-the-lifetime-for-let-s-encrypt-certificates-for-how-long-are-they-valid).

We recommend that you update certificates in advance if they are not [updated automatically](../../../certificate-manager/concepts/challenges.md#auto).

{% list tabs group=instructions %}

- Performing a check in the management console {#console}

  1. In the management console, select the cloud or folder to check the VMs in.
  1. In the list of services, select **{{ certificate-manager-full-name }}**.
  1. Open the settings of each certificate and find the **End date** parameter.
  1. If the parameter shows that the certificate will be valid for at least 30 days more, the recommendation is fulfilled. Otherwise, proceed to "Guides and solutions to use".

- Performing a check via the CLI {#cli}

  1. See what organizations are available to you and write down the ID you need:

     ```bash
     yc organization-manager organization list
     ```

  1. Search for any of your organization's certificates with the end date:

     ```bash
     export ORG_ID=<organization ID>
     for CLOUD_ID in $(yc resource-manager cloud list --organization-id=${ORG_ID} --format=json | jq -r '.[].id');
     do for FOLDER_ID in $(yc resource-manager folder list --cloud-id=$CLOUD_ID --format=json | jq -r '.[].id'); 
     do for CERT_ID in $(yc certificate-manager certificate list --folder-id=$FOLDER_ID --format=json | jq -r '.[].id'); \
     do yc certificate-manager certificate get --id $CERT_ID --format=json | jq -r '. | "Date of the end " + .not_after + " --- Cert_ID " + .id'
     done;
     done;
     done
     ```

  1. If there is no `privileged: true` in front of each VM ID, the recommendation is fulfilled. Otherwise, proceed to "Guides and solutions to use".

{% endlist %}

**Guides and solutions to use:**

Update the certificate or set up auto updates.

### {{ mgl-full-name }} {#git-lab-service}

#### 3.32 {{ GL }} instance security setup guidelines are followed {#git-lab-secure}

See the recommendations [here](../../../managed-gitlab/concepts/security.md#secure-instance). 

{% list tabs group=instructions %}

- Manual check {#manual}

  Run a manual check.

{% endlist %}

#### 3.33 Requirements for application protection in {{ GL }} are met {#gl-app-container-registry}

##### 3.33.1 Protected secure pipeline templates are used {#pipeline-blocks}

When working with {{ mgl-name }}, make sure you use built-in GitLab security mechanisms to secure your pipeline. You can integrate a pipeline into your projects in the [following ways](../../../managed-gitlab/concepts/security.md#security-pipeline-usage):

* Creating a pipeline in an individual project and connecting it to other projects using the [`include`](https://docs.gitlab.com/ee/ci/yaml/includes.html) function. This option is available for all license types.
* Using the [`Compliance framework and pipeline`](https://docs.gitlab.com/ee/user/project/settings/index.html#compliance-frameworks) mechanism that you can run in any group project. It is available for the `Ultimate` license.
* Copying pipeline sections to `.gitlab-ci.yml` files in your projects.

##### 3.33.2 Approval rules are configured {#setup-code-review}

With [{{ mgl-full-name }}](../../../managed-gitlab/index.yaml), you can flexibly set up required [approval rules](../../../managed-gitlab/concepts/approval-rules.md) before the code can be added to the target project branch. This feature is an alternative to the GitLab Enterprise Edition’s [Approval Rules](https://docs.gitlab.com/ee/user/project/merge_requests/approvals/rules.html) tool and is available regardless of the GitLab [version](https://about.gitlab.com/pricing).

If a [{{ GL }} instance](../../../managed-gitlab/concepts/index.md#instance) has the approval rules enabled, {{ mgl-name }} analyzes approvals from reviewers for compliance with the specified rules. If there are not enough approvals, a thread is created in a merge request that blocks it from being merged to the target branch. Editing the merge request creates or updates a comment in the thread with its current compliance status. Once all the required approvals are obtained, the thread is closed.

If you close a thread manually, it will be created again. If a merge request is approved regardless of the existing rules, users with the `Maintainer` role or higher will receive an email notification about the violated code approval workflow.

{% list tabs group=instructions %}

- Performing a check in the management console {#console}

  1. In the [management console]({{ link-console-main }}), select the [folder](../../../resource-manager/concepts/resources-hierarchy.md#folder) where your {{ GL }} instance is located.
  1. In the list of services, select **{{ ui-key.yacloud.iam.folder.dashboard.label_managed-gitlab }}**.
  1. Select the instance you need and click **{{ ui-key.yacloud.common.edit }}** in the top-right corner of the page.
  1. Make sure to select a configured approval rule [configuration](../../../managed-gitlab/concepts/approval-rules.md#packages) in the **{{ ui-key.yacloud.gitlab.field_approval-rules }}** field.

{% endlist %}

**Guides and solutions to use:**

[Enabling approval rules in the {{ GL }} instance](../../../managed-gitlab/operations/approval-rules.md#enable)

#### 3.34 {{ managed-k8s-full-name }} security guidelines are used {#k8s-security}

Check the recommendations in [{#T}](../../../security/standard/kubernetes-security.md).

#### 3.35 {{ oslogin }} is used for connection to a VM or {{ k8s }} node {#os-login-onto-hosts}

[{{ oslogin }}](../../../organization/concepts/os-login.md) is a convenient way to manage connections to {{ managed-k8s-full-name }} [VMs](../../../compute/concepts/vm.md) and [cluster](../../../managed-kubernetes/concepts/index.md#kubernetes-cluster) nodes over SSH via the [CLI](../../../cli/quickstart.md) or a standard SSH client with an SSH certificate or SSH key, which you first need to add to the {{ oslogin }} profile of organization user or [service account](../../../iam/concepts/users/service-accounts.md) in {{ org-full-name }}.

{{ oslogin }} links the account of a virtual machine or {{ k8s }} node user with that of an organization or service account user. To manage access to virtual machines and {{ k8s }} nodes, [enable](../../../organization/operations/os-login-access.md) the OS Login access option at the organization level and then [activate](../../../compute/operations/vm-connect/enable-os-login.md) {{ oslogin }} access on each virtual machine or {{ k8s }} node separately.

Thus, you can easily manage access to virtual machines and {{ k8s }} nodes by assigning appropriate roles to users or service accounts. If you revoke the roles from a user or service account, they will lose access to all virtual machines and {{ k8s }} nodes with {{ oslogin }} access enabled.

**Guides and solutions to use:**

* [Enabling {{ oslogin }} access at the organization level](../../../organization/operations/os-login-access.md).
* [Setting up {{ oslogin }} access on an existing VM](../../../compute/operations/vm-connect/enable-os-login.md).
* [Connect to the virtual machine via {{ oslogin }}](../../../compute/operations/vm-connect/os-login.md).
* [Connecting to a {{ k8s }} node via {{ oslogin }}](../../../managed-kubernetes/operations/node-connect-oslogin.md).

#### 3.36 Vulnerability scanning is performed at the cloud IP level {#ip-level}

We recommend that customers should scan their hosts for vulnerabilities by themselves. Cloud resources support the installation of custom virtual images of vulnerability scanners or software agents on hosts. There are many paid and free scanning solutions on the market.

Network scanners scan hosts that are accessible over a network. Generally, authentication can be configured on network scanners. 

Examples of free network scanners:
- [Nmap](https://nmap.org/)
- [OpenVAS](https://www.openvas.org/)
- [OWASP ZAP](https://www.zaproxy.org/)

Example of a free scanner operating as an agent on hosts: [Wazuh](https://documentation.wazuh.com/current/user-manual/capabilities/vulnerability-detection/how_it_works.html). Wazuh can also be used as a host-based intrusion detection system (IDS).

You can also use a [solution](/marketplace/products/scanfactory/scanfactory-saas) from {{ marketplace-name }}.

{% list tabs group=instructions %}

- Manual check {#manual}

  Run a manual check.

{% endlist %}

#### 3.37 External security scans are performed according to the {{ yandex-cloud }} rules {#external-security-scans}

Customers hosting their own software in {{ yandex-cloud }} can perform external security scans for the hosted software, including penetration tests. You can run your own scans or use contractors. For more information, see [Rules for performing external security scans](../../../security/compliance/pentest.md).

{% list tabs group=instructions %}

- Manual check {#manual}

  Run a manual check.

{% endlist %}

#### 3.38 The security updates process has been set up {#security-updates}

Customers must perform security updates themselves within their [scope of responsibility](../../../security/respons.md). Various automated tools are available for centralized automated OS and software updates.

{{ yandex-cloud }} publishes [security bulletins](../../../security/security-bulletins/index.md) to notify customers of newly discovered vulnerabilities and security updates.

### Backups {#backup}

#### 3.39 {{ backup-short-name }} or scheduled snapshots are used {#snapshot}

Make sure to back up all VMs in your organization using one of these options:
* Scheduled snapshots
* {{ backup-short-name }}

{% list tabs group=instructions %}

- Performing a check in the management console {#console}

  1. In the management console, select the cloud or folder to check the VMs in.
  1. In the list of services, select {{ compute-short-name }}.
  1. Make sure that the scheduled snapshot policy is set up on the VMs.
  1. In the list of services, select {{ backup-short-name }}.
  1. Make sure that it is enabled.

{% endlist %}


### {{ api-gw-full-name }} {#api-gateway}

An API gateway is an interface for working with services in {{ yandex-cloud }} or on the internet. A gateway is specified declaratively using [OpenAPI 3.0](https://www.openapis.org/what-is-openapi) specifications.


#### 3.40 Access management in {{ api-gw-name }} is configured {#api-gateway-access-managment}

{{ yandex-cloud }} users can only perform operations on resources that are allowed by the roles assigned to them. With no roles assigned, a user cannot perform most operations.

[{{ iam-full-name }}](../../../iam/) checks all operations in {{ yandex-cloud }}. If an entity does not have required permissions, {{ iam-short-name }} returns an error.

Make sure that the {{ yandex-cloud }} user has access to the [{{ api-gw-name }}](../../../api-gateway/concepts/index.md) resources. The user needs proper roles for it. Roles for an API gateway can be issued by users with the `api-gateway.admin` role or one of the following roles:

{% include [roles-list](../../../_includes/iam/roles-list.md) %}

{% list tabs group=instructions %}

- Performing a check in the management console {#console}

  1. In the management console, select the cloud and folder to check the API gateway access in.
  1. Click the **Access permissions** tab.
  1. Make sure that users have the roles required to access the gateway.

{% endlist %}

You can also assign a role for an API gateway via the {{ yandex-cloud }} [CLI](../../../cli/cli-ref/serverless/cli-ref/api-gateway/add-access-binding.md) or [API](../../../api-gateway/api-ref/apigateway/authentication.md).

To learn more about roles in {{ api-gw-name }}, see [{#T}](../../../api-gateway/security/index.md#roles-list).


#### 3.41 Networking is configured in {{ api-gw-name }} {#networking}

By default, an API gateway resides in an isolated IPv4 network with a [NAT gateway](../../../vpc/concepts/gateways.md) enabled. For this reason, it can only access public IPv4 addresses.

For the gateway to have access not just to the internet but to the user resources as well, [specify](../../../api-gateway/operations/api-gw-network-add.md) the [cloud network](../../../vpc/concepts/network.md#network) those resources reside in in the API gateway settings.

{% include [network](../../../_includes/functions/network.md) %}

If you specify a network in the API gateway settings, this will create an auxiliary subnet with addresses from the `198.19.0.0/16` range in each availability zone. The API gateway will get an IP address from the respective subnet and will have access to all network resources.

{% include [network](../../../_includes/functions/network-note.md) %}

{% list tabs group=instructions %}

- Performing a check in the management console {#console}

  1. In the management console, select the folder containing the API gateway.
  1. From the list of services, select **{{ api-gw-name }}**.
  1. Select the API gateway you need from the list.
  1. Make sure the cloud network is specified in the **Overview** section.

{% endlist %}

**Guides and solutions to use:** 

If the API gateway does not require access to resources from the specified cloud network, delete it from the gateway settings. To learn more, see [{#T}](../../../api-gateway/operations/api-gw-update.md).

#### 3.42 Recommendations for using custom domains are followed {#using-own-domain}

{{ api-gw-short-name }} is integrated with the {{ certificate-manager-short-name }} domain management system.

If you are using your own domains in {{ api-gw-short-name }} with confirmed permissions when accessing the API:

* Regularly [check the validity](../../../certificate-manager/operations/managed/cert-update.md) of the TLS certificate linked to your domain.
* Use [TLS](../../../storage/concepts/tls.md) version 1.2 or higher.
* Use [additional protection tools](../../../api-gateway/concepts/extensions/), such as intrusion detection and DDoS protection systems.

{% list tabs group=instructions %}

- Manual check {#manual}

  Run a manual check of the TLS version and the validity of the TLS connection certificate.

{% endlist %}

For more information about domains, see [{#T}](../../../certificate-manager/concepts/domains/services.md).

#### 3.43 Recommendations for using Websocket are followed {#websocket}

For two-way asynchronous communication between clients and an API gateway, {{ api-gw-short-name }} supports the [WebSocket](https://en.wikipedia.org/wiki/WebSocket) protocol. To connect to an API gateway using WebSocket, you can use a service domain allocated when creating the API gateway or any other domain added to the API gateway.

You can manage web sockets using the [API](../../../api-gateway/api-ref/websocket/authentication.md) that receives information about a connection, sends data to the client side, and closes the connection.

We recommend that you use the following when connecting to the API gateway via WebSocket:
* [TLS](../../../storage/concepts/tls.md) version 1.2 or higher (regularly [check the validity](../../../certificate-manager/operations/managed/cert-update.md) of the TLS connection certificate).
* OpenAPI 3.0 [authentication and authorization mechanisms](#authorization).
* [API gateway specification extensions](../../../api-gateway/concepts/extensions/), which can help you enhance your virtual environment security.

{% list tabs group=instructions %}

- Performing a check in the management console {#console}

  1. In the management console, select the folder containing the API gateway.
  1. From the list of services, select **{{ api-gw-name }}**.
  1. Select the API gateway you need from the list.
  1. Set up integrations in the OpenAPI specification using the following operations: `x-yc-apigateway-websocket-message`, `x-yc-apigateway-websocket-connect`, or `x-yc-apigateway-websocket-disconnect`.

{% endlist %}

For more information, see [{#T}](../../../api-gateway/tutorials/api-gw-websocket.md).

#### 3.44 API gateway interaction with {yandex-cloud} services is configured {#inter-cloud-services}

Make sure that security enhancement extensions were added to the {{ api-gw-name }} specification.

{% list tabs group=instructions %}

- Performing a check in the management console {#console}

  1. In the management console, select the folder containing the API gateway.
  1. From the list of services, select **{{ api-gw-name }}**.
  1. Select the API gateway you need from the list.
  1. OpenAPI 3.0 is used in the **Specification** section.

{% endlist %}

#### 3.45 API gateway security is enhanced with extensions {#inter-cloud-services}

The `x-yc-apigateway:smartWebSecurity` extension uses [{{ sws-full-name }} profile](../../../smartwebsecurity/concepts/profiles.md) rules with conditions for actions to apply to HTTP requests received by the protected resource:
* The [basic rules](../../../smartwebsecurity/concepts/rules.md#base-rules) block unwanted traffic.
* The [Smart Protection](../../../smartwebsecurity/concepts/rules.md#smart-protection-rules) rule for the whole traffic provides the fullest and transparent protection.
* [Advanced Rate Limiter](../../../smartwebsecurity/concepts/arl.md) sets request number limits, thus reducing workload on web apps and protecting the backend from depleting resources.
* The [WAF](../../../smartwebsecurity/concepts/waf.md) profile analyzes web app's incoming HTTP requests based on pre-configured rules for DoS/DDoS protection.

{% list tabs group=instructions %}

- Performing a check in the management console {#console}

  1. In the management console, select the folder containing the API gateway.
  1. From the list of services, select **{{ api-gw-name }}**.
  1. Select the API gateway you need from the list.
  1. Make sure the **Specification** section uses the `x-yc-apigateway:smartWebSecurity` extension, which protects the API gateway as well as your application, function, or container from DDoS attacks based on the {{ sws-full-name }} profile rules.

{% endlist %}

#### 3.46 Authorization in the API gateway is configured {#authorization}

We recommend using the OpenAPI 3.0 authentication and authorization mechanisms that are standard for {{ api-gw-name }}. Currently, you can use authorization via a function and via a JWT.

* [Authorization via Cloud Functions](../../../api-gateway/concepts/extensions/function-authorizer.md). For HTTP request authorization, {{ api-gw-name }} calls the `x-yc-apigateway-authorizer:function` extension. Currently these three types are supported: `HTTP Basic`, `HTTP Bearer`, and `API Key`.
* [Authorization via a JWT](../../../api-gateway/concepts/extensions/jwt-authorizer.md). For HTTP request authorization, {{ api-gw-name }} validates a token and verifies its signature using the following supported public keys: address, place, fields, body, time, caching mode, and cache retention period.

{% list tabs group=instructions %}

- Performing a check in the management console {#console}

  1. In the management console, select the folder containing the API gateway.
  1. From the list of services, select **{{ api-gw-name }}**.
  1. Select the API gateway you need from the list.
  1. Make sure that the **Specification** section has the `x-yc-apigateway-authorizer:jwt` or `x-yc-apigateway-authorizer:function` extension configured.

{% endlist %}

#### 3.47 Authorization context is used {#auth-context}

We recommend using an [authorization context](../../../api-gateway/concepts/extensions/function-authorizer.md#context) in the [request](../../../functions/concepts/function-invoke.md#request) inside the `requestContext.authorizer` field. This helps preserve data integrity and prevents unauthorized access.

{% list tabs group=instructions %}

- Manual check {#manual}

  Make sure an authorization context is configured in the API gateway specification settings when the `x-yc-apigateway-authorizer:function` extension is used.

{% endlist %}

#### 3.48 Logging is on {#api-logs}

We recommend to keep logging enabled when creating an API gateway. For more information, see [{#T}](../../../api-gateway/operations/api-gw-logs-write.md).

{% list tabs group=instructions %}

- Performing a check in the management console {#console}

  1. In the management console, select the folder containing the API gateway.
  1. From the list of services, select **{{ api-gw-name }}**.
  1. Select the API gateway you need from the list.
  1. Make sure that the **Write logs** option is enabled in the **Logging** section and that the gateway logging level and destination are set up.

{% endlist %}

 Use audit logs that go to [{{ at-full-name }}](../../../api-gateway/at-ref/) for the API gateway performance analysis.