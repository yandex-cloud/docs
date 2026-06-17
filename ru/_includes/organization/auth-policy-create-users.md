В блоке **{{ ui-key.yacloud_org.organization.security-settings.UsersAndGroupsCard.title }}** укажите пользователей или группы, в отношении которых будет применяться политика:

1. В поле **{{ ui-key.yacloud_org.organization.security-settings.ScopeCardBlock.include_label_8Kp2A }}** выберите:

    * `{{ ui-key.yacloud_org.organization.security-settings.UsersAndGroupsCard.scope_all }}` — чтобы создаваемая политика аутентификации применялась ко всем пользователям [организации](*organization).
    * `{{ ui-key.yacloud_org.organization.security-settings.ScopeCardBlock.selected_resources_qvwZX }}` — чтобы политика применялась к выбранным пользователям и/или группам пользователей.

        Нажмите кнопку **{{ ui-key.yacloud.common.add }}**, чтобы выбрать определенных пользователей или группы пользователей, к которым будет применяться политика. При необходимости воспользуйтесь строкой поиска.
1. (Опционально) В поле **{{ ui-key.yacloud_org.organization.security-settings.ScopeCardBlock.exclude_label_4Mn7B }}** нажмите кнопку **{{ ui-key.yacloud.common.add }}**, чтобы указать определенных пользователей или группы пользователей, к которым не будет применяться политика.

    {% note info %}

    Одинаковые пользователи или группы не могут быть заданы одновременно в списках включения и исключения.

    {% endnote %}