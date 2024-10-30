# Получение информации о пользователе

Вы можете узнать идентификатор, почту и другую информацию о пользователях.

{% list tabs group=instructions %}

- Интерфейс {{ cloud-center }} {#cloud-center}

  {% include [users-info](../../../_includes/users-info.md) %}

- CLI {#cli}

  {% include [cli-install](../../../_includes/cli-install.md) %}

  1. Посмотрите описание команды получения информации о пользователе:

      ```bash
      yc iam user-account get --help
      ```

  1. Получите информацию о пользователе, указав его логин:
      
      ```bash
      yc iam user-account get just.mad.hatter
      ```

      Результат:

      ```text
      id: ajei8n5ahmfh********
      yandex_passport_user_account:
          login: just.mad.hatter
          default_email: just.mad.hatter@yandex.ru
      ```

- API {#api}

  Если вы знаете логин пользователя, воспользуйтесь методом REST API [getByLogin](../../api-ref/YandexPassportUserAccount/getByLogin.md) для ресурса [YandexPassportUserAccount](../../api-ref/YandexPassportUserAccount/index.md) или вызовом gRPC API [YandexPassportUserAccount/GetByLogin](../../api-ref/grpc/YandexPassportUserAccount/getByLogin.md).
  
  Если вы знаете идентификатор пользователя, воспользуйтесь методом REST API [get](../../api-ref/UserAccount/get.md) для ресурса [UserAccount](../../api-ref/UserAccount/index.md) или вызовом gRPC API [UserAccountService/Get](../../api-ref/grpc/ServiceAccount/get.md).

  Чтобы получить информацию о федеративных пользователях, воспользуйтесь методом REST API [listUserAccounts](../../../organization/saml/api-ref/Federation/listUserAccounts) для ресурса [Federation](../../../organization/saml/api-ref/Federation/) или вызовом gRPC API [FederationService/ListUserAccounts](../../../organization/saml/api-ref/grpc/Federation/listUserAccounts.md). Чтобы получить информацию об определенном федеративном пользователе, примените фильтрацию по логину с помощью параметра `filter`.

{% endlist %}
