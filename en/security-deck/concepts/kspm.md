---
title: '{{ k8s }}® Security Posture Management (KSPM) in {{ sd-full-name }}'
description: '{{ k8s }}® Security Posture Management (KSPM) ensures that containerized applications and images used in your {{ yandex-cloud }} infrastructure comply with comprehensive security requirements and best practices.'
---

# {{ k8s }}® Security Posture Management (KSPM)

{% include [note-preview-kspm](../../_includes/security-deck/note-preview-kspm.md) %}

{% include [kspm-basic-intro](../../_includes/security-deck/kspm-basic-intro.md) %}

The KSPM configuration is set when you [create](../operations/workspaces/create.md) a workspace and may include checking clusters for compliance with the following standards:

{% include [kspm-sec-standard-list](../../_includes/security-deck/kspm-sec-standard-list.md) %}

The KSPM module allows you to flexibly select and customize security rules to meet your organization's specific requirements, as well as create rule exceptions.

{% include [kspm-alerts](../../_includes/security-deck/kspm-alerts.md) %}

For more information, see [{#T}](../operations/kspm/enable-kspm.md).

### See also {#see-also}

* [{#T}](workspace.md)
* [{#T}](cspm.md)
* [{#T}](ai-assistant.md)
* [{#T}](../quickstart-overview.md)
* [{#T}](../operations/kspm/enable-kspm.md).
* [{#T}](../security/kspm-roles.md)
