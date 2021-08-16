# Getting user ID or email

You can get the following information about any registered Yandex.Cloud user:

* ID
* Login
* Email (only via the CLI and API)

{% list tabs %}

- Management console

  {% include [grant-role-console-first-steps](../../../_includes/iam/grant-role-console-first-steps.md) %}

- CLI

  1. See the description of the get user information command:

      ```
      $ yc iam user-account get --help
      ```

  2. Get user information by specifying the user's login:

      ```
      $ yc iam user-account get just.mad.hatter
      id: ajei8n5ahmfhuk5fog0g
      yandex_passport_user_account:
          login: just.mad.hatter
          default_email: just.mad.hatter@yandex.ru
      ```

- API

  Get information about the user (the [UserAccount](../../api-ref/UserAccount/index.md) resource):
  * If you know the user's login, use the [getByLogin](../../api-ref/YandexPassportUserAccount/getByLogin.md) method for the [YandexPassportUserAccount](../../api-ref/YandexPassportUserAccount/index.md) resource.
  * If you know the user's ID, use the [get](../../api-ref/UserAccount/get.md) method for the [UserAccount](../../api-ref/UserAccount/index.md) resource.

{% endlist %}

