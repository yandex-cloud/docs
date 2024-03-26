# Secure configuration

This section provides recommendations to customers on security settings in {{ yandex-cloud }} services and the use of additional data protection tools.

## Default passwords {#default-credentials}

{{ yandex-cloud }} services do not have default credentials. In each service, the client specifically assigns user passwords and other secrets. However, software managed by the client that is installed on virtual machines or inside containers may contain initial credentials that should be changed (for example, the login `admin` with the password `admin`).

To automatically verify credentials, we recommend using paid security scanners or the following free tools:
* [changeme](https://github.com/ztgrace/changeme).
* [nmap script http-default-accounts](https://nmap.org/nsedoc/scripts/http-default-accounts.html).
* [nmap script ssh-brute](https://nmap.org/nsedoc/scripts/ssh-brute.html).

## Managing infrastructure {#infrastructure}

In IaaS services, the customer is responsible for the configuration of their resources.

To check your host compliance with the security standards and best practices, we recommend using the free utility [OpenSCAP](https://www.open-scap.org/getting-started/).

### Serial console {#serial-console}

Access to the serial console is disabled on VMs by default. We do not recommend enabling it for security reasons. The risks of using the serial console are listed in the {{ compute-full-name }} documentation, [{#T}](../../compute/operations/serial-console/index.md).

When working with a serial console:
* Make sure that critical data is not output to the serial console.
* If you enable SSH access to the serial console, make sure that both the credentials management and the password used for logging in to the operating system locally are compliant with regulator standards. For example, in an infrastructure for storing payment card data, a password must meet [PCI DSS](/security/standards/pci) requirements: it must contain both letters and numbers, be at least 7 characters long, and be changed at least once every 90 days.

{% note info %}

According to the PCI DSS standard, access to VMs via a serial console is considered "non-console" access, and {{ yandex-cloud }} uses TLS encryption for it.

{% endnote %}

### Preparing VM images {#vm-preparing}

When deploying a VM instance, we recommend you to:
* Prepare a VM image whose system settings correspond to your information security policy. You can create an image using Packer. See [{#T}](../../tutorials/infrastructure-management/packer-quickstart.md).
* Use this image to create a VM or [instance group](../../compute/concepts/instance-groups/index.md).
* Look up the VM details to check that this image was actually used to create the disk.

### {{ TF }} {#terraform}

With {{ TF }}, you can manage a cloud infrastructure using configuration files. If you change the files, {{ TF }} will automatically detect which part of your configuration is already deployed, and what should be added or removed. For more information, see [{#T}](../../tutorials/infrastructure-management/terraform-quickstart.md).

We do not recommend using private information in {{ TF }} configuration files, such as passwords, secrets, personal data, or payment system data. Instead, you should use services for storing and using secrets in the configuration file, such as [HashiCorp Vault](/marketplace/products/yc/vault-yckms) from {{ marketplace-full-name }} or [{{ lockbox-name }}](../../lockbox/) (to transfer secrets to the target object without using {{ TF }}).

If you still need to enter private information in the configuration, you should take the following security measures:
* Use [sensitive = true](https://www.terraform.io/docs/language/values/outputs.html#sensitive-suppressing-values-in-cli-output) for private information to exclude it from the console output of `terraform plan` and `terraform apply`.
* Use [terraform remote state](https://www.terraform.io/docs/language/state/remote.html). We recommend uploading a {{ TF }} state to {{ objstorage-full-name }} (see [Uploading {{ TF }} states to {{ objstorage-name }}](../../tutorials/infrastructure-management/terraform-state-storage.md)) and setting up configuration locking using {{ ydb-full-name }} to prevent simultaneous editing by administrators (see a [setup example](https://github.com/yandex-cloud/examples/tree/master/terraform-ydb-state)).
* Use the [mechanism for transferring secrets to {{ TF }} via env](https://www.terraform.io/docs/cli/config/environment-variables.html#tf_var_name) instead of plain text or use built-in {{ kms-full-name }} features for [encrypting data in {{ TF }}](../../kms/tutorials/terraform-secret.md) (using a separate file with private data) ([learn more about this technique](https://blog.gruntwork.io/a-comprehensive-guide-to-managing-secrets-in-your-terraform-code-1d586955ace1#3073)).

   For more information about {{ objstorage-name }} security, see [{{ objstorage-name }}](#object-storage) below.

{% note warning %}

When a configuration is deployed, you can delete the configuration file with private data.

{% endnote %}

Scan your {{ TF }} manifests using [Checkov](https://github.com/bridgecrewio/checkov) with {{ yandex-cloud }} support.


![](../../_assets/overview/solution-library-icon.svg)[Example: Scanning .tf files with Checkov](https://github.com/yandex-cloud/yc-solution-library-for-security/tree/master/terraform-sec/checkov-yc)
![](../../_assets/overview/solution-library-icon.svg)[Example: Storing {{ TF }} states in {{ objstorage-name }}](https://github.com/yandex-cloud/examples/tree/master/terraform-ydb-state)


### Integrity control {#integrity-control}

Numerous information security standards require integrity control of critical files. To do this, you can use free host-based solutions:
* [Wazuh](https://documentation.wazuh.com/current/learning-wazuh/detect-fs-changes.html)
* [Osquery](https://osquery.readthedocs.io/en/stable/deployment/file-integrity-monitoring/)


In {{ marketplace-name }}, paid solutions are also available, such as [CloudGuard](/marketplace?search=payg).


### Side-channel attacks {#side-channel}

To ensure the best protection against CPU side-channel attacks (for example, Spectre or Meltdown):
* Use full-core VMs (that is, VMs with the CPU share of 100%).
* Use VMs with an even number of cores (2 cores, 4 cores, and so on).
* Make sure to install such updates for the OS and kernel that are protected from side-channel attacks (for example, [Kernel page-table isolation for Linux](https://en.wikipedia.org/wiki/Kernel_page-table_isolation), applications built with [Retpoline](https://en.wikipedia.org/wiki/Spectre_%28security_vulnerability%29)).


We recommend that you use [dedicated hosts](../../compute/concepts/dedicated-host.md) for the most security-critical resources.

[Learn more](https://www.youtube.com/watch?v=VSP_cp6vDQQ&list=PL1x4ET76A10a9Jr6six11s0kRxeQ3fgom&index=17) about side-channel attack protection in cloud environments.


## {{ objstorage-name }} {#object-storage}

### Data encryption {#encryption}

When using {{ objstorage-name }}, set up encryption for critical data at rest and in transit. {{ objstorage-name }} provides built-in encryption. For more information, see [{#T}](encryption.md).

### Access restriction {#object-storage-access}

We recommend assigning minimum roles to a bucket using {{ iam-full-name }}, then making them broader or more specific using BucketPolicy (for example, to restrict access to the bucket by IP addresses, grant granular rights to objects, and so on).

Access to {{ objstorage-name }} resources is verified at three levels:
* [{{ iam-name }} verification](../../iam/concepts/index.md)
* [Bucket policies](../../storage/concepts/policy.md)
* [Access Control Lists (ACLs)](../../storage/concepts/acl.md)

Verification procedure:
1. If a request passes the {{ iam-name }} check, the next step is the bucket policy check.
1. Bucket policy rules are checked in the following order:
   1. If the request meets at least one of the `Deny` rules, access is denied.
   1. If the request meets at least one of the `Allow` rules, access is allowed.
   1. If the request does not meet any of the rules, access is denied.
1. If the request fails the {{ iam-name }} or bucket policy check, access verification is performed based on an object's ACL.

In the {{ iam-name }} service, a bucket inherits the same access rights as those of the folder and cloud where it's located. For more information, see [Inheritance of bucket access rights by {{ yandex-cloud }} system groups](../../storage/concepts/acl.md#inheritance). For this reason, we do not recommend assigning roles for entire folders in {{ objstorage-name }}. We recommend that you only assign the minimum required roles to certain buckets or objects in {{ objstorage-name }}.

Bucket policies are used for additional data protection, for example, to restrict access to a bucket by IP addresses, grant granular rights to objects, and so on.

With ACLs, you can grant access to an object bypassing {{ iam-name }} verification and bucket policies. We recommend setting strict ACLs for buckets.


![](../../_assets/overview/solution-library-icon.svg) [Example of a secure {{ objstorage-name }} configuration: {{ TF }}](https://github.com/yandex-cloud-examples/yc-s3-secure-bucket)


### Deletion protection and version backups {#versioning}

When processing critical data in buckets, you must ensure that data is protected from deletion and that versions are backed up. This can be achieved by versioning and lifecycle management mechanisms.

Bucket versioning is the ability to store the history of object versions. Each version is a complete copy of an object and occupies space in {{ objstorage-name }}. Using version control protects your data from both unintentional user actions and application faults.

If you delete/modify an object with versioning enabled, a new version of the object with a new ID is effectively created. In the case of deletion, the object becomes unreadable, but its version is kept and can be restored.

For more information about setting up versioning, see the {{ objstorage-name }} documentation, [{#T}](../../storage/concepts/versioning.md).

The lifecycle management mechanism allows you to set a policy for deleting or moving data, for example:
* Delete all non-current versions of objects (condition type: NoncurrentVersionExpiration) on expiry of a certain number of days since the version became non-current.
* Delete all current versions of objects (condition type: Expiration) on expiry of a certain number of days since they were uploaded.

For more information about lifecycles, see the {{ objstorage-name }} documentation, [{#T}](../../storage/concepts/lifecycles.md) and [{#T}](../../storage/s3/api-ref/lifecycles/xml-config.md).

The storage period of critical data in a bucket is determined by the client's information security requirements and information security standards. For example, the PCI DSS standard states that audit logs should be stored for at least one year and should be readily available online for at least three months.


### Audits {#audit}

When using {{ objstorage-name }} to store critical data, be sure to enable logging of actions with buckets and configure the versioning mechanism and lifecycle for objects with logs. For more information, see [{#T}](../../storage/concepts/server-logs.md) in the {{ objstorage-name }} documentation.

You can also analyze {{ objstorage-name }} logs in {{ datalens-full-name }}.


### Cross-Origin Resource Sharing (CORS) {#cors}

If cross-domain requests to bucket objects are required, the client should configure the CORS (cross-origin resource sharing) policy in accordance with the client's information security requirements. For more information, see [{#T}](../../storage/s3/api-ref/cors/xml-config.md) in the {{ objstorage-name }} documentation.

## Managed Services for Databases {#managed-services-for-databases}

We recommend prohibiting internet access to databases that contain critical data, in particular PCI DSS data or private data. Configure security groups to only allow connections to the DBMS from specific IP addresses. See the instructions in [{#T}](../../vpc/operations/security-group-create.md). You can specify a security group in the cluster settings or when creating the cluster in the network settings section.

Do not enable access to databases containing critical data from the management console, {{ datalens-name }}, or other services, unless explicitly required. You may need access to the database from the management console to send SQL queries to the database and visualize the data structure, or access from {{ datalens-name }} to visualize and analyze data. For such access , use the {{ yandex-cloud }} service network with authentication and TLS encryption. You can enable and disable access from the management console, {{ datalens-name }}, or other services in the cluster settings or when creating it in the advanced settings section.


## {{ sf-full-name }} and {{ api-gw-full-name }} {#cloud-functions-api-gateway}

### Using a service account {#cloud-functions-service-account}

To get an IAM token when executing a function, you must assign a service account for the function. See the instructions in [{#T}](../../functions/operations/function-sa.md). In this case, the function receives an IAM token using built-in {{ yandex-cloud }} mechanisms without having to transfer any secrets to the function from outside.

### Function access control {#cloud-functions-access-control}

In cases where the use of public functions is not explicitly required, we recommend that you use private functions. For more information about setting up access to functions, see [{#T}](../../functions/operations/function/function-private.md).

### Side-channel attacks in {{ sf-name }} {#cloud-functions-side-channel}

Hosts and hypervisors running {{ sf-name }} contain all the applicable updates for side-channel attack protection. However, keep in mind that different clients' functions are not isolated by cores. Thus, there is technically an attack surface between one user's function and another's. {{ yandex-cloud }} security experts believe that side-channel attacks are unlikely in the context of functions, but this risk must be accounted for, particularly in the overall threats and risk analysis model employed by the PCI DSS infrastructure.

### Specifics of time synchronization in functions {#cloud-functions-time}

The {{ sf-name }} service does not guarantee time synchronization prior to or during execution of requests by functions. To generate a function log with exact timestamps on the {{ sf-name }} side, output the log to stdout. The client can also independently accept function execution logs and label them with a timestamp on the receiving side. In this case, the timestamp is taken from the time source synced with {{ yandex-cloud }}. For more information about time synchronization, see the {{ compute-name }} documentation, [{#T}](../../compute/tutorials/ntp.md)

### Managing HTTP headers in functions {#http-headers}

If the function is called to process an HTTP request, the returned result should be a JSON document containing the HTTP response code, response headers, and response content. {{ sf-name }} will automatically process this JSON and the user will receive data as a standard HTTP response.

The client needs to manage the response headers on their own in accordance with regulator requirements and the threat model. For more information on how to process an HTTP request, see the {{ sf-name }} documentation, [Invoking a function using HTTP](../../functions/concepts/function-invoke.md#http).



## {{ ydb-name }} {#ydb}

### Operations with data {#ydb-data}

It's prohibited to use confidential data, particularly PCI DSS data, as the names of database, tables, columns, folders, and so on. It's prohibited to send PCI DSS data to {{ ydb-name }} (both Dedicated and Serverless) as clear text. Prior to sending data, be sure to encrypt the data at the application level. For this you can use the {{ kms-name }} service or any other PCI DSS-compliant method. For data where the storage period is known in advance, we recommend that you configure the [Time To Live](https://ydb.tech/en/docs/concepts/ttl) option.

### SQL injection protection {#sql-injections}

When working with the database, use [parameterized prepared statements](https://ydb.tech/en/docs/reference/ydb-sdk/example/#param-queries) to protect against SQL injection. If the application dynamically generates query templates, you must prevent the injection of untrusted user input into the SQL query template.

### Network access {#ydb-network}

When accessing the database in dedicated mode, we recommend that you use it inside {{ vpc-full-name }} and disable public access to it from the internet. In serverless mode, the database can be accessed from the internet. You must therefore take this into account when modeling threats to your PCI DSS infrastructure. For more information about the operating modes, see the [Serverless and dedicated modes](../../ydb/concepts/serverless-and-dedicated.md) section in the {{ ydb-name }} documentation.

When setting up database permissions, use the principle of least privilege.

### Backups {#ydb-backup}

When creating [on-demand backups](../../ydb/pricing/serverless.md#rules-auto-backup-storage), make sure that the backup data is properly protected.

When creating backups on demand in {{ objstorage-name }}, follow the recommendations in the [{{ objstorage-name }}](#object-storage) subsection above (for example, use the built-in bucket encryption feature).


## {{ container-registry-full-name }} and {{ cos-full-name }} {#container-registry-solution}

We do not recommend that you use privileged containers to run loads that process untrusted user input. Privileged containers must be used for the purposes of administering VMs or other containers. We recommend that you use delete policies for automatically deleting outdated container images.

We recommend using the [image vulnerability scanner](../../container-registry/concepts/vulnerability-scanner.md) integrated into {{ container-registry-full-name }}.

## {{ certificate-manager-full-name }} {#cert-manager}

{{ certificate-manager-name }} allows you to manage TLS certificates for API gateways in the {{ api-gw-name }} service and for websites and buckets in {{ objstorage-name }}. {{ alb-full-name }} is integrated with {{ certificate-manager-name }} for storing and installing certificates. We recommend that you use {{ certificate-manager-name }} to obtain your certificates and rotate them automatically.

When using TLS in your application, we recommend that you limit the list of your trusted root certificate authorities (root CA). When using certificate pinning, keep in mind that Let's Encrypt certificates are [valid for 90 days](https://letsencrypt.org/docs/faq/#what-is-the-lifetime-for-let-s-encrypt-certificates-for-how-long-are-they-valid).
