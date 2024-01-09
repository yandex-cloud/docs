---
title: "Как включить экранирование источников в {{ cdn-full-name }}"
description: "Следуя данной инструкции, вы сможете включить экранирование источников." 
---

# Включение экранирования источников

Чтобы включить [экранирование источников](../../concepts/origins-shielding.md) для [ресурса](../../concepts/resource.md):

{% list tabs group=instructions %}

- Консоль управления {#console}

  1. В [консоли управления]({{ link-console-main }}) выберите каталог, в котором расположен ресурс.
  1. Выберите сервис **{{ ui-key.yacloud.iam.folder.dashboard.label_cdn }}**.
  1. Нажмите на имя необходимого ресурса.
  1. Перейдите на вкладку **{{ ui-key.yacloud.cdn.label_shielding }}**.
  1. В правом верхнем углу включите опцию экранирования источников.
  1. В окне **{{ ui-key.yacloud.cdn.label_shielding-settings-title }}** в поле **{{ ui-key.yacloud.cdn.label_shielding-location }}** выберите необходимую локацию.
  1. Нажмите кнопку **{{ ui-key.yacloud.cdn.button_activate-shielding }}**.

  После включения статус экранирования изменится с `Not activated` на `Active`.

{% endlist %}

{% include [after-changes-tip](../../../_includes/cdn/after-changes-tip.md) %}
