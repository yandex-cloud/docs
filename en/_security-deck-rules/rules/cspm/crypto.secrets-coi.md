### Use secret encryption for Container Optimized Image {#secrets-coi}

#|
|| **kind** | **severity** | **ID** ||
|| automatic | high | crypto.secrets-coi ||
|#

#### Description

{% note tip "**Automatic verification**" %}

This control automatically checks for secret encryption in Container Optimized Image configurations.

{% endnote %}

KMS supports the encryption of secrets used in a Terraform configuration, e.g., for transferring secrets to a VM in encrypted form. See Encrypting secrets in Hashicorp [Terraform](https://yandex.cloud/en/docs/kms/tutorials/terraform-secret) in the KMS documentation. It is not safe to openly provide secrets through environment variables, because they are displayed in the VM properties.

#### Guides and solutions

* Encrypting secrets in Terraform to transfer them to a VM from a Container Optimized Image: <https://github.com/yandex-cloud-examples/yc-encrypt-coi-secrets>
* For other recommendations on how to use Terraform safely, see Secure configuration: Terraform: <https://yandex.cloud/en/docs/security/standard/virtualenv-safe-config#tf-using>
