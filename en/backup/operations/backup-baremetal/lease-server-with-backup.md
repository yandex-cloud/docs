---
title: How to lease a {{ baremetal-full-name }} server with a connection to {{ backup-full-name }}
description: Follow this guide to lease a {{ baremetal-name }} server with a connection to {{ backup-name }}.
---

# Leasing a {{ baremetal-full-name }} server connected to {{ backup-name }}

You can back up your {{ baremetal-name }} [servers](../../../baremetal/concepts/servers.md) with supported Linux-based operating systems: {#os-support}

{% include [baremetal-os-list](../../../_includes/backup/baremetal-os-list.md) %}

## Leasing a {#server-rent} server

{% list tabs group=instructions %}

- Management console {#console}

  1. {% include [server-lease-step1](../../../_includes/baremetal/instruction-steps/server-lease-step1.md) %}
  1. {% include [server-lease-step2](../../../_includes/baremetal/instruction-steps/server-lease-step2.md) %}
  1. {% include [server-lease-step3](../../../_includes/baremetal/instruction-steps/server-lease-step3.md) %}
  1. {% include [server-lease-step4](../../../_includes/baremetal/instruction-steps/server-lease-step4.md) %}
  1. {% include [server-lease-step5](../../../_includes/baremetal/instruction-steps/server-lease-step5.md) %}
  1. {% include [server-lease-step6](../../../_includes/baremetal/instruction-steps/server-lease-step6.md) %}

      {% include [server-lease-backup-partitioning-notice](../../../_includes/baremetal/instruction-steps/server-lease-backup-partitioning-notice.md) %}

  1. {% include [server-lease-step7-backup](../../../_includes/baremetal/instruction-steps/server-lease-step7-backup.md) %}
  1. {% include [server-lease-step8](../../../_includes/baremetal/instruction-steps/server-lease-step8.md) %}
  1. {% include [server-lease-step9-backup](../../../_includes/baremetal/instruction-steps/server-lease-step9-backup.md) %}
  1. Under **{{ ui-key.yacloud.baremetal.title_server-access }}**:

      {% include [server-lease-access](../../../_includes/baremetal/server-lease-access.md) %}

  1. Enable server backup in {{ backup-name }}:

      {% include [server-lease-step10](../../../_includes/baremetal/instruction-steps/server-lease-step10.md) %}

  1. {% include [server-lease-step11](../../../_includes/baremetal/instruction-steps/server-lease-step11.md) %}
  1. {% include [server-lease-step12](../../../_includes/baremetal/instruction-steps/server-lease-step12.md) %}

{% endlist %}

For more information on leasing a server, see the [{{ baremetal-name }} documentation](../../../baremetal/operations/servers/server-lease.md).

{% note info %}

{% include [lvm-restoration-notice](../../../_includes/backup/lvm-restoration-notice.md) %}

{% endnote %}