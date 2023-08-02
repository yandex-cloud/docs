# Настройка OmniAuth

С помощью [OmniAuth](https://rubygems.org/gems/omniauth/) пользователи могут авторизоваться в {{ GL }}, используя учетные данные других сервисов.

Чтобы интегрировать провайдер аутентификации для {{ GL }} через OmniAuth, [добавьте провайдер аутентификации](#add-provider), в процессе указав его [параметры](#params).

## Добавление провайдера аутентификации {#add-provider}

1. В [консоли управления]({{ link-console-main }}) перейдите на страницу каталога и выберите сервис **{{ ui-key.yacloud.iam.folder.dashboard.label_managed-gitlab }}**.
1. Нажмите на имя нужного кластера и выберите вкладку **{{ ui-key.yacloud.gitlab.title_omniauth }}**.
1. Нажмите кнопку **{{ ui-key.yacloud.gitlab.button_setup-omniauth }}**.
1. Чтобы добавить провайдера аутентификации, нажмите кнопку **Add**.
1. Выберите тип и укажите [параметры провайдера аутентификации](#params).
1. Нажмите кнопку **Создать**.

Подробнее о работе OmniAuth в {{ GL }} см. в [документации {{ GL }}]({{ gl.docs }}/ee/integration/omniauth.html).

## Параметры провайдера аутентификации {#params}

Часть параметров являются общими для всех провайдеров:

* **Allow single sign on** — разрешить использование SSO. Если установлено значение `true`, то при авторизации незарегистрированного в {{ GL }} пользователя через провайдер OmniAuth для него будет автоматически создана учетная запись в {{ GL }}.
* **Auto link users by email** — установить соответствие между именем пользователя в OmniAuth и в {{ GL }}, если к ним привязан один адрес электронной почты.
* **Block auto-created users** — переводить автоматически созданные учетные записи в состояние [Pending approval]({{ gl.docs }}/ee/administration/moderate_users.html#users-pending-approval) до их одобрения администратором.
* **External provider** — установить для провайдера свойство _внешний_. Пользователи, авторизованные через данный провайдер, будут считаться [внешними]({{ gl.docs }}/ee/user/admin_area/external_users.html) и не будут иметь доступа к [внутренним проектам]({{ gl.docs }}/ee/user/public_access.html#internal-projects-and-groups).
* **Auto link LDAP user** — создавать LDAP-сущность для автоматически созданных учетных записей. Применимо только для инстансов, к которым подключен LDAP-провайдер.

Остальные параметры зависят от выбранного типа провайдера.

### Bitbucket Cloud {#bitbucket}

{% include [omniauth-common](../../_includes/managed-gitlab/omniauth-common.md) %}

О том, как получить идентификатор и секретный ключ приложения, см. в [инструкции по настройке провайдера]({{ gl.docs }}/ee/integration/bitbucket.html#bitbucket-omniauth-provider).

### Github Enterprise {#gitlab-ee}

{% include [omniauth-common](../../_includes/managed-gitlab/omniauth-common.md) %}
* **URL** — ссылка на репозиторий в GitHub.

О том, как получить идентификатор и секретный ключ приложения, см. в [инструкции по настройке провайдера]({{ gl.docs }}/ee/integration/github.html).

### {{ GL }} self-managed {#gitlab-self}

{% include [omniauth-common](../../_includes/managed-gitlab/omniauth-common.md) %}
* **Site** — ссылка на репозиторий в {{ GL }}.

О том, как получить идентификатор и секретный ключ приложения, см. в [инструкции по настройке провайдера]({{ gl.docs }}/ee/integration/gitlab.html).

### Google OAuth 2.0 {#google}

{% include [omniauth-common](../../_includes/managed-gitlab/omniauth-common.md) %}

О том, как получить идентификатор и секретный ключ приложения, см. в [инструкции по настройке провайдера]({{ gl.docs }}/ee/integration/google.html#configure-the-google-cloud-resource-manager).

### Keycloak {#keycloak}

{% note info %}

Для работы с {{ GL }} сервер Keycloak должен использовать протокол HTTPS.

{% endnote %}

* **Label** — название провайдера аутентификации. Может быть любым.
* **Issuer** — URL источника авторизации, например `https://keycloak.example.com/realms/myrealm`.
* **Client ID** — идентификатор клиента, полученный при настройке Keycloak.
* **Client Secret** — секретный ключ клиента, полученный при настройке Keycloak.
* **Site** — ссылка на репозиторий в {{ GL }}.

### LDAP {#ldap}

{% note warning %}

Перед настройкой интеграции с LDAP убедитесь, что пользователи на LDAP-сервере не могут:

* Изменять аттрибуты `mail`, `email` и `userPrincipalName`. Пользователи с такими привилегиями потенциально могут получить доступ к любой учетной записи на {{ GL }}-сервере.
* Иметь общий адрес электронной почты. Пользователи LDAP с общим адресом электронной почты смогут использовать один аккаунт в {{ GL }}.

{% endnote %}

* **Name** — отображаемое имя пользователя в LDAP.
* **Label** — название LDAP-сервера. Может быть любым.
* **Host** — IP-адрес или доменное имя LDAP-сервера.
* **Port** — порт LDAP-сервера для подключения.
* **Username ID** — идентификатор пользователя в LDAP.
* **Encryption** — метод шифрования трафика.
* **Base** — имя LDAP-каталога, где хранятся учетные записи пользователей.

О том, как выполнить минимальные настройки LDAP-сервера для работы с {{ GL }}, см. в [документации {{ GL }}]({{ gl.docs }}/ee/administration/auth/ldap/#configure-ldap).

### Microsoft Azure Active Directory {#azure-ad}

* **Label** — название провайдера аутентификации. Может быть любым.
* **Client ID** — идентификатор клиента, полученный при регистрации приложения.
* **Client Secret** — секретный ключ клиента, полученный при регистрации приложения.
* **Tenant ID** — идентификатор тенанта, полученный при регистрации приложения.

О том, как зарегистрировать приложение на стороне Azure, см. в [документации {{ GL }}]({{ gl.docs }}/ee/integration/azure.html#register-an-azure-application).

### Microsoft Azure OAuth 2 {#azure-oauth}

* **Label** — название провайдера аутентификации. Может быть любым.
* **Client ID** — идентификатор клиента, полученный при регистрации приложения.
* **Client Secret** — секретный ключ клиента, полученный при регистрации приложения.
* **Tenant ID** — идентификатор тенанта, полученный при регистрации приложения.

О том, как зарегистрировать приложение на стороне Azure, см. в [документации {{ GL }}]({{ gl.docs }}/ee/integration/azure.html#register-an-azure-application).

### SAML {#saml}

* **Label** — название провайдера аутентификации. Может быть любым.
* **Assertion consumer service URL** — HTTPS-эндпоинт инстанса {{ GL }}. Чтобы сформировать этот URL, добавьте `/users/auth/saml/callback` к адресу вашего инстанса {{ GL }}, например `https://example.gitlab.yandexcloud.net/users/auth/saml/callback`.
* **IDP certificate fingerprint** — SHA1-отпечаток открытого ключа сертификата, например `90:CC:16:F0:8D:...`. Выдается при настройке провайдера идентификации.
* **IDP SSO target URL** — URL провайдера идентификации. Выдается при настройке провайдера идентификации.
* **Issuer** — уникальный идентификатор приложения, в котором будет происходить аутентификация пользователя, например `https://example.gitlab.yandexcloud.net`.
* **Name identifier format** — формат идентификатора имени. Выдается при настройке провайдера идентификации.

О том, как настроить SAML на стороне провайдера идентификации, см. в [документации {{ GL }}]({{ gl.docs }}/ee/integration/saml.html#configure-saml-on-your-idp).
