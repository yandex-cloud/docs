# Получение информации о пользователе

Вы можете узнать идентификатор, почту и другую информацию о пользователях.

{% list tabs %}

- Cloud Organization

  {% include [users-info](../../../_includes/users-info.md) %}


- CLI

  1. Посмотрите описание команды получения информации о пользователе:

      ```bash
      yc iam user-account get --help
      ```

  1. Получите информацию о пользователе, указав его логин:
      
      ```bash
      yc iam user-account get just.mad.hatter
      ```

      Результат:

      ```bash
      id: ajei8n5ahmfhuk5fog0g
      yandex_passport_user_account:
          login: just.mad.hatter
          default_email: just.mad.hatter@yandex.ru
      ```

- API

  Если вы знаете логин пользователя, воспользуйтесь методом REST API [getByLogin](../../api-ref/YandexPassportUserAccount/getByLogin.md) для ресурса [YandexPassportUserAccount](../../api-ref/YandexPassportUserAccount/index.md) или вызовом gRPC API [YandexPassportUserAccount/GetByLogin](../../api-ref/grpc/yandex_passport_user_account_service.md#GetByLogin).
  
  Если вы знаете идентификатор пользователя, воспользуйтесь методом REST API [get](../../api-ref/UserAccount/get.md) для ресурса [UserAccount](../../api-ref/UserAccount/index.md) или вызовом gRPC API [UserAccountService/Get](../../api-ref/grpc/service_account_service.md#Get).

  Чтобы получить информацию о федеративных пользователях, воспользуйтесь методом REST API [listUserAccounts](../../../organization/api-ref/Federation/listUserAccounts) для ресурса [Federation](../../../organization/api-ref/Federation/) или вызовом gRPC API [FederationService/ListUserAccounts](../../../organization/api-ref/grpc/federation_service#ListUserAccounts). Чтобы получить информацию об определенном федеративном пользователе, примените фильтрацию по логину с помощью параметра `filter`.


{% endlist %}
