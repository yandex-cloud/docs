# Secure configuration

This section provides recommendations to customers on security settings in {{ yandex-cloud }} services and the use of additional data protection tools.

## Default passwords {#default-credentials}

{{ yandex-cloud }} services don't have default credentials. In each service, the client specifically assigns user passwords and other secrets. However, software managed by the client that is installed on virtual machines or inside containers may contain initial credentials that should be changed (for example, the login `admin` with the password `admin`).

To automatically verify credentials, we recommend using paid security scanners or the following free tools:
- [changeme](https://github.com/ztgrace/changeme)
- [nmap script http-default-accounts](https://nmap.org/nsedoc/scripts/http-default-accounts.html)
- [nmap script ssh-brute](https://nmap.org/nsedoc/scripts/ssh-brute.html)

## Managing infrastructure {#infrastructure}

In IaaS services, the client is responsible for the configuration of their resources.

To check host compliance with security standards and best practices, we recommend using the free utility [OpenSCAP](https://www.open-scap.org/getting-started/).

### Serial console {#serial-console}

On VMs, access to the serial console is disabled by default. We don't recommend enabling it for security reasons. See the risks of using the serial console in [{#T}](../../../compute/operations/serial-console/index.md) in the Yandex Compute Cloud documentation.

When working with a serial console:
- Make sure that critical data is not output to the serial console.
- If you enable SSH access to the serial console, make sure that both the credentials management and the password used for logging in to the operating system locally are compliant with regulator standards. For example, in an infrastructure for storing payment card data, passwords must meet PCI DSS requirements: it must contain both letters and numbers, be at least 7 characters long, and be changed at least once every 90 days.

{% note info %}

According to the PCI DSS standard, access to a VM via a serial console is considered "non-console", and {{ yandex-cloud }} uses TLS encryption for it.

{% endnote %}

### Preparing VM images {#vm-preparing}

When deploying virtual machines, we recommend:
- Preparing a VM image whose system settings correspond to your information security policy. You can create an image using Packer. See [Getting started with Packer](../../../tutorials/infrastructure-management/packer-quickstart.md).
- Use this image to create a virtual machine or [instance group](../../../compute/concepts/instance-groups/index.md).
- Look up the virtual machine's information to check that it was created using this image.

### Terraform {#terraform}

With Terraform, you can manage a cloud infrastructure using configuration files. If you change the files, Terraform automatically determines which part of your configuration is already deployed and what should be added or removed. For more information, see [Getting started with Terraform](../../../tutorials/infrastructure-management/terraform-quickstart.md).

We don't recommend using private information in Terraform configuration files, such as passwords, secrets, personal data or payment system data. Instead, you should use services to store and use secrets in the configuration file, such as [HashiCorp Vault](https://cloud.yandex.com/marketplace/products/f2eokige6vtlf94uvgs2) or [{{ lockbox-name }}](https://cloud.yandex.com/services/lockbox) (to transfer secrets to the target object without using Terraform).

If you still need to enter private information in the configuration, you should take the following security measures:
- Specify the [sensitive = true](https://www.terraform.io/docs/language/values/outputs.html#sensitive-suppressing-values-in-cli-output) parameter for private information to disable outputting it to the console when running `terraform plan` and `terraform apply`.
- Use [terraform remote state](https://www.terraform.io/docs/language/state/remote.html). We recommend uploading a Terraform state to Yandex Object Storage (see [Uploading Terraform states to Object Storage](../../../tutorials/infrastructure-management/terraform-state-storage.md)) and setting up configuration locking using Yandex Database to prevent simultaneous editing by administrators (see a [setup example](https://github.com/yandex-cloud/examples/tree/master/terraform-ydb-state)). 
- Use the [mechanism for transferring secrets to Terraform using env](https://www.terraform.io/docs/cli/config/environment-variables.html#tf_var_name) instead of plain text, or use built-in {{ kms-name }} capabilities for [encrypting data in Terraform](https://cloud.yandex.com/en/docs/kms/tutorials/terraform-secret) (using a separate file with private data) ([learn more about this technique](https://blog.gruntwork.io/a-comprehensive-guide-to-managing-secrets-in-your-terraform-code-1d586955ace1#3073))

   For more information about Yandex Object Storage security, see [Object Storage](#object-storage) below.

{% note warning %}

When a configuration is deployed, you can delete the configuration file with private data.

{% endnote %}

### Integrity control {#integrity-control}

Numerous information security standards require integrity control of critical files. To do this, you can use free host-based solutions:

- [Wazuh](https://documentation.wazuh.com/current/learning-wazuh/detect-fs-changes.html)
- [Osquery](https://osquery.readthedocs.io/en/stable/deployment/file-integrity-monitoring/)

In [Yandex Cloud Marketplace](https://cloud.yandex.com/marketplace?categories=security), paid solutions are also available, such as [Kaspersky Security](https://cloud.yandex.com/marketplace/products/f2eghdh3f8nnbu389nsh).

### Dedicated hosts and side-channel attacks {#dedicated-hosts}

To ensure the best protection against CPU side-channel attacks (for example, Spectre or Meltdown):
- Use full-core virtual machines (instances with a CPU share of 100%).
- Use virtual machines with an even number of cores (2 cores, 4 cores, and so on).
- Install updates for your operating system and kernel that ensure side-channel attack protection (for example, [Kernel page-table isolation for Linux](https://en.wikipedia.org/wiki/Kernel_page-table_isolation), applications built with [Retpoline](https://en.wikipedia.org/wiki/Spectre_%28security_vulnerability%29)).

For the most security-critical resources, we recommend that you use [dedicated hosts](../../../compute/concepts/dedicated-host).

[Learn more](https://www.youtube.com/watch?v=VSP_cp6vDQQ&list=PL1x4ET76A10a9Jr6six11s0kRxeQ3fgom&index=17) about side-channel attack protection in cloud environments.

## Object Storage {#object-storage}

### Data encryption {#encryption}

#### Encryption at rest

When using Yandex Object Storage, make sure critical data is encrypted. Use any of the following approaches for encrypting data:
- Recommended approach: bucket encryption using KMS keys (server-side encryption). This encryption method protects against the accidental or intentional publication of bucket contents on the internet. See the instructions in [{#T}](../../../storage/operations/buckets/encrypt.md).

   {% note alert %}

   Data in {{ objstorage-short-name }} is encrypted using [envelope encryption](../../../kms/concepts/envelope.md). Deleting a key is the same as destroying all data encrypted with that key.

   {% endnote %}

- Integrating Object Storage with the KMS service for client-side encryption. For encryption methods, see [{#T}](../../../kms/tutorials/encrypt/index.md)
- Third-party client-side encryption libraries prior to sending data to Object Storage. When using third-party libraries for data encryption and your own key management methods, be sure that your operation model, algorithms, and key lengths comply with regulator requirements.

#### Encryption in transit

Object Storage supports secure connections over HTTPS. You can upload your own security certificate if a connection to your Object Storage site requires HTTPS access. Integration with Yandex Certificate Manager is also available. See [{#T}](../../../storage/operations/hosting/certificate.md), [Accessing a bucket over HTTPS](../../../storage/concepts/bucket.md#bucket-https).

When using Object Storage, be sure that support for TLS protocols below version 1.2 is disabled at the client level. Use the [aws:securetransport](../../../storage/s3/api-ref/policy/conditions.md) bucket policy to ensure running without TLS is disabled for the bucket.

### Access restriction {#object-storage-access}

We recommend assigning minimum roles to the bucket using IAM and supplementing/specifying them using BucketPolicy (for example, to restrict access to the bucket by IP addresses, grant granular rights to objects, and so on).

Access to Object Storage resources is verified at three levels:

- [IAM verification](../../../iam/concepts/index.md)
- [Bucket policy](../../../storage/concepts/policy.md)
- [Access Control Lists (ACLs)](../../../storage/concepts/acl.md)

Verification procedure:

1. If a request passes the IAM check, the next step is the bucket policy check.
1. Bucket policy rules are checked in the following order:
    1. If the request meets at least one of the `Deny` rules, access is denied.
    1. If the request meets at least one of the `Allow` rules, access is allowed.
    1. If the request doesn't meet any of the rules, access is denied.
1. If the request failed the IAM or bucket policy check, access verification is performed based on an object's ACL.

In the IAM service, a bucket inherits the same access rights as those of the folder and cloud where it's located. For more information, see [Inheritance of bucket access rights by {{ yandex-cloud }} system groups](../../../storage/concepts/acl.md#inheritance). For this reason, we don't recommend assigning roles for entire folders in Object Storage. We recommend assigning only the minimum necessary roles to certain buckets or objects in Object Storage.

Bucket policies are used for additional data protection, for example, to restrict access to a bucket by IP addresses, grant granular rights to objects, and so on.

With ACLs, you can grant access to an object bypassing IAM verification and bucket policies. We recommend setting strict ACLs for buckets.

![](../../../_assets/overview/solution-library-icon.svg) [Example of a secure Yandex Object Storage configuration: Terraform](https://github.com/yandex-cloud/yc-solution-library-for-security/tree/master/configuration/hardering_bucket)

### Deletion protection and version backups {#versioning}

When processing critical data in buckets, you must ensure that data is protected from deletion and that versions are backed up. This can be achieved by versioning and lifecycle management mechanisms.

Bucket versioning is the ability to store the history of object versions. Each version is a full copy of the object and occupies space in Object Storage. By using version control, you can protect your data from both unintentional user actions and application faults.

If you delete/modify an object with versioning enabled, a new version of the object with a new ID is effectively created. In the case of deletion, the object becomes unreadable, but its version is kept and can be restored.

For more information about setting up versioning, see [{#T}](../../../storage/concepts/versioning.md) in the Object Storage documentation.

The lifecycle management mechanism allows you to set a policy for deleting or moving data, for example:

- Delete all non-current versions of objects (condition type: NoncurrentVersionExpiration) a specific number of days after the versions become non-current.
- Delete all current versions of objects (condition type: Expiration) a specific number of days after they are uploaded.

For more information about lifecycles, see [{#T}](../../../storage/concepts/lifecycles.md) and [{#T}](../../../storage/s3/api-ref/lifecycles/xml-config.md) in the Object Storage documentation.

The storage period of critical data in a bucket is determined by the client's information security requirements and information security standards. For example, the PCI DSS standard states that audit logs should be stored for at least one year and should be readily available online for at least three months.

### Audits {#audit}

When using Object Storage to store critical data, you must enable logging of actions with buckets and configure the versioning mechanism and lifecycle for objects with logs. For more information, see [{#T}](../../../storage/concepts/server-logs.md) in the Object Storage documentation.

You can also analyze Object Storage logs in DataLens. Learn more in the article [Analyzing Object Storage logs using DataLens](https://cloud.yandex.ru/blog/posts/2021/04/storage-logs).

### Cross-Origin Resource Sharing (CORS) {#cors}

If you need cross-domain requests to objects in buckets, the client should configure the CORS (cross-origin resource sharing) policy in accordance with the client's information security requirements. For more information, see [{#T}](../../../storage/s3/api-ref/cors/xml-config.md) in the Object Storage documentation.

## Managed Services for Databases {#managed-services-for-databases}

We recommend prohibiting internet access to databases that contain critical data, in particular PCI DSS data or private data. Configure security groups to allow connections to the DBMS only from specific IP addresses. See the instructions in [{#T}](../../../vpc/operations/security-group-create.md). You can specify a security group in the cluster settings or when creating the cluster in the network settings section.

You shouldn't enable access to databases containing critical data from the management console, DataLens, or other services unless you have to. You may need access to the database from the management console to send SQL queries to the database and visualize the data structure, or access from DataLens to visualize and analyze data. For such access, the {{ yandex-cloud }} service network is used, with authentication and TLS encryption. You can enable and disable access from the management console, DataLens, or other services in the cluster settings or when creating it in the advanced settings section.

## Yandex Cloud Functions and Yandex API Gateway {#cloud-functions-api-gateway}

### Using a service account {#cloud-functions-service-account}

To get an IAM token when executing a function, you must assign a service account for the function. See the instructions in [{#T}](../../../functions/operations/function-sa.md). In this case, the function receives an IAM token using built-in {{ yandex-cloud }} mechanisms without having to transfer any secrets to the function from outside.

### Function access control {#cloud-functions-access-control}

In cases where the use of public functions is not explicitly required, we recommend that you use private functions. For more information about setting up access to functions, see [{#T}](../../../functions/operations/function-public.md).

### Side-channel attacks in Cloud Functions {#cloud-functions-side-channel}

Hosts and hypervisors running Cloud Functions contain all the applicable updates for side-channel attack protection. However, keep in mind that different clients' functions are not isolated by cores. Thus, there is technically an attack surface between one user's function and another's. {{ yandex-cloud }} security experts believe that side-channel attacks are unlikely in the context of functions, but this risk must be accounted for, particularly in the overall threats and risk analysis model employed by the PCI DSS infrastructure.

### Specifics of time synchronization in functions {#cloud-functions-time}

The Cloud Functions service does not guarantee time synchronization prior to or during execution of requests by functions. To generate a function log with exact timestamps on the Cloud Functions side, output the log to stdout. The client can also independently accept function execution logs and label them with a timestamp on the receiving side. In this case, the timestamp is taken from the time source synced with {{ yandex-cloud }}. For more information about time synchronization, see [{#T}](../../../compute/tutorials/ntp.md) in the Compute Cloud documentation.

### Managing HTTP headers in functions {#http-headers}

If the function is called to process an HTTP request, the returned result should be a JSON document containing the HTTP response code, response headers, and response content. Cloud Functions will automatically process this JSON and the user will receive data as a standard HTTP response.
The client needs to manage the response headers on their own in accordance with regulator requirements and the threat model. For more information on how to process an HTTP request, see [Invoking a function using HTTP](../../../functions/concepts/function-invoke.md#http) in the Cloud Functions documentation.

## Yandex Database {#ydb}

### Operations with data {#ydb-data}

It's prohibited to use confidential data, particularly PCI DSS data, as the names of database, tables, columns, folders, and so on. It's prohibited to send PCI DSS data to YDB (both Dedicated and Serverless) as clear text. Prior to sending data, be sure to encrypt the data at the application level. For this you can use the KMS service or any other PCI DSS-compliant method. For data where the storage period is known in advance, we recommend that you configure the [Time To Live](../../../ydb/concepts/ttl.md) function.

### SQL injection protection {#sql-injections}

When working with a database, use [parameterized prepared statements](../../../ydb/ydb-sdk/#param-prepared-queries.md) to protect against SQL injection. If the application dynamically generates query templates, you must prevent the injection of untrusted user input into the SQL query template.

### Network access {#ydb-network}

When accessing the database in Dedicated mode, we recommend that you use it inside VPC, disabling public access to it from the internet. In Serverless mode, the database can be accessed from the internet. You must therefore take this into account when modeling threats to your PCI DSS infrastructure. {% if audience == "external" %} For more information about operation modes, see [Serverless and Dedicated modes Yandex Database](../../../ydb/concepts/serverless_and_dedicated.md) in YDB documentation. {% endif %}

When setting up database permissions, use the principle of least privilege.

### Backups {#ydb-backup}

When creating [on-demand backups](../../../ydb/pricing/serverless#rules-auto-backup-storage), make sure that the backup data is properly protected.

When creating backups on demand in Object Storage, follow the recommendations in the [Object Storage](#object-storage) subsection (for example, use the built-in bucket encryption feature).

## Container Registry and Container Solution {#container-registry-solution}

We do not recommend that you use privileged containers to run loads that process untrusted user input. Privileged containers must be used for the purposes of administering virtual machines or other containers. We recommend that you use delete policies for automatically deleting outdated container images.

We recommend using the image vulnerability scanner integrated into Yandex Container Registry.

<!-- insert a link to the documentation where it appears -->

## Certificate Manager {#cert-manager}

Certificate Manager lets you manage TLS gateway certificates for Yandex API Gateway and sites and buckets in Yandex Object Storage. Application Load Balancer is integrated with Certificate Manager for storing and installing certificates. We recommend that you use Certificate Manager to obtain your certificates and rotate them automatically.

When using TLS in your application, we recommend that you limit the list of your trusted root certificate authorities (root CA). When using certificate pinning, keep in mind that Let's Encrypt certificates are [valid for 90 days](https://letsencrypt.org/docs/faq/#what-is-the-lifetime-for-let-s-encrypt-certificates-for-how-long-are-they-valid).

