# Добавление пользователя в облако

Чтобы добавлять пользователей в облако, вы должны пригласить его в [организацию](../../../organization/enable-org.md), которая назначена облаку.

Добавлять можно [пользователей с аккаунтом на Яндексе](#passport-user) и [федеративных пользователей](#federated-user).

## Добавить пользователя с аккаунтом на Яндексе {#passport-user}

1. [Войдите в аккаунт]({{ link-passport-login }}) администратора организации.
1. Перейдите в сервис [{{ org-full-name }}]({{ link-org-main }}).
1. На левой панели выберите раздел [Пользователи](https://org.cloud.yandex.ru/users) ![icon-users](../../../_assets/organization/icon-users.png).
1. В правом верхнем углу нажмите кнопку **Добавить пользователя**.
1. Введите почтовый адрес пользователя Яндекса.
1. Нажмите кнопку **Добавить**. Пользователь будет подключен к организации и получит доступ к ее сервисам.

{% note info %}

{% include [yandex-account-2fa-warning.md](../../../_includes/iam/yandex-account-2fa-warning.md) %}

{% endnote %}

## Добавить федеративных пользователей {#federated-user}

Для добавления федеративных пользователей вам необходимо знать Name ID пользователей, которые возвращает сервер поставщика удостоверений (IdP) вместе с ответом об успешной аутентификации. Обычно это основной email пользователя. Если вы не знаете, что возвращает сервер в качестве Name ID, обратитесь к администратору, который настраивал аутентификацию в вашей федерации.

Чтобы добавить пользователей федерации в организацию:

{% list tabs %}

- Консоль управления

  1. [Войдите в аккаунт]({{ link-passport-login }}) администратора организации.
  1. Перейдите в сервис [{{ org-full-name }}]({{ link-org-main }}).
  1. На левой панели выберите раздел [Пользователи](https://org.cloud.yandex.ru/users) ![icon-users](../../../_assets/organization/icon-users.png).
  1. В правом верхнем углу нажмите на стрелку возле кнопки **Добавить пользователя**. Выберите **Добавить федеративных пользователей**.
  1. Выберите федерацию, из которой необходимо добавить пользователей.
  1. Перечислите Name ID пользователей, разделяя их переносами строк.
  1. Нажмите кнопку **Добавить**. Пользователи будут подключены к организации.

- CLI

  {% include [cli-install](../../../_includes/cli-install.md) %}

  {% include [default-catalogue](../../../_includes/default-catalogue.md) %}

  1. Посмотрите описание команды добавления пользователей:

      ```
      yc organization-manager federation saml add-user-accounts --help
      ```

  1. Добавьте пользователей, перечислив их Name ID через запятую:

      ```
      yc organization-manager federation saml add-user-accounts --name my-federation \
        --name-ids=alice@example.com,bob@example.com,charlie@example.com
      ```

- API

  Чтобы добавить пользователей федерации в облако:

  1.  Сформируйте файл с телом запроса, например `body.json`. В теле запроса укажите массив Name ID пользователей, которых необходимо добавить:

      ```json
      {
        "nameIds": [
          "alice@example.com",
          "bob@example.com",
          "charlie@example.com"
        ]
      }
      ```
  1.  Отправьте запрос, указав в параметрах идентификатор федерации:

      ```bash
      $ curl -X POST \
        -H "Content-Type: application/json" \
        -H "Authorization: Bearer <IAM-токен>" \
        -d '@body.json' \
        https://iam.api.cloud.yandex.net/iam/v1/saml/federations/<ID федерации>:addUserAccounts
      ```

{% endlist %}

#### Что дальше {#what-is-next}

* [Назначьте роли добавленным пользователям](../roles/grant.md).