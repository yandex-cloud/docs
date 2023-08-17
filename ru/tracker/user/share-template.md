# Использовать общие шаблоны

Чтобы другие пользователи могли применять ваш шаблон:

1. [Настройте общий доступ к шаблону](share-template.md#section_nmn_prs_zz). Вы можете настроить доступ для отдельных пользователей или всей организации.

1. Попросите коллег [подключить шаблон в персональных настройках](share-template.md#section_vkg_trs_zz).

## Как настроить доступ к шаблону {#section_nmn_prs_zz}

Чтобы изменить настройки доступа к шаблону:

1. Выберите нужную опцию:
    - [Задачи]({{ link-settings }}/templates/issues), чтобы изменить шаблон задачи.
    - [Комментарии]({{ link-settings }}/templates/comments), чтобы изменить шаблон комментария.

1. При необходимости отфильтруйте лишние шаблоны с помощью кнопки ![](../../_assets/tracker/queue-filter.png).

1. Возле нужного шаблона нажмите кнопку **{{ ui-key.startrek.blocks-desktop_b-page-settings-templates.item-actions-permissions }}**.

1. Настройте разрешения **{{ ui-key.startrek.blocks-desktop_roles-table.read }}**, **{{ ui-key.startrek.blocks-desktop_roles-table.write }}** и **{{ ui-key.startrek.blocks-desktop_roles-table.grant }}** для категорий:
    - **{{ ui-key.startrek.blocks-desktop_roles-table.users }}** — индивидуальные настройки для отдельных пользователей. Чтобы добавить пользователя в эту категорию, введите его логин или имя в строку поиска в верхней части таблицы.
    - **{{ ui-key.startrek.blocks-desktop_roles-table.groups }}** — настройки для всех сотрудников.


    - **{{ ui-key.startrek.blocks-desktop_roles-table.roles }}** — настройки для пользователей, обладающих определенными ролями по отношению к шаблону:
        - **{{ ui-key.startrek-backend.roles.templateRole.name.OWNER }}** — владелец шаблона. По умолчанию владелец — это создатель шаблона и только у него есть разрешения **{{ ui-key.startrek.blocks-desktop_roles-table.write }}** и **{{ ui-key.startrek.blocks-desktop_roles-table.grant }}**.
        - **{{ ui-key.startrek-backend.roles.templateRole.name.QUEUE_TEAM_MEMBER }}** — пользователи-участники команды очереди, к которой привязана задача.

Общие шаблоны доступны для подключения всем пользователям на вкладке **Подключение**.

## Как поделиться шаблоном {#section_ucr_rrs_zz}

Чтобы поделиться шаблоном с коллегой, отправьте ему ссылку на шаблон:

1. {% include [go to settings](../../_includes/tracker/transition-page.md) %} 

1. В правом верхнем углу нажмите ![](../../_assets/tracker/svg/queue-settings.svg) **{{ ui-key.startrek.ui_components_PageQueue_header.settings }}**.

1. На верхней панели {{ tracker-name }} нажмите ![](../../_assets/tracker/tracker-settings.png) → **{{ ui-key.startrek.blocks-desktop_b-head.manage-templates }}**.

1. Выберите нужную опцию:
    - **{{ ui-key.startrek.blocks-desktop_b-page-settings-templates.type-issues }}**, чтобы изменить шаблон задачи.
    - **{{ ui-key.startrek.blocks-desktop_b-page-settings-templates.type-comments }}**, чтобы изменить шаблон комментария.

1. При необходимости отфильтруйте лишние шаблоны с помощью кнопки ![](../../_assets/tracker/queue-filter.png).

1. Возле нужного шаблона выберите ![](../../_assets/tracker/share.png) → **{{ ui-key.startrek.blocks-desktop_b-page-settings-templates.link-to-template }}**.

1. Скопируйте содержимое адресной строки браузера и отправьте его пользователю, с которым хотите поделиться.

{% note info %}

Пользователь сможет увидеть шаблон, только если у него есть к нему [доступ на чтение](#section_nmn_prs_zz).

{% endnote %}

## Как подключить общий шаблон {#section_vkg_trs_zz}

Если у вас есть [доступ на чтение](#section_nmn_prs_zz) к нужному шаблону, вы можете использовать его для создания задач или комментариев. Для этого подключите шаблон:

1. {% include [go to settings](../../_includes/tracker/transition-page.md) %} 

1. В правом верхнем углу нажмите ![](../../_assets/tracker/svg/queue-settings.svg) **{{ ui-key.startrek.ui_components_PageQueue_header.settings }}**.

1. На верхней панели {{ tracker-name }} нажмите ![](../../_assets/tracker/tracker-settings.png) → **{{ ui-key.startrek.blocks-desktop_b-head.manage-templates }}**.

1. Выберите нужную опцию:
    - **{{ ui-key.startrek.blocks-desktop_b-page-settings-templates.type-issues }}**, чтобы изменить шаблон задачи.
    - **{{ ui-key.startrek.blocks-desktop_b-page-settings-templates.type-comments }}**, чтобы изменить шаблон комментария.

1. При необходимости отфильтруйте лишние шаблоны с помощью кнопки ![](../../_assets/tracker/queue-filter.png).

1. Возле нужного шаблона нажмите переключатель, чтобы он перешел в положение ![](../../_assets/tracker/enabled-switch-2.png).



