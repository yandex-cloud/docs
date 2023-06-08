# Standard for securing {{ yandex-cloud }} infrastructure 1.0

## Introduction {#intro}

This document provides recommendations for technical protection measures and helps you choose information security measures when deploying information systems in {{ yandex-cloud }}.
The recommendations and security measures described in the standard have links to the **instructions and solutions for setting up** secure resource configurations with standard and additional information security tools available to {{ yandex-cloud }} users.
The standard also describes different methods and tools for verifying recommendation compliance, such as:

* Using the management console UI.
* Using the {{ yandex-cloud }} CLI.
* Manually.

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
* Authentication and access control.
* Network security.
* Secure configuration of a virtual environment.
* Data encryption and key management.
* Collecting, monitoring, and analyzing audit logs.
* Vulnerability management.
* Backups.
* Physical security.

### Requirements to meet before you start {#requirements-and-preparation}

Before you perform checks, make sure that:
* You have the YC CLI installed and set up according to the [instructions](../../../cli/quickstart.md).
* You have logged in to the [management console]({{ link-console-main }}).
* The jq utility is installed.

You can automate the audit of compliance with all the recommendations using available solutions from our partners:
* [Neocat](/marketplace/products/neoflex/neocat): A product for cloud security management from Neoflex. It's used as an isolated installation within the user's cloud perimeter and no administrator privileges need to be granted.
* [Cloud Advisor](/blog/posts/2021/03/cloud-advisor-review): An agentless platform that identifies and prioritizes cloud security risks, helps you reduce costs, ensure compliance with regulatory requirements, and manage your cloud infrastructure.

### Responsibility limitation {#liability-limit}

{{ yandex-cloud }} uses the concept of [Shared responsibility](/security/shared-responsibility). Where the lines are drawn for who is responsible for security depends on the services used by the system in the cloud, their usage model, i.e., infrastructure as a service ([IaaS](/blog/posts/2022/01/iaas)), platform as a service ([PaaS](/blog/posts/2023/03/paas)), or software as a service ([SaaS](/blog/posts/2023/03/saas)), and the security tools and policies the cloud provider has in place.

### Terms and abbreviations {#terms}

This document uses the terms and definitions introduced in ISO/IEC 27000:2018 and ISO/IEC 29100:2011, as well as the terms from the {{ yandex-cloud }} [glossary](../../../glossary/).
