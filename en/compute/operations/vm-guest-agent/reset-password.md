---
title: How to reset a Windows Server admin password
description: This article describes how to reset a Windows Server VM admin password.
---

# Resetting a Windows Server admin password

{% note warning %}

[Install](install.md) the password reset agent, if you have not installed it yet.

{% endnote %}

The first time you [connect to the VM via RDP](../vm-connect/rdp.md), you need to reset the default admin password and generate a new one.

{% list tabs group=instructions %}

- Management console {#console}

  1. In the [management console]({{link-console-main}}), select **{{ compute-name }}**.
  1. Select the VM in question.
  1. Click **Reset password**.
  1. In the window that opens, click **Generate password**.

{% endlist %}

{% note warning %}

Make sure to save the generated password, as it no longer be shown in the management console once you close the window.

{% endnote %}