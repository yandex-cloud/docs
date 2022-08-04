{% cut "Headers" %}

- **Host**

    API host address:

    ```
    {{ host }}
    ```

- **Authorization**

    OAuth token in `OAuth <token value>` format. For example:

    ```
    OAuth 0c4181a7c2cf4521964a72ff57a34a07
    ```

{% if audience == "external" %}

- **X-Org-ID**

    Organization ID.

{% endif %}

{% endcut %}

