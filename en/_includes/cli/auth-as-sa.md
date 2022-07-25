To authenticate as a service account:

1. Get a list of service accounts that exist in your cloud:

    ```
    yc iam service-account --folder-id <folder ID> list
    +----------------------+------------+
    |          ID          |    NAME    |
    +----------------------+------------+
    | aje3932acd0c5ur7dagp | default-sa |
    +----------------------+------------+
    ```

1. Create an authorized key for the service account and save it to the `key.json` file:

    ```
    yc iam key create --service-account-name default-sa --output key.json --folder-id <folder ID>
    id: aje83v701b1un777sh40
    service_account_id: aje3932acd0c5ur7dagp
    created_at: "2019-08-26T12:31:25Z"
    key_algorithm: RSA_2048
    ```

1. Add the service account authorized key to the CLI profile.

    1. Create a new CLI profile:

        ```
        yc config profile create sa-profile
        ```

    1. Add an authorized key:

        ```
        yc config set service-account-key key.json
        ```

{% if product == "cloud-il" %}
1. Add the hostname and the port for sending requests to {{ yandex-cloud }} to the CLI profile:

   ```
   yc config set endpoint {{ api-host }}:443
   ```   
{% endif %}

1. Make sure that the service account parameters are added correctly:

   {% if product == "yandex-cloud" %}
   
    ```
    yc config list
    service-account-key:
      id: aje83v701b1un777sh40
      service_account_id: aje3932acd0c5ur7dagp
      created_at: "2019-08-26T12:31:25Z"
      key_algorithm: RSA_2048
      public_key: |
        -----BEGIN PUBLIC KEY-----
        MIIBIjANBg...
        -----END PUBLIC KEY-----
      private_key: |
        -----BEGIN PRIVATE KEY-----
        MIIEvwIBAD...
        -----END PRIVATE KEY-----
    ```
   
   {% endif %}

   {% if product == "cloud-il" %}

    ```
    yc config list
    endpoint: {{ api-host }}:443
    service-account-key:
      id: aje83v701b1un777sh40
      service_account_id: aje3932acd0c5ur7dagp
      created_at: "2019-08-26T12:31:25Z"
      key_algorithm: RSA_2048
      public_key: |
        -----BEGIN PUBLIC KEY-----
        MIIBIjANBg...
        -----END PUBLIC KEY-----
      private_key: |
        -----BEGIN PRIVATE KEY-----
        MIIEvwIBAD...
        -----END PRIVATE KEY-----
    ```

   {% endif %}

1. Configure your profile to run commands.

    {% include [add-folder](../cli-add-folder.md) %}

