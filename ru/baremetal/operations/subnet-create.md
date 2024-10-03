---
title: "Как создать приватную подсеть в {{ baremetal-full-name }}"
description: "Следуя данной инструкции, вы сможете создать приватную подсеть, к которой подключите ваши серверы в {{ baremetal-full-name }}."
---

# Создать приватную подсеть

{% list tabs group=instructions %}

- Консоль управления {#console}

  1. В [консоли управления]({{ link-console-main }}) выберите каталог, в котором хотите создать [приватную подсеть](../concepts/index.md#private-subnet).
  1. В списке сервисов выберите **{{ baremetal-name }}**.
  1. На панели слева выберите ![icon](../../_assets/console-icons/nodes-right.svg) **{{ ui-key.yacloud.baremetal.label_subnetworks }}**.
  1. Справа вверху нажмите кнопку **Создать подсеть**.
  1. В поле **{{ ui-key.yacloud.baremetal.field_name }}** укажите имя подсети. Требования к имени:

     * длина — от 2 до 63 символов;
     * может содержать строчные буквы латинского алфавита, цифры и дефисы;
     * первый символ — буква, последний — не дефис.

  1. (Опционально) Добавьте **{{ ui-key.yacloud.baremetal.field_description }}** подсети.
  1. (Опционально) Добавьте метки.
  1. (Опционально) Настройте маршрутизацию для взаимодействия с серверами из других [пулов](../concepts/index.md#server-pools):

     1. Включите опцию **{{ ui-key.yacloud.baremetal.title_routing-settings }}**.
     1. В поле **{{ ui-key.yacloud.baremetal.field_network-id }}** выберите [VRF](../concepts/index.md#vrf). Он должен быть создан заранее.
     1. В поле **{{ ui-key.yacloud.baremetal.field_CIDR }}** введите IP-адрес и маску подсети.
     1. Нажмите кнопку **Создать подсеть**.

{% endlist %}
