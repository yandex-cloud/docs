---
title: How to reset a Windows Server admin password
description: This tutorial describes how to reset a Windows Server VM admin password.
---

# Resetting a Windows Server admin password

{% note warning %}

If you do not have a password reset agent, [install](install.md) it.

{% endnote %}

The first time you [connect to the VM over RDP](../vm-connect/rdp.md), you need to reset the default admin password and generate a new one.

{% list tabs group=instructions %}

- Management console {#console}

   1. In the [management console]({{link-console-main}}), select **{{ compute-name }}**.
   1. Select the appropriate VM.
   1. Click **Reset password**.
   1. In the window that opens, click **Generate password**.

{% endlist %}

{% note warning %}

Make sure to save the generated password. It will not be displayed in the management console after you close the window.

{% endnote %}