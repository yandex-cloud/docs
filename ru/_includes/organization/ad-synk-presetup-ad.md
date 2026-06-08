1. Создайте пользователя домена, от имени которого агент будет выполнять синхронизацию.
1. Выдайте этому пользователю следующие разрешения:

    * `Replicating Directory Changes`;
    * `Replicating Directory Changes All`.
1. На контроллере домена откройте сетевые порты для входящего трафика, поступающего с IP-адреса сервера, на котором установлен агент {{ ad-sync-agent }}:

    {% include [ad-synk-ports](./ad-synk-ports.md) %}

1. (Опционально) Если вы планируете настраивать аутентификацию с использованием протокола [Kerberos](https://ru.wikipedia.org/wiki/Kerberos), настройте [SPN](https://learn.microsoft.com/en-us/windows/win32/ad/service-principal-names).