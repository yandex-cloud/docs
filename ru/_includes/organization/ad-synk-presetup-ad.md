1. Создайте пользователя домена, от имени которого агент будет выполнять синхронизацию.
1. Выдайте этому пользователю следующие разрешения:

    * `Replicating Directory Changes`;
    * `Replicating Directory Changes All`.
1. На контроллере домена откройте сетевые [TCP](https://ru.wikipedia.org/wiki/TCP)-порты для входящего трафика, поступающего с IP-адреса сервера, на котором установлен агент {{ ad-sync-agent }}:

    {% include [ad-synk-ports](./ad-synk-ports.md) %}