---
title: "Как изменить алиас в {{ ml-platform-full-name }}"
description: "Следуя данной инструкции, вы сможете изменить алиас."
---

# Изменить алиас

Чтобы изменить [алиас](../../concepts/deploy/index.md#alias):
1. {% include [find project](../../../_includes/datasphere/ui-find-project.md) %}
1. В блоке **{{ ui-key.yc-ui-datasphere.project-page.project-resources }}** выберите **{{ ui-key.yc-ui-datasphere.common.alias }}**.
1. Напротив нужного алиаса нажмите ![Options](../../../_assets/console-icons/ellipsis.svg) и выберите ![Edit](../../../_assets/console-icons/pencil.svg) **{{ ui-key.yc-ui-datasphere.common.edit }}**.
1. Измените параметры алиаса:
    * [Ноды](../../concepts/deploy/index.md#node), на которые перенаправляться запросы к алиасу.
    * Процент запросов, который перенаправляться к каждой ноде.
    * Метаданные алиаса.
    * Список управления доступом с [идентификаторами каталогов](../../../resource-manager/operations/folder/get-id.md), из которых можно подключаться к алиасу.
    * Каталог, в котором создаются новые ресурсы.
1. Нажмите кнопку **{{ ui-key.yc-ui-datasphere.common.save }}**.

#### См. также {#see-also}

* [{#T}](alias-delete.md)
