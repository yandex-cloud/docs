# {{ yandex-cloud }} infrastructure security standard, version {{ security-standard-current-version }}

## Introduction {#intro}

This document offers recommendations for means of technical protection and helps you choose adequate information security measures when deploying information systems in {{ yandex-cloud }}.

{{ yandex-cloud }} ensures the physical security of data centers. See a [detailed description of its physical security measures](../../../security/standarts.md). If critical data is transmitted outside {{ yandex-cloud }}, the customer is responsible for managing physical access at all data processing locations.

The recommendations and security measures mentioned in the standard come with links to the **Guides and solutions for setting up** secure resource configurations using standard and additional information security tools available to {{ yandex-cloud }} users.

The standard also describes the methods and means of verifying compliance with the recommendations, including:

* Management console UI
* {{ yandex-cloud }} CLI
* Manually

### Scope {#application}


These recommendations are addressed to architects, technical specialists, and information security experts who employ the following services to develop protected cloud systems and security policies for the cloud platform:

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
* [{{ mmg-full-name }}](../../../storedoc/)
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
* Secure virtual environment configuration.
* Data encryption and key management
* Collecting, monitoring, and analyzing audit logs
* Backup
* Physical security
* Application security
* {{ k8s }} security

### Requirements and preparation {#requirements-and-preparation}

Before you perform checks, make sure that:
* You have the CLI is installed and configured according to [this guide](../../../cli/quickstart.md).
* You have logged in to the [management console]({{ link-console-main }}).
* The jq utility is installed.

You can automate the audit of compliance with all the recommendations using available solutions from our partners:
* [Cloud Advisor](/marketplace/products/cloudadvisor/cloudadvisor): Agentless CNAPP that provides vulnerability scanning, malware detection, configuration auditing, asset inventory, and compliance validation for VMs and containers.
* [Neocat](/marketplace/products/neoflex/neocat): Cloud security management product by Neoflex. Operates as an isolated installation within the user's cloud perimeter and requires no administrator privileges.

### Limitation of responsibility {#liability-limit}

{{ yandex-cloud }} uses the [shared responsibility](/security/shared-responsibility) concept. Where the lines are drawn for who is responsible for security depends on the services used by the system in the cloud, their usage model, i.e., infrastructure as a service (IaaS), platform as a service (PaaS), or software as a service (SaaS), and the security tools and policies the cloud provider has in place.

### Terms and abbreviations {#terms}

This document uses the terms and definitions introduced in ISO/IEC 27000:2018 and ISO/IEC 29100:2011.

### IDs {#ids}

Each check has an ID in the following format: `ID:IAM1`. These IDs are used to create links to standard sections for use in Cloud Security Posture Management ({{ cspm-name }}) tools and do not contain any other information.
