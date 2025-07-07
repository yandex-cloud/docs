---
title: How to lease a server in {{ baremetal-full-name }}
description: In this tutorial, you will learn how to lease a server in {{ baremetal-full-name }}.
---

# Leasing a server

{% list tabs group=instructions %}

- Management console {#console}

  1. {% include [server-lease-step1](../../../_includes/baremetal/instruction-steps/server-lease-step1.md) %}
  1. {% include [server-lease-step2](../../../_includes/baremetal/instruction-steps/server-lease-step2.md) %}
  1. {% include [server-lease-step3](../../../_includes/baremetal/instruction-steps/server-lease-step3.md) %}
  1. {% include [server-lease-step4](../../../_includes/baremetal/instruction-steps/server-lease-step4.md) %}
  1. {% include [server-lease-step5](../../../_includes/baremetal/instruction-steps/server-lease-step5.md) %}
  1. {% include [server-lease-step6](../../../_includes/baremetal/instruction-steps/server-lease-step6.md) %}
  1. {% include [server-lease-step7-bm](../../../_includes/baremetal/instruction-steps/server-lease-step7-bm.md) %}
  1. {% include [server-lease-step8](../../../_includes/baremetal/instruction-steps/server-lease-step8.md) %}
  1. {% include [server-lease-step9-bm](../../../_includes/baremetal/instruction-steps/server-lease-step9-bm.md) %}
  1. If you are installing an OS on the server from a public image in {{ marketplace-name }}, set the server access settings under **{{ ui-key.yacloud.baremetal.title_server-access }}**:

      {% include [server-lease-access](../../../_includes/baremetal/server-lease-access.md) %}

  1. Optionally, enable server backup in [{{ backup-full-name }}](../../../backup/index.yaml):

      {% include [server-lease-step10](../../../_includes/baremetal/instruction-steps/server-lease-step10.md) %}

      For more information, see [{#T}](../../../backup/operations/backup-baremetal/lease-server-with-backup.md).

  1. {% include [server-lease-step11](../../../_includes/baremetal/instruction-steps/server-lease-step11.md) %}
  1. {% include [server-lease-step12](../../../_includes/baremetal/instruction-steps/server-lease-step12.md) %}

{% endlist %}

Once you lease a server, you can install or reinstall the OS at any time using either a {{ marketplace-name }} public image or your own custom ISO. For more information, see [{#T}](./reinstall-os-from-marketplace.md) and [{#T}](./reinstall-os-from-own-image.md).