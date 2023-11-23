---
title: "Как посмотреть график сетевых соединений в {{ vpc-full-name }}"
description: "Следуя данной инструкции, вы сможете посмотреть график сетевых соединений." 
---

# График сетевых соединений

Чтобы посмотреть график сетевых соединений вашей [виртуальной машины](../../glossary/vm.md) или кластера:

{% list tabs %}

- Консоль управления

  1. В [консоли управления]({{ link-console-main }}) перейдите в каталог с нужным ресурсом.
  1. В списке сервисов выберите нужный сервис, например, **{{ ui-key.yacloud.iam.folder.dashboard.label_compute }}** для виртуальной машины или **{{ ui-key.yacloud.iam.folder.dashboard.label_data-proc }}** для кластера.
  1. Выберите ресурс в списке.
  1. Перейдите на вкладку **{{ ui-key.yacloud.common.monitoring }}**.
  1. Найдите график **Connections quota utilization**.

  Значения на графике могут превышать значения изнутри ресурса. Это происходит из-за задержки удаления записей:

  {% include [conditions-for-deleting-records](../../_includes/vpc/conditions-for-deleting-records.md) %}

{% endlist %}
