[Документация Yandex Cloud](../index.md) > [Yandex Resource Manager](index.md) > Начало работы

# Как начать работать с Yandex Resource Manager

При регистрации в Yandex Cloud для пользователя будет создано _облако_ — отдельное рабочее пространство, для которого этот пользователь будет назначен владельцем. В облаке будет создан каталог `default` и сеть `default`.

Владелец может создавать в этом облаке новые каталоги и ресурсы, а также управлять правами доступа к ним.

1. Чтобы создать каталог в облаке:

    1. В [консоли управления](https://console.yandex.cloud) на панели сверху нажмите ![image](../_assets/console-icons/layout-side-content-left.svg) или ![image](../_assets/console-icons/chevron-down.svg) и выберите нужное [облако](concepts/resources-hierarchy.md#cloud).
    1. Справа от названия облака нажмите ![image](../_assets/console-icons/ellipsis.svg).
    1. Выберите ![image](../_assets/console-icons/plus.svg) **Создать каталог**.
    
       ![create-folder1](../_assets/resource-manager/create-folder-1.png)
    
    1. Введите имя [каталога](concepts/resources-hierarchy.md#folder). Требования к имени:
    
        * длина — от 3 до 63 символов;
        * может содержать строчные буквы латинского алфавита, цифры и дефисы;
        * первый символ — буква, последний — не дефис.
    
    1. (Опционально) Введите описание каталога.
    1. Выберите опцию **Создать сеть по умолчанию**. Будет создана [сеть](../vpc/concepts/network.md#network) с подсетями в каждой зоне доступности. Также в этой сети будет создана [группа безопасности по умолчанию](../vpc/concepts/security-groups.md#default-security-group), внутри которой весь сетевой трафик разрешен.
    1. Нажмите кнопку **Создать**.
    
       ![create-folder2](../_assets/resource-manager/create-folder-2.png)

1. Предоставьте пользователю доступ к созданному каталогу:

    1. В [консоли управления](https://console.yandex.cloud) на панели сверху нажмите ![image](../_assets/console-icons/layout-side-content-left.svg) или ![image](../_assets/console-icons/chevron-down.svg) и выберите каталог.
    1. Перейдите на вкладку **Права доступа**.
    1. Нажмите кнопку **Настроить доступ**.
    1. В открывшемся окне выберите раздел **Пользовательские аккаунты**.
    1. Выберите пользователя из списка или воспользуйтесь поиском по пользователям.
    1. Нажмите кнопку ![image](../_assets/console-icons/plus.svg) **Добавить роль**.
    1. Выберите роль `resource-manager.editor`. Эта роль позволяет читать информацию о каталоге, в том числе список прав доступа, редактировать и удалить каталог.
    1. Нажмите кнопку **Сохранить**.

{% note info %}

Подробнее об управлении ролями читайте в разделе [Роли](../iam/concepts/access-control/roles.md).

{% endnote %}

#### Что дальше {#what-is-next}

* [Назначьте роли на каталог](operations/folder/set-access-bindings.md).
* [Назначьте роли на облако](operations/cloud/set-access-bindings.md).
* [Создайте новое облако](operations/cloud/create.md).