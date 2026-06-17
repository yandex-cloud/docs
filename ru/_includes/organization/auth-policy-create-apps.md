В блоке **{{ ui-key.yacloud_org.organization.security-settings.AppsCard.title_hBXgK }}** укажите [приложения](*applications), аутентификацией в которых будет управлять создаваемая политика:

1. В поле **{{ ui-key.yacloud_org.organization.security-settings.ScopeCardBlock.include_label_8Kp2A }}** выберите:

    * `{{ ui-key.yacloud_org.organization.security-settings.AppsCard.scope_all_iXjnP }}` — чтобы создаваемая политика применялась к аутентификации пользователей во всех приложениях организации.
    * `{{ ui-key.yacloud_org.organization.security-settings.ScopeCardBlock.selected_resources_qvwZX }}` — чтобы политика применялась к аутентификации только в выбранных приложениях.

        В появившемся поле выберите нужные приложения. При необходимости воспользуйтесь строкой поиска по имени или идентификатору приложения.
1. (Опционально) В поле **{{ ui-key.yacloud_org.organization.security-settings.ScopeCardBlock.exclude_label_4Mn7B }}** выберите приложения, к аутентификации в которых не будет применяться политика.

    {% note info %}

    Одинаковые приложения не могут быть заданы одновременно в списках включения и исключения.

    {% endnote %}