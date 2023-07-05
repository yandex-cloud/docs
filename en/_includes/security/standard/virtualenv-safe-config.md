# 3. Secure configuration of a virtual environment

This section provides recommendations to customers on security settings in {{ yandex-cloud }} services and the use of additional data protection tools in virtual environments.

### Overview {#general}

#### 3.1 A serial console is either used under control or not used {#serial-console}

On VMs, access to the serial console is disabled by default. The risks of using the serial console are listed in the {{ compute-full-name }} documentation, [{#T}](../../../compute/operations/serial-console/index.md).

When working with a serial console:

* Make sure that critical data is not output to the serial console.
* If you enable SSH access to the serial console, make sure that both the credentials management and the password used for logging in to the operating system locally are compliant with regulator standards. For example, in an infrastructure for storing payment card data, passwords must meet PCI DSS requirements: it must contain both letters and numbers, be at least 7 characters long, and be changed at least once every 90 days.

{% note info %}

According to the PCI DSS standard, access to a VM via a serial console is considered "non-console", and {{ yandex-cloud }} uses TLS encryption for it.

{% endnote %}

We recommend using access to the serial console only when absolutely necessary.
 
{% list tabs %}

- Performing a check in the management console

   1. In the management console, select the folder to check the VMs in.
   1. In the list of services, select **{{ compute-name }}**.
   1. Open the settings of all the necessary VMs.
   1. Under **Access**, find the **Additional** parameter.
   1. **Serial console access** must be disabled.
   1. If it's disabled for all the VMs, the recommendation is fulfilled. Otherwise, proceed to the "Instructions and solutions to use".

- Performing a check via the CLI

   1. See what organizations are available to you and write down the desired ID:

      ```bash
      yc organization-manager organization list
      ```

   1. Find the VM with access to the serial console enabled:

      ```bash
      export ORG_ID=<organization ID>
      for CLOUD_ID in $(yc resource-manager cloud list --organization-id=${ORG_ID} --format=json | jq -r '.[].id');
      do for FOLDER_ID in $(yc resource-manager folder list --cloud-id=$CLOUD_ID --format=json | jq -r '.[].id');
      do for VM_ID in $(yc compute instance list --folder-id=$FOLDER_ID --format=json | jq -r '.[].id'); do echo "VM_ID: " && yc compute instance get --id=$VM_ID --full --format=json | jq -r '. | select(.metadata."serial-port-enable"=="1")' | jq -r '.id' && echo "FOLDER_ID: " $FOLDER_ID && echo "-----"
      done;
      done;
      done
      ```

   1. If an empty value is set in VM_ID next to FOLDER_ID, the recommendation is fulfilled. Otherwise, proceed to the "Instructions and solutions to use".

{% endlist %}

**Instructions and solutions to use:**

If the serial console should not be used on the VM, disable it.

#### 3.2 A benchmark image is used for VM deployment {#standard-image}

When deploying virtual machines, we recommend:

* Preparing a VM image whose system settings correspond to your information security policy. You can create an image using Packer. See [{#T}](../../../tutorials/infrastructure-management/packer-quickstart.md).
* Use this image to create a VM or [{#T}](../../../compute/concepts/instance-groups/index.md).
* Look up the virtual machine's information to check that it was created using this image.

{% list tabs %}

- Performing a check in the management console

   1. In the management console, select the folder to check the VMs in.
   1. In the list of services, select **{{ compute-name }}**.
   1. Go to the **Disks** tab.
   1. Open the settings of all disks.
   1. Under **Source**, find the **Identifier** parameter.
   1. If every disk displays the ID of your benchmark image, the recommendation is fulfilled. Otherwise, proceed to the "Instructions and solutions to use".

- Performing a check via the CLI

   1. See what organizations are available to you and write down the desired ID:

      ```bash
      yc organization-manager organization list
      ```

   1. Run the command below to search for the VM disks that do not contain the ID of your benchmark image:

      ```bash
      export ORG_ID=export ORG_ID=<organization ID>
      export IMAGE_ID=<Your reference image ID>
      for CLOUD_ID in $(yc resource-manager cloud list --organization-id=${ORG_ID} --format=json | jq -r '.[].id');
      do for FOLDER_ID in $(yc resource-manager folder list --cloud-id=$CLOUD_ID --format=json | jq -r '.[].id');
      do for DISK_ID in $(yc compute disk list --folder-id=$FOLDER_ID --format=json | jq -r '.[].id'); \
      do echo "DISK_ID: " && yc compute disk get --id=$DISK_ID \
      --format=json | jq -r --arg IMAGE_ID $IMAGE_ID '. | select(."source_image_id"==$IMAGE_ID | not)' | jq -r '.id' && echo "FOLDER_ID: " $FOLDER_ID && echo "-----"
      done;
      done;
      done
      ```

   1. If an empty value is set in DISK_ID next to FOLDER_ID, the recommendation is fulfilled. Otherwise, proceed to the "Instructions and solutions to use".

{% endlist %}

**Instructions and solutions to use:**

1. Find out why these VM disks use an image different from the benchmark one.
1. Recreate the VMs with the appropriate image.

#### 3.3 {{ TF }} is used in accordance with best information security practices {#tf-using}

With {{ TF }}, you can manage a cloud infrastructure using configuration files. If you change the files, {{ TF }} automatically determines which part of your configuration is already deployed and what should be added or removed. For more information, see [{#T}](../../../tutorials/infrastructure-management/terraform-quickstart.md).

We do not recommend using private information in {{ TF }} configuration files, such as passwords, secrets, personal data, or payment system data. Instead, you should use services for storing and using secrets in the configuration file, such as [HashiCorpVault](/marketplace/products/yc/vault-yckms) from {{ marketplace-name }} or [Lockbox](/services/lockbox) (to transfer secrets to the target object without using {{ TF }}).

If you still need to enter private information in the configuration, take the following security measures:

* Specify the [sensitive = true](https://www.terraform.io/docs/language/values/outputs.html#sensitive-suppressing-values-in-cli-output) parameter for private information to disable outputting it to the console when running `terraform plan` and `terraform apply`.
* Use [terraformremotestate](https://www.terraform.io/docs/language/state/remote.html). We recommend [uploading](../../../tutorials/infrastructure-management/terraform-state-storage.md) a {{ TF }} state to {{ objstorage-name }} and [setting up](https://github.com/yandex-cloud/examples/tree/master/terraform-ydb-state) configuration locks using {{ ydb-name }} to prevent simultaneous edits by administrators.
* Use the [mechanism for transferring secrets to {{ TF }} via env](https://www.terraform.io/docs/cli/config/environment-variables.html#tf_var_name) instead of plain text or use built-in KeyManagementService features for [encrypting data in {{ TF }}](../../../kms/tutorials/terraform-secret.md) using a separate file with private data. [Learn more about this technique](https://blog.gruntwork.io/a-comprehensive-guide-to-managing-secrets-in-your-terraform-code-1d586955ace1#3073).

For more information about {{ objstorage-name }} security, see [{{ objstorage-name }}](#objstorage) below.

{% note info %}

When a configuration is deployed, you can delete the configuration file with private data.

{% endnote %}

Scan your Terraform manifests using [Checkov](https://github.com/bridgecrewio/checkov) with {{ yandex-cloud }} support.

* [Example: Scanning .tf files with Checkov](https://github.com/yandex-cloud/yc-solution-library-for-security/tree/master/terraform-sec/checkov-yc)
* [Example: Storing a {{ TF }} state in {{ objstorage-name }}](https://github.com/yandex-cloud/yc-solution-library-for-security/tree/master/terraform-sec/remote-backend).

{% list tabs %}

- Manual check

   Collect data about using the {{ TF }} best security practices from different points.

{% endlist %}

#### 3.4. Integrity control of files is performed {#file-integrity-control}

Numerous information security standards require integrity control of critical files. To do this, you can use free host-based solutions:

* [Wazuh](https://documentation.wazuh.com/current/learning-wazuh/detect-fs-changes.html)
* [Osquery](https://osquery.readthedocs.io/en/stable/deployment/file-integrity-monitoring/)

Paid solutions are also available in the Yandex Cloud marketplace, such as Kaspersky Security.

{% list tabs %}

- Manual check

   Collect data about using integrity control from different points.

{% endlist %}

#### 3.5 Principles of protection against side-channel attacks are used {#side-chanel-protection}

To ensure the best protection against CPU level side-channel attacks (such as Spectre or Meltdown):

* Use full-core virtual machines (instances with a CPU share of 100%).
* Use virtual machines with an even number of cores (2 cores, 4 cores, and so on).
* Install updates for your operating system and kernel that ensure side-channel attack protection (for example, [Kernelpage-tableisolation for Linux](https://en.wikipedia.org/wiki/Kernel_page-table_isolation) or applications built using [Retpoline](https://en.wikipedia.org/wiki/Spectre_%28security_vulnerability%29)).

We recommend that you use [dedicated hosts](../../../compute/concepts/dedicated-host.md) for the most security-critical resources.

[Learn more](https://www.youtube.com/watch?v=VSP_cp6vDQQ&list=PL1x4ET76A10a9Jr6six11s0kRxeQ3fgom&index=17) about side-channel attack protection in cloud environments.

### {{ objstorage-full-name }} {#objstorage}

#### 3.6 No public access to a {{ objstorage-name }} bucket is allowed {#bucket-access}

We recommend assigning minimum roles to a bucket using {{ iam-short-name }} and supplementing or specifying them using BucketPolicy (for example, to restrict access to the bucket by IP, grant granular rights to objects, and so on).

Access to {{ objstorage-name }} resources is verified at three levels:

* [{{ iam-short-name }} verification](../../../iam/concepts).
* [Bucket policy](../../../storage/concepts/policy.md).
* [Access Control Lists (ACLs)](../../../storage/concepts/acl.md).

**Verification procedure:**

1. If a request passes the {{ iam-short-name }} check, the next step is the bucket policy check.
1. Bucket policy rules are checked in the following order:

   1. If the request meets at least one of the Deny rules, access is denied.
   1. If the request meets at least one of the Allow rules, access is allowed.
   1. If the request doesn't meet any of the rules, access is denied.

1. If the request fails the {{ iam-short-name }} or bucket policy check, access verification is performed based on an object's ACL.

In the {{ iam-short-name }} service, a bucket inherits the same access rights as those of the folder and cloud where it's located. For more information, see [{#T}](../../../storage/concepts/acl.md#inheritance). Therefore, we recommend that you only assign the minimum required roles to certain buckets or objects in {{ objstorage-name }}.

Bucket policies are used for additional data protection, for example, to restrict access to a bucket by IP, grant granular rights to objects, and so on.

With ACLs, you can grant access to an object bypassing {{ iam-short-name }} verification and bucket policies. We recommend setting strict ACLs for buckets.

[Example of a secure {{ objstorage-name }} configuration: {{ TF }}](https://github.com/yandex-cloud/yc-solution-library-for-security/tree/master/configuration/hardering_bucket)

{% list tabs %}

- Performing a check in the management console

   1. In the management console, select the cloud or folder to check the buckets in.
   1. In the list of services, select **{{ objstorage-name }}**.
   1. Click the three dots next to each bucket and check their ACLs for allUsers and allAuthenticatedUsers.
   1. Open the bucket and check the ACL of each of its objects for allUsers and allAuthenticatedUsers.
   1. Check that the object **Read access** section has the **Public** parameter enabled. Otherwise, proceed to the "Instructions and solutions to use".

- Performing a check via the CLI

   1. [Configure](../../../storage/tools/aws-cli.md) the AWS CLI to work with a cloud.
   1. Run the command below to check the bucket ACL for `allUsers` and `allAuthenticatedUsers`:

      ```bash
      aws --endpoint-url=https://{{ s3-storage-host }} s3api get-bucket-acl <your bucket's name>
      ```

{% endlist %}

**Instructions and solutions to use:**

If public access is enabled, [remove](../../../iam/operations/roles/revoke.md) it or perform access control (grant permission to access public data consciously).

#### 3.7 {{ objstorage-name }} uses Bucket Policies {#bucket-policy}

[Bucket policies](../../../storage/concepts/policy.md) set permissions for actions with buckets, objects, and object groups. A policy is triggered when a user makes a request to a resource. As a result, the request is either executed or rejected.

Bucket Policy [examples](../../../storage/concepts/policy.md#config-examples):

* Policy that only enables object download from a specified range of IP addresses.
* Policy that prohibits downloading objects from the specified IP address.
* Policy that provides different users with full access only to certain folders, with each user being able to access their own.
* Policy that gives each user and service account full access to a folder named the same as the user ID or service account ID.

We recommend making sure that your {{ objstorage-name }} bucket uses at least one policy.

{% list tabs %}

- Performing a check in the management console

   1. In the management console, select the cloud or folder to check the bucket policies in.
   1. From the list of services, select {{ objstorage-name }}.
   1. Go to **Access policy**.
   1. Make sure that at least one policy is enabled. Otherwise, proceed to the "Instructions and solutions to use".

- Performing a check via the CLI

   1. [Configure](../../../storage/tools/aws-cli.md) the AWS CLI to work with a cloud.
   1. Run the command below to check the bucket ACL for allUsers and allAuthenticatedUsers:

      ```bash
      aws --endpoint-url=https://{{ s3-storage-host }} s3api get-bucket-policy --bucket <your bucket's name>
      ```

{% endlist %}

**Instructions and solutions to use:**

[Enable](../../../storage/concepts/policy.md#config-examples) the desired policy.

#### 3.8 In {{ objstorage-name }}, the Object locks feature is enabled {#object-lock}

When processing critical data in buckets, you must ensure that data is protected from deletion and that versions are backed up. This can be achieved by versioning and lifecycle management mechanisms, as well as by using object locks.

Bucket versioning is the ability to store the history of object versions. Each version is a complete copy of the object and occupies space in {{ objstorage-name }}. Using version control protects your data from both unintentional user actions and application faults.

If you delete or modify an object with versioning enabled, a new version of the object with a new ID is effectively created. In the case of deletion, the object becomes unreadable, but its version is kept and can be restored.

For more information about setting up versioning, see the {{ objstorage-name }} documentation, [Bucket versioning](../../../storage/concepts/versioning.md).

For more information about lifecycles, see the {{ objstorage-name }} documentation, [Bucket object lifecycles](../../../storage/concepts/lifecycles.md) and [Bucket object lifecycle configuration](../../../storage/s3/api-ref/lifecycles/xml-config.md).

In addition, to protect object versions against deletion, use [object locks](../../../storage/concepts/object-lock.md). For more information about object lock types and how to enable them, see the documentation.

The storage period of critical data in a bucket is determined by the client's information security requirements and information security standards. For example, the PCI DSS standard states that audit logs should be stored for at least one year and be available online for at least three months.

{% list tabs %}

- Performing a check in the management console

   1. In the management console, select the cloud or folder to check the buckets in.
   1. In the list of services, select **{{ objstorage-name }}**.
   1. Open the settings of all buckets.
   1. Go to the **Versioning** tab and make sure it's enabled. Otherwise, proceed to the "Instructions and solutions to use".

- Performing a check via the CLI

   1. [Configure](../../../storage/tools/aws-cli.md) the AWS CLI to work with a cloud.
   1. Run the command below to check whether versioning is enabled:

      ```bash
      aws --endpoint https://{{ s3-storage-host }} \
      s3api get-bucket-versioning \
      --bucket <your bucket's name>
      ```

   1. Run the command below to check whether versioning is enabled:

      ```bash
      aws --endpoint-url=https://{{ s3-storage-host }}/ \
      s3api get-object-lock-configuration \
      --bucket <your bucket's name>
      ```

{% endlist %}

**Instructions and solutions to use:**

If public access is enabled, remove it or use access control (by only enabling it when necessary and if approved).

#### 3.9 In {{ objstorage-name }}, logging of actions with buckets is enabled {#bucket-logs}

When using {{ objstorage-name }} to store critical data, be sure to enable logging of actions with buckets. For more information, see the {{ objstorage-name }} documentation, [Logging actions with a bucket](../../../storage/concepts/server-logs.md).

This makes sure that data-plane logs with the following objects are written: PUT, DELETE, GET, POST, OPTIONS, and HEAD.

In a similar way, you can request [writing](../../../audit-trails/concepts/events.md#objstorage) these logs to {{ at-short-name }}, except reads. In the future, all these logs will be written to {{ at-short-name }}.

You can also analyze {{ objstorage-name }} logs in {{ datalens-short-name }}. Learn more in the article [Analyzing {{ objstorage-name }} logs using {{ datalens-short-name }}](../../../tutorials/datalens/storage-logs-analysis.md).

**Instructions and solutions to use:**

You can only use {{ TF }}/API to check if logging is enabled by following the [instructions](../../../storage/operations/buckets/enable-logging.md).

#### 3.10 In {{ objstorage-name }}, Cross-Origin Resource Sharing (CORS) is set up {#cors}

If [cross-domain requests](https://en.wikipedia.org/wiki/Cross-origin_resource_sharing) to objects in buckets are required, the customer should configure the CORS policy in accordance with the customer's information security requirements. For more information, see the {{ objstorage-name }} documentation, [CORS configuration of buckets](../../../storage/s3/api-ref/cors/xml-config.md).

{% list tabs %}

- Performing a check in the management console

   1. In the management console, select the cloud or folder to check the buckets in.
   1. In the list of services, select **{{ objstorage-name }}**.
   1. Open the settings of all buckets.
   1. Go to the **CORS** tab and make sure that the configuration is set up. Otherwise, proceed to the "Instructions and solutions to use".

{% endlist %}

**Instructions and solutions to use:**

[Set up](../../../storage/s3/api-ref/cors/xml-config.md) CORS.

### Managed Services for Databases

#### 3.11 A security group is assigned in managed databases {#db-security-group}

We recommend prohibiting internet access to databases that contain critical data, in particular PCI DSS data or private data. Configure security groups to only allow connections to the DBMS from specific IP addresses. See the instructions in [Creating a security group](../../../vpc/operations/security-group-create.md). You can specify a security group in the cluster settings or when creating the cluster in the network settings section.

{% list tabs %}

- Performing a check in the management console

   1. In the management console, select the cloud or folder to check the databases in.
   1. In the list of services, select a service or services with managed databases.
   1. In the object settings, find the **Security group** parameter and make sure that at least one security group is assigned.
   1. If the parameters of each object have at least one security group set, the recommendation is fulfilled. Otherwise, proceed to the "Instructions and solutions to use".

- Performing a check via the CLI

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

   1. If an empty string is output, the recommendation is fulfilled. Otherwise, proceed to the "Instructions and solutions to use".

- Checking if managed databases have SGs

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

   1. If an empty string is output, the recommendation is fulfilled. If not, proceed to the "Instructions and solutions to use".

{% endlist %}

**Instructions and solutions to use:**

If any databases without security groups are found, assign them or enable the **Default security group** [functionality](../../../vpc/concepts/security-groups.md#default-security-group.md).

#### 3.12 No public IP address is assigned in managed databases {#db-ip}
Assigning a public IP to a managed database raises information security risks. We recommend that you don't assign an external IP unless absolutely necessary.

{% list tabs %}

- Performing a check in the management console

   1. In the management console, select the cloud or folder to check the databases in.
   1. In the list of services, select a service or services with managed databases.
   1. In the object settings, go to the **Hosts** tab.
   1. If the parameters of each object have the **Public access** option disabled, the recommendation is fulfilled. Otherwise, proceed to the "Instructions and solutions to use".

- Performing a check via the CLI

   1. See what organizations are available to you and write down the desired ID:

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

   1. If an empty string is output, the recommendation is fulfilled. If not, proceed to the "Instructions and solutions to use".

{% endlist %}

**Instructions and solutions to use:**

Disable public access if it is not required.

#### 3.13 The deletion protection feature is enabled {#deletetion-protection}

In {{ yandex-cloud }} managed databases, you can enable deletion protection. Deletion protection manages cluster protection from accidental deletion by a user. Enabled protection will not prevent a manual connection to a cluster to delete data.

{% list tabs %}

- Performing a check in the management console

   1. In the management console, select the cloud or folder to check the databases in.
   1. In the list of services, select a service or services with managed databases.
   1. In the object settings, go to the **Advanced settings** tab.
   1. If the parameters of each object have the **Deletion protection** option enabled, the recommendation is fulfilled. Otherwise, proceed to the "Instructions and solutions to use".

- Performing a check via the CLI

   1. See what organizations are available to you and write down the desired ID:

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

   1. If an empty string is output, the recommendation is fulfilled. Otherwise, proceed to the "Instructions and solutions to use".

{% endlist %}

**Instructions and solutions to use:**

1. In the management console, select the cloud or folder to enable deletion protection in.
1. In the list of services, select a service or services with managed databases.
1. In the object settings, go to the **Advanced settings** tab.
1. In the object parameters, enable **Deletion protection**.

#### 3.14 The setting that enables access from {{ datalens-short-name }} is not activated unless needed {#db-datalens-access}

You shouldn't enable access to databases containing critical data from the management console, [{{ datalens-short-name }}](../../../datalens), or other services unless you have to. Access from {{ datalens-short-name }} may be required for data analysis and visualization. For such access, the {{ yandex-cloud }} service network is used, with authentication and TLS encryption. You can enable and disable access from {{ datalens-short-name }} or other services in the cluster settings or when creating it in the advanced settings section.

{% list tabs %}

- Performing a check in the management console

   1. In the management console, select the cloud or folder to check the databases in.
   1. In the list of services, select a service or services with managed databases.
   1. In the object settings, go to the **Advanced settings** tab.
   1. If the parameters of each object have **Access from {{ datalens-short-name }}** disabled, the recommendation is fulfilled. Otherwise, proceed to the "Instructions and solutions to use".

- Performing a check via the CLI

   1. See what organizations are available to you and write down the desired ID:

      ```bash
      yc organization-manager organization list
      ```

   1. Find managed DB clusters with access from {{ datalens-short-name }} enabled:

      ```bash
      export ORG_ID=<organization ID>
      for CLOUD_ID in $(yc resource-manager cloud list --organization-id=${ORG_ID} --format=json | jq -r '.[].id');
      do for FOLDER_ID in $(yc resource-manager folder list --cloud-id=$CLOUD_ID --format=json | jq -r '.[].id');
      do for DB_ID in $(yc managed-mysql cluster list --folder-id=$FOLDER_ID --format=json | jq -r '.[].id'); do yc managed-mysql cluster get --id=$DB_ID --format=json | jq -r '. | select(.config.access.data_lens)' | jq -r '.id'
      done;
      done;
      done
      ```

   1. If an empty string is output, the recommendation is fulfilled. Otherwise, proceed to the "Instructions and solutions to use".

{% endlist %}

**Instructions and solutions to use:**

1. In the management console, select the cloud or folder to disable access from {{ datalens-short-name }} in.
1. In the list of services, select a service or services with managed databases.
1. In the object settings, go to the **Advanced settings** tab.
1. In the object parameters, disable **Access from {{ datalens-short-name }}**.

#### 3.15 Access from the management console is disabled in managed databases {#db-console-access}

You may need access to the database from the management console to send [SQL queries](../../..//managed-postgresql/operations/web-sql-query.md) to the database and visualize the data structure.

We recommend that you enable this type of access only if needed, because it raises information security risks. In normal mode, use a standard DB connection as a DB user.

{% list tabs %}

- Performing a check in the management console

   1. In the management console, select the cloud or folder to check the databases in.
   1. In the list of services, select a service or services with managed databases.
   1. In the object settings, go to the **Advanced settings** tab.
   1. If the parameters of each object have **Access from the management console** disabled, the recommendation is fulfilled. Otherwise, proceed to the "Instructions and solutions to use".

- Performing a check via the CLI

   1. See what organizations are available to you and write down the desired ID:

      ```bash
      yc organization-manager organization list
      ```

   1. Run the command below to search for managed DB clusters with access from the management console enabled:

      ```bash
      export ORG_ID=<organization ID>
      for CLOUD_ID in $(yc resource-manager cloud list --organization-id=${ORG_ID} --format=json | jq -r '.[].id');
      do for FOLDER_ID in $(yc resource-manager folder list --cloud-id=$CLOUD_ID --format=json | jq -r '.[].id');
      do for DB_ID in $(yc managed-mysql cluster list --folder-id=$FOLDER_ID --format=json | jq -r '.[].id'); do yc managed-mysql cluster get --id=$DB_ID --format=json | jq -r '. | select(.config.access.web_sql)' | jq -r '.id'
      done;
      done;
      done
      ```

   1. If an empty string is output, the recommendation is fulfilled. Otherwise, proceed to the "Instructions and solutions to use".

{% endlist %}

**Instructions and solutions to use:**

1. In the management console, select the cloud or folder to disable access from the management console in.
1. In the list of services, select a service or services with managed databases.
1. In the object settings, go to the **Advanced settings** tab.
1. In the object parameters, disable **Access from console**.

### {{ sf-name }} and {{ api-gw-full-name }} {#functions-api-gateway}

#### 3.16 Public cloud functions are only used in exceptional cases {#public-function-access}

In cases where the use of public functions is not explicitly required, we recommend that you use private functions. For more information about setting up access to functions, see [Managing rights to access functions](../../../functions/operations/function/function-public.md). We recommend using private functions and assigning rights to invoke functions to specific cloud users.

{% list tabs %}

- Performing a check in the management console

   1. In the management console, select the cloud or folder to check the functions in.
   1. In the list of services, select **{{ sf-name }}**.
   1. Open all the functions.
   1. In the function settings, go to the **Overview** tab.
   1. If the parameters of each object have the **Public function** option disabled, the recommendation is fulfilled. Otherwise, proceed to the "Instructions and solutions to use".

- Performing a check via the CLI

   1. Run the command below to search for `allUsers` access rights at the {{ sf-name }} level in all folders:

      ```bash
      export ORG_ID=<organization ID>
      for CLOUD_ID in $(yc resource-manager cloud list --organization-id=${ORG_ID} --format=json | jq -r '.[].id');
      do for FOLDER_ID in $(yc resource-manager folder list --cloud-id=$CLOUD_ID --format=json | jq -r '.[].id');
      do for FUN in $(yc serverless function list --folder-id=$FOLDER_ID --format=json | jq -r '.[].id'); \
      do yc serverless function list-access-bindings --id $FUN --format=json | jq -r '.[] | select(.subject.id=="allAuthenticatedUsers" or .subject.id=="allUsers")' && echo $FUN
      done;
      done;
      done
      ```

   1. If none of the specified resources contain `allUsers` and `allAuthenticatedUsers`, the recommendation is fulfilled. Otherwise, proceed to the "Instructions and solutions to use".

{% endlist %}

**Instructions and solutions to use:**

[Disable](../../../functions/operations/function/function-private.md) public access.

#### 3.17 Side-channel attacks in {{ sf-name }} are considered {#side-channel-attacks}

Hosts and hypervisors running {{ sf-name }} contain all the applicable updates for side-channel attack protection. However, keep in mind that different clients' functions are not isolated by cores. Thus, there is technically an attack surface between one user's function and another's. {{ yandex-cloud }} security experts believe that side-channel attacks are unlikely in the context of functions, but this risk must be accounted for, particularly in the overall threats and risk analysis model employed by the PCI DSS infrastructure.

{% list tabs %}

- Manual check

   Make sure the most critical systems don't use {{ sf-name }} or this is considered in the risk analysis model.

{% endlist %}

#### 3.18 Specifics of time synchronization in {{ sf-name }} are considered {#ntp-functions}

The {{ sf-name }} service does not guarantee time synchronization prior to or during execution of requests by functions. To generate a function log with exact timestamps on the {{ sf-name }} side, output the log to stdout. The client can also independently accept function execution logs and label them with a timestamp on the receiving side. In this case, the timestamp is taken from the time source synced with {{ yandex-cloud }}. For more information about time synchronization, see the {{ compute-short-name }} documentation, [Configuring clock synchronization](../../../compute/tutorials/ntp.md).

#### 3.19 Specifics of header management in {{ sf-name }} are considered {#http-functions}
If the function is called to process an HTTP request, the returned result should be a JSON document containing the HTTP response code, response headers, and response content. {{ sf-name }} will automatically process this JSON and the user will receive data as a standard HTTP response. The client needs to manage the response headers on their own in accordance with regulator requirements and the threat model. For more information on how to process an HTTP request, see the {{ sf-name }} documentation, [Invoking a function in {{ sf-name }}](../../../functions/concepts/function-invoke.md).

#### 3.20 {{ serverless-containers-short-name }}/{{ sf-name }} uses the {{ vpc-short-name }} internal network {#vpc-functions}

By default, the function is invoked in the isolated IPv4 network with the NAT gateway enabled. For this reason, only public IPv4 addresses are available.

If necessary, you can specify a cloud network in function settings. In this case, the function:

* Is executed in a given cloud network.
* Has access to the internet and user resources in the given network, such as databases and VMs.
* Has an IP address within the `198.19.0.0/16` range when accessing user resources.

{% list tabs %}

- Performing a check in the management console

   1. In the management console, select the cloud or folder to check the functions in.
   1. From the list of services, select {{ sf-name }}.
   1. Open all the functions.
   1. In the object settings, go to the **Edit function version** tab.
   1. If the parameters of each object have **Network — {{ vpc-short-name }}** set, the recommendation is fulfilled. Otherwise, proceed to the "Instructions and solutions to use".

- Performing a check via the CLI

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

   1. If an empty string is output, the recommendation is fulfilled. Otherwise, proceed to the "Instructions and solutions to use".

{% endlist %}

**Instructions and solutions to use:**

1. Select the cloud or folder to check the functions in.
1. Select **{{ sf-name }}** in the list of services.
1. Open the function.
1. In the object settings, go to the **Edit function version** tab.
1. Set **Network — {{ vpc-short-name }}**.

### {{ ydb-name }} {#ydb-access}

#### 3.21 Recommendations for using confidential data in {{ ydb-short-name }} are followed {#ydb-confidential-data}

It's prohibited to use confidential data as the names of databases, tables, columns, directories, and so on. It's prohibited to send critical data, such as payment card details, to {{ ydb-name }} (both Dedicated and Serverless) as clear text. Prior to sending data, be sure to encrypt it at the application level. For this you can use the KMS service or any other method compliant with the regulator standard. For data where the storage period is known in advance, we recommend that you configure the [Time To Live](https://ydb.tech/ru/docs/concepts/ttl) option.

#### 3.22 Recommendations for SQL injection protection in {{ ydb-short-name }} are followed {#ydb-sql-injection}

When working with the database, use [parameterized prepared statements](https://ydb.tech/ru/docs/reference/ydb-sdk/example/#param-queries) to protect against SQL injection. If the application dynamically generates query templates, you must prevent the injection of untrusted user input into the SQL query template.

#### 3.23 No public access to {{ ydb-short-name }} is allowed {#ydb-public}

When accessing the database in dedicated mode, we recommend that you use it inside {{ vpc-short-name }}, disabling public access to it from the internet. In serverless mode, the database can be accessed from the internet. You must therefore take this into account when modeling threats to your infrastructure. For more information about the operating modes, see the [Serverless and dedicated modes](../../../ydb/concepts/serverless-and-dedicated.md) section in the {{ ydb-name }} documentation.

When setting up database permissions, use the principle of least privilege.

{% list tabs %}

- Performing a check in the management console

   1. In the management console, select the cloud or folder to check the database in.
   1. In the list of services, select **{{ ydb-name }}**.
   1. Open all the databases.
   1. In the database settings, go to the **Network** tab.
   1. If the parameters of each object have the **Public IP addresses** option disabled, the recommendation is fulfilled. Otherwise, proceed to the "Instructions and solutions to use".

- Performing a check via the CLI

   1. See what organizations are available to you and write down the desired ID:

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

   1. If an empty string is output, the recommendation is fulfilled. Otherwise, proceed to the "Instructions and solutions to use".

{% endlist %}

**Instructions and solutions to use:**

Disable public access if it is not required.

#### 3.24 Recommendations for {{ ydb-short-name }} backups are followed {#ydb-backup}

When creating [on-demand backups](../../../ydb/pricing/serverless.md), make sure that the backup data is properly protected.

When creating backups on demand in {{ objstorage-name }}, follow the recommendations in the {{ objstorage-name }} subsection above (for example, use the built-in bucket encryption feature).

### {{ container-registry-full-name }} {#container-registry}

#### 3.25 ACL by IP address is set up for {{ container-registry-full-name }} {#acl-container-registry}

We recommend that you limit access to your {{ container-registry-short-name }} to specific IPs.

{% list tabs %}

- Performing a check in the management console

   1. In the management console, select the cloud or folder to check the registry in.
   1. In the list of services, select **{{ container-registry-short-name }}**.
   1. In the settings of the specific registry, go to the **Access for IP address** tab.
   1. If specific IPs to allow access for are set in the parameters, the recommendation is fulfilled. Otherwise, proceed to the "Instructions and solutions to use".

- Performing a check via the CLI

   1. See what organizations are available to you and write down the desired ID:

      ```bash
      yc organization-manager organization list
      ```

   1. Run the command below to search for CRs that are not filtered by IP:

      ```bash
      export ORG_ID=<organization ID>
      for CLOUD_ID in $(yc resource-manager cloud list --organization-id=${ORG_ID} --format=json | jq -r '.[].id');
      do for FOLDER_ID in $(yc resource-manager folder list --cloud-id=$CLOUD_ID --format=json | jq -r '.[].id');
      do for CR in $(yc container registry list --folder-id=$FOLDER_ID --format=json | jq -r '.[].id'); do yc container registry list-ip-permissions --id=$CR --format=json | jq -r '.[] | select(.ip)' | jq -r '.action' && echo $CR "IF ACTION PULL/PUSH exist before CR then OK"
      done;
      done;
      done
      ```

   1. If PULL/PUSH is output before each registry ID, the recommendation is fulfilled. Otherwise, proceed to the "Instructions and solutions to use".

{% endlist %}

**Instructions and solutions to use:**

Specify the IP addresses for registry access.

### {{ cos-full-name }} {#container-solution}

We do not recommend that you use privileged containers to run loads that process untrusted user input. Privileged containers should be used for the purposes of administering VMs or other containers.

{% list tabs %}


- Performing a check in the management console

   1. In the management console, select the cloud or folder to check the VMs in.
   1. In the list of services, select **{{ compute-short-name }}**.
   1. Open the settings of a specific VM with a **Container Optimized Image**.
   1. In the Docker container's **Settings**, find the **Privileged mode** parameter.
   1. If it's disabled, the recommendation is fulfilled. Otherwise, proceed to the "Instructions and solutions to use".
       


- Performing a check via the CLI

   1. See what organizations are available to you and write down the desired ID:

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

   1. If you don't see `privileged: true` before any VM ID, the recommendation is fulfilled. Otherwise, proceed to the "Instructions and solutions to use".

{% endlist %}


**Instructions and solutions to use:**

1. In the management console, select the cloud or folder to check the VMs in.
1. In the list of services, select **{{ compute-short-name }}**.
1. Open the settings of a specific VM with a **Container Optimized Image**.
1. In the Docker container's Settings, disable the **Privileged mode** parameter.



#### 3.26 A {{ certificate-manager-full-name }} certificate is valid for at least 30 days {#certificate-validity}

{{ certificate-manager-full-name }} lets you manage TLS certificates for API gateways in the API Gateway service and for websites and buckets in {{ objstorage-name }}. {{ alb-name }} is integrated with {{ certificate-manager-short-name }} for storing and installing certificates. We recommend that you use {{ certificate-manager-short-name }} to obtain your certificates and rotate them automatically.

When using TLS in your application, we recommend that you limit the list of your trusted root certificate authorities (root CA).

When using certificate pinning, keep in mind that Let's Encrypt certificates are [valid for 90 days](https://letsencrypt.org/docs/faq/#what-is-the-lifetime-for-let-s-encrypt-certificates-for-how-long-are-they-valid).

We recommend that you update certificates in advance if they are not [updated automatically](../../../certificate-manager/concepts/challenges.md#auto).

{% list tabs %}

- Performing a check in the management console

   1. In the management console, select the cloud or folder to check the VMs in.
   1. In the list of services, select **{{ certificate-manager-full-name }}**.
   1. Open the settings of each certificate and find the **End date** parameter.
   1. If the parameter shows that the certificate will be valid for at least 30 days more, the recommendation is fulfilled. Otherwise, proceed to the "Instructions and solutions to use".

- Performing a check via the CLI

   1. See what organizations are available to you and write down the desired ID:

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

   1. If you don't see `privileged: true` before any VM ID, the recommendation is fulfilled. Otherwise, proceed to the "Instructions and solutions to use".

{% endlist %}

**Instructions and solutions to use:**

Update the certificate or set up auto updates.

### {{ mgl-full-name }} {#git-lab-service}

#### 3.27 Recommendations on security settings for a {{ GL }} instance are followed {#git-lab-secure}

See the recommendations [here](../../../managed-gitlab/concepts/security.md#secure-instance).

{% list tabs %}

- Manual check

   Run a manual check.

{% endlist %}
