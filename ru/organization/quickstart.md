# Начало работы с {{ org-name }}

Чтобы начать работу, создайте организацию и добавьте в нее пользователей.

_Организация_ — это рабочее пространство, которое объединяет разные типы ресурсов {{ yandex-cloud }} и пользователей. [Подробнее об организациях, ресурсах и пользователях](../overview/roles-and-resources.md).

Управлять настройками организации вы можете в разделе **{{ ui-key.yacloud_org.layout.organization }}** интерфейса [сервиса {{ cloud-center }}]({{ cloud-center-link }}).

Перед началом работы с {{ org-full-name }} [войдите]({{link-passport}}) в ваш аккаунт на Яндексе. Если у вас еще нет аккаунта, [создайте]({{ support-passport-create }}) его.

## Создайте организацию {#create}

{% list tabs group=instructions %}

- Интерфейс {{ cloud-center }} {#cloud-center}

  {% include [create-new-org](../_includes/organization/create-new-org.md) %}

{% endlist %}

После регистрации вы станете владельцем организации и сможете управлять аккаунтами сотрудников, подключать и отключать сервисы.

## Добавьте сотрудников {#add-users}

Вы можете подключить сотрудников с помощью аккаунтов на Яндексе — тогда они получат доступ к сервисам организации. Если в компании уже используется другая система управления учетными данными (например, Active Directory или Google Workspace), вы можете настроить федерацию удостоверений, чтобы сотрудники использовали свои рабочие аккаунты для доступа к сервисам {{yandex-cloud}}.

### Подключите сотрудников с аккаунтами на Яндексе {#add-ya-users}

Если у сотрудников компании есть аккаунты на Яндексе (например, `{{login-example}}`), они могут использовать эти аккаунты для доступа к сервисам {{yandex-cloud}}, подключенным к вашей организации.

Чтобы подключить сотрудников с аккаунтами на Яндексе:

{% list tabs group=instructions %}

- Интерфейс {{ cloud-center }} {#cloud-center}

  {% include [add-yandex-user](../_includes/organization/add-yandex-user.md) %}

{% endlist %}

Пользователи будут подключены к организации, как только примут приглашение по ссылке из письма и выберут подходящий аккаунт для входа.

### Настройте федерацию удостоверений {#add-federation}

Федерация удостоверений — это технология, которая позволяет реализовать систему единого входа (Single Sign-On, SSO) и использовать корпоративные аккаунты для авторизации в {{org-full-name}}. В этом случае ваша корпоративная система управления учетными записями пользователей выступает в роли поставщика удостоверений (IdP — identity provider).

Чтобы настроить федерацию удостоверений:

* Выполните настройки в {{ yandex-cloud }}:

    {% list tabs group=instructions %}

    - Интерфейс {{ cloud-center }} {#cloud-center}

      1. Перейдите в сервис [{{ org-full-name }}]({{ link-org-cloud-center }}).

      1. На панели слева выберите ![icon-federation](../_assets/console-icons/vector-square.svg) **{{ ui-key.yacloud_org.pages.federations }}**.

      1. В правом верхнем углу страницы нажмите кнопку ![Circles3Plus](../_assets/console-icons/circles-3-plus.svg) **{{ ui-key.yacloud_org.form.federation.action.create }}**. В открывшемся окне:

          1. Введите название и описание федерации.

          1. В поле **{{ ui-key.yacloud_org.entity.federation.field.cookieMaxAge }}** укажите время, в течение которого браузер не должен требовать у пользователя повторной аутентификации.

          1. В поле **{{ ui-key.yacloud_org.entity.federation.field.issuer }}** укажите идентификатор IdP-сервера, на котором будет происходить аутентификация пользователя. Во время аутентификации пользователя IdP-сервер должен указывать этот же идентификатор в ответе сервису {{ org-name }}.

              {% note info %}

              Формат идентификатора зависит от типа IdP-сервера, который вы используете (например, Active Directory или Google Workspace).

              {% endnote %}

          1. В поле **{{ ui-key.yacloud_org.entity.federation.field.ssoBinding }}** выберите **POST**.

          1. В поле **{{ ui-key.yacloud_org.entity.federation.field.ssoUrl }}** укажите адрес страницы, на которую браузер должен перенаправить пользователя для аутентификации.

          1. Включите опцию **{{ ui-key.yacloud_org.entity.federation.field.autocreateUsers }}**, чтобы аутентифицированный пользователь автоматически добавлялся в организацию.
         
             Если вы не включите эту опцию, федеративных пользователей потребуется [добавить вручную](operations/add-account.md#add-user-sso).

          1. Нажмите кнопку **{{ ui-key.yacloud_org.form.federation.create.action.create }}**.

    {% endlist %}

* Настройте сервер поставщика удостоверений, чтобы он передавал в {{yandex-cloud}} информацию об успешной аутентификации и атрибуты пользователя.

   Атрибуты пользователей, которые поддерживают сервисы {{org-full-name}}, перечислены в инструкциях по настройке федерации удостоверений для разных поставщиков удостоверений:

   * [Active Directory](./tutorials/federations/integration-adfs.md).
   * [Google Workspace](./tutorials/federations/integration-gworkspace.md).
   * [Microsoft Entra ID](./tutorials/federations/integration-azure.md).
   * [Keycloak](./tutorials/federations/integration-keycloak.md).
   * [Другие SAML-совместимые поставщики удостоверений](./operations/setup-federation.md).