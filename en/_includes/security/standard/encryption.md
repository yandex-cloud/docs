# 4. Data encryption and key and secret management

### Introduction {#intro}

{{ yandex-cloud }} provides built-in encryption features for a number of services. It is the customer's responsibility to enable encryption in these services and implement encryption in other components for processing critical data. Data encryption and encryption key management are performed by [{{ kms-name }}](../../../kms/) ({{ kms-short-name }}).

{{ yandex-cloud }} APIs support cipher suites in specific TLS versions that are compliant with PCI DSS and other standards.

### Encryption at rest {#at-rest}

By default, all user data at rest is encrypted at the {{ yandex-cloud }} level. Encryption at the {{ yandex-cloud }} level implements one of the best practices for protecting user data and is performed using {{ yandex-cloud }} keys.

If your corporate information security policy sets specific key size and rotation frequency requirements, you can encrypt data with your own keys. To do this, you can use the {{ kms-short-name }} service and its integration with other {{ yandex-cloud }} services or implement data plane encryption completely on your own.

{{ yandex-cloud }} provides data-at-rest encryption for the following services:
* {{ objstorage-name }}.
* {{ managed-k8s-name }}.

#### 4.1 In {{ objstorage-full-name }}, encryption of data at rest using {{ kms-short-name }} keys is enabled {#storage-kms}

To protect critical data in {{ objstorage-full-name }}, we recommend using bucket server-side encryption with {{ kms-full-name }} keys. This encryption method protects against accidental or intentional publication of the bucket content on the web. For more information, see [Encryption](../../../storage/concepts/encryption.md) in the {{ objstorage-name }} documentation.

{% list tabs %}

- Performing a check in the management console

   1. In the management console, select the cloud or folder to check the buckets in.
   1. In the list of services, select **{{ objstorage-name }}**.
   1. Go to the bucket settings.
   1. Go to the **Encryption** tab.
   1. Make sure that encryption is enabled and the {{ kms-short-name }} encryption key is specified.
   1. If encryption is enabled, the recommendation is fulfilled. Otherwise, proceed to the "Guides and solutions to use".

- Performing a check via the CLI

   1. [Configure](../../../storage/tools/aws-cli.md) the AWS CLI to work with a cloud.
   1. Run the command below to check whether encryption is enabled:

      ```bash
      aws --endpoint-url=https://{{ s3-storage-host }}/ \
      s3api get-bucket-encryption \
      --bucket <bucket name>
      ```

   1. If encryption is enabled, the recommendation is fulfilled. Otherwise, proceed to the "Guides and solutions to use".

{% endlist %}

**Guides and solutions to use:**

Configure bucket encryption using the [guide](../../../storage/operations/buckets/encrypt.md).

### Encryption in transit {#in-transit}

In most cases, you can only connect to {{ yandex-cloud }} services over HTTPS. However, some scenarios allow data plane access to services over HTTP, without connection encryption at the application level. In all these scenarios, the user can choose the protocol to be used for data plane operations (HTTP or HTTPS) in the service settings, and specify their own TLS certificate if HTTPS is selected.

{% note info %}

When working with (or connecting to) {{ yandex-cloud }} APIs, make sure to use TLS 1.2 or higher, since its prior versions are vulnerable.

For example, by using the gRPC interfaces of {{ yandex-cloud }}, you can enforce TLS 1.2 or higher. That's because gRPC is based on HTTP/2 where TLS 1.2 is the minimum supported TLS version.

Support for legacy TLS protocols in {{ yandex-cloud }} services will [gradually be discontinued](../../../security/security-bulletins/index.md).

{% endnote %}

{{ yandex-cloud }} allows you to use your own TLS certificates for the following services:
* {{ objstorage-name }}.
* {{ alb-name }}.
* {{ api-gw-name }}.
* {{ cdn-name }}.

#### 4.2 HTTPS is enabled for hosting static websites in {{ objstorage-full-name }} {#storage-https}

[{{ objstorage-name }}](../../../storage/) supports secure connections over HTTPS. You can upload your own security certificate if a connection to your {{ objstorage-name }} website requires HTTPS access. Integration with [{{ certificate-manager-name }}](../../../certificate-manager/) is also supported. See the instructions in the {{ objstorage-name }} documentation:
* [Configuring HTTPS](../../../storage/operations/hosting/certificate.md)
* [Bucket](../../../storage/concepts/bucket.md)

