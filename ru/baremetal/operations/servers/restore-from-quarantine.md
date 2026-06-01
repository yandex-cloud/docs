---
title: Восстановить сервер из карантина в {{ baremetal-full-name }}
description: Следуя данной инструкции, вы сможете восстановить сервер из карантина в {{ baremetal-full-name }}.
---

# Восстановить сервер из карантина

{% note info %}

Функция восстановления из карантина доступна только в консоли управления {{ yandex-cloud }}.

{% endnote %}

Если сервер находится в карантине, вы можете восстановить его для дальнейшего использования в течение 72 часов. При восстановлении период времени, в течение которого сервер находился в карантине, будет включен в оплачиваемый срок аренды. Подробнее о карантине на странице [{#T}](../../concepts/servers.md#quarantine).

{% list tabs group=instructions %}

- Консоль управления {#console}

  1. В [консоли управления]({{ link-console-main }}) выберите каталог, которому принадлежит сервер.
  1. Перейдите в сервис **{{ ui-key.yacloud.iam.folder.dashboard.label_baremetal }}**.
  1. В строке с нужным сервером нажмите значок ![image](../../../_assets/console-icons/ellipsis.svg) и выберите **{{ ui-key.yacloud.baremetal.action_server-prolongate-ended-rent }}**.
  1. В открывшемся окне подтверждения ознакомьтесь с сообщением `{{ ui-key.yacloud.baremetal.message_confirm-server-prolongate-ended-rent }}`. Нажмите кнопку **{{ ui-key.yacloud.baremetal.action_server-prolongate-ended-rent }}**.

{% endlist %}
