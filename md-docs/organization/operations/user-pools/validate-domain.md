# Подтвердить домен


Для добавления пользователей можно использовать только подтвержденные [домены](../../concepts/domains.md).

Чтобы подтвердить домен, вы должны быть его владельцем и располагать необходимыми учетными данными, чтобы изменить DNS-записи на сайте DNS-провайдера вашего домена.

## Подтвердить домен в пуле пользователей {#userpool}

{% list tabs group=instructions %}

- Интерфейс {{ cloud-center }} {#cloud-center}

  1. Войдите в сервис [{{ org-full-name }}]({{ link-org-cloud-center }}) с учетной записью администратора или владельца организации.
  1. На панели слева нажмите ![userpool](../../../_assets/organization/userpool.svg) **{{ ui-key.yacloud_org.pages.userpools }}** и выберите нужный [пул пользователей](../../concepts/user-pools.md).
  1. Выберите домен, который необходимо подтвердить.
  1. В открывшемся блоке будет указана информация для прохождения процедуры проверки прав на домен.
  1. После прохождения процедуры нажмите **{{ ui-key.yacloud_org.common.confirm }}**.

- CLI {#cli}

  Если у вас еще нет интерфейса командной строки {{ yandex-cloud }} (CLI), [установите и инициализируйте его](../../../cli/quickstart.md#install).

  По умолчанию используется каталог, указанный при [создании](../../../cli/operations/profile/profile-create.md) профиля CLI. Чтобы изменить каталог по умолчанию, используйте команду `yc config set folder-id <идентификатор_каталога>`. Также для любой команды вы можете указать другой каталог с помощью параметров `--folder-name` или `--folder-id`. Если вы обращаетесь к ресурсу по имени, поиск будет выполнен в каталоге по умолчанию. Если вы обращаетесь к ресурсу по идентификатору, поиск будет выполнен глобально — во всех каталогах с учетом прав доступа.  

  1. Подтвердите, что домен принадлежит вам:

     1. Перейдите в раздел управления DNS-записями на сайте DNS-провайдера вашего домена:
     1. Добавьте TXT-запись со следующими параметрами:

        * **Host** или **Subdomain** — `_yandexcloud-challenge`
        * **Text** или **Value** — значение поля `value`, полученное после [привязки домена](add-domain.md).

     1. Дождитесь обновления записей в системе DNS. Обновление может занять до 72 часов.

  1. Посмотрите описание команды CLI для подтверждения домена в [пуле пользователей](../../concepts/user-pools.md):

     ```bash
     yc organization-manager idp userpool domain validate --help
     ```

  1. Выполните команду:

      ```bash
      yc organization-manager idp userpool domain validate <идентификатор_пула> <домен> \
        --name <домен>
      ```

      Например, подтвердите домен `my-domain.ru` в федерации `my-federation`:

      ```bash
      yc organization-manager federation saml validate-domain my-federation \
        --domain my-domain.ru
      ```

- API {#api}

  Воспользуйтесь методом REST API [Userpool.ValidateDomain](../../idp/api-ref/Userpool/validateDomain.md) для ресурса [Userpool](../../idp/api-ref/Userpool/index.md) или вызовом gRPC API [UserpoolService/ValidateDomain](../../idp/api-ref/grpc/Userpool/validateDomain.md).

{% endlist %}

## Подтвердить домен в федерации удостоверений {#federation}

{% list tabs group=instructions %}

- CLI {#cli}

  Если у вас еще нет интерфейса командной строки {{ yandex-cloud }} (CLI), [установите и инициализируйте его](../../../cli/quickstart.md#install).

  По умолчанию используется каталог, указанный при [создании](../../../cli/operations/profile/profile-create.md) профиля CLI. Чтобы изменить каталог по умолчанию, используйте команду `yc config set folder-id <идентификатор_каталога>`. Также для любой команды вы можете указать другой каталог с помощью параметров `--folder-name` или `--folder-id`. Если вы обращаетесь к ресурсу по имени, поиск будет выполнен в каталоге по умолчанию. Если вы обращаетесь к ресурсу по идентификатору, поиск будет выполнен глобально — во всех каталогах с учетом прав доступа.

  1. Подтвердите, что домен принадлежит вам:

     1. Перейдите в раздел управления DNS-записями на сайте DNS-провайдера вашего домена:
     1. Добавьте TXT-запись со следующими параметрами:

        * **Host** или **Subdomain** — `_yandexcloud-challenge`
        * **Text** или **Value** — значение поля `value`, полученное после [привязки домена](add-domain.md).

     1. Дождитесь обновления записей в системе DNS. Обновление может занять до 72 часов.

  1. Посмотрите описание команды CLI для подтверждения домена в [федерации](../../concepts/add-federation.md):

     ```bash
     yc organization-manager federation saml validate-domain --help
     ```

  1. Выполните команду:

     ```bash
     yc organization-manager federation saml validate-domain <имя_или_идентификатор_федерации> \
       --domain <домен>
     ```

     Где `--domain` — ваш домен.

     Например, подтвердите домен `my-domain.ru` в федерации `my-federation`:

     ```bash
     yc organization-manager federation saml validate-domain my-federation \
       --domain my-domain.ru
     ```

- API {#api}

   Воспользуйтесь методом REST API [Federation.ValidateDomain](../../saml/api-ref/Federation/validateDomain.md) для ресурса [Federation](../../saml/api-ref/Federation/index.md) или вызовом gRPC API [FederationService/ValidateDomain](../../saml/api-ref/grpc/Federation/validateDomain.md).

{% endlist %}