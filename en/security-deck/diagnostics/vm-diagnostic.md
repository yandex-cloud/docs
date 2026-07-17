---
title: Possible errors when using {{ vuln-man-name }} ({{ vuln-man-short-name }}) in {{ sd-full-name }}
description: In this tutorial, you will learn about the possible errors when using {{ vuln-man-name }} ({{ vuln-man-short-name }}).
---

# Troubleshooting {{ vuln-man-name }} ({{ vuln-man-short-name }})

## Access denied to resource `Id` {#account-permissions}

The service account lacks permissions for one or more resources within the scan scope. Make sure the service account has the required [roles](../security/index.md) to scan the specified resources. Then restart the scan.

## Resource `Id` was not found in scope {#resource-not-found}

A resource listed in the scan scope was deleted or moved. Check the scan scope configuration for relevance in the [workspace settings](../operations/workspaces/update.md) under **{{ ui-key.yacloud_org.security.workspaces.WorkspaceEditPageLayout.tabResources_vJuSN }}**. Either remove the missing resource from the scan target list or restore it and then restart the scan.

## OS is not supported {#unsupported-os}

The image uses an operating system for which {{ vuln-man-short-name }} has no up-to-date vulnerability databases. This image will be skipped by the scan. Consider upgrading the image to a supported OS version. If this OS type is critical for you, contact [support]({{ link-console-support }}).

## An unexpected technical error occurred while scanning image {#internal-error}

Unforeseen issue on the {{ vuln-man-name }} side. If the error persists, contact [support]({{ link-console-support }}). In your ticket, state the error code and scan run ID.
