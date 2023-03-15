# Получение идентификатора или почты пользователя

{% list tabs %}

- Cloud Organization

  {% include [users-info](../../../_includes/users-info.md) %}

{% if product == "yandex-cloud" %}

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

  Получите информацию о пользователе (ресурс [UserAccount](../../api-ref/UserAccount/index.md)):
  * Если вы знаете логин пользователя, используйте метод REST API [getByLogin](../../api-ref/YandexPassportUserAccount/getByLogin.md) для ресурса [YandexPassportUserAccount](../../api-ref/YandexPassportUserAccount/index.md) или вызов gRPC API [YandexPassportUserAccount/GetByLogin](../../api-ref/grpc/yandex_passport_user_account_service.md#GetByLogin).
  * Если вы знаете идентификатор пользователя, используйте метод REST API [get](../../api-ref/UserAccount/get.md) для ресурса [UserAccount](../../api-ref/UserAccount/index.md) или вызов gRPC API [UserAccountService/Get](../../api-ref/grpc/service_account_service.md#Get).

{% endif %}

{% endlist %}
