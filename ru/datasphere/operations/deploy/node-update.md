---
title: Как изменить ноду в {{ ml-platform-full-name }}
description: Следуя данной инструкции, вы сможете изменить ноду.
---

# Изменить ноду

Чтобы изменить [ноду](../../concepts/deploy/index.md#node):
1. {% include [find project](../../../_includes/datasphere/ui-find-project.md) %}
1. В блоке **{{ ui-key.yc-ui-datasphere.project-page.project-resources }}** выберите **{{ ui-key.yc-ui-datasphere.resources.node }}**.
1. В строке с нужной нодой нажмите ![Options](../../../_assets/console-icons/ellipsis.svg) и выберите ![Edit](../../../_assets/console-icons/pencil.svg) **{{ ui-key.yc-ui-datasphere.common.edit }}**.
1. Измените параметры ноды:
    * Имя ноды.
    * Описание ноды.
    * Каталог, в котором создаются новые ресурсы.
    * [Конфигурацию](../../concepts/configurations.md) вычислительных ресурсов [инстанса](../../concepts/deploy/index.md), на котором развернута нода.
    * [Зоны доступности](../../../overview/concepts/geo-scope.md), в которых размещен инстанс.
    * [Подсети](../../../vpc/concepts/network.md#subnet) в которых размещен инстанс.
    * [Идентификаторы каталогов](../../../resource-manager/operations/folder/get-id.md), из которых можно подключаться к ноде (блок **ACL**).
1. Нажмите кнопку **{{ ui-key.yc-ui-datasphere.common.save }}**.

#### См. также {#see-also}

* [{#T}](node-delete.md)
