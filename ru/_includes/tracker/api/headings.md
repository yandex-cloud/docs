{% cut "Заголовки" %}

- **Host**

    Адрес узла, предоставляющего API:
    ```
	{{ host }}
	```

- **Authorization**

    OAuth-токен в формате `OAuth <значение токена>`, например:
    ```
    OAuth 0c4181a7c2cf4521964a72ff57a34a07
    ```
{% if audience == "external" %}
- **X-Org-ID**

    Идентификатор организации.
    
{% endif %}

{% endcut %}