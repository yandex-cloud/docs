---
title: How to recover the {{ backup-full-name }} agent
description: Follow this guide to recover the {{ backup-full-name }} agent after a Linux kernel version update.
---

# Recovering the {{ backup-name }} agent after a Linux kernel update


{% include [update-kernel-headers-description](../../../_includes/backup/operations/update-kernel-headers-description.md) %}

{% list tabs group=operating_system %}

- Debian/Ubuntu {#ubuntu}

  {% include [update-kernel-headers-ubuntu](../../../_includes/backup/operations/update-kernel-headers-ubuntu.md) %}

- CentOS {#centos}

  {% include [update-kernel-headers-centos](../../../_includes/backup/operations/update-kernel-headers-centos.md) %}

{% endlist %}

If you were unable to recover your {{ backup-name }} agent for any reason, [contact]({{ link-console-support }}) support.