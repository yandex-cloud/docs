---
title: How to recover the {{ backup-full-name }} agent on a {{ baremetal-name }} server
description: Follow this guide to recover the {{ backup-name }} agent on a {{ baremetal-full-name }} server after a Linux kernel version update.
---

# Restoring the {{ backup-name }} agent after a Linux kernel update

{% include [update-kernel-headers-description](../../../_includes/backup/operations/update-kernel-headers-description.md) %}

{% list tabs group=operating_system %}

- Debian/Ubuntu {#ubuntu}

  {% include [update-kernel-headers-ubuntu](../../../_includes/backup/operations/update-kernel-headers-ubuntu.md) %}

{% endlist %}

If you were unable to recover your {{ backup-name }} agent for any reason, [contact]({{ link-console-support }}) support.