# Versions of the standard for securing {{ yandex-cloud }} infrastructure

### Changes in version 1.2 {#version-1-2}

Publication date: 25/09/24.

* **Deleted section 6. Vulnerability management**.

* **Added the [{#T}](../../../security/standard/kubernetes-security.md) section**:
    * [{#T}](../../../security/standard/kubernetes-security.md#not-use-critical-data).
    * [{#T}](../../../security/standard/kubernetes-security.md#maximum-isolation).
    * [{#T}](../../../security/standard/kubernetes-security.md#api-security).
    * [{#T}](../../../security/standard/kubernetes-security.md#kubernetes-auth).
    * [{#T}](../../../security/standard/kubernetes-security.md#kubernetes-safe-config).
    * [{#T}](../../../security/standard/kubernetes-security.md#data-encryption).
    * [{#T}](../../../security/standard/kubernetes-security.md#docker-images-periodic-scan).
    * [{#T}](../../../security/standard/kubernetes-security.md#version-update).
    * [{#T}](../../../security/standard/kubernetes-security.md#backup).
    * [{#T}](../../../security/standard/kubernetes-security.md#check-list).
    * [{#T}](../../../security/standard/kubernetes-security.md#security-standards).
    * [{#T}](../../../security/standard/kubernetes-security.md#audit-logs).

* **Added the following items**:
    * [{#T}](../../../security/standard/authentication.md#group-mapping).
    * [{#T}](../../../security/standard/authentication.md#key-usage-control).
    * [{#T}](../../../security/standard/virtualenv-safe-config.md#use-sts-for-storage-keys).
    * [{#T}](../../../security/standard/virtualenv-safe-config.md#use-presigned-urls).
    * [{#T}](../../../security/standard/virtualenv-safe-config.md#os-login-onto-hosts).
    * [{#T}](../../../security/standard/encryption.md#managed-vm-kms).
    * [{#T}](../../../security/standard/audit-logs.md#data-plane-events).
    * [{#T}](../../../security/standard/app-security.md#use-sws).
    * [{#T}](../../../security/standard/app-security.md#use-waf).
    * [{#T}](../../../security/standard/app-security.md#use-arl).
    * [{#T}](../../../security/standard/app-security.md#setup-code-review).

* **Updated the following items**:
    * Added description of data event audit logs in [{#T}](../../../security/standard/audit-logs.md#audit-trails).
    * **6.2 Vulnerability scanning is performed at the cloud IP level** was moved to section [3. Secure configuration of a virtual environment](../../../security/standard/virtualenv-safe-config.md#ip-level).
    * **6.3 External security scans are performed according to the cloud rules** was moved to section [3. Secure configuration of a virtual environment](../../../security/standard/virtualenv-safe-config.md#external-security-scans).
    * **6.4 The process of security updates is set up** was moved to section [3. Secure configuration of a virtual environment](../../../security/standard/virtualenv-safe-config.md#security-updates).
    * **6.5 A web application firewall is used** was updated and moved to section [8. Application security](../../../security/standard/app-security.md#use-waf).
    * In [{#T}](../../../security/standard/app-security.md#pipeline-artifacts-cosign), added a recommendation to save the asymmetric key pair of a [Cosign](https://github.com/sigstore/cosign) electronic signature in [{{ kms-full-name }}](../../../kms/quickstart/index.md) and to use the saved key pair for signing artifacts and verifying the signature.

* **Deleted the following items**:
    * Deleted **4.6 For critical VMs, disk encryption using KMS is set up** because now there is a more convenient disk encryption method described in [{#T}](../../../security/standard/encryption.md#managed-vm-kms).

### Changes in version 1.1 {#version-1-1}

Publication date: 25/09/23.

* **Added the following items**:
    * 1.20 Impersonation is used wherever possible.
    * 1.21 Resource labels are used.
    * 1.22 {{ yandex-cloud }} security notifications are enabled.
    * 1.23 The `auditor` role is used to prevent access to user data.
    * 3.4.2 Integrity control of a VM runtime environment.
    * 3.28 Antivirus protection is used.
    * 3.29 {{ managed-k8s-full-name }} security guidelines are used.
    * 4.16 There is a guide for cloud administrators on handling compromised secrets.

* **Updated the following items**:
    * 1.4, 1.14: Added recommendations for using the `{{ roles-auditor }}` role.
    * 1.9: Added recommendations for placing critical service accounts in separate folders.
    * 1.12: Added `{{ roles-editor }}` to the list of privileged roles assigned at the organization, cloud, and folder levels.
    * 4.7: Added a guide on how to encrypt data in {{ mpg-full-name }} and {{ mgp-full-name }} using `pgcrypto` and {{ kms-short-name }}.
    * 4.14: Added recommendations for using {{ lockbox-full-name }} in {{ TF }} without writing the information to `.tfstate`.


* **Added section 9. Application security**:
    * 9.1 {{ captcha-full-name }} is used.
    * 9.2 Enabled the scan on push policy for the containerized image vulnerability scanner.
    * 9.3 Container images are periodically scanned.
    * 9.4 Container images used in a production environment have the last scan date a week ago or less.
    * 9.5 Software artifacts are built using attestations.
    * 9.6 Artifacts within a pipeline can be signed using Cosign, a third-party command line utility.
    * 9.7 Artifacts are checked when deployed in {{ managed-k8s-full-name }}.
    * 9.8 Ready-made secure pipeline blocks are used.

