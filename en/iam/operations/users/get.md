# Getting user ID or email

{% list tabs %}

- Cloud Organization

   {% include [users-info](../../../_includes/users-info.md) %}

{% if product == "yandex-cloud" %}

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

      ```bash
      id: ajei8n5ahmfhuk5fog0g
      yandex_passport_user_account:
          login: just.mad.hatter
          default_email: just.mad.hatter@yandex.ru
      ```

- API

   Get information about the user (the [UserAccount](../../api-ref/UserAccount/index.md)):
   * If you know the user's login, use the [getByLogin](../../api-ref/YandexPassportUserAccount/getByLogin.md) method for the [YandexPassportUserAccount](../../api-ref/YandexPassportUserAccount/index.md) resource.
   * If you know the user's ID, use the [get](../../api-ref/UserAccount/get.md) method for the [UserAccount](../../api-ref/UserAccount/index.md) resource.

{% endif %}

{% endlist %}
