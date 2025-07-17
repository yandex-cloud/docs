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
  1. {% include [server-lease-step10-bm](../../../_includes/baremetal/instruction-steps/server-lease-step10-bm.md) %}
  1. Если вы устанавливаете на сервер операционную систему из публичного образа в {{ marketplace-short-name }}, в блоке **{{ ui-key.yacloud.baremetal.title_server-access }}** задайте параметры доступа к серверу:

      {% include [server-lease-access](../../../_includes/baremetal/server-lease-access.md) %}

  1. (Опционально) Включите резервное копирование сервера в [{{ backup-full-name }}](../../../backup/index.yaml):

      {% include [server-lease-step11](../../../_includes/baremetal/instruction-steps/server-lease-step11.md) %}

      Подробнее см. в инструкции [{#T}](../../../backup/operations/backup-baremetal/lease-server-with-backup.md).

  1. {% include [server-lease-step12](../../../_includes/baremetal/instruction-steps/server-lease-step12.md) %}
  1. {% include [server-lease-step13](../../../_includes/baremetal/instruction-steps/server-lease-step13.md) %}

- CLI {#cli}

   {% include [cli-install](../../../_includes/cli-install.md) %}

   {% include [default-catalogue](../../../_includes/default-catalogue.md) %}

   1. {% include [server-lease-cli-step1](../../../_includes/baremetal/instruction-steps/server-lease-cli-step1.md) %}

   1. {% include [server-lease-cli-step2](../../../_includes/baremetal/instruction-steps/server-lease-cli-step2.md) %}

   1. {% include [server-lease-cli-step3](../../../_includes/baremetal/instruction-steps/server-lease-cli-step3.md) %}

      Где:
      * {% include [server-lease-cli-pool-id](../../../_includes/baremetal/instruction-steps/server-lease-cli-pool-id.md) %}
      * {% include [server-lease-cli-configuration](../../../_includes/baremetal/instruction-steps/server-lease-cli-configuration.md) %}
      * {% include [server-lease-cli-storage](../../../_includes/baremetal/instruction-steps/server-lease-cli-storage.md) %}
      * {% include [server-lease-cli-os](../../../_includes/baremetal/instruction-steps/server-lease-cli-os.md) %}

        {% include [server-lease-step7-iso](../../../_includes/baremetal/instruction-steps/server-lease-step7-iso.md) %}

      * {% include [server-lease-cli-rental-period](../../../_includes/baremetal/instruction-steps/server-lease-cli-rental-period.md) %}

        {% include [server-lease-step6-period](../../../_includes/baremetal/instruction-steps/server-lease-step6-period.md) %}

      * {% include [server-lease-cli-network](../../../_includes/baremetal/instruction-steps/server-lease-cli-network.md) %}

          {% note warning %}

          {% include [public-subnet-no-dhcp](../../../_includes/baremetal/public-subnet-no-dhcp.md) %}

          {% endnote %}

      {% include [server-lease-cli-general](../../../_includes/baremetal/instruction-steps/server-lease-cli-general.md) %}

{% endlist %}

После того как вы арендуете сервер, вы в любой момент сможете установить или переустановить на нем операционную систему из публичного образа в {{ marketplace-name }} или из собственного ISO-образа. Подробнее см. в инструкциях [{#T}](./reinstall-os-from-marketplace.md) и [{#T}](./reinstall-os-from-own-image.md).

## Пример {#example}

 Арендуйте сервер с публичным образом ОС:

 {% list tabs group=instructions %}

 - CLI {#cli}

   ```bash
   yc baremetal server create \
     --hardware-pool-id ru-central1-m4 \
     --configuration-id ly5lymxdltk3xitpkrmi \
     --storage "partition={type=EXT3,size-gib=1000,mount-point=/},partition={type=EXT4,size-gib=500,mount-point=/root},raid-type=RAID0,disk={id=1,size-gib=1862,type=HDD},disk={id=2,size-gib=1862,type=HDD}" \
     --storage "partition={type=EXT3,size-gib=1000,mount-point=/boot},partition={type=SWAP,size-gib=10},disk={id=3,size-gib=1862,type=HDD}" \
     --os-settings "image-id=ly5vhn4lapeva2qs3bx5,ssh-key-public=ssh-ed25519 AAAAC3NzaC1lZDI1NTE5AAAAIGcM4tRfRHJGrlLMT+YJFr+aOdSQYnYYjAoj********,password-lockbox-secret={secret-id=e6qmvglkitn6********,version-id=e6qquvv4kh8e********,key=password}" \
     --rental-period-id 1-day \
     --network-interfaces private-subnet-id=ly5ztavbezrf******** \
     --network-interfaces public-subnet-id=ly5o6l7pxmk2********* \
     --name demo-baremetal-server \
     --description "My first BareMetal server" \
     --labels env=test
   ```

   {% include [server-lease-cli-result](../../../_includes/baremetal/instruction-steps/server-lease-cli-result.md) %}

{% endlist %}
