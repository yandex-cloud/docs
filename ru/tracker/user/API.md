# API {{ tracker-name }}

Управляйте вашими задачами в {{ tracker-name }} с помощью HTTP-запросов к {% if audience == "external" %}[REST API {{ tracker-full-name }}]{% if locale == "ru" %}(https://yandex.ru/dev/connect/tracker/api/about-docpage/){% else %}(https://tech.yandex.com/connect/tracker/){% endif %}{% else %}REST API {{ tracker-full-name }}{% endif %}.

API {{ tracker-full-name }} предназначен для веб-сервисов и приложений, которые работают с задачами вашей организации от имени пользователя. При этом возможности API зависят от прав доступа пользователя, от имени которого выполняются запросы.

С помощью API {{ tracker-name }} вы можете:

- интегрировать {{ tracker-name }} с другими сервисами — например, управлять задачами с помощью чат-бота или связать {{ tracker-name }} с CRM-системой;
- автоматизировать процессы, связанные с созданием, массовым изменением и поиском задач по параметрам;
- задавать специфические правила обработки определенных действий — например, обновлять статус задачи по таймеру;
- создавать браузерные расширения для работы с {{ tracker-name }}.

Подробнее о работе с API {{ tracker-name }} читайте в {% if audience == "external" %}[документации]{% if locale == "ru" %}(https://yandex.ru/dev/connect/tracker/api/about-docpage/){% else %}(https://tech.yandex.com/connect/tracker/api/about-docpage/){% endif %}{% else %}документации{% endif %}.

{% if audience == "internal" %}

- [Документация API на Вики.](https://wiki.yandex-team.ru/tracker/api/)
- [Сгенерированная документация.](https://st-api.yandex-team.ru/docs/)

{% endif %}

{% note tip %}

Попробуйте наш [Python-клиент](python.md) для работы с API {{ tracker-name }}. Так вам будет проще начать использовать API в своих приложениях.

{% endnote %}