When using [{{ objstorage-name }}](../../../storage/), be sure that support for TLS protocols below version 1.2 is disabled at the client level. Use the bucket policy [`aws:securetransport`](../../../storage/s3/api-ref/policy/conditions.md) to ensure that running without TLS is disabled for the bucket.

{% list tabs %}

- Performing a check in the management console

   1. In the management console, select the cloud or folder to check the buckets in.
   1. In the list of services, select **{{ objstorage-name }}**.
   1. Go to the bucket settings.
   1. Go to the **HTTPS** tab.
   1. Make sure that access over the protocol is enabled and a certificate is specified.
   1. If access over HTTPS is enabled, the recommendation is fulfilled. Otherwise, proceed to the "Guides and solutions to use".

{% endlist %}

**Guides and solutions to use:**
Enable access over HTTPS if a bucket is used for hosting a static website.

#### 4.3 {{ alb-full-name }} uses HTTPS {#alb-https}

[{{ alb-name }}](../../../application-load-balancer/) supports an HTTPS listener with a [certificate](../../../certificate-manager/concepts/imported-certificate.md) uploaded from {{ certificate-manager-name }}. See[how to set up the listener](../../../application-load-balancer/concepts/application-load-balancer.md) in the {{ alb-full-name }} documentation.

{% list tabs %}

- Performing a check in the management console

   1. In the management console, select the cloud or folder to check the load balancers in.
   1. In the list of services, select **{{ alb-name }}**.
   1. Go to the load balancer settings.
   1. Make sure that **HTTPS** is specified for the load balancer.
   1. If HTTPS is specified, the recommendation is fulfilled. Otherwise, proceed to the "Guides and solutions to use".

- Performing a check via the CLI

   1. See what organizations are available to you and write down the ID you need:

      ```bash
      yc organization-manager organization list
      ```

   1. Run the command below to output the list of all load balancers without HTTPS:

      ```bash
      export ORG_ID=<organization ID>
      for CLOUD_ID in $(yc resource-manager cloud list --organization-id=${ORG_ID} --format=json | jq -r '.[].id');
      do for FOLDER_ID in $(yc resource-manager folder list --cloud-id=$CLOUD_ID --format=json | jq -r '.[].id');
      do for ALB in $(yc application-load-balancer load-balancer list --folder-id=$FOLDER_ID --format=json | jq -r '.[].id'); \
      do yc application-load-balancer load-balancer get --id $ALB --format json | jq -r '. | select(.listeners[0].tls | not)' | jq -r '.id'
      done;
      done;
      done
      ```

   1. If an empty list is output, the recommendation is fulfilled. Otherwise, proceed to the "Guides and solutions to use".

{% endlist %}

**Guides and solutions to use:**

Enable an HTTPS listener using the instructions.

#### 4.4 {{ api-gw-full-name }} uses HTTPS and its own domain {#api-gateway-https}

[{{ api-gw-name }}](../../../api-gateway/) supports secure connections over HTTPS. You can link your own domain and upload your own security certificate to access your [API gateway](../../../api-gateway/concepts/index.md) over HTTPS.

{% list tabs %}

- Performing a check in the management console

   1. In the management console, select the cloud or folder to check the gateways in.
   1. In the list of services, select **{{ api-gw-name }} → Gateway settings → Domains**.
   1. Make sure the domain and certificate are enabled.
   1. If the domain and certificate are active, the recommendation is fulfilled. Otherwise, proceed to the "Guides and solutions to use".

- Performing a check via the CLI

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

   1. If an empty list is output, the recommendation is fulfilled. Otherwise, proceed to the "Guides and solutions to use".

{% endlist %}

**Guides and solutions to use:**

1. In the management console, select the cloud or folder to enable domains and certificates in.
1. In the list of services, select **{{ api-gw-name }} → Gateway settings → Domains**.
1. Enable the domains and certificates.

#### 4.5 {{ cdn-full-name }} uses HTTPS and its own SSL certificate {#cdn-https}

[{{ cdn-name }}](../../../cdn/) supports secure connections to origins over HTTPS. You can also upload your own security certificate to access your [CDN resource](../../../cdn/concepts/resource.md) over HTTPS.

{% list tabs %}

- Performing a check in the management console

   1. In the management console, select the cloud or folder to check the resources in.
   1. In the list of services, select **{{ cdn-name }}**.
   1. Go to the resource settings, the **Additional** tab.
   1. Make sure the **Origin request protocol** field is set to **HTTPS**.
   1. Make sure the **Certificate** field specifies your own certificate or a **Let’s encrypt** certificate.
   1. If HTTPS and your own certificate are specified, the recommendation is fulfilled. Otherwise, proceed to the "Guides and solutions to use".

