# Data encryption and key management

Yandex.Cloud provides built-in encryption features for a number of services. It's the customer's responsibility to enable encryption in these services and implement encryption in other components for processing critical data. Data encryption and encryption key management is done by [{{ kms-full-name }}](../../../kms/index.yaml) (KMS).

{{ yandex-cloud }} APIs support cipher suites in specific TLS versions that are compliant with PCI DSS and other standards.

## Encryption at rest

By default, all user data at rest is encrypted at the {{ yandex-cloud }} level. Encryption at the {{ yandex-cloud }} level implements one of the best practices for protecting user data and is performed using {{ yandex-cloud }} keys.

If your corporate information security policy sets specific key size and rotation frequency requirements, you can encrypt data with your own keys. To do this, you can use the KMS service and its integration with other {{ yandex-cloud }} services or implement encryption on the data plane level completely on your own.

{{ yandex-cloud }} provides data-at-rest encryption for the following services:

- [{{objstorage-full-name}}](#storage-at-rest)
- [{{managed-k8s-name}}](#kubernetes)

### {{objstorage-full-name}} {#storage-at-rest}

When using [{{objstorage-full-name}}](../../../storage/index.yaml), make sure to encrypt critical data. You can do this using any of the following methods:

- Recommended: Object Storage bucket encryption using KMS keys (server-side encryption). This encryption method protects against the accidental or intentional publication of bucket contents on the internet. See the instructions in [{#T}](../../../storage/operations/buckets/encrypt.md) of the Object Storage documentation.

   {% note alert %}

   Data in {{ objstorage-short-name }} is encrypted using [envelope encryption](../../../kms/concepts/envelope.md). Deleting a key is the same as destroying all data encrypted with that key.

   {% endnote %}

- Integrating Object Storage with the KMS service for client-side encryption. For more information, see [{#T}](#libs) below.

- Using third-party client-side encryption libraries prior to sending data to Object Storage. If you use third-party data encryption libraries and your own key management methods, be sure that your operation model, algorithms, and key sizes comply with regulatory requirements.

### {{managed-k8s-name}} {#kubernetes}

[{{managed-k8s-name}}](../../../managed-kubernetes/index.yaml) has a built-in secret encryption mechanism. For more information, see [{#T}](#k8s-secrets) below.

## Encryption in transit

In most cases, you can only connect to {{ yandex-cloud }} services over HTTPS. However, some scenarios allow data plane access to services over HTTP, without connection encryption at the application level. In all these scenarios, the user can choose the protocol to be used for data plane operations (HTTP or HTTPS) in the service settings, and specify their own TLS certificate if HTTPS is selected.

{% note warning %}

When working with (or connecting to) {{ yandex-cloud }} APIs, make sure to use TLS 1.2 or higher, since its prior versions are vulnerable. For example, by using the gRPC interfaces of Yandex.Cloud, you can enforce TLS 1.2 or higher. That's because gRPC is based on HTTP/2 where TLS 1.2 is the minimum supported TLS version. Support for legacy TLS protocols in Yandex.Cloud services will [gradually be discontinued](../../security-bulletins/index.md#19112020-—-otkaz-ot-ustarevshih-tls-protokolov).

{% endnote %}

{{ yandex-cloud }} lets you use your own TLS certificates for the following services:

- [{{objstorage-full-name}}](#storage-in-transit)
- [{{alb-full-name}}](#load-balancer)
- [{{vpc-name}} (VPC)](#vpc)
- [{{api-gw-full-name}}](#api-gw)
- [{{cdn-full-name}}](#cdn)

### {{objstorage-full-name}} {#storage-in-transit}

[{{objstorage-full-name}}](../../../storage/index.yaml) supports secure connections over HTTPS. You can upload your own security certificate if a connection to your Object Storage site requires HTTPS access. Integration with [{{certificate-manager-full-name}}](../../../certificate-manager/index.yaml) is also available. For more information, see the Object Storage documentation:

- [{#T}](../../../storage/operations/hosting/certificate.md)
- [{#T}](../../../storage/concepts/bucket.md#bucket-https)

When using Object Storage, be sure that support for TLS protocols below version 1.2 is disabled at the client level. Use the [aws:securetransport](../../../storage/s3/api-ref/policy/conditions.md) bucket policy to ensure running without TLS is disabled for the bucket.

### {{alb-full-name}} {#load-balancer}

[{{alb-full-name}}](../../../application-load-balancer/index.yaml) supports an HTTPS listener with a [certificate](../../../certificate-manager/concepts/imported-certificate.md) imported from {{certificate-manager-name}}. See how to [set up the listener](../../../application-load-balancer/concepts/application-load-balancer.md#listener-example) in the Application Load Balancer documentation.

### {{vpc-name}} (VPC) {#vpc}

Possible options for using encrypted communication channels are described in [{#T}](network.md#remote-access).

Please note that [{{interconnect-full-name}}](../../../interconnect/index.yaml) does not provide built-in encryption mechanisms. Be sure to enable encryption in transit on your own by:

- Installing in the cloud VPN gateways with encryption enabled, such as VMs based on Check Point images from [Yandex Cloud Marketplace](https://cloud.yandex.ru/marketplace?categories=network).
- Using application-level encryption.
- Using [GOST VPN](network.md#gost-vpn).

### {{api-gw-full-name}} {#api-gw}

[{{api-gw-full-name}}](../../../api-gateway/index.yaml) supports secure connections over HTTPS. You can upload your own security certificate to access your [API gateway](../../../api-gateway/concepts/) over HTTPS.

### {{cdn-full-name}} {#cdn}

[{{cdn-full-name}}](../../../cdn/index.yaml) supports secure connections over HTTPS. You can upload your own security certificate to access your [CDN resource](../../../cdn/concepts/resource.md) over HTTPS.

## Providing encryption on your own

When using services with no built-in encryption, it's the customer's responsibility to ensure that critical data is encrypted.

### Yandex Compute Cloud

If disk encryption is mandatory under regulatory requirements, place your application files on a VM's secondary disk (not the boot disk) and configure full disk encryption for it.

![](../../../_assets/overview/solution-library-icon.svg)[Solution: VM disk encryption using KMS](https://github.com/yandex-cloud/yc-solution-library-for-security/tree/master/encrypt_and_keys/encrypt_disk_VM)

### Managed Services for Databases

If data encryption is mandatory under regulatory requirements, make sure to encrypt data at the application level prior to writing it to a database, for example, using KMS.

### Yandex Message Queue

If you use [{{message-queue-full-name}}](../../../message-queue/index.yaml) to transfer critical data or secrets (encryption keys, API keys, and so on), be sure to encrypt this data at the application level before you send it to Yandex Message Queue, for example, using KMS. For the KMS key, we recommend that you set up a rotation period greater than or equal to the maximum message processing time in Yandex Message Queue.

### Recommended cryptographic libraries {#libs}

For client-side encryption, we recommend that you use the following libraries:

- AWS Encryption SDK and its [KMS integration](../../../kms/solutions/encrypt/aws-encryption-sdk.md).
- Google Tink and its [KMS integration](../../../kms/solutions/encrypt/google-tink.md).
- [Yandex.Cloud SDK](../../../kms/solutions/encrypt/sdk.md) with any other cryptographic library compatible with PCI DSS or any standards used in your company.

For a comparison of libraries, see [{#T}](../../../kms/solutions/encrypt/index.md) in the KMS documentation.

## Managing keys {#key-management}

We recommend that you use [Yandex Key Management Service](../../../kms/index.yaml) for data encryption and key management. KMS helps you protect data in the {{ yandex-cloud }} infrastructure. You can also use it to encrypt or decrypt any of your data.

KMS uses the AES-GCM encryption mode. You can select the key length (128, 192, or 256 bits) and set up the preferred key rotation period. You can also create a key whose every cryptographic operation will only  be handled inside a hardware security module (HSM).

### Authentication and authorization in KMS

To access the KMS service, you need an [IAM token](../../../iam/concepts/authorization/iam-token.md).

To automate operations with KMS, we recommend that you create a [service account](../../../iam/concepts/users/service-accounts.md) and run commands and scripts under it. If you use VMs, get an IAM token for your service account using the mechanism of [assigning a service account](../../../compute/operations/vm-connect/auth-inside-vm.md) to a VM. For other ways to get an IAM token for your service account, see [{#T}](../../../iam/operations/iam-token/create-for-sa.md) in the IAM documentation.

We recommend that you grant your users and service accounts granular permissions for specific keys in the KMS service. For more information, see [{#T}](../../../kms/security/index.md) in the KMS documentation.

Read more about security measures for access control in [{#T}](access.md).

### Key rotation

To improve the security of your infrastructure, we recommend that you categorize your encryption keys into two groups:

1. Keys for services that process critical data, but don't store it. For example, Yandex Message Queue or Yandex Cloud Functions.
2. Keys for services that store critical data. For example, Managed Services for Databases

For the first group of keys, we recommend that you set up automatic key rotation with a rotation period slightly longer than the data processing period in these services. When the rotation period expires, the old key versions must be deleted. In the case of automatic rotation and the deletion of old key versions, previously processed data can't be restored and decrypted.

For data storage services, we recommend that you either manually rotate keys or use automatic key rotation, depending on your internal procedures for processing critical data.

A secure value for AES-GCM mode is encryption using 4294967296 (= 2<sup>32</sup>) blocks. Having reached this number of encrypted blocks, you need to create a new DEK version. For more information about AES-GCM, see the [NIST recommendations](https://nvlpubs.nist.gov/nistpubs/Legacy/SP/nistspecialpublication800-38d.pdf).

{% note alert %}

Destroying any version of a key means destroying all data encrypted with it. You can protect a key against deletion by setting the [deletionProtection](../../../kms/api-ref/SymmetricKey/index.md) parameter. However, it doesn't protect against deleting individual versions.

{% endnote %}

For more information about key rotation, see [{#T}](../../../kms/concepts/version.md) in the KMS documentation.

## Managing secrets

Don't use critical data and access secrets (such as authentication tokens, API keys, and encryption keys) explicitly in the code, cloud object names and descriptions, VM metadata, and so on. Instead, use secret storage services like Yandex Lockbox or HashiCorp Vault.

### {{ lockbox-name }}

{{ lockbox-name }} securely stores secrets: they are only stored in encrypted form with encryption performed using KMS. For secret access control, use service roles.

For instructions on how to use the service, see the [Lockbox documentation](../../../lockbox/index.yaml).

### HashiCorp Vault

[Vault](https://www.vaultproject.io/) lets you use KMS as a trusted service for encrypting secrets. This is implemented through the [Auto Unseal](https://www.vaultproject.io/docs/concepts/seal#auto-unseal) feature.

To store secrets with Vault, you can use a VM based on an [image from Yandex Cloud Marketplace](https://cloud.yandex.ru/marketplace/products/yc/vault-yckms) with a pre-installed HashiCorp Vault build and Auto Unseal support. Instructions for setting up Auto Unseal are provided in [{#T}](../../../kms/solutions/vault-secret.md) in the KMS documentation.

### Secrets in Kubernetes {#k8s-secrets}

To store secrets, such as passwords, OAuth tokens, and SSH keys, use one of the following methods:

- [Kubernetes Secrets](https://kubernetes.io/docs/concepts/configuration/secret/).

   By default, secrets are stored unencrypted in etcd. However, {{managed-k8s-name}} lets you encrypt secrets using KMS. To enable secret encryption, specify the KMS key when creating a Kubernetes cluster. You can't add the key when you edit the cluster. For more information, see [{#T}](../../../kms/solutions/kubernetes.md) in the KMS documentation.

- {{ lockbox-name }}.

   See the instructions in the {{ lockbox-name }} documentation.

- HashiCorp Vault with KMS support from [{{ marketplace-full-name }}](https://cloud.yandex.ru/marketplace/products/yc/vault-yckms).

### Transferring secrets to a VM using Terraform and KMS

KMS supports the encryption of secrets used in a Terraform configuration, such as to transfer secrets to a VM in encrypted form. See the instructions in [{#T}](../../../kms/solutions/terraform-secret.md) in the KMS documentation. It's not safe to explicitly pass secrets through environment variables, because they are displayed in the VM properties.

![](../../../_assets/overview/solution-library-icon.svg)[Solution: Encrypting secrets in Terraform to transfer them to a VM with a Container Optimized Image](https://github.com/yandex-cloud/yc-solution-library-for-security/tree/master/encrypt_and_keys/terraform%2BKMS%2BCOI)

For other recommendations on how to use Terraform safely, see [Secure configuration: Terraform](secure-config.md#terraform).

