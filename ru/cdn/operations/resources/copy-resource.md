---
title: Как копировать конфигурацию одного ресурса в другой в {{ cdn-full-name }}
description: Следуя данной инструкции, вы сможете копировать конфигурацию одного ресурса в другой.
---

# Копировать конфигурацию одного ресурса в другой

{% include [copy-configuration](../../../_includes/cdn/copy-configuration.md) %}

{% list tabs group=instructions %}

- Консоль управления {#console}

  1. В [консоли управления]({{ link-console-main }}) выберите [каталог](../../../resource-manager/concepts/resources-hierarchy.md#folder), в котором нужно создать ресурс.
  1. [Перейдите](../../../console/operations/select-service.md#select-service) в сервис **{{ ui-key.yacloud.iam.folder.dashboard.label_cdn }}**.
  1. Нажмите кнопку **{{ ui-key.yacloud.cdn.button_resource-create }}**.
  1. В поле **{{ ui-key.yacloud.cdn.label_copy-config }}** выберите существующий CDN-ресурс, настройки которого вы хотите скопировать в новый.
  1. При необходимости откорректируйте параметры.

      {% note warning %}

      Параметр **{{ ui-key.yacloud.cdn.label_personal-domain }}** должен быть уникальным для каждого ресурса.

      {% endnote %}

  1. Нажмите **{{ ui-key.yacloud.common.continue }}**.
  1. При необходимости откорректируйте параметры в разделах **{{ ui-key.yacloud.cdn.label_resource-cache }}**, **{{ ui-key.yacloud.cdn.label_resource-http-headers }}** и **{{ ui-key.yacloud.cdn.label_additional }}** и нажмите **{{ ui-key.yacloud.common.continue }}**.

{% endlist %}

{% include [get-and-create-cname](../../../_includes/cdn/get-and-create-cname.md) %}

{% include [after-creation-tip](../../../_includes/cdn/after-creation-tip.md) %}

{% include [note-dns-aname](../../../_includes/cdn/note-dns-aname.md) %}