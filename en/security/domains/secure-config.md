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

To check your host compliance with the security standards and best practices, we recommend using the free utility [OpenSCAP](https://www.open-scap.org/getting-started/).

### Serial console {#serial-console}

On VMs, access to the serial console is disabled by default. We don't recommend enabling it for security reasons. The risks of using the serial console are listed in the {{ compute-full-name }} documentation, [{#T}](../../compute/operations/serial-console/index.md).

When working with a serial console:
- Make sure that critical data is not output to the serial console.
- If you enable SSH access to the serial console, make sure that both the credentials management and the password used for logging in to the operating system locally are compliant with regulator standards. For example, in an infrastructure for storing payment card data, passwords must meet PCI DSS requirements: it must contain both letters and numbers, be at least 7 characters long, and be changed at least once every 90 days.

{% note info %}

According to the PCI DSS standard, access to a VM via a serial console is considered "non-console", and {{ yandex-cloud }} uses TLS encryption for it.

{% endnote %}

### Preparing VM images {#vm-preparing}

When deploying virtual machines, we recommend:
- Preparing a VM image whose system settings correspond to your information security policy. You can create an image using Packer. See [Getting started with Packer](../../tutorials/infrastructure-management/packer-quickstart.md).
- Use this image to create a virtual machine or [instance group](../../compute/concepts/instance-groups/index.md).
- Look up the virtual machine's information to check that it was created using this image.

### Terraform {#terraform}

With Terraform, you can manage a cloud infrastructure using configuration files. If you change the files, Terraform automatically determines which part of your configuration is already deployed and what should be added or removed. For more information, see [Getting started with Terraform](../../tutorials/infrastructure-management/terraform-quickstart.md).

We don't recommend using private information in Terraform configuration files, such as: passwords, secrets, personal data, or payment system data. Instead, you should use services to store and use secrets in the configuration file, such as: {% if product == "yandex-cloud" %}[HashiCorp Vault](/marketplace/products/yc/vault-yckms) from {{ marketplace-name }}{% endif %}{% if product == "cloud-il" %}HashiCorp Vault{% endif %} or [{{ lockbox-name }}](../../lockbox/index.yaml) (to transfer secrets to the target object without using Terraform).

If you still need to enter private information in the configuration, you should take the following security measures:
- Specify the [sensitive = true](https://www.terraform.io/docs/language/values/outputs.html#sensitive-suppressing-values-in-cli-output) parameter for private information to disable outputting it to the console when running `terraform plan`and `terraform apply`.
- Use [terraform remote state](https://www.terraform.io/docs/language/state/remote.html). We recommend uploading a Terraform state to {{ objstorage-full-name }} (see [Uploading Terraform states to {{ objstorage-full-name }}](../../tutorials/infrastructure-management/terraform-state-storage.md)){% if product == "yandex-cloud" %} and setting up configuration locking using {{ ydb-full-name }} to prevent simultaneous editing by administrators (see a [setup example](https://github.com/yandex-cloud/examples/tree/master/terraform-ydb-state)){% endif %}. 
- Use the mechanism for [transferring secrets to Terraform via env](https://www.terraform.io/docs/cli/config/environment-variables.html#tf_var_name) instead of plain text or use built-in {{ kms-name }} features for [encrypting data in Terraform](../../kms/tutorials/terraform-secret.md) (using a separate file with private data) ([learn more about this technique](https://blog.gruntwork.io/a-comprehensive-guide-to-managing-secrets-in-your-terraform-code-1d586955ace1#3073)).

   For more information about {{ objstorage-name }} security, see [{{ objstorage-full-name }}](#object-storage) below.

{% note warning %}

When a configuration is deployed, you can delete the configuration file with private data.

{% endnote %}

### Integrity control {#integrity-control}

Numerous information security standards require integrity control of critical files. To do this, you can use free host-based solutions:
- [Wazuh](https://documentation.wazuh.com/current/learning-wazuh/detect-fs-changes.html)
- [Osquery](https://osquery.readthedocs.io/en/stable/deployment/file-integrity-monitoring/)

{% if product == "yandex-cloud" %}
In {{ marketplace-full-name }}, paid solutions are also available, such as [Kaspersky Security](/marketplace/products/kaspersky/kaspersky-hybrid-cloud-security-payg).

{% endif %}
### Side-channel attacks {#side-channel}

To ensure the best protection against CPU side-channel attacks (for example, Spectre or Meltdown):

- Use full-core virtual machines (instances with a CPU share of 100%).
- Use virtual machines with an even number of cores (2 cores, 4 cores, and so on).
- Install updates for your operating system and kernel that ensure side-channel attack protection (for example, [Kernel page-table isolation for Linux](https://en.wikipedia.org/wiki/Kernel_page-table_isolation), applications built using [Retpoline](https://en.wikipedia.org/wiki/Spectre_%28security_vulnerability%29)).

{% if product == "yandex-cloud" %}

We recommend that you use [dedicated hosts](../../compute/concepts/dedicated-host) for the most security-critical resources.

[Learn more](https://www.youtube.com/watch?v=VSP_cp6vDQQ&list=PL1x4ET76A10a9Jr6six11s0kRxeQ3fgom&index=17) about side-channel attack protection in cloud environments.

{% endif %}
## {{ objstorage-full-name }} {#object-storage}

### Data encryption {#encryption}

When using {{ objstorage-name }}, set up encryption for critical data at rest and in transit. {{ objstorage-name }} provides built-in encryption. For more information, see [{#T}](encryption.md).

### Access restriction {#object-storage-access}

We recommend assigning minimum roles to a bucket using {{ iam-short-name }} and supplementing/specifying them using BucketPolicy (for example, to restrict access to the bucket by IP addresses, grant granular rights to objects, and so on).

Access to {{ objstorage-name }} resources is verified at three levels:

- [{{ iam-short-name }} verification](../../iam/concepts/index.md)
- [Bucket policies](../../storage/concepts/policy.md)
- [Access Control Lists (ACLs)](../../storage/concepts/acl.md)

Verification procedure:

1. If a request passes the {{ iam-short-name }} check, the next step is the bucket policy check.
1. Bucket policy rules are checked in the following order:
   1. If the request meets at least one of the `Deny` rules, access is denied.
   1. If the request meets at least one of the `Allow` rules, access is allowed.
   1. If the request doesn't meet any of the rules, access is denied.
1. If the request fails the {{ iam-short-name }} or bucket policy check, access verification is performed based on an object's ACL.

In the {{ iam-short-name }} service, a bucket inherits the same access rights as those of the folder and cloud where it's located. For more information, see [Inheritance of bucket access rights by {{ yandex-cloud }} system groups](../../storage/concepts/acl.md#inheritance). For this reason, we don't recommend assigning roles for entire folders in {{ objstorage-name }}. We recommend that you only assign the minimum required roles to certain buckets or objects in {{ objstorage-name }}.

Bucket policies are used for additional data protection, for example, to restrict access to a bucket by IP addresses, grant granular rights to objects, and so on.

With ACLs, you can grant access to an object bypassing {{ iam-short-name }} verification and bucket policies. We recommend setting strict ACLs for buckets.

{% if product == "yandex-cloud" %}
![](../../_assets/overview/solution-library-icon.svg) [Example of a secure {{ objstorage-name }} configuration: Terraform](https://github.com/yandex-cloud/yc-solution-library-for-security/tree/master/configuration/hardering_bucket)

{% endif %}
### Deletion protection and version backups {#versioning}

When processing critical data in buckets, you must ensure that data is protected from deletion and that versions are backed up. This can be achieved by versioning and lifecycle management mechanisms.

Bucket versioning is the ability to store the history of object versions. Each version is a complete copy of the object and occupies space in {{ objstorage-short-name }}. By using version control, you can protect your data from both unintentional user actions and application faults.

If you delete/modify an object with versioning enabled, a new version of the object with a new ID is effectively created. In the case of deletion, the object becomes unreadable, but its version is kept and can be restored.

For more information about setting up versioning, see the {{ objstorage-short-name }} documentation, [{#T}](../../storage/concepts/versioning.md).

The lifecycle management mechanism allows you to set a policy for deleting or moving data, for example:
- Delete all non-current versions of objects (condition type: NoncurrentVersionExpiration) a specific number of days after the versions become non-current.
- Delete all current versions of objects (condition type: Expiration) a specific number of days after they are uploaded.

For more information about lifecycles, see the {{ objstorage-short-name }} documentation, [{#T}](../../storage/concepts/lifecycles.md) and [{#T}](../../storage/s3/api-ref/lifecycles/xml-config.md).

The storage period of critical data in a bucket is determined by the client's information security requirements and information security standards. For example, the PCI DSS standard states that audit logs should be stored for at least one year and should be readily available online for at least three months.


{% if product == "yandex-cloud" %}

### Audits {#audit}

When using {{ objstorage-short-name }} to store critical data, be sure to enable logging of actions with buckets and configure the versioning mechanism and lifecycle for objects with logs. For more information, see the {{ objstorage-short-name }} documentation, [{#T}](../../storage/concepts/server-logs.md).

You can also analyze {{ objstorage-short-name }} logs in {{ datalens-short-name }}. Learn more in the article [Analyzing {{ objstorage-name }} logs using {{ datalens-short-name }}](https://cloud.yandex.ru/blog/posts/2021/04/storage-logs).

{% endif %}


### Cross-Origin Resource Sharing (CORS) {#cors}

If you need cross-domain requests to objects in buckets, the client should configure the CORS (cross-origin resource sharing) policy in accordance with the client's information security requirements. For more information, see the {{ objstorage-short-name }} documentation, [{#T}](../../storage/s3/api-ref/cors/xml-config.md).

## Managed Services for Databases {#managed-services-for-databases}

We recommend prohibiting internet access to databases that contain critical data, in particular PCI DSS data or private data. Configure security groups to only allow connections to the DBMS from specific IP addresses. See the instructions in [{#T}](../../vpc/operations/security-group-create.md). You can specify a security group in the cluster settings or when creating the cluster in the network settings section.

You shouldn't enable access to databases containing critical data from the management console{% if product == "yandex-cloud" %}, {{ datalens-name }}{% endif %}, or other services unless you have to. You may need access to the database from the management console to send SQL queries to the database and visualize the data structure{% if product == "yandex-cloud" %}, or access from {{ datalens-name }} to visualize and analyze data. For such access{% endif %}{% if product == "cloud-il" %}For such access{% endif %}, use the {{ yandex-cloud }} service network with authentication and TLS encryption. You can enable and disable {% if product == "yandex-cloud" %}access from the management console, {{ datalens-name }}{% endif %}{% if product == "cloud-il" %}access from the management console{% endif %}, or other services in the cluster settings or when creating it in the advanced settings section.

{% if product == "yandex-cloud" %}
## {{ sf-name }} and {{ api-gw-full-name }} {#cloud-functions-api-gateway}

### Using a service account {#cloud-functions-service-account}

To get an IAM token when executing a function, you must assign a service account for the function. See the instructions in [{#T}](../../functions/operations/function-sa.md). In this case, the function receives an IAM token using built-in {{ yandex-cloud }} mechanisms without having to transfer any secrets to the function from outside.

### Function access control {#cloud-functions-access-control}

In cases where the use of public functions is not explicitly required, we recommend that you use private functions. For more information about setting up access to functions, see [{#T}](../../functions/operations/function-public.md).

### Side-channel attacks in {{ sf-name }} {#cloud-functions-side-channel}

Hosts and hypervisors running {{ sf-name }} contain all the applicable updates for side-channel attack protection. However, keep in mind that different clients' functions are not isolated by cores. Thus, there is technically an attack surface between one user's function and another's. {{ yandex-cloud }} security experts believe that side-channel attacks are unlikely in the context of functions, but this risk must be accounted for, particularly in the overall threats and risk analysis model employed by the PCI DSS infrastructure.

### Specifics of time synchronization in functions {#cloud-functions-time}

The {{ sf-name }} service does not guarantee time synchronization prior to or during execution of requests by functions. To generate a function log with exact timestamps on the {{ sf-name }} side, output the log to stdout. The client can also independently accept function execution logs and label them with a timestamp on the receiving side. In this case, the timestamp is taken from the time source synced with {{ yandex-cloud }}. For more information about time synchronization, see the Compute Cloud documentation, [{#T}](../../compute/tutorials/ntp.md).

### Managing HTTP headers in functions {#http-headers}

If the function is called to process an HTTP request, the returned result should be a JSON document containing the HTTP response code, response headers, and response content. {{ sf-name }} will automatically process this JSON and the user will receive data as a standard HTTP response.
The client needs to manage the response headers on their own in accordance with regulator requirements and the threat model. For more information on how to process an HTTP request, see the {{ sf-name }} documentation, [Invoking a function using HTTP](../../functions/concepts/function-invoke.md#http).

{% endif %}
{% if product == "yandex-cloud" %}
## {{ ydb-name }} {#ydb}

### Operations with data {#ydb-data}

It's prohibited to use confidential data, particularly PCI DSS data, as the names of database, tables, columns, folders, and so on. It's prohibited to send PCI DSS data to {{ ydb-full-name }} (both Dedicated and Serverless) as clear text. Prior to sending data, be sure to encrypt the data at the application level. For this you can use the {{ kms-short-name }} service or any other PCI DSS-compliant method. For data where the storage period is known in advance, we recommend that you configure the [Time To Live](https://ydb.tech/en/docs/concepts/ttl) option.

### SQL injection protection {#sql-injections}

When working with the database, use [parameterized prepared statements](https://ydb.tech/en/docs/reference/ydb-sdk/example/#param-queries) to protect against SQL injection. If the application dynamically generates query templates, you must prevent the injection of untrusted user input into the SQL query template.

### Network access {#ydb-network}

When accessing the database in Dedicated mode, we recommend that you use it inside VPC, disabling public access to it from the internet. In Serverless mode, the database can be accessed from the internet. You must therefore take this into account when modeling threats to your PCI DSS infrastructure. {% if audience == "external" %} For more information about operating modes, see the YDB documentation, [Serverless and Dedicated modes](../../managed-ydb/concepts/serverless-and-dedicated.md). {% endif %}

When setting up database permissions, use the principle of least privilege.

### Backups {#ydb-backup}

When creating [on-demand backups](../../managed-ydb/pricing/serverless.md#rules-auto-backup-storage), make sure that the backup data is properly protected.

When creating backups on demand in {{ objstorage-short-name }}, follow the recommendations in the [{{ objstorage-short-name }}](#object-storage) subsection above (for example, use the built-in bucket encryption feature).
{% endif %}

## {{ container-registry-full-name }}{% if product == "yandex-cloud" %} and {{ cos-full-name }} {% endif %}{#container-registry-solution}

We do not recommend that you use privileged containers to run loads that process untrusted user input. Privileged containers must be used for the purposes of administering virtual machines or other containers. We recommend that you use delete policies for automatically deleting outdated container images.

We recommend using the image vulnerability scanner integrated into {{ container-registry-full-name }}.

## {{ certificate-manager-full-name }} {#cert-manager}

{{ certificate-manager-full-name }} lets you manage TLS gateway certificates for{% if product == "yandex-cloud" %} {{ api-gw-name }} and {% endif %} websites and buckets in {{ objstorage-name }}. {{ alb-name }} is integrated with {{ certificate-manager-short-name }} for storing and installing certificates. We recommend that you use {{ certificate-manager-short-name }} to obtain your certificates and rotate them automatically.

When using TLS in your application, we recommend that you limit the list of your trusted root certificate authorities (root CA). When using certificate pinning, keep in mind that Let's Encrypt certificates are [valid for 90 days](https://letsencrypt.org/docs/faq/#what-is-the-lifetime-for-let-s-encrypt-certificates-for-how-long-are-they-valid).
