Добавьте данные для аутентификации в файл `/etc/apt/auth.conf`:

{% list tabs group=registry_auth %}

- IAM-токен {#iam-token}

    ```text
    machine https://{{ cloud-registry }}/debian/<идентификатор_реестра>
    login iam
    password <IAM-токен>
    ```

- API-ключ {#api-key}

    ```text
    machine https://{{ cloud-registry }}/debian/<идентификатор_реестра>
    login api_key
    password <API-ключ>
    ```

{% endlist %}
