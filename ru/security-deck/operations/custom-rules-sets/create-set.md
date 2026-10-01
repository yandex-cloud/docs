---
title: Создание пользовательских наборов правил в {{ sd-full-name }}
description: В данном разделе вы узнаете, как в {{ sd-full-name }} создавать пользовательские наборы правил.
---

# Создать пользовательский набор правил

Пользовательские [наборы правил](../../concepts/standard-compliance/index.md) содержат правила контроля безопасности модулей [Контроля конфигурации ({{ cspm-name }})](../../concepts/cspm.md#rules), [Контроля {{ k8s }} ({{ kspm-name }})](../../concepts/kspm.md) и [Обнаружения угроз ({{ td-name }})](../../concepts/threat-detector.md#rules) и используются в [окружениях](../../concepts/workspace.md) {{ sd-name }}. Если у вас еще нет окружения, [создайте](../workspaces/create.md) его.

{% include [custom-reuirements-role](../../../_includes/security-deck/custom-reuirements-role.md) %}

{% list tabs group=instructions %}

- Интерфейс {{ sd-name }} {#cloud-sd}

  1. Перейдите в сервис [{{ sd-full-name }}]({{ link-sd-main }}).
  1. На панели слева выберите ![seal-check](../../../_assets/console-icons/seal-check.svg) **{{ ui-key.yacloud_org.security-center.label_comp }}**.
  1. В верхней части окна выберите окружение.
  1. На открывшейся странице нажмите ![plus](../../../_assets/console-icons/plus.svg) **{{ ui-key.yacloud_org.security.comp.CompSetsPage.create_set_button }}**.
  1. Укажите имя и (опционально) описание набора.
  1. (Опционально) Отключите активацию набора, если не хотите использовать его сразу.
  1. (Опционально) Загрузите иконку набора.
  1. В разделе **{{ ui-key.yacloud_org.security.comp.RulesFormSection.title_uUdpa }}** выберите правила, которые нужно включить в набор.

      Используйте фильтры, чтобы найти нужные правила.

  1. Нажмите **{{ ui-key.yacloud.common.save }}**.

{% endlist %}


#### Полезные ссылки {#see-also}

* [{#T}](../cspm/view-rules.md)
* [{#T}](../kspm/view-rules.md)
* [{#T}](../td/view-rules.md)