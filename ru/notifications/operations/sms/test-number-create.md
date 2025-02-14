---
title: Добавить тестовый номер в {{ cns-full-name }}
description: Следуя этой инструкции, вы сможете добавить тестовый номер.
---

# Добавить тестовый номер

{% include [sandbox-test-numbers](../../../_includes/notifications/sandbox-test-numbers.md) %}

Чтобы добавить тестовый номер:

{% list tabs group=instructions %}

- Консоль управления {#console}

  1. В [консоли управления]({{ link-console-main }}) выберите каталог, в котором вы хотите создать канал уведомлений.
  1. В списке сервисов выберите **{{ ui-key.yacloud.iam.folder.dashboard.label_cns }}**.
  1. Выберите нужный канал SMS-уведомлений.
  1. Перейдите на вкладку ![image](../../../_assets/console-icons/handset-arrow-in.svg) **{{ ui-key.yacloud.cns.label_phone-numbers }}**.
  1. Нажмите **Добавить тестовый номер**.
  1. В открывшемся окне введите номер телефона и нажмите **Получить код**. На указанный телефон будет отправлено SMS с кодом подтверждения.

      Поддерживаются российские телефонные номера в формате [E.164](https://ru.wikipedia.org/wiki/E.164), например `+79991112233`.

  1. Введите код из SMS и нажмите **{{ ui-key.yacloud.common.confirm }}**.

{% endlist %}
