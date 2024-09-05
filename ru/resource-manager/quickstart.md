# Как начать работать с {{ resmgr-full-name }}

При регистрации в {{ yandex-cloud }} для пользователя будет создано _облако_ — отдельное рабочее пространство, для которого этот пользователь будет назначен владельцем. В облаке будет создан каталог `default` и сеть `default`.

Владелец может создавать в этом облаке новые каталоги и ресурсы, а также управлять правами доступа к ним.

1. Чтобы создать каталог в облаке:

    {% include [create-folder](../_includes/create-folder.md) %}

1. Предоставьте пользователю доступ к созданному каталогу:

    1. На [стартовой странице]({{ link-console-main }}) консоли управления выберите каталог.
    1. Перейдите на вкладку **{{ ui-key.yacloud.common.resource-acl.label_access-bindings }}**.
    1. Нажмите кнопку **{{ ui-key.yacloud.common.resource-acl.button_configure-access }}**.
    1. В окне **{{ ui-key.yacloud.component.acl.update-dialog.label_title }}** нажмите кнопку **{{ ui-key.yacloud.component.acl.update-dialog.button_select-subject }}**.
    1. Выберите пользователя из списка или воспользуйтесь поиском по пользователям.
    1. Нажмите кнопку **{{ ui-key.yacloud.component.acl.update-dialog.button_add-role }}**.
    1. Выберите роль `resource-manager.editor`. Эта роль позволяет читать информацию о каталоге, в том числе список прав доступа, редактировать и удалить каталог.
    1. Нажмите кнопку **{{ ui-key.yacloud.common.save }}**.

{% note info %}

Подробнее об управлении ролями читайте в разделе [Роли](../iam/concepts/access-control/roles.md).

{% endnote %}

#### Что дальше {#what-is-next}

* [Назначьте роли на каталог](operations/folder/set-access-bindings.md).
* [Назначьте роли на облако](operations/cloud/set-access-bindings.md).
* [Создайте новое облако](operations/cloud/create).