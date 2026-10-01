---
title: Просмотр списка пользовательских наборов правил в {{ sd-full-name }}
description: В данном разделе вы узнаете, как в {{ sd-full-name }} посмотреть список пользовательских наборов правил.
---

# Посмотреть список пользовательских наборов правил

{% include [custom-reuirements-role](../../../_includes/security-deck/custom-reuirements-role.md) %}

{% list tabs group=instructions %}

- Интерфейс {{ sd-name }} {#cloud-sd}

  1. Перейдите в сервис [{{ sd-full-name }}]({{ link-sd-main }}).
  1. На панели слева выберите ![seal-check](../../../_assets/console-icons/seal-check.svg) **{{ ui-key.yacloud_org.security-center.label_comp }}**.
  1. В верхней части окна выберите окружение.

      Наборы правил, созданные пользователями, будут отмечены тегом `Пользовательский`.

{% endlist %}