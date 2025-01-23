# Versions of the standard for securing {{ yandex-cloud }} infrastructure

### Changes in version {{ security-standard-current-version }} {#current-version}

Publication date: 27/12/24.

* **Deleted Section 6. Backup**. The section's content was moved to Section [3. Secure configuration of a virtual environment](../../../security/standard/virtualenv-safe-config.md#backup).

* **Deleted Section 7. Physical security**. The section's content was moved to Section [{#T}](../../../security/standard/index.md#intro).

* **Added the following items:**
    * [{#T}](../../../security/standard/authentication.md#api-key-scopes).
    * [{#T}](../../../security/standard/authentication.md#key-usage-control).
    * [{#T}](../../../security/standard/authentication.md#ciem-access-control).

* **Updated the following items:**
    * Added [{{ container-registry-full-name }}](../../../container-registry/), [{{ sws-full-name }}](../../../smartwebsecurity/), and [{{ captcha-full-name }}](../../../smartcaptcha/) to [{#T}](../../../security/standard/index.md#application).
    * Added {{ sws-name }} usage info to [{#T}](../../../security/standard/network-security.md#ddos-protection).
    * Renumbered item [{#T}](../../../security/standard/virtualenv-safe-config.md#vpc-functions) (formerly `3.22`) and updated it with info about restrictions on networking between functions and user resources.
    * Renumbered and renamed item [{#T}](../../../security/standard/virtualenv-safe-config.md#function-access-and-env) (formerly `3.18 Public cloud functions are only used in exceptional cases`). Updated the item with information about assigning roles for a function, working with secrets and environment variables from a function, and accessing managed {{ mpg-full-name }} and {{ mch-full-name }} databases from a function.
    * Renumbered item [{#T}](../../../security/standard/virtualenv-safe-config.md#side-channel-attacks) (formerly `3.19`).
    * Renumbered item [{#T}](../../../security/standard/virtualenv-safe-config.md#ntp-functions) (formerly `3.20`) and updated it with info on how functions are getting time data.
    * Renumbered item [{#T}](../../../security/standard/virtualenv-safe-config.md#http-functions) (formerly `3.21`) and updated it with a description of how to invoke a function with the `?integration=raw` query parameter.
    * Added the following to [{#T}](../../../security/standard/encryption.md#storage-https):
        * Checks via the CLI
        * Link to HTTPS configuration [guide](../../../storage/operations/hosting/certificate.md)
    * Added links to best security practices to [{#T}](../../../security/standard/audit-logs.md#hardering).
    * In [{#T}](../../../security/standard/audit-logs.md#data-plane-events), expanded the list of services for which you can track events on this level.
    * In [{#T}](../../../security/standard/app-security.md#use-sws), added checks via the CLI.

### Changes in version 1.2 {#version-1-2}

Publication date: 25/09/24.

* **Deleted Section 6. Vulnerability management**.

* **Added Section 7. {{ k8s }} security:**
    * 7.1 The use of sensitive data is limited.
    * 7.2 Resources are isolated from each other.
    * 7.3 There is no access to the {{ k8s }} API and node groups from untrusted networks.
    * 7.4 Authentication and access management are configured in {{ managed-k8s-name }}.
    * 7.5 {{ managed-k8s-name }} uses a safe configuration.
    * 7.6 Data encryption and {{ managed-k8s-name }} secret management are done in _ESO as a Service_ format.
    * 7.7 Docker images are stored in a {{ container-registry-short-name }} registry configured for regular image scanning.
    * 7.8 One of the three latest {{ k8s }} versions is used, updates are monitored.
    * 7.9 Backup is configured.
    * 7.10 Check lists are in place for security when creating and using Docker images.
    * 7.11 The {{ k8s }} security policy is in place.
    * 7.12 Audit log collection is set up for incident investigation.

* **Added the following items:**
    * 1.1.1 User group mapping is set up in an identity federation.
    * 1.24 Tracking the date of last access key use in {{ iam-full-name }}.
    * 3.11 {{ sts-full-name }} is used for getting access keys to {{ objstorage-name }}.
    * 3.12 Pre-signed URLs are generated for isolated cases of access to specific objects in {{ objstorage-name }} private buckets.
    * 3.32 {{ oslogin }} is used for connection to a VM or {{ k8s }} node.
    * 4.8 Encryption of disks and virtual machine snapshots is used.
    * 5.8 Data events are monitored.
    * 8.9 {{ sws-full-name }} security profile is used.
    * 8.10 A web application firewall is used.
    * 8.11 Advanced Rate Limiter is used.
    * 8.12 Approval rules are set.

* **Updated the following items:**
    * In **5.1 {{ at-full-name }} is enabled at the organization level**, added description of data event audit logs.
    * **6.2 Vulnerability scanning is performed at the cloud IP level** was moved to Section **3. Secure configuration of a virtual environment**.
    * **6.3 External security scans are performed according to the cloud rules** was moved to Section **3. Secure configuration of a virtual environment**.
    * **6.4 The process of security updates is set up** was moved to Section **3. Secure configuration of a virtual environment**.
    * **6.5 A web application firewall is used** was updated and moved to Section **8. Application security**.
    * In **8.6 Ensure artifact integrity**, added a recommendation to save the asymmetric key pair of a [Cosign](https://github.com/sigstore/cosign) electronic signature in [{{ kms-full-name }}](../../../kms/quickstart/index.md) and to use the saved key pair for signing artifacts and verifying the signature.

* **Deleted the following items:**
    * Deleted **4.6 For critical VMs, disk encryption using {{ kms-short-name }} is set up** because now there is a more convenient disk encryption method described in **4.8 Encryption of disks and virtual machine snapshots is used**.

### Changes in version 1.1 {#version-1-1}

Publication date: 25/09/23.

* **Added the following items:**
    * 1.20 Impersonation is used wherever possible.
    * 1.21 Resource labels are used.
    * 1.22 {{ yandex-cloud }} security notifications are enabled.
    * 1.23 The `auditor` role is used to prevent access to user data.
    * 3.4.2 Integrity control of a VM runtime environment.
    * 3.28 Antivirus protection is used.
    * 3.29 {{ managed-k8s-full-name }} security guidelines are used.
    * 4.16 There is a guide for cloud administrators on handling compromised secrets.

* **Updated the following items:**
    * 1.4, 1.14: Added recommendations for using the `{{ roles-auditor }}` role.
    * 1.9: Added recommendations for placing critical service accounts in separate folders.
    * 1.12: Added `{{ roles-editor }}` to the list of privileged roles assigned at the organization, cloud, and folder levels.
    * 4.7: Added a guide on how to encrypt data in {{ mpg-full-name }} and {{ mgp-full-name }} using `pgcrypto` and {{ kms-short-name }}.
    * 4.14: Added recommendations for using {{ lockbox-full-name }} in {{ TF }} without writing the information to `.tfstate`.


* **Added Section 9. Application security:**
    * 9.1 {{ captcha-full-name }} is used.
    * 9.2 Enabled the scan on push policy for the containerized image vulnerability scanner.
    * 9.3 Container images are periodically scanned.
    * 9.4 Container images used in a production environment have the last scan date a week ago or less.
    * 9.5 Software artifacts are built using attestations.
    * 9.6 Artifacts within a pipeline can be signed using Cosign, a third-party command line utility.
    * 9.7 Artifacts are checked when deployed in {{ managed-k8s-full-name }}.
    * 9.8 Ready-made secure pipeline blocks are used.
