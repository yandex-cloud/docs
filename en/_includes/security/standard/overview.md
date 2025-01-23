# {{ yandex-cloud }} infrastructure security standard {{ security-standard-current-version }}

## Introduction {#intro}

This document provides recommendations for technical protection measures and helps you choose information security measures when deploying information systems in {{ yandex-cloud }}.

{{ yandex-cloud }} ensures the physical security of data centers. See a [detailed description of its physical security measures](../../../security/standarts.md). If critical data is transmitted outside {{ yandex-cloud }}, the customer is responsible for managing physical access at all data processing locations.

The recommendations and security measures described in the standard have links to the **Guides and solutions for setting up** secure resource configurations with standard and additional information security tools available to {{ yandex-cloud }} users.

The standard also describes different methods and tools for verifying recommendation compliance, such as:

* Using the management console UI
* Using the {{ yandex-cloud }} CLI
* Manually

### Scope {#application}


The recommendations are designed for solution architects, technical specialists, and information security experts who use the following services when developing secure cloud systems and security policies to work with the cloud platform:

* [{{ alb-full-name }}](../../../application-load-balancer/)
* [{{ at-full-name }}](../../../audit-trails/)
* [{{ certificate-manager-full-name }}](../../../certificate-manager/)
* [{{ dns-full-name }}](../../../dns/)
* [{{ cloud-logging-full-name }}](../../../logging/)
* [{{ org-full-name }}](../../../organization/)
* [{{ compute-full-name }}](../../../compute/)
* [{{ container-registry-full-name }}](../../../container-registry/)
* [{{ iam-full-name }} ({{ iam-short-name }})](../../../iam/)
* [{{ kms-full-name }}](../../../kms/)
* [{{ lockbox-full-name }}](../../../lockbox/)
* [{{ mch-full-name }}](../../../managed-clickhouse/)
* [{{ mgl-full-name }}](../../../managed-gitlab/)
* [{{ managed-k8s-full-name }}](../../../managed-kubernetes/)
* [{{ mmg-full-name }}](../../../managed-mongodb/)
* [{{ mmy-full-name }}](../../../managed-mysql/)
* [{{ mpg-full-name }}](../../../managed-postgresql/)
* [{{ mrd-full-name }}](../../../managed-redis/)
* [{{ ydb-full-name }}](../../../ydb/)
* [{{ network-load-balancer-full-name }}](../../../network-load-balancer/)
* [{{ objstorage-full-name }}](../../../storage/)
* [{{ resmgr-full-name }}](../../../resource-manager/)
* [{{ sws-full-name }}](../../../smartwebsecurity/)
* [{{ captcha-full-name }}](../../../smartcaptcha/)
* [{{ vpc-full-name }}](../../../vpc/)

The standard can be used as the basis for developing company-specific recommendations. Not all of the information security measures and recommendations from this document are applicable. Moreover, additional measures and recommendations that are not included in the current standard may be required.

### Standard structure {#structure}

The standard describes recommendations for the following security objectives:
* Authentication and access management
* Network security
* Secure configuration of a virtual environment
* Data encryption and key management
* Collecting, monitoring, and analyzing audit logs
* Backup
* Physical security
* Application security
* {{ k8s }} security

### Requirements and preparation {#requirements-and-preparation}

Before you perform checks, make sure that:
* You have the YC CLI installed and set up according to the [instructions](../../../cli/quickstart.md).
* You have logged in to the [management console]({{ link-console-main }}).
* The jq utility is installed.

You can automate the audit of compliance with all the recommendations using available solutions from our partners:
* [Neocat](/marketplace/products/neoflex/neocat): Product for cloud security management from Neoflex. It is used as an isolated installation within the user cloud perimeter and no administrator privileges need to be granted.
* Cloud Advisor: Agentless platform that identifies and prioritizes cloud security risks, helps you reduce costs, ensure compliance with regulatory requirements, and manage your cloud infrastructure.

### Responsibility limitation {#liability-limit}

{{ yandex-cloud }} uses the concept of [Shared responsibility](/security/shared-responsibility). Where the lines are drawn for who is responsible for security depends on the services used by the system in the cloud, their usage model, i.e., infrastructure as a service (IaaS), platform as a service (PaaS), or software as a service (SaaS), and the security tools and policies the cloud provider has in place.

### Terms and abbreviations {#terms}

This document uses the terms and definitions introduced in ISO/IEC 27000:2018 and ISO/IEC 29100:2011, as well as the terms from the {{ yandex-cloud }} .
