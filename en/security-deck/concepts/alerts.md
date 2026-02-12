---
title: '{{ alerts-name }} in {{ sd-full-name }}'
description: '{{ alerts-name }} provides a single interface for information on security issues in {{ yandex-cloud }} clients'' infrastructure.'
---

# About {{ alerts-name }}

{% include [note-preview](../../_includes/note-preview.md) %}

{{ alerts-name }} in {{ sd-full-name }} provides a single interface for viewing _alerts_, which are special documents containing notifications or warnings about security issues, such as infrastructure attacks, vulnerabilities, unsafe configurations, leaks, and incidents. This module provides additional information about each alert, a list of affected resources, the source of the alert, and tips on how to resolve the issue.

{{ alerts-name }} uses [alert sinks](./workspace.md#alert-sinks) containing alerts collected from various security services, such as [Data Security Posture Management ({{ dspm-name }})](./dspm.md), [Cloud Security Posture Management ({{ cspm-name }})](./cspm.md), and [{{ k8s }} Security Posture Management (KSPM)](./kspm.md), as data sources.

On the alert page, you can run its AI analysis. The [AI assistant](./ai-assistant.md) will help you fix your configuration issue, factoring in the alert context and parameters. In addition to its recommendations, the AI assistant will prepare a summary and explain the substance of the alert.

#### See also {#see-also}

* [{#T}](../../ycdr/concepts/index.md)
* [{#T}](./cspm.md)
* [{#T}](./kspm.md)
* [{#T}](./ai-assistant.md)