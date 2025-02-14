---
title: Выйти из песочницы в {{ cns-full-name }}
description: Следуя этой инструкции, вы сможете выйти из песочницы.
---

# Выйти из песочницы

{% include [individual-in-sandbox](../../../_includes/notifications/individual-in-sandbox.md) %}

После отработки функциональности на тестовых номерах вы можете подать заявку на выход из режима песочницы:

{% list tabs group=instructions %}

- Консоль управления {#console}

  1. В [консоли управления]({{ link-console-main }}) выберите каталог, в котором вы хотите создать канал уведомлений.
  1. В списке сервисов выберите **{{ ui-key.yacloud.iam.folder.dashboard.label_cns }}**.
  1. Выберите нужный канал SMS-уведомлений c [индивидуальным отправителем](../../concepts/sms.md#individual-sender).
  1. Нажмите **{{ ui-key.yacloud.cns.action_sms-leave-sandbox }}**.

      После этого будет автоматически сформирована заявка в техническую поддержку на выход из песочницы.

      {% include [sms-quota-increase](../../../_includes/notifications/sms-quota-increase.md) %}

{% endlist %}

После одобрения заявки вы сможете отправлять SMS на любые российские телефонные номера в формате [E.164](https://ru.wikipedia.org/wiki/E.164), например `+79991112233`.
