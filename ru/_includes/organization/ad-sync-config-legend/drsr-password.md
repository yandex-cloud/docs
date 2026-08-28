* `drsr` — настройки протокола [DRSR](https://learn.microsoft.com/en-us/openspecs/windows_protocols/ms-drsr/) для аутентификации на стороне {{ microsoft-idp.ad-short }} [пользователя](../../../organization/concepts/ad-sync/index.md#dc-setup) с назначенными правами на выполнение репликации данных в каталоге:

    * `host` — домен или IP-адрес контроллера домена {{ microsoft-idp.ad-short }}.
    * `username` — `sAMAccountName` пользователя домена {{ microsoft-idp.ad-short }}, которому [назначены](../../../organization/concepts/ad-sync/index.md#dc-setup) права на выполнение репликации данных.
    * `password` — пароль пользователя домена {{ microsoft-idp.ad-short }}.