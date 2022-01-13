{% cut "Headers" %}

- **Host**
{% if audience == "external" %}
Address of the node that provides the API:

    ```
    https://api.tracker.yandex.net
    ```

    {% else %}

    ```
    https://st-api.yandex-team.ru/
    ```

    {% endif %}

- **Authorization**

    OAuth token in `OAuth <token value>` format. For example:

    ```
    OAuth 0c4181a7c2cf4521964a72ff57a34a07
    ```

{% if audience == "external" %}

- **X-Org-ID**

    Organization ID.

{% endif %}

- **Content-Type**

    Request body format. Must be `multipart/form-data`.

{% endcut %}

