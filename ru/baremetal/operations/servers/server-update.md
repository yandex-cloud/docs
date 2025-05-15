---
title: Как изменить сервер в {{ baremetal-full-name }}
description: Следуя данной инструкции, вы сможете изменить имя или описание сервера в {{ baremetal-full-name }}.
---

# Изменить сервер

{% list tabs group=instructions %}

- Консоль управления {#console}

  1. В [консоли управления]({{ link-console-main }}) выберите [каталог](../../../resource-manager/concepts/resources-hierarchy.md#folder), которому принадлежит сервер.
  1. В списке сервисов выберите **{{ ui-key.yacloud.iam.folder.dashboard.label_baremetal }}**.
  1. В строке с нужным сервером нажмите значок ![image](../../../_assets/console-icons/ellipsis.svg) и выберите **{{ ui-key.yacloud.common.edit }}**.
  1. При необходимости измените имя, описание, метки, продолжительность периода аренды и сетевые настройки сервера.

      {% note info %}

      Изменения в настройке продолжительности периода аренды вступят в силу только по истечении текущего периода, на который был арендован сервер.

      {% endnote %}

  1. Нажмите кнопку **{{ ui-key.yacloud.common.save-changes }}**.

{% endlist %}
