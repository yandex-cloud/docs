# Data encryption and key management

{{ yandex-cloud }} provides built-in encryption features for a number of services. It's the customer's responsibility to enable encryption in these services and implement encryption in other components for processing critical data. Data encryption and encryption key management is done by [{{ kms-full-name }}](../../kms/) ({{ kms-short-name }}).

{{ yandex-cloud }} APIs support cipher suites in specific TLS versions that are compliant with PCI DSS and other standards.


## Encryption at rest {#encryption-at-rest}

By default, all user data at rest is encrypted at the {{ yandex-cloud }} level. Encryption at the {{ yandex-cloud }} level implements one of the best practices for protecting user data and is performed using {{ yandex-cloud }} keys.

If your corporate information security policy sets specific key size and rotation frequency requirements, you can encrypt data with your own keys. To do this, you can use the {{ kms-short-name }} service and its integration with other {{ yandex-cloud }} services or implement data plane encryption completely on your own.

{{ yandex-cloud }} provides data-at-rest encryption for the following services:

* [{{objstorage-full-name}}](#storage-at-rest)
* [{{managed-k8s-name}}](#kubernetes)

### {{objstorage-full-name}} {#storage-at-rest}

To protect critical data in [{{ objstorage-full-name }}](../../storage/), we recommend using bucket server-side encryption with [{{ kms-full-name }}](../../kms/) keys. This encryption method protects against the accidental or intentional publication of bucket contents on the internet. For more information, see [{#T}](../../storage/concepts/encryption.md) in the {{ objstorage-name }} documentation.


### {{managed-k8s-name}} {#kubernetes}

[{{managed-k8s-name}}](../../managed-kubernetes/) has a built-in secret encryption mechanism. For more information, see [{#T}](#k8s-secrets) below.

## Encryption in transit {#in-transit}

In most cases, you can only connect to {{ yandex-cloud }} services over HTTPS. However, some scenarios allow data plane access to services over HTTP, without connection encryption at the application level. In all these scenarios, the user can choose the protocol to be used for data plane operations (HTTP or HTTPS) in the service settings, and specify their own TLS certificate if HTTPS is selected.

{% note warning %}

When working with (or connecting to) {{ yandex-cloud }} APIs, make sure to use TLS 1.2 or higher, since its prior versions are vulnerable. For example, by using the gRPC interfaces of {{ yandex-cloud }}, you can enforce TLS 1.2 or higher. That's because gRPC is based on HTTP/2 where TLS 1.2 is the minimum supported TLS version. Support for legacy TLS protocols in {{ yandex-cloud }} services will [gradually be discontinued](../security-bulletins/index.md#discontinue-support-for-deprecated-tls).

{% endnote %}

{{ yandex-cloud }} lets you use your own TLS certificates for the following services:
- [{{objstorage-full-name}}](#storage-in-transit)
- [{{alb-full-name}}](#load-balancer)
- [{{vpc-name}} (VPC)](#vpc)
   
- [{{api-gw-full-name}}](#api-gw)
- [{{cdn-full-name}}](#cdn)

### {{objstorage-full-name}} {#storage-in-transit}

[{{objstorage-full-name}}](../../storage/) supports secure connections over HTTPS. You can upload your own security certificate if a connection to your Object Storage site requires HTTPS access. Integration with [{{certificate-manager-full-name}}](../../certificate-manager/). See the following instructions in the Object Storage documentation:

- [{#T}](../../storage/operations/hosting/certificate.md)
- [{#T}](../../storage/concepts/bucket.md#bucket-https)

When using Object Storage, be sure that support for TLS protocols below version 1.2 is disabled at the client level. Use the bucket policy [aws:securetransport](../../storage/s3/api-ref/policy/conditions.md) to ensure that running without TLS is disabled for the bucket.

### {{alb-full-name}} {#load-balancer}

[{{alb-full-name}}](../../application-load-balancer/) supports an HTTPS listener with a [certificate](../../certificate-manager/concepts/imported-certificate.md) uploaded from {{certificate-manager-name}}. See [how to set up the listener](../../application-load-balancer/concepts/application-load-balancer.md#listener-example) in the Application Load Balancer documentation.

### {{vpc-name}} (VPC) {#vpc}

Possible options for using encrypted communication channels are described in [{#T}](network.md#remote-access).

Please note that [{{interconnect-full-name}}](../../interconnect/) does not provide built-in encryption mechanisms. Be sure to enable encryption in transit on your own by:
- Installing in the cloud VPN gateways with encryption enabled, such as VMs based on [Check Point](/marketplace?search=Check+Point) images from {{ marketplace-full-name }}. 
- Using application-level encryption.
- Using [GOST VPN](network.md#gost-vpn).


### {{api-gw-full-name}} {#api-gw}

[{{api-gw-full-name}}](../../api-gateway/) supports secure connections over HTTPS. You can upload your own security certificate to access your [API gateway](../../api-gateway/concepts/) over HTTPS.

### {{cdn-full-name}} {#cdn}

[{{cdn-full-name}}](../../cdn/) supports secure connections over HTTPS. You can upload your own security certificate to access your [CDN resource](../../cdn/concepts/resource.md) over HTTPS.

## Providing encryption on your own {#self-encryption}

When using services with no built-in encryption, it's the customer's responsibility to ensure that critical data is encrypted.


### {{ compute-full-name }} {#self-encryption-compute}

If disk encryption is mandatory under regulatory requirements, place your application files on a VM's secondary disk (not the boot disk) and configure full disk encryption for it.

![](../../_assets/overview/solution-library-icon.svg)[Solution: VM disk encryption using {{ kms-short-name }}](https://github.com/yandex-cloud/yc-solution-library-for-security/tree/master/encrypt_and_keys/encrypt_disk_VM)

### Managed Services for Databases {#mdb}

If data encryption is mandatory under regulatory requirements, make sure to encrypt data at the application level prior to writing it to a database, for example, using {{ kms-short-name }}.

### {{ message-queue-full-name }} {#message-queue}

If you use [{{message-queue-full-name}}](../../message-queue/) to transfer critical data or secrets (encryption keys, API keys, and so on), be sure to encrypt this data at the application level before you send it to {{ message-queue-short-name }}, for example, using {{ kms-short-name }}. For the {{ kms-short-name }} key, we recommend that you set up a rotation period greater than or equal to the maximum message processing time in {{ message-queue-short-name }}.


### {{ objstorage-full-name }} {#storage-self-encryption}

For client-side encryption before uploading data to a [{{ objstorage-full-name }}](../../storage/) bucket, you can use the following approaches:

{% include [storage-encryption-client-side](../../_includes/storage/encryption-client-side.md) %}


### Recommended cryptographic libraries {#libs}

For client-side encryption, we recommend that you use the following libraries:

- AWS Encryption SDK and its [{{ kms-short-name }} integration](../../kms/tutorials/encrypt/aws-encryption-sdk.md).
- Google Tink and its [{{ kms-short-name }} integration](../../kms/tutorials/encrypt/google-tink.md).
- [{{ yandex-cloud }} SDK](../../kms/tutorials/encrypt/sdk.md) with any other cryptographic library compatible with PCI DSS or any standards used in your company.

For a comparison of libraries, see the {{ kms-short-name }} documentation, [{#T}](../../kms/tutorials/encrypt/index.md).

## Managing keys {#key-management}

We recommend that you use [{{ kms-full-name }}](../../kms/) for encrypting data and managing keys. {{ kms-short-name }} helps you protect data in the {{ yandex-cloud }} infrastructure. You can also use it to encrypt or decrypt any of your data.

{{ kms-short-name }} uses AES-GCM encryption mode. You can select the key length (128, 192, or 256 bits) and set up the preferred key rotation period. You can also create a key whose every cryptographic operation will only be handled inside a hardware security module (HSM). For more information, see [{#T}](../../kms/concepts/hsm.md).

### Authentication and authorization in {{ kms-short-name }} {#kms-authorization}

To access the {{ kms-short-name }} service, you need an [IAM token](../../iam/concepts/authorization/iam-token.md).

To automate operations with {{ kms-short-name }}, we recommend that you create a [service account](../../iam/concepts/users/service-accounts.md) and run commands and scripts under it. If you use VMs, get an IAM token for your service account using the mechanism of [assigning a service account](../../compute/operations/vm-connect/auth-inside-vm.md) to your VM. For other ways to get an IAM token for your service account, see the {{ iam-short-name }} documentation, [{#T}](../../iam/operations/iam-token/create-for-sa.md).

We recommend that you grant your users and service accounts granular permissions for specific keys in the {{ kms-short-name }} service. For more information, see the {{ kms-short-name }} documentation, [{#T}](../../kms/security/index.md).

For more information about security measures for access control, see [{#T}](access.md).

### Key rotation {#key-rotation}

To improve the security of your infrastructure, we recommend that you categorize your encryption keys into two groups:
1. Keys for services that process critical data, but don't store it. For example, {{ message-queue-full-name }},{{ sf-full-name }}.
2. Keys for services that store critical data. For example, Managed Services for Databases.

For the first group of keys, we recommend that you set up automatic key rotation with a rotation period slightly longer than the data processing period in these services. When the rotation period expires, the old key versions must be deleted. In the case of automatic rotation and the deletion of old key versions, previously processed data can't be restored and decrypted.

For data storage services, we recommend that you either manually rotate keys or use automatic key rotation, depending on your internal procedures for processing critical data.

A secure value for AES-GCM mode is encryption using 4294967296 (= 2<sup>32</sup>) blocks. Having reached this number of encrypted blocks, you need to create a new DEK version. For more information about the AES-GCM operating mode, see the [NIST materials](https://nvlpubs.nist.gov/nistpubs/Legacy/SP/nistspecialpublication800-38d.pdf).

{% note alert %}

Destroying any version of a key means destroying all data encrypted with it. You can protect a key against deletion by setting the [deletionProtection](../../kms/api-ref/SymmetricKey/index.md) parameter. However, it doesn't protect against deleting individual versions.

{% endnote %}

For more information about key rotation, see the {{ kms-short-name }} documentation, [{#T}](../../kms/concepts/version.md).

## Managing secrets {#secrets}

Don't use critical data and access secrets (such as authentication tokens, API keys, and encryption keys) explicitly in the code, cloud object names and descriptions, VM metadata, and so on. Instead, use secret storage services like {{ lockbox-name }} or HashiCorp Vault.

### {{ lockbox-name }} {#lockbox}

{{ lockbox-name }} securely stores secrets: they are only stored in encrypted form with encryption performed using {{ kms-short-name }}. For secret access control, use service roles.

For instructions on how to use the service, see the Lockbox [documentation](../../lockbox/).

### HashiCorp Vault {#hashicorp-vault}

[Vault](https://www.vaultproject.io/) lets you use {{ kms-short-name }} as a trusted service for encrypting secrets. This is implemented through the [Auto Unseal](https://www.vaultproject.io/docs/concepts/seal#auto-unseal) mechanism.


To store secrets with Vault, you can use a VM based on an image from [{{ marketplace-full-name }}](/marketplace/products/yc/vault-yckms) with a pre-installed HashiCorp Vault build and Auto Unseal support. Instructions for setting up Auto Unseal are provided in the {{ kms-short-name }} documentation, [{#T}](../../kms/tutorials/vault-secret.md).

### Secrets in {{ k8s }} {#k8s-secrets}

To store secrets, such as passwords, OAuth tokens, and SSH keys, use one of the following methods:

- How [{{ k8s }} secrets](https://kubernetes.io/docs/concepts/configuration/secret/) work.

   By default, secrets are stored unencrypted in etcd. However, {{managed-k8s-name}} lets you encrypt secrets using {{ kms-short-name }}. To enable the encryption of secrets, specify a {{ kms-short-name }} key when creating a {{ k8s }} cluster. You can't add the key when you edit the cluster. For more information, see the {{ kms-short-name }} documentation, [{#T}](../../kms/tutorials/k8s.md).

- {{ lockbox-name }}.

   See the instructions in the {{ lockbox-name }} documentation, [{#T}](../../lockbox/tutorials/kubernetes-lockbox-secrets.md).


- [HashiCorp Vault with {{ kms-short-name }}](/marketplace/products/yc/vault-yckms) support from {{ marketplace-full-name }}.

### Transferring secrets to a VM using {{ TF }} and {{ kms-short-name }} {#secrets-tf-kms}

{{ kms-short-name }} supports the encryption of secrets used in a {{ TF }} configuration, such as to transfer secrets to a VM in encrypted form. See the instructions in the {{ kms-short-name }} documentation, [{#T}](../../kms/tutorials/terraform-secret.md). It's not safe to explicitly pass secrets through environment variables, because they are displayed in the VM properties.


![](../../_assets/overview/solution-library-icon.svg)[Solution: Encrypting secrets in {{ TF }} to transfer them to a VM from a Container Optimized Image](https://github.com/yandex-cloud/yc-solution-library-for-security/tree/master/encrypt_and_keys/terraform%2BKMS%2BCOI)

For other recommendations on how to use {{ TF }} safely, see [Secure configuration: {{ TF }}](secure-config.md#terraform).
