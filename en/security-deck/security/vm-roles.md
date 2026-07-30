---
title: Service roles for {{ vuln-man-name }} in {{ sd-full-name }}
description: This page lists the service roles required to control access to the {{ vuln-man-name }} ({{ vuln-man-short-name }}) module in {{ sd-name }}.
---

# Service roles for {{ vuln-man-name }} ({{ vuln-man-short-name }})

With [{{ vuln-man-name }}](../concepts/vulnerability-management.md) ({{ vuln-man-short-name }}) service roles, you can manage user access to the VM resources and their settings, as well as to the vulnerability scanning results.

{% include [roles-security-deck-vulnerability-manager](../../_mermaid/roles/security-deck-vm.md) %}

#### vulnerability-manager.auditor {#vulnerability-manager-auditor}

{% include [vulnerability-manager.auditor](../../_roles/vulnerability-manager/auditor.md) %}

#### vulnerability-manager.viewer {#vulnerability-manager-viewer}

{% include [vulnerability-manager.viewer](../../_roles/vulnerability-manager/viewer.md) %}

#### vulnerability-manager.editor {#vulnerability-manager-editor}

{% include [vulnerability-manager.editor](../../_roles/vulnerability-manager/editor.md) %}

#### vulnerability-manager.admin {#vulnerability-manager-admin}

{% include [vulnerability-manager.admin](../../_roles/vulnerability-manager/admin.md) %}