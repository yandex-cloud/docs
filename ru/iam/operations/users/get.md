# Получение идентификатора или почты пользователя


Вы можете получить следующую информацию о любом зарегистрированном пользователе {{ yandex-cloud }}:
* идентификатор;
* логин{% if product == "cloud-il" %}.{% endif %}{% if product == "yandex-cloud" %};{% endif %}
{% if product == "yandex-cloud" %}
* почта (только через CLI и API).
{% endif %}

{% list tabs %}

- Консоль управления

  1. Войдите в [консоль управления]({{ link-console-main }}).
  1. [Выберите](../../../resource-manager/operations/cloud/switch-cloud.md) облако.
  1. Перейдите на вкладку **Права доступа**.

{% if product == "yandex-cloud" %}
- CLI

  1. Посмотрите описание команды получения информации о пользователе:

      ```bash
      yc iam user-account get --help
      ```

  2. Получите информацию о пользователе, указав его логин:
      
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
  * Если вы знаете логин пользователя, используйте метод [getByLogin](../../api-ref/YandexPassportUserAccount/getByLogin.md) для ресурса [YandexPassportUserAccount](../../api-ref/YandexPassportUserAccount/index.md).
  * Если вы знаете идентификатор пользователя, используйте метод [get](../../api-ref/UserAccount/get.md) для ресурса [UserAccount](../../api-ref/UserAccount/index.md).

{% endif %}
{% endlist %}
