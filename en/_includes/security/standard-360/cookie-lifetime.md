{% list tabs group=instructions %}

- Checking via the API {#API}

    To check the current lifetime value of cookie sessions, use the [DomainSessionsService_Get](https://yandex.ru/dev/api360/doc/ru/ref/DomainSessionsService/DomainSessionsService_Get) REST API method for the [DomainSessionsService](https://yandex.ru/dev/api360/doc/ru/ref/DomainSessionsService/) resource. The `authTTL` parameter in the response body gives the sessions' expiration time in seconds. If `authTTL` equals 0, the lifetime is unlimited.

{% endlist %}

**Guides and solutions to use:**

Set the cookie lifetime parameter to not more than 7 days (604,800 seconds). This will reduce the risks due to potentially compromised sessions and unauthorized access.

{% list tabs group=instructions %}

- API {#API}

    To update the cookie session lifetime value, use the [DomainSessionsService_Update](https://yandex.ru/dev/api360/doc/ru/ref/DomainSessionsService/DomainSessionsService_Update) REST API method for the [DomainSessionsService](https://yandex.ru/dev/api360/doc/ru/ref/DomainSessionsService/) resource.

    **Response example:**

    ```json
    {
    "authTTL": 604800
    }
    ```
    
    Where `authTTL` is time in seconds (in this example, set to 7 days).

{% endlist %}