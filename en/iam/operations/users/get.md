# Getting user information

You can get the ID, email address, and other user information.

{% list tabs %}

- Cloud Organization

   {% include [users-info](../../../_includes/users-info.md) %}


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

   If you know the user's login, use the [getByLogin](../../api-ref/YandexPassportUserAccount/getByLogin.md) REST API method for the [YandexPassportUserAccount](../../api-ref/YandexPassportUserAccount/index.md) resource or the [YandexPassportUserAccount/GetByLogin](../../api-ref/grpc/yandex_passport_user_account_service.md#GetByLogin) gRPC API call.

   If you know the user's ID, use the [get](../../api-ref/UserAccount/get.md) REST API method for the [UserAccount](../../api-ref/UserAccount/index.md) resource or the [UserAccountService/Get](../../api-ref/grpc/service_account_service.md#Get) gRPC API call.

   To get information about federated users, use the [listUserAccounts](../../../organization/api-ref/Federation/listUserAccounts) REST API method for the [Federation](../../../organization/api-ref/Federation/) resource or the [FederationService/ListUserAccounts](../../../organization/api-ref/grpc/federation_service#ListUserAccounts) gRPC API call. To get information about a particular federated user, use the `filter` parameter to filter users by login.


{% endlist %}
