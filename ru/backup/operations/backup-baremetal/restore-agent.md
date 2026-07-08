---
title: Как восстановить работоспособность агента {{ backup-full-name }}
description: Следуя данной инструкции, вы сможете восстановить работоспособность агента {{ backup-full-name }} после обновления версии ядра Linux.
---

# Восстановить работоспособность агента {{ backup-name }} после обновления ядра Linux


{% include [update-kernel-headers-description](../../../_includes/backup/operations/update-kernel-headers-description.md) %}

{% list tabs group=operating_system %}

- Debian/Ubuntu {#ubuntu}

  {% include [update-kernel-headers-ubuntu](../../../_includes/backup/operations/update-kernel-headers-ubuntu.md) %}

- CentOS {#centos}

  {% include [update-kernel-headers-centos](../../../_includes/backup/operations/update-kernel-headers-centos.md) %}

{% endlist %}

Если по какой-либо причине восстановить работу агента {{ backup-name }} не удалось, [обратитесь]({{ link-console-support }}) в службу технической поддержки.