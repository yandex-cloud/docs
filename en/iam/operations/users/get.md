# Getting user ID or email

You can get the following information about any registered {{ yandex-cloud }} user:
* ID
* Login
* Email (only via the CLI and API)

{% list tabs %}

- Management console

   1. Log in to the [management console]({{ link-console-main }}).
   2. [Select the desired cloud](../../../resource-manager/operations/cloud/switch-cloud.md).
   3. Go to [Access bindings in cloud]({{ link-console-cloud }}?section=resource-acl) (the **Access bindings** tab).

- CLI

   1. See the description of the get user information command:

      ```bash
      yc iam user-account get --help
      ```

   1. Get user information by specifying the user's login:

      ```bash
      yc iam user-account get just.mad.hatter
      ```

      Result:

      ```
      id: ajei8n5ahmfhuk5fog0g
      yandex_passport_user_account:
          login: just.mad.hatter
          default_email: just.mad.hatter@yandex.ru
      ```

- API

   Get information about the user (the [UserAccount](../../api-ref/UserAccount/index.md)):
   * If you know the user's login, use the [getByLogin](../../api-ref/YandexPassportUserAccount/getByLogin.md) method for the [YandexPassportUserAccount](../../api-ref/YandexPassportUserAccount/index.md) resource.
   * If you know the user's ID, use the [get](../../api-ref/UserAccount/get.md) method for the [UserAccount](../../api-ref/UserAccount/index.md) resource.
{% endlist %}
