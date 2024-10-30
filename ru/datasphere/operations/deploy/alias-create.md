# Создать алиас

Вы можете распределять нагрузку между [нодами](../../concepts/deploy/index.md#node) и обновлять развернутые сервисы во время работы, используя [алиасы](../../concepts/resource-model.md#resources).

Чтобы создать алиас:
1. {% include [find project](../../../_includes/datasphere/ui-find-project.md) %}
1. В правом верхнем углу нажмите **{{ ui-key.yc-ui-datasphere.project-page.project-card.create-resource }}**. Во всплывающем окне выберите **{{ ui-key.yc-ui-datasphere.common.alias }}**.
1. Задайте параметры алиаса:
    * В поле **{{ ui-key.yc-ui-datasphere.common.name }}** укажите имя алиаса.
    * В поле **{{ ui-key.yc-ui-datasphere.common.prefix }}** выберите доступный префикс алиаса.
    * В блоке **{{ ui-key.yc-ui-datasphere.new-alias.field.label-nodes }}** выберите ноду, на которую будут перенаправляться запросы к алиасу. Укажите процент запросов, который будет перенаправляться к ноде. Чтобы добавить еще одну ноду нажмите ![Add](../../../_assets/console-icons/plus.svg) **{{ ui-key.yc-ui-datasphere.new-alias.add-new }}**.
    * (Опционально) В блоке **{{ ui-key.yc-ui-datasphere.new-alias.field.label-metadata }}** нажмите ![Add](../../../_assets/console-icons/plus.svg) **{{ ui-key.yc-ui-datasphere.new-alias.add-new }}** и укажите метаданные алиаса в формате ключ-значение.
    * В блоке **{{ ui-key.yc-ui-datasphere.common.folder }}** выберите каталог, в котором будут создаваться новые ресурсы.
    * В блоке **{{ ui-key.yc-ui-datasphere.new-alias.field.label-acl }}** выберите **{{ ui-key.yc-ui-datasphere.common.type }}** — **{{ ui-key.yc-ui-datasphere.alias.public }}** или **{{ ui-key.yc-ui-datasphere.alias.private }}**.
1. Нажмите кнопку **{{ ui-key.yc-ui-datasphere.common.save }}**.

Чтобы посмотреть все созданные алиасы:
1. {% include [find project](../../../_includes/datasphere/ui-find-project.md) %}
1. В блоке **{{ ui-key.yc-ui-datasphere.project-page.project-resources }}** выберите **{{ ui-key.yc-ui-datasphere.common.alias }}**.

#### См. также {#see-also}

* [{#T}](alias-update.md)
* [{#T}](alias-delete.md)
