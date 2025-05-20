---
title: Как арендовать сервер {{ baremetal-full-name }} с подключением к {{ backup-full-name }}
description: Следуя данной инструкции, вы сможете арендовать сервер {{ baremetal-name }} с подключением к {{ backup-name }}.
---

# Арендовать сервер {{ baremetal-full-name }} с подключением к {{ backup-name }}

{% note info %}

{% include [baremetal-note](../../../_includes/backup/baremetal-note.md) %}

{% endnote %}

Вы можете создавать резервные копии [серверов](../../../baremetal/concepts/servers.md) {{ baremetal-name }} с поддерживаемыми операционными системами на базе Linux: {#os-support}

{% include [baremetal-os-list](../../../_includes/backup/baremetal-os-list.md) %}

## Аренда сервера {#server-rent}

{% list tabs group=instructions %}

- Консоль управления {#console}

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
  1. В блоке **{{ ui-key.yacloud.baremetal.title_server-access }}**:

      {% include [server-lease-access](../../../_includes/baremetal/server-lease-access.md) %}

  1. Включите резервное копирование сервера в {{ backup-name }}:

      {% include [server-lease-step10](../../../_includes/baremetal/instruction-steps/server-lease-step10.md) %}

  1. {% include [server-lease-step11](../../../_includes/baremetal/instruction-steps/server-lease-step11.md) %}
  1. {% include [server-lease-step12](../../../_includes/baremetal/instruction-steps/server-lease-step12.md) %}

{% endlist %}

Подробнее об аренде сервера см. в [документации {{ baremetal-name }}](../../../baremetal/operations/servers/server-lease.md).

{% note info %}

{% include [lvm-restoration-notice](../../../_includes/backup/lvm-restoration-notice.md) %}

{% endnote %}