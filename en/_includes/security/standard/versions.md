# Versions of {{ yandex-cloud }} infrastructure security standard

### Changes in version {{ security-standard-current-version }} {#current-version}

Publication date: 16/06/2025.

* **Updated the following items**:
    * Updated the [{#T}](../../../security/standard/authentication.md) section with new best practices for using {{ yandex-cloud }} with {{ yandex-360 }}.
    * In [{#T}](../../../security/standard/authentication.md#yandex-id-accounts), added a recommendation to set up 2FA for existing Yandex ID accounts.
    * In [{#T}](../../../security/standard/network-security.md#vpc-sg):
        * Changed the title from `{{ vpc-name }} has at least one security group`.
        * Improved recommendations for using security groups.
    * In [{#T}](../../../security/standard/audit-logs.md#os-level), added a recommendation to increase the logging level inside VMs to `VERBOSE`.
    * In [{#T}](../../../security/standard/audit-logs.md#app-level), added a recommendation to enable audit log collection in an unmanaged DBMS.
    * In [{#T}](../../../security/standard/audit-logs.md#data-plane-events), added a recommendation to enable all data events related to modifying operations for the specified list of services.
* Removed item **4.6 For critical data, MDB encryption with {{ kms-short-name }} is used**. The following items in [{#T}](../../../security/standard/encryption.md) have been renumbered accordingly.


### Changes in version 1.4.0 {#version-1-4-0}

Publication date: 08/04/24.

* Deleted **3.20 Side-channel attacks in {{ sf-name }} are addressed** due to the minimum level of risk.

* **Added the following items**:
    * 2.7 Employees use {{ cloud-desktop-full-name }} for remote access.
    * 2.8 Secure Yandex Browser is used for remote access to {{ cloud-desktop-name }}.
    * 3.1 Antivirus protection is used.
    * 3.7 The corporate {{ yandex-cloud }} users have the {{ yandex-cloud }} Certified Security Specialist certification.
    * 3.29 Requirements for application protection in {{ container-registry-full-name }} are met.
    * 3.30 Privileged containers are not used in {{ cos-full-name }}.
    * 3.40 Access management in {{ api-gw-name }} is configured.
    * 3.41 Networking is configured in {{ api-gw-name }}.
    * 3.42 Recommendations for using custom domains are followed.
    * 3.43 Recommendations for using Websocket are followed.
    * 3.44 API gateway interaction with {{ yandex-cloud }} services is configured.
    * 3.46 Authorization in the API gateway is configured.
    * 3.47 Authorization context is used.
    * 3.48 Logging is on.
    * 5.9 {{ sd-name }} {{ atr-name }} is on for inspection of {{ yandex-cloud }} employees actions with your infrastructure.
    * 6.2 When creating a registry in {{ container-registry-full-name }}, keep the safe registry settings by default.
    * 6.14 Trusted and unwanted IP addresses are grouped into lists.

* **In section 3. Secure virtual environment configuration**:
    * Renamed the **{{ sf-full-name }}** subsection (formerly `{{ sf-name }} and {{ api-gw-full-name }}`).
    * Added the **{{ api-gw-full-name }}** section (items 3.40 - 3.48).
    * Changed the numbering of some items in this section due to adding new subsections and items.
    
* **Updated the following items**:
    * In **1.5 Service roles are used instead of primitive ones: {{ roles-admin }}, {{ roles-editor }}, {{ roles-viewer }}, {{ roles-auditor }}**, added commands for checks via the CLI in PowerShell.
    * In **1.10 Periodic rotation of service account keys is performed**, added commands for checks via the CLI in PowerShell.
    * In **1.14 There are no cloud keys in clear text in the VM metadata service**, added automatic scripts for checks via the CLI in Bash and PowerShell.
    * In **1.17 Privileged roles are assigned only to trusted administrators**, added commands for checks via the CLI in PowerShell.
    * In **1.18 Strong passwords are set for local users of managed databases**, added a recommendation on using generated {{ lockbox-full-name }} secrets.
    * In **1.20 The correct resource model is used**, extended the description of the resource model and recommendation on how to use it.
    * In **1.21 There is no <q>public access</q> to resources in the organization**, added commands for checks via the CLI in PowerShell.
    * In **1.25 The date of the last service account authentication and the last use of the access keys in {{ iam-full-name }} are tracked**, added commands for checks via the CLI.
    * In **2.1 For cloud objects, a firewall or security groups are used**, updated the description of the principle of using custom VM disk images (the [BYOI](https://en.wikipedia.org/wiki/Bring_your_own_operating_system) principle).
    * Renumbered items **2.9 Outgoing internet access is controlled** (formerly `2.7`) and **2.10 DNS queries are not provided to third-party recursive resolvers** (formerly `2.8`).
    * Renumbered item **3.11 Logging of actions with buckets is enabled in {{ objstorage-name }}** (formerly `3.9`), clarified the description of bucket operation logging in {{ at-short-name }}, fixed punctuation.
    * Renumbered item **3.19 Access from the management console is disabled on managed databases** (formerly `3.17`), extended the command for checks in Bash, and added a command for checks in PowerShell.
    * Renumbered item **3.21 Access permissions, secrets and environment variable management, and connection to the DBMS are configured for functions** (formerly `3.19`), clarified the recommendation on storing secrets and sensitive data in {{ lockbox-full-name }} and accessing DB cluster hosts from a function.
    * In **3.28 ACL configured by IP addresses for {{ container-registry-full-name }}**, added commands for checks via the CLI in PowerShell.
    * Renumbered item **3.34 {{ managed-k8s-full-name }} security recommendations are used** (formerly `3.31`) and updated the link to the recommendations in **{{ k8s }} security requirements**.
    * Renumbered item **3.38 Established security update process** (formerly `3.35`) and added a link to [security bulletins](../../../security/security-bulletins/index.md).
    * In **Encryption at rest**, added the check of encrypted VM disks via the CLI and the guide for replacing unencrypted disks with encrypted ones, added a link to the [key rotation](../../../kms/operations/key.md#rotate) concept in the corporate information security policy.
    * In **4.3 {{ alb-full-name }} uses HTTPS**:
        * Fixed the link to [Listener setup description](../../../application-load-balancer/concepts/application-load-balancer.md#listener) in the {{ alb-full-name }} tutorials.
        * Fixed the link to the {{ alb-full-name }} HTTPS listener [guide](../../../application-load-balancer/tutorials/tls-termination/index.md).
        * Added a command for checks via the CLI in PowerShell.
    * In **4.13 The organization uses {{ lockbox-full-name }} to securely store secrets**, shortened the listed of secret storage services and the description of how to use them in {{ TF }} and the management console.
    * In **4.16 There is a guide for cloud administrators on handling compromised secrets**, rearranged the list of cloud secrets for detection.
    * In **5.2 {{ at-full-name }} events are exported to SIEM systems**, shortened the list of SIEM systems for which {{ yandex-cloud }} audit log export solutions are ready.
    * In **5.8 Data events are monitored**, replaced the list of supported services with a link to [{#T}](../../../audit-trails/concepts/events-data-plane.md).
    * Added a new item to **6. Application protection** and renumbered items 6.2 to 6.13.
    * In **6.10 {{ sws-full-name }} security profile is used**, clarified the threat models {{ sws-full-name }} provides protection from.
    * In **6.12 Advanced Rate Limiter is used**, clarified the definition of Advanced Rate Limiter (ARL).

### Changes in version 1.3 {#version-1-3}

Publication date: 27/12/24.

* **Deleted Section 6. Backup**. The section's content was moved to Section **3. Secure virtual environment configuration**.

* **Deleted Section 7. Physical security**. Moved its contents to **Introduction**.

* **Added the following items:**
    * 1.11 Service account API keys have specified scopes.
    * 1.25 The date of the last service account authentication and the last use of the access keys in {{ iam-full-name }} are tracked.
    * 1.26 Access permissions of users and service accounts are regularly audited using the {{ sd-full-name }} CIEM.

* **Updated the following items:**
    * Added [{{ container-registry-full-name }}](../../../container-registry/index.yaml), [{{ sws-full-name }}](../../../smartwebsecurity/index.yaml), and [{{ captcha-full-name }}](../../../smartcaptcha/index.yaml) to **Scope**.
    * Added information about using {{ sws-name }} to **2.5 DDoS protection is enabled**.
    * Renumbered item **3.18 {{ serverless-containers-name }}/{{ sf-short-name }} uses the {{ vpc-short-name }} internal network** (formerly `3.22`) and updated it with info on networking restrictions between functions and user resources.
    * Renumbered and renamed item **3.19 Functions are configured in terms of access control, secret and environment variable management, and DBMS connection** (formerly `3.18 Public cloud functions are only used in exceptional cases`). Updated the item with information about assigning roles for a function, working with secrets and environment variables from a function, and accessing managed {{ mpg-full-name }} and {{ mch-full-name }} databases from a function.
    * Renumbered item **3.20 Side-channel attacks in {{ sf-name }} are addressed** (formerly `3.19`)
    * Renumbered item **3.21 Aspects of time synchronization in {{ sf-name }} are addressed** (formerly `3.20`) and updated it with info on how functions get time data.
    * Renumbered item **3.22 Aspects of header management in {{ sf-name }} are addressed** (formerly `3.21`) and updated it with a description of how to invoke a function with the `?integration=raw` query parameter.
    * Added the following to **4.2 HTTPS for static website hosting is enabled in {{ objstorage-full-name }}**:
        * Checks via the CLI
        * Link to the HTTPS setup [guide](../../../storage/operations/hosting/certificate.md)
    * In item **5.4 The {{ objstorage-name }} bucket that stores the {{ at-full-name }} audit logs has been hardened**, added links to best security practices.
    * In **5.8 Data events are monitored**, expanded the list of services for which you can track events on this level.
    * In item **6.9 A {{ sws-full-name }} security profile is used**, added checks via the CLI.

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
    * 3.11 {{ sts-full-name }} is used to get access keys to {{ objstorage-name }}.
    * 3.12 Pre-signed URLs are generated for isolated cases of access to specific objects in {{ objstorage-name }} private buckets.
    * 3.32 {{ oslogin }} is used for connection to a VM or {{ k8s }} node.
    * 4.8 Encryption of disks and virtual machine snapshots is used.
    * 5.8 Data events are monitored.
    * 8.9 A {{ sws-full-name }} security profile is used.
    * 8.10 A web application firewall is used.
    * 8.11 Advanced Rate Limiter is used.
    * 8.12 Approval rules are configured.

* **Updated the following items:**
    * In **5.1 {{ at-full-name }} is enabled at the organization level**, added description of data event audit logs.
    * **6.2 Vulnerability scanning is performed at the cloud IP level** was moved to Section **3. Secure virtual environment configuration**.
    * **6.3 External security scans are performed according to the cloud rules** was moved to Section **3. Secure virtual environment configuration**.
    * **6.4 The security update process has been set up** was moved to Section **3. Secure virtual environment configuration**.
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

