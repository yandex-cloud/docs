1. Создайте аккаунт пользователя домена или [аккаунт gMSA](*gmsa_account), от имени которого агент будет выполнять синхронизацию.
1. Выдайте этому аккаунту следующие разрешения на домен, указанный в конфигурации агента в секции `sync_settings.filter`:

    * `Replicating Directory Changes`;
    * `Replicating Directory Changes All`.

    Если вы используете обратную запись паролей, дополнительно выдайте аккаунту следующие разрешения на Organization Units (OU), указанные в конфигурации агента в секции `sync_settings.filter`, или на весь домен:

    * `Change Password`;
    * `Reset Password`;
    * `Write pwdLastSet`.
1. На контроллере домена откройте сетевые порты для входящего трафика, поступающего с IP-адреса сервера, на котором установлен агент {{ ad-sync-agent }}:

    {% include [ad-sync-ports](./ad-sync-ports.md) %}

1. (Опционально) Если вы планируете настраивать аутентификацию с использованием протокола [Kerberos](https://ru.wikipedia.org/wiki/Kerberos), настройте [SPN](https://learn.microsoft.com/en-us/windows/win32/ad/service-principal-names).
