# Как отключить платные возможности {{ tracker-name }}

{% note info %}

Чтобы не платить за использование {{ tracker-name }}, вы можете отключить платные возможности и оставить сотрудникам только бесплатный доступ в режиме [<q>{{ ui-key.startrek.ui_components_page-admin_OrgUsersPane.access-level_read_only }}</q>](access.md#readonly). Полностью отключить {{ tracker-name }} невозможно. 

{% endnote %}

Чтобы прекратить использование платных возможностей {{ tracker-full-name }}, отзовите у сотрудников организации полный доступ в {{ tracker-name }}. Если полный доступ есть не более чем у 5 пользователей, использование {{ tracker-name }} не тарифицируется. Подробнее читайте в разделе [{#T}](pricing.md).

1. На панели слева {{ tracker-name }} нажмите **{{ ui-key.startrek.blocks-desktop_b-queues-info.admin }}** → **{{ ui-key.startrek.ui_components_page-admin_PageAdmin.menu-item-users }}**.

1. Убедитесь, что настройка **Полный доступ для новых пользователей** отключена.

1. Для сотрудников, у которых нужно отозвать доступ, в столбце **{{ ui-key.startrek.ui_components_page-admin_OrgUsersPane.title_access }}** выберите **{{ ui-key.startrek.ui_components_page-admin_OrgUsersPane.access-level_read_only }}**.


После того как у сотрудников будет отозван полный доступ в {{ tracker-name }}, они не смогут создавать и обновлять задачи. Возможность просматривать информацию в {{ tracker-name }} сохранится.