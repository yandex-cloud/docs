{% list tabs group=instructions %}

- Проверка через API {#API}

    Чтобы проверить текущее значение времени жизни cookie-сессий, воспользуйтесь методом REST API [DomainSessionsService_Get](https://yandex.ru/dev/api360/doc/ru/ref/DomainSessionsService/DomainSessionsService_Get) для ресурса [DomainSessionsService](https://yandex.ru/dev/api360/doc/ru/ref/DomainSessionsService/). Параметр `authTTL` в теле ответа указывает время в секундах, через которое сессии истекают. Если значение `authTTL` равно 0, срок жизни не ограничен.

{% endlist %}

**Инструкции и решения по выполнению:**

Установите значение параметра времени жизни cookie не более 7 дней (604 800 секунд). Это снизит риски, связанные с возможной компрометацией сессий и несанкционированным доступом.

{% list tabs group=instructions %}

- API {#API}

    Чтобы изменить значение времени жизни cookie-сессий, воспользуйтесь методом REST API [DomainSessionsService_Update](https://yandex.ru/dev/api360/doc/ru/ref/DomainSessionsService/DomainSessionsService_Update) для ресурса [DomainSessionsService](https://yandex.ru/dev/api360/doc/ru/ref/DomainSessionsService/).

    **Пример ответа:**

    ```json
    {
    "authTTL": 604800
    }
    ```
    
    Где `authTTL` — время в секундах (в данном примере установлено на 7 дней).

{% endlist %}