---
title: Service roles for {{ td-full-name }} in {{ sd-full-name }}
description: This page lists the service roles required to control access to the {{ td-full-name }} ({{ td-name }}) module in {{ sd-name }}.
---

# Service roles for {{ td-full-name }} ({{ td-name }})

With [{{ td-full-name }}](../concepts/threat-detector.md) ({{ td-name }}) service roles, you can manage user access to the KSPM resources and their settings, as well as to the data on detected threats.

{% include [roles-security-deck-threat-detector](../../_mermaid/roles/security-deck-td.md) %}

#### threat-detector.worker {#threat-detector-worker}

{% include [threat-detector.worker](../../_roles/threat-detector/worker.md) %}

#### threat-detector.auditor {#threat-detector-auditor}

{% include [threat-detector.auditor](../../_roles/threat-detector/auditor.md) %}

#### threat-detector.viewer {#threat-detector-viewer}

{% include [threat-detector.viewer](../../_roles/threat-detector/viewer.md) %}

#### threat-detector.editor {#threat-detector-editor}

{% include [threat-detector.editor](../../_roles/threat-detector/editor.md) %}

#### threat-detector.admin {#threat-detector-admin}

{% include [threat-detector.admin](../../_roles/threat-detector/admin.md) %}