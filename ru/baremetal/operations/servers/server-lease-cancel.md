---
title: Как отказаться от аренды сервера в {{ baremetal-full-name }}
description: Следуя данной инструкции, вы сможете отказаться от аренды сервера в {{ baremetal-full-name }}.
---

# Отказаться от аренды сервера

После отказа от аренды сервер проработает до конца оплаченного периода, а затем будет удален.

{% list tabs group=instructions %}

- Консоль управления {#console}

  1. В [консоли управления]({{ link-console-main }}) выберите каталог, которому принадлежит сервер.
  1. В списке сервисов выберите **{{ baremetal-name }}**.
  1. В строке с нужным сервером нажмите значок ![image](../../../_assets/console-icons/ellipsis.svg) и выберите **{{ ui-key.yacloud.baremetal.action_delete-server }}**.
  1. В открывшемся окне нажмите кнопку **{{ ui-key.yacloud.baremetal.action_delete-server }}**.

{% endlist %}
