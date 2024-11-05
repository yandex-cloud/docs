---
title: Как создать VRF в {{ baremetal-full-name }}
description: Следуя данной инструкции, вы сможете создать виртуальный сегмент сети (VRF) в {{ baremetal-full-name }}.
---

# Создать VRF

{% list tabs group=instructions %}

- Консоль управления {#console}

  1. В [консоли управления]({{ link-console-main }}) выберите каталог, в котором хотите создать [виртуальный сегмент сети (VRF)](../concepts/network.md#vrf-segment).
  1. В списке сервисов выберите **{{ ui-key.yacloud.iam.folder.dashboard.label_baremetal }}**.
  1. На панели слева выберите ![icon](../../_assets/console-icons/vector-square.svg) **{{ ui-key.yacloud.baremetal.label_networks }}**.
  1. Справа вверху нажмите кнопку **{{ ui-key.yacloud.baremetal.label_create-network }}**.
  1. В поле **{{ ui-key.yacloud.baremetal.field_name }}** укажите имя VRF. Требования к имени:

     * длина — от 2 до 63 символов;
     * может содержать строчные буквы латинского алфавита, цифры и дефисы;
     * первый символ — буква, последний — не дефис.

  1. (Опционально) Добавьте **{{ ui-key.yacloud.baremetal.field_description }}** VRF.
  1. (Опционально) Добавьте метки.
  1. Нажмите кнопку **{{ ui-key.yacloud.baremetal.label_create-network }}**.

{% endlist %}
