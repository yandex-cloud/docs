В блоке **{{ ui-key.yacloud_org.organization.security-settings.NetworksCard.title_aSxuJ }}** задайте IP-адреса, с которых создаваемая политика будет разрешать или запрещать аутентификацию пользователей:

1. В поле **{{ ui-key.yacloud_org.organization.security-settings.ScopeCardBlock.include_label_8Kp2A }}** выберите:

    * `{{ ui-key.yacloud_org.organization.security-settings.NetworksCard.scope_all_1pGZE }}` — чтобы создаваемая политика применялась к событиям аутентификации пользователей с любых IP-адресов.
    * `{{ ui-key.yacloud_org.organization.security-settings.ScopeCardBlock.selected_resources_qvwZX }}` — чтобы создаваемая политика применялась к событиям аутентификации с IP-адресов, относящихся к заданным диапазонам.

        В появившемся поле введите один или несколько диапазонов IPv4- или IPv6-адресов в нотации [CIDR](https://ru.wikipedia.org/wiki/Бесклассовая_адресация).
1. (Опционально) В поле **{{ ui-key.yacloud_org.organization.security-settings.ScopeCardBlock.exclude_label_4Mn7B }}** задайте диапазоны IP-адресов, к событиям аутентификации с которых не будет применяться политика.

    {% note info %}

    Одинаковые диапазоны IP-адресов не могут быть заданы одновременно в списках включения и исключения.

    {% endnote %}