# Изменить алиас

Чтобы изменить [алиас](../../concepts/deploy/index.md#alias):
1. {% include [find project](../../../_includes/datasphere/ui-find-project.md) %}
1. В блоке **{{ ui-key.yc-ui-datasphere.project-page.project-resources }}** выберите **{{ ui-key.yc-ui-datasphere.common.alias }}**.
1. Напротив нужного алиаса нажмите ![Options](../../../_assets/options.svg) и выберите ![Edit](../../../_assets/datasphere/edit.svg) **{{ ui-key.yc-ui-datasphere.common.edit }}**.
1. Измените параметры алиаса:
    * [Ноды](../../concepts/deploy/index.md#node), на которые перенаправляться запросы к алиасу.
    * Процент запросов, который перенаправляться к каждой ноде. 
    * Метаданные алиаса.
    * Список управления доступом с [идентификаторами каталогов](../../../resource-manager/operations/folder/get-id.md), из которых можно подключаться к алиасу.
    * Каталог, в котором создаются новые ресурсы.
1. Нажмите кнопку **{{ ui-key.yc-ui-datasphere.common.save }}**.

#### Что дальше {#what-is-next}

* [{#T}](alias-delete.md)