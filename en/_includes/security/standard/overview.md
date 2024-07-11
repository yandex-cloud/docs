# Standard for securing {{ yandex-cloud }} infrastructure 1.1

## Introduction {#intro}

This document provides recommendations for technical protection measures and helps you choose information security measures when deploying information systems in {{ yandex-cloud }}.
The recommendations and security measures described in the standard have links to the **Guides and solutions for setting up** secure resource configurations with standard and additional information security tools available to {{ yandex-cloud }} users.
The standard also describes different methods and tools for verifying recommendation compliance, such as:

* Using the management console UI
* Using the {{ yandex-cloud }} CLI
* Manually

### What is new in version 1.1 {#whats-new-1-1}

List of changes to version 1.1. compared to version 1.0:

* Added the following items:

   * 1.20 Impersonation is used wherever possible.
   * 1.21 Resource labels are used.
   * 1.22 {{ yandex-cloud }} security notifications are enabled.
   * 1.23 The `{{ roles-auditor }}` role is used to prevent access to user data.
   * 3.4.2 Integrity control of a VM runtime environment.
   * 3.28 Antivirus protection is used.
   * 3.29 {{ managed-k8s-full-name }} security guidelines are used.
   * 4.16 There is a guide for cloud administrators on handling compromised secrets.

* Updated the following items:

   * 1.4, 1.14 Added recommendations for using the `{{ roles-auditor }}` role.
   * 1.9 Added recommendations for placing critical service accounts in separate folders.
   * 1.12 Added `{{ roles-editor }}` to the list of privileged roles assigned at the organization, cloud, and folder levels.
   * 4.7 Added a guide on how to encrypt data in {{ mpg-full-name }} and {{ mgp-full-name }} using `pgcrypto` and {{ kms-short-name }}.
   * 4.13 Added recommendations for using {{ lockbox-full-name }} in {{ TF }} without writing the information to `.tfstate`.


* Added the [{#T}](../../../security/standard/app-security.md) section:

   * 9.1 {{ captcha-full-name }} is used.
   * 9.2 Enabled the scan on push policy for the containerized image vulnerability scanner.
   * 9.3 Container images are periodically scanned.
   * 9.4 Container images used in a production environment have the last scan date a week ago or less.
   * 9.5 Software artifacts are built using attestations.
   * 9.6 Artifacts within a pipeline can be signed using Cosign, a third-party command line utility.
   * 9.7 Artifacts are checked when deployed in {{ managed-k8s-full-name }}.
   * 9.8 Ready-made blocks of a secure pipeline are used.


### Scope {#application}


The recommendations are designed for solution architects, technical specialists, and information security experts who use the following services when developing secure cloud systems and security policies to work with the cloud platform:

* [{{ iam-name }} ({{ iam-short-name }})](../../../iam/)
* [{{ alb-name }}](../../../application-load-balancer/)
* [{{ at-name }}](../../../audit-trails/)
* [{{ certificate-manager-name }}](../../../certificate-manager/)
* [{{ dns-name }}](../../../dns/)
* [{{ cloud-logging-name }}](../../../logging/)
* [{{ compute-name }}](../../../compute/)
* [{{ kms-name }}](../../../kms/)
* [{{ lockbox-name }}](../../../lockbox/)
* [{{ mch-name }}](../../../managed-clickhouse/)
* [{{ mgl-name }}](../../../managed-gitlab/)
* [{{ mmg-name }}](../../../managed-mongodb/)
* [{{ mmy-name }}](../../../managed-mysql/)
* [{{ mpg-name }}](../../../managed-postgresql/)
* [{{ mrd-name }}](../../../managed-redis/)
* [{{ network-load-balancer-name }}](../../../network-load-balancer/)
* [{{ objstorage-name }}](../../../storage/)
* [{{ org-name }}](../../../organization/)
* [{{ resmgr-name }}](../../../resource-manager/)
* [{{ vpc-name }}](../../../vpc/)
* [{{ ydb-name }}](../../../ydb/)

The standard can be used as the basis for developing company-specific recommendations. Not all of the information security measures and recommendations from this document are applicable. Moreover, additional measures and recommendations that are not included in the current standard may be required.

### Structure of the standard {#structure}

The standard describes recommendations for the following security objectives:
* Authentication and access control
* Network security
* Secure configuration of a virtual environment
* Data encryption and key management
* Collecting, monitoring, and analyzing audit logs
* Vulnerability management
* Backups
* Physical security
* Application security

### Requirements to meet before you start {#requirements-and-preparation}

Before you perform checks, make sure that:
* You have the YC CLI installed and set up according to the [instructions](../../../cli/quickstart.md).
* You have logged in to the [management console]({{ link-console-main }}).
* The jq utility is installed.

You can automate the audit of compliance with all the recommendations using available solutions from our partners:
* [Neocat](/marketplace/products/neoflex/neocat): Product for cloud security management from Neoflex. It is used as an isolated installation within the user cloud perimeter and no administrator privileges need to be granted.
* [Cloud Advisor](/blog/posts/2021/03/cloud-advisor-review): Agentless platform that identifies and prioritizes cloud security risks, helps you reduce costs, ensure compliance with regulatory requirements, and manage your cloud infrastructure.

### Responsibility limitation {#liability-limit}

{{ yandex-cloud }} uses the concept of [Shared responsibility](/security/shared-responsibility). Where the lines are drawn for who is responsible for security depends on the services used by the system in the cloud, their usage model, i.e., infrastructure as a service ([IaaS](/blog/posts/2022/01/iaas)), platform as a service ([PaaS](/blog/posts/2023/03/paas)), or software as a service ([SaaS](/blog/posts/2023/03/saas)), and the security tools and policies the cloud provider has in place.

### Terms and abbreviations {#terms}

This document uses the terms and definitions introduced in ISO/IEC 27000:2018 and ISO/IEC 29100:2011, as well as the terms from the {{ yandex-cloud }} [glossary](../../../glossary/).
