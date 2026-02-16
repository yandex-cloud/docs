# {{ yandex-360 }} protection and safe use standard, version {{ 360-standard-current-version }}

## Introduction {#introduction}

This document offers recommendations for means of technical protection and helps you choose adequate information security measures when using {{ yandex-360 }} services.

The recommendations and security measures mentioned in this standard come with links to the APIs and solutions for setting up secure configurations using standard information security tools.

The standard describes the methods and means of verifying compliance with the recommendations, including:

* {{ yandex-360 }} UI
* [API {{ yandex-360 }}](https://yandex.ru/dev/api360/doc/ru/)

### Scope {#scope}

These recommendations are addressed to administrators, technical specialists, and information security specialists responsible for the security of information systems built around {{ yandex-360 }} services.

The standard can be used as the basis for developing company-specific recommendations. Not all of the information security measures and recommendations from this document are applicable. Moreover, additional measures and recommendations that are not included in the current standard may be required.

### Standard structure {#structure}

The standard describes recommendations for the following security objectives:

* Account and access permission management.
* Two-factor authentication and account recovery.
* Monitoring and analysis of audit logs.
* Password policy and password management.
* Restricting access to external services and applications.
* Data protection and leak prevention.

### Requirements and preparation {#requirements}

Prior to the checks, make sure that:

* You have the necessary access permissions for the {{ yandex-360 }} APIs.
* You are familiar with the documentation for the APIs in question.
* You have access to audit logs and other necessary data.

You can automate the audit of compliance with all recommendations using {{ yandex-360 }} API-based scripts.

### Limitation of responsibility {#limitation-of-liability}

{{ yandex-360 }} uses the concept of shared responsibility. The limit of responsibility for security depends on the type of platform (SaaS model), built-in protection mechanisms, and policies made available by the provider.

As a service provider, Yandex is responsible for physical security of data centers, supporting a holistic fault-tolerant platform, network infrastructure protection, monitoring and analysis of system-level events, as well as implementation of the Security-by-Default mechanisms: data encryption, anti-spam and anti-DDoS tools, other inbuilt levels of protection.

The client (Organization 360 owner) contributes access setup and management functions: assigns roles (users, managers, admins), implements password policies, enables two-factor authentication, configures networking rules for services (e.g., Yandex Telemost), performs data processing and classification, backups and audits of objects within the organization.

The provider thus guarantees the infrastructure-level security and stability, whereas the client ensures reliable configuration, access control, and data protection within their SaaS organization.

### Terms and abbreviations {#terms}

This document uses the terms and definitions used in the {{ yandex-360 }} documentation, as well as generally accepted terms in the field of information security.