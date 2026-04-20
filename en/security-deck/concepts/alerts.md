---
title: '{{ alerts-name }} in {{ sd-full-name }}'
description: '{{ alerts-name }} provides a single interface for information on security issues in {{ yandex-cloud }} clients'' infrastructure.'
---

# About {{ alerts-name }}

{% include [note-preview](../../_includes/note-preview.md) %}

{{ alerts-name }} in {{ sd-full-name }} provides a single interface for viewing _alerts_, which are special documents containing notifications or warnings about security issues, such as infrastructure attacks, vulnerabilities, unsafe configurations, leaks, and incidents. This module provides additional information about each alert, a list of affected resources, the source of the alert, and tips on how to resolve the issue.

{{ alerts-name }} uses [alert sinks](./workspace.md#alert-sinks) containing alerts collected from security services, such as:

* [{{ cspm-full-name }} ({{ cspm-name }})](./cspm.md)
* [{{ dspm-full-name }} ({{ dspm-name }})](./dspm.md)
* [{{ kspm-full-name }} ({{ kspm-name }})](./kspm.md)
* {{ td-full-name }} ({{ td-name }})
* [{{ vuln-man-name }} ({{ vuln-man-short-name }})](./vulnerability-management.md)
* [{{ ycdr-name }}](../../ycdr/)

On the alert page, you can [run](../operations/alerts/work.md#ai-analysis) its AI analysis. The [AI assistant](./ai-assistant.md) will help you fix your configuration issue, factoring in the alert context and parameters. In addition to its recommendations, the AI assistant will prepare a summary and explain the substance of the alert.

To streamline operations with a large number of alerts, the module [supports](../operations/alerts/view.md#search) visual grouping, search, and filtering. These features enable you to:

* Quickly find alerts of a certain type.
* Filter alerts by source to analyze threats by their impact on infrastructure.
* Assess the scale of data for analysis and investigation.


#### See also {#see-also}

* [{#T}](../operations/alerts/work.md)
* [{#T}](../operations/alerts/view.md)
* [{#T}](../../ycdr/concepts/index.md)
* [{#T}](./cspm.md)
* [{#T}](./kspm.md)
* [{#T}](./ai-assistant.md)