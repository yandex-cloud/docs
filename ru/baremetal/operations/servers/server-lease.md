---
title: Как арендовать сервер в {{ baremetal-full-name }}
description: Следуя данной инструкции, вы сможете арендовать сервер в {{ baremetal-full-name }}.
---

# Арендовать сервер

{% list tabs group=instructions %}

- Консоль управления {#console}

  1. {% include [server-lease-step1](../../../_includes/baremetal/instruction-steps/server-lease-step1.md) %}
  1. {% include [server-lease-step2](../../../_includes/baremetal/instruction-steps/server-lease-step2.md) %}
  1. {% include [server-lease-step3](../../../_includes/baremetal/instruction-steps/server-lease-step3.md) %}
  1. {% include [server-lease-step4](../../../_includes/baremetal/instruction-steps/server-lease-step4.md) %}
  1. {% include [server-lease-step5](../../../_includes/baremetal/instruction-steps/server-lease-step5.md) %}
  1. {% include [server-lease-step6](../../../_includes/baremetal/instruction-steps/server-lease-step6.md) %}
  1. {% include [server-lease-step7-bm](../../../_includes/baremetal/instruction-steps/server-lease-step7-bm.md) %}
  1. {% include [server-lease-step8](../../../_includes/baremetal/instruction-steps/server-lease-step8.md) %}
  1. {% include [server-lease-step9-bm](../../../_includes/baremetal/instruction-steps/server-lease-step9-bm.md) %}
  1. Если вы устанавливаете на сервер операционную систему из публичного образа в {{ marketplace-short-name }}, в блоке **{{ ui-key.yacloud.baremetal.title_server-access }}** задайте параметры доступа к серверу:

      {% include [server-lease-access](../../../_includes/baremetal/server-lease-access.md) %}

  1. (Опционально) Включите резервное копирование сервера в [{{ backup-full-name }}](../../../backup/index.yaml):

      {% include [server-lease-step10](../../../_includes/baremetal/instruction-steps/server-lease-step10.md) %}

      Подробнее см. в инструкции [{#T}](../../../backup/operations/backup-baremetal/lease-server-with-backup.md).

  1. {% include [server-lease-step11](../../../_includes/baremetal/instruction-steps/server-lease-step11.md) %}
  1. {% include [server-lease-step12](../../../_includes/baremetal/instruction-steps/server-lease-step12.md) %}

{% endlist %}

После того как вы арендуете сервер, вы в любой момент сможете установить или переустановить на нем операционную систему из публичного образа в {{ marketplace-short-name }} или из собственного ISO-образа. Подробнее см. в инструкциях [{#T}](./reinstall-os-from-marketplace.md) и [{#T}](./reinstall-os-from-own-image.md).