- Performing a check via the CLI

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

   1. If an empty list is output, the recommendation is fulfilled. Otherwise, proceed to the "Guides and solutions to use".

{% endlist %}

**Guides and solutions to use:**

[Enable](../../../cdn/operations/resources/configure-basics.md) a certificate and HTTPS using the instructions.

### Providing encryption on your own {#self-encryption}

**When using services with no built-in encryption, it's the customer's responsibility to ensure that critical data is encrypted.**

#### 4.6 For critical VMs, disk encryption using {{ kms-short-name }} is set up {#self-vm-kms}

If disk encryption is required, place your application files on a VM's secondary disk (not the boot disk) and configure full disk encryption for it.

{% list tabs %}

- Manual check

   Manually check whether this solution is used for critical VMs.

{% endlist %}

**Guides and solutions to use:**

[VM disk encryption using {{ kms-short-name }}](https://github.com/yandex-cloud-examples/yc-encrypt-vm-disk-with-kms).

#### 4.7 For critical data, MDB encryption with {{ kms-short-name }} is used {#self-data-kms}

If data encryption is required, make sure to encrypt data at the application level prior to writing it to a database, for example, using [{{ kms-short-name }}](../../../kms/operations/symmetric-encryption.md) and add-on, such as `pgcrypto`.

{% list tabs %}

- Manual check

   Make sure that the stored data is encrypted.

- Performing a check via the CLI

   To get a list of all extensions set in a database, run this command:

     ```bash
     yc managed-postgresql database get <database_name> --cluster-id <managed_postgre_cluster_id> --format=json | jq -r '.extensions | .[].name'
     ```

   If the command output contains the `pgcrypto` line, it means that the database has an extension for application-level data encryption enabled.

{% endlist %}

**Guides and solutions to use:**

You can learn how to encrypt data in {{ mpg-full-name }} and {{ mgp-full-name }} using `pgcrypto` in [{#T}](../../../managed-greenplum/operations/extensions/pgcrypto.md).

#### 4.8 Data encryption at the application level is used {#self-data-app}

For client-side encryption before uploading data to a {{ objstorage-full-name }} bucket, you can use the following approaches:
* Integrating {{ objstorage-name }} with the {{ kms-name }} service for client-side encryption. For more information, see "Recommended cryptographic libraries".
* Using third-party client-side encryption libraries prior to sending data to {{ objstorage-name }}. If you use third-party data encryption libraries and your own key management methods, make sure that your operation model, algorithms, and key sizes comply with regulatory requirements.

For client-side encryption, we recommend that you use the following libraries:
* AWS Encryption SDK and its [{{ kms-short-name }} integration](../../../kms/tutorials/encrypt/aws-encryption-sdk.md).
* Google Tink and its [{{ kms-short-name }} integration](../../../kms/tutorials/encrypt/google-tink.md).
* [{{ yandex-cloud }} SDK](../../../kms/tutorials/encrypt/sdk.md) with any other cryptographic library compatible with PCI DSS or any standards used in your company.

For a comparison of libraries, see the {{ kms-short-name }} documentation,  [Which encryption method should I choose?](../../../kms/tutorials/encrypt/).

{% list tabs %}

- Manual check

   Make sure that the stored data is encrypted.

{% endlist %}

### Managing keys {#keys}

We recommend that you use [{{ kms-name }}](../../../kms/tutorials/encrypt/sdk.md) for encrypting data and managing keys. {{ kms-short-name }} helps you protect data in the {{ yandex-cloud }} infrastructure. You can also use it to encrypt or decrypt any of your data.

{{ kms-short-name }} uses AES-GCM encryption mode. You can select the key length (128, 192, or 256 bits) and set up the preferred key rotation period.

#### 4.9 {{ kms-name }} keys are stored in a hardware security module (HSM) {#keys-hsm}

In production environments, we recommend using separate keys whose every cryptographic operation will only be handled inside a HSM. For more information, see [Hardware security module (HSM)](../../../kms/concepts/hsm.md).

To use the HSM, when creating a key, select AES-256 HSM as the algorithm type. The HSM will handle all operations with this key internally, and no additional actions are required.

We recommend using HSMs for {{ kms-short-name }} keys to enhance the security level.

{% list tabs %}

- Performing a check in the management console

   1. In the management console, select the cloud or folder to check the keys in.
   1. In the list of services, select **{{ kms-name }}**.
   1. Go to the **Keys** tab.
   1. Make sure the **Encryption algorithm** field is set to **AES-256 HSM**.
   1. If AES-256 HSM is specified, the recommendation is fulfilled. Otherwise, proceed to the "Guides and solutions to use".

- Performing a check via the CLI

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

   1. If the encryption algorithm contains AES-256 HSM, the recommendation is fulfilled. Otherwise, proceed to the "Guides and solutions to use".

{% endlist %}

**Guides and solutions to use:**

[Set](../../../kms/operations/symmetric-encryption.md) the encryption algorithm for {{ kms-short-name }} keys to AES-256 HSM.

#### 4.10 Permissions to manage keys in {{ kms-short-name }} are granted to users under control {#keys-controlled-users}

To access the {{ kms-short-name }} service, you need an [IAM token](../../../iam/concepts/authorization/iam-token.md).

To automate operations with {{ kms-short-name }}, we recommend that you create a [service account](../../../iam/concepts/users/service-accounts.md) and run commands and scripts under it. If you use VMs, get an IAM token for your service account using the mechanism of [assigning a service account](../../../compute/operations/vm-connect/auth-inside-vm.md) to your VM. For other ways to get an IAM token for your service account, see the {{ iam-short-name }} documentation,  [Getting an IAM token for a service account](../../../iam/operations/iam-token/create-for-sa.md).

We recommend that you grant granular permissions for specific keys in the {{ kms-short-name }} service to your users and service accounts. For more information, see the {{ kms-short-name }} documentation, [Access management in {{ kms-name }}](../../../kms/security/).

For more information about security measures for access control, see [Authentication and access control](../../../security/domains/access.md).

To verify the {{ kms-short-name }} key access rights, check out who is granted access rights to:
* An organization, cloud, and folders with permissions such as: `admin`, `editor`, `kms.admin`, `kms.editor`, and `kms.keys.encrypterDecrypter`.
* Keys such as: `kms.keys.encrypterDecrypter` and `kms.editor`.

{% list tabs %}

- Performing a check in the management console

   1. In the management console, select the cloud or folder to check the key access rights in.
   1. Click the **Access bindings** tab.
   1. Make sure the `admin`, `editor`, `kms.admin`, `kms.editor`, and `kms.keys.encrypterDecrypter` roles are only granted to users under control.
   1. You can only verify the key access rights in the CLI.

- Performing a check via the CLI

   1. See what organizations are available to you and write down the ID you need:

      ```bash
      yc organization-manager organization list
      ```

   1. Run the command below to search for accounts at the organization level:

      ```bash
      export ORG_ID=<organization ID>
      yc organization-manager organization list-access-bindings --id=${ORG_ID} --format=json | jq -r '.[] | select(.role_id=="admin" or .role_id=="editor" or .role_id=="kms.admin" or .role_id=="kms.editor" or .role_id=="kms.keys.encrypterDecrypter")'
      ```

   1. If there are no accounts in the list, the recommendation is fulfilled. Otherwise, proceed to the "Guides and solutions to use".

   1. Find accounts with roles assigned at the cloud level:

      ```bash
      export ORG_ID=<organization ID>
      for CLOUD_ID in $(yc resource-manager cloud list --organization-id=${ORG_ID} --format=json | jq -r '.[].id');
      do yc resource-manager cloud list-access-bindings --id=$CLOUD_ID --format=json | jq -r '.[] | select(.role_id=="admin" or .role_id=="editor" or .role_id=="kms.admin" or .role_id=="kms.editor" or .role_id=="kms.keys.encrypterDecrypter")'
      done
      ```

   1. If there are no accounts in the list, the recommendation is fulfilled. Otherwise, proceed to the "Guides and solutions to use".

   1. Run the command below to search for accounts with primitive roles assigned at the level of all folders in your clouds:

      ```bash
      export ORG_ID=<organization ID>
      for CLOUD_ID in $(yc resource-manager cloud list --organization-id=${ORG_ID} --format=json | jq -r '.[].id');
      do for FOLDER_ID in $(yc resource-manager folder list --cloud-id=$CLOUD_ID --format=json | jq -r '.[].id'); \
      do yc resource-manager folder list-access-bindings --id=$FOLDER_ID --format=json | jq -r '.[] | select(.role_id=="admin" or .role_id=="editor" or .role_id=="kms.admin" or .role_id=="kms.editor" or .role_id=="kms.keys.encrypterDecrypter")' && echo $FOLDER_ID
      done;
      done
      ```

   1. If there are no accounts in the list, the recommendation is fulfilled. Otherwise, proceed to the "Guides and solutions to use".

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
* Keys for services that process critical data but do not store it. e.g., {{ message-queue-name }} and {{ sf-name }}.
* Keys for services that store critical data, e.g., Managed Services for Databases.

For the first group, we recommend that you set up automatic key rotation with a rotation period longer than the data processing period in these services. When the rotation period expires, the old key versions must be deleted. In the case of automatic rotation and the deletion of old key versions, previously processed data cannot be restored and decrypted.

For data storage services, we recommend that you either manually rotate keys or use automatic key rotation, depending on your internal procedures for processing critical data.

A secure value for AES-GCM mode is encryption using 4294967296 (= 2<sup>32</sup>) blocks. Having reached this number of encrypted blocks, you need to create a new DEK version. For more information about the AES-GCM operating mode, see the [NIST materials](https://nvlpubs.nist.gov/nistpubs/Legacy/SP/nistspecialpublication800-38d.pdf).

{% note info %}

Destroying any version of a key means destroying all data encrypted with it. You can protect a key against deletion by setting the deletionProtection parameter. However, it does not protect against deleting individual versions.

{% endnote %}

For more information about key rotation, see the {{ kms-short-name }} documentation, [Key version](../../../kms/concepts/version.md).

{% list tabs %}

- Performing a check in the management console

   1. In the management console, select the cloud or folder to check the keys in.
   1. In the list of services, select **{{ kms-name }}**.
   1. Go to the key settings.
   1. Find the **Rotation period** parameter.
   1. If the parameter is set to any value different from **No rotation**, the recommendation is fulfilled. Otherwise, proceed to the "Guides and solutions to use".

- Performing a check via the CLI

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

   1. If an empty list is output, the recommendation is fulfilled. Otherwise, proceed to the "Guides and solutions to use".

{% endlist %}

**Guides and solutions to use:**

Set the key rotation period.

#### 4.12 Make sure that deletion protection is enabled for {{ kms-short-name }} keys {#keys-deletion-protection}

Deleting a {{ kms-short-name }} key always means destroying data. Therefore, be sure to protect the keys against accidental deletion. {{ kms-short-name }} has the necessary feature.

{% list tabs %}

- Performing a check in the management console

   1. In the management console, select the cloud or folder to check the keys in.
   1. In the list of services, select **{{ kms-name }}**.
   1. Go to the key settings.
   1. Find the **Deletion protection** parameter.
   1. If it is set to **Yes**, the recommendation is fulfilled. Otherwise, proceed to the "Guides and solutions to use".

- Performing a check via the CLI

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

   1. If an empty list is output, the recommendation is fulfilled. Otherwise, proceed to the "Guides and solutions to use".

{% endlist %}

**Guides and solutions to use:**

Enable deletion protection.

### Managing secrets {#secrets}

Do not use critical data and access secrets, such as authentication tokens, API keys, and encryption keys, explicitly in the code, cloud object names and descriptions, VM metadata, etc. Instead, use secret storage services, such as {{ lockbox-short-name }} or HashiCorp Vault.

#### 4.13 The organization uses {{ lockbox-full-name }} for secure secret storage {#secrets-lockbox}

Do not use critical data and access secrets, such as authentication tokens, API keys, and encryption keys, explicitly in the code, cloud object names and descriptions, VM metadata, etc. Instead, use secret storage services, such as {{ lockbox-short-name }} or [HashiCorp Vault](/marketplace/products/yc/vault-yckms) (from {{ marketplace-name }}).

{{ lockbox-short-name }} securely stores secrets in an encrypted form only. Encryption is performed using {{ kms-short-name }}. For secret access control, use service roles.

You can learn how to use the service in the [{{ lockbox-short-name }} documentation](../../../lockbox/).

[Vault](https://www.vaultproject.io/) allows you to use {{ kms-short-name }} as a trusted service for encrypting secrets. This is implemented through the [Auto Unseal](https://www.vaultproject.io/docs/concepts/seal) mechanism.

To store secrets with Vault, you can use a VM based on an [image](/marketplace/products/yc/vault-yckms) from {{ marketplace-name }} with a pre-installed HashiCorp Vault build and Auto Unseal support. You can find the guide on setting up Auto Unseal in the {{ kms-short-name }} documentation, [Auto Unseal in Hashicorp Vault](../../../kms/tutorials/vault-secret.md).

{% note info %}

When working in {{ TF }}, we recommend using a script to [fill in](https://terraform-provider.yandexcloud.net/Resources/lockbox_secret_version) the contents of a secret. This ensures that its contents do not remain in the `.tfstate` file.

{% endnote %}

{% list tabs %}

- Performing a check in the management console

   1. In the management console, select the cloud or folder to check the secrets in.
   1. In the list of services, select **{{ lockbox-short-name }}**.
   1. Make sure that at least one {{ lockbox-short-name }} secret is used.
   1. Find the **Deletion protection** parameter.
   1. If {{ lockbox-short-name }} is used or {{ k8s }} VMs or entities have Hashicorp Vault installed, the recommendation is fulfilled. Otherwise, proceed to the "Guides and solutions to use".

- Performing a check via the CLI

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

   1. If an empty list is output, the recommendation is fulfilled. Otherwise, proceed to the "Guides and solutions to use".

{% endlist %}

**Guides and solutions to use:**

Store secrets in {{ lockbox-short-name }} or [Hashicorp Vault](/marketplace/products/yc/vault-yckms) from {{ marketplace-short-name }}.

#### 4.14 For {{ serverless-containers-name }} and {{ sf-name }}, {{ lockbox-short-name }} secrets are used {#secrets-serverless-functions}

When working with {{ serverless-containers-name }} or {{ sf-name }}, it is often necessary to use a secret (such as a token or password).

If you specify secret information in environment variables, it can be viewed by any cloud user with permissions to view and use a function, which causes information security risks.

We recommend using Serverless integration with {{ lockbox-short-name }} for that. You can use a specific secret from {{ lockbox-full-name }} and a service account with access rights to this secret to use it in a function or container.

Make sure that the secrets are used as described above.

{% list tabs %}

- Performing a check in the management console

   1. In the management console, select the cloud or folder to check the functions in.
   1. In the list of services, select **{{ sf-name }}**.
   1. Go to the function settings, the **Editor** tab.
   1. Find the **{{ lockbox-short-name }} secrets** parameter.
   1. If the parameters of each object specify **{{ lockbox-short-name }} secrets** or there are no environment variables with secret data, the recommendation is fulfilled. Otherwise, proceed to the "Guides and solutions to use".

- Performing a check via the CLI

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

   1. If an empty list is output, the recommendation is fulfilled. Otherwise, proceed to the "Guides and solutions to use".

{% endlist %}

**Guides and solutions to use:**

Delete the secret data from env and [use](../../../functions/operations/function/version-manage.md) the {{ lockbox-short-name }} integration functionality.

#### 4.15 When working with {{ coi }}, secret encryption is used {#secrets-coi}

{{ kms-short-name }} supports the encryption of secrets used in a {{ TF }} configuration, e.g., for transferring secrets to a VM in encrypted form. See the [Encrypting secrets in {{ TF-full }}](../../../kms/tutorials/terraform-secret.md) section of the {{ kms-short-name }} documentation. It is not safe to openly transmit secrets through environment variables, because they are displayed in the VM properties.

**Guides and solutions to use:**

[Encrypting secrets in {{ TF }} to transfer them to a VM from a {{ coi }}](https://github.com/yandex-cloud-examples/yc-encrypt-coi-secrets).

For other recommendations on how to use {{ TF }} safely, see [Secure configuration: {{ TF }}](../../../security/domains/secure-config.md).

#### 4.16 There is a guide for cloud administrators on what to do if their cloud secrets are compromised {#secrets-scanning}

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
* (NEW) {{ yandex-cloud }} {{ captcha-name }} Server Key
* (NEW) {{ lockbox-short-name }} structured secrets

The service automatically notifies a customer of any found secrets belonging to their infrastructure:

* By email
* Using {{ at-full-name }} [events](../../../audit-trails/concepts/events.md)

**Guides and solutions to use:**

Make sure that:

* [Contact information of the person in charge of an organization is valid](../../../security/standard/authentication.md#org-contacts).
* [{{ at-full-name }} is enabled at the organization level](../../../security/standard/audit-logs.md#audit-trails).
* The administrator has read the [guide](../../../security/operations/search-secrets.md#secret-is-leaked) to follow if secrets are compromised.