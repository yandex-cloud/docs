---
title: Possible errors when using Cloud Security Posture Management ({{ cspm-name }}) in {{ sd-full-name }}
description: In this tutorial, you will learn about possible errors related to Cloud Security Posture Management ({{ cspm-name }}).
---

# Troubleshooting Cloud Security Posture Management ({{ cspm-name }})

## Failed to access a resource explicitly specified in the workspace {#explicit-resource-access-error}

The infrastructure check result is incomplete. The service account lacks permissions for one or more child resources of one of the workspace resources. Make sure the service account has the necessary [roles](../security/cspm-roles.md) for all the workspace resources. Then restart the workspace check.

## Failed to access a resource {#resource-access-error}

The infrastructure check result may be incomplete. The service account lacks permissions for one or more resources within the scope of the check. Make sure the service account has the necessary [roles](../security/cspm-roles.md) for all resources within the scope of the check. Then restart the workspace check.

## Failed to send an alert for a rule {#alert-send-error}

Check the alert sink specified in settings to make sure it exists and operates correctly. Make sure the alert sink is properly configured, accessible, and not overloaded. For details on configuring alert sinks, see [About {{ alerts-name }}](../concepts/alerts.md).

## Unforeseen error when calculating or sending an alert for a rule {#alert-processing-error}

Unforeseen issue when processing an alert on the {{ cspm-name }} side. If the error persists, contact [support]({{ link-console-support }}). In your ticket, include the error code and rule ID.
