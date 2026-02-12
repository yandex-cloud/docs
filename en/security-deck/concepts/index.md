---
title: '{{ sd-full-name }} overview'
description: '{{ sd-name }} is a CNAPP, a comprehensive platform that discovers vulnerabilities, monitors and protects access to data, and enforces compliance with regulations and industry standards.'
---

# {{ sd-full-name }} overview

{% include [note-preview-by-request](../../_includes/note-preview-by-request.md) %}

{{ sd-full-name }} is a comprehensive CNAPP service whose modules discover vulnerabilities, monitor and protect access to data, and enforce compliance with regulations and industry standards.

The {{ sd-name }} modules allow you to achieve a number of security objectives:

* **Comprehensive data protection**. The [Data Security Posture Management](./dspm.md) (DSPM) module detects sensitive information stored in {{ objstorage-full-name }} [buckets](../../storage/concepts/bucket.md) and {{ yandex-360 }} [Yandex Disks]({{ link-yandex }}/support/yandex-360/business/disk/web/{{ lang }}/index.html) for timely action to protect it from unauthorized access or leaks.

* **Containerized application security management**: [{{ k8s }} Security Posture Management (KSPM)](./kspm.md) ensures the security of containerized applications and [images](../../container-registry/concepts/docker-image.md) they use. The KSPM module automatically checks the cloud infrastructure against corporate and industry standards, identifies all {{ k8s }} clusters and containers in the specified [workspace](./workspace.md), and deploys security components in them as defined in the configuration.

* **User access management**. The [Cloud Infrastructure Entitlement Management](./ciem.md) (CIEM) module allows you to manage user [access](../../iam/concepts/access-control/index.md) to diverse corporate resources with full control over who has access to which data, and what actions are allowed with that data.

    One of the fundamental principles of [{{ iam-full-name }}](../../iam/index.yaml) is that of least privilege, where users get only the access permissions they need to perform their job duties.

    {{ ciem-name }} implements this principle and helps to ensure:

    * Data security by managing user access to company resources.
    * Prevention of unauthorized access to sensitive information.
    * Effective management of [user](../../overview/roles-and-resources.md#users) and [service account](../../iam/concepts/users/service-accounts.md) access permissions.
    * Shorter time to investigate security incidents.

* **{{ yandex-cloud }} configuration management**: [Cloud Security Posture Management ({{ cspm-name }})](./cspm.md) checks the {{ yandex-cloud }} infrastructure and applications deployed within the specified [workspace](./workspace.md) for compliance with comprehensive security requirements and best practices. This module helps ensure compliance with the selected security policies and protection against common threats and vulnerabilities in the cloud.

* **Transparent data handling**. The [{{ atr-name }}](./access-transparency.md) module allows customers to follow what {{ yandex-cloud }} engineers do with the organization's resources.


Integration between modules simplifies the process of monitoring the actions of {{ yandex-cloud }} engineers and users, allowing you to quickly respond to possible security threats.

Comprehensive use of modules helps reduce the risks associated with unauthorized access, data leaks, and non-compliance with regulatory requirements.

{% include [sd-usage-security-disclaimer](../../_includes/security-deck/sd-usage-security-disclaimer.md) %}

