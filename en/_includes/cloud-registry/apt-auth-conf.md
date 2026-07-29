Add authentication data to the `/etc/apt/auth.conf` file:

{% list tabs group=registry_auth %}

- IAM token {#iam-token}

    ```text
    machine https://{{ cloud-registry }}/debian/<registry_ID>
    login iam
    password <IAM_token>
    ```

- API key {#api-key}

    ```text
    machine https://{{ cloud-registry }}/debian/<registry_ID>
    login api_key
    password <API_key>
    ```

{% endlist %}
