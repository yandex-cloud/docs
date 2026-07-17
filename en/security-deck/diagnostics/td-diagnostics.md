---
title: Possible errors when using {{ td-full-name }} ({{ td-name }}) in {{ sd-full-name }}
description: In this tutorial, you will learn about possible errors related to {{ td-full-name }} ({{ td-name }}).
---

# Troubleshooting {{ td-full-name }} ({{ td-name }})

## Service account does not have sufficient permissions for resources in scope {#account-permissions}

The service account lacks permissions for resources within the collection scope. The error description will include the service account ID and the resource it was unable to access. Make sure the service account has the `threat-detector.worker` [role](../security/index.md) for the resources scanned by the module.

## Alert delivery for this rule is restricted {#delivery-limit}

The user received over 100 alerts triggered by a single rule within five minutes. In the error description, you will see the number of alerts and the timestamp of the last alert. Try to identify the root cause of mass alerts or mute alerts for this rule.
