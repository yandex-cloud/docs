---
title: Possible errors when using {{ sd-full-name }}
description: In this tutorial, you will learn about possible errors related to {{ sd-full-name }}.
---

# Troubleshooting in {{ sd-full-name }}

The {{ sd-name }} interface provides complete error data for the following modules:

* [{{ vuln-man-name }} ({{ vuln-man-short-name }})](vm-diagnostic.md)
* [{{ td-full-name }} ({{ td-name }})](td-diagnostics.md)
* [{{ k8s }}® Security Posture Management ({{ kspm-name }})](kspm-diagnostics.md)
* [Cloud Security Posture Management ({{ cspm-name }})](cspm-diagnostics.md)
* [Data Security Posture Management ({{ dspm-name }})](dspm-diagnostics.md)

To view detected errors:

{% list tabs group=instructions %}

- {{ sd-name }} UI {#cloud-sd}

  1. Go to [{{ sd-full-name }}]({{ link-sd-main }}).
  1. At the top of the window, select the [workspace](*popup-1).
  1. In the left-hand panel, click ![vector-circle](../../_assets/console-icons/vector-circle.svg) **Workspace**.
  1. Go to the **Notifications** tab.
  1. Select a module. You will see a table with the following columns:
     
     * `{{ ui-key.yacloud_org.security.workspaces.WorkspaceModuleErrorsTable.field_message_b4Q1s }}`: Error message.
     * `{{ ui-key.yacloud_org.security.workspaces.WorkspaceModuleErrorsTable.field_source_y9C3p }}`: Resource the error was detected in.
     * `{{ ui-key.yacloud_org.security.workspaces.WorkspaceModuleErrorsTable.field_date_d5R8n }}`: Error detection date.

{% endlist %}

[*popup-1]: A _{{ sd-name }} workspace_ is a container holding the {{ sd-name }} module settings and resources, a list of controlled resources, control parameters, and other settings.
