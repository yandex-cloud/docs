---
title: Создание облака в другом регионе
description: Следуя данной инструкции, вы сможете создать новое облако в другом регионе с помощью управляемой организации.
---

# Создать облако в другом регионе

{% include [note-preview-by-request](../../../_includes/note-preview-by-request.md) %}

Чтобы создавать облака в другом [регионе](../../../overview/concepts/region.md), [подключите](../../../organization/operations/add-region.md) управляемую организацию. После этого выполните следующие шаги:

{% list tabs group=instructions %}

- Консоль управления {#console}

  1. Перейдите в [консоль управления]({{ link-console-main }}).

  1. В левом верхнем углу рядом с полем **{{ ui-key.yacloud.cloud-tree-list.value_search-placeholder }}** нажмите значок ![plus](../../../_assets/console-icons/plus.svg). В открывшемся окне:
  
  1. Выберите регион, отличающийся от региона основной организации.

  1. Перейдите в консоль этого региона.

  1. В левом верхнем углу рядом с полем **{{ ui-key.yacloud.cloud-tree-list.value_search-placeholder }}** нажмите значок ![plus](../../../_assets/console-icons/plus.svg). В открывшемся окне:

     1. Задайте имя облака. Требования к имени:

          {% include [name-format.md](../../../_includes/name-format.md) %}

     1. Нажмите **{{ ui-key.yacloud.common.create }}**.

{% endlist %}