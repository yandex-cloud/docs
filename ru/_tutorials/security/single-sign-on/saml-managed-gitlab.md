# Создать SAML-приложение в {{ org-full-name }} для интеграции с {{ mgl-name }}

Чтобы пользователи вашей [организации](../../../organization/concepts/organization.md) могли аутентифицироваться в {{ mgl-full-name }} с помощью технологии единого входа по стандарту [SAML](https://ru.wikipedia.org/wiki/SAML), создайте [SAML-приложение](../../../organization/concepts/applications.md#saml) в {{ org-name }} и настройте его на стороне {{ org-name }} и на стороне {{ mgl-name }}.

{% include [saml-app-admin-role](../../../_includes/organization/saml-app-admin-role.md) %}

Чтобы дать доступ пользователям вашей организации в {{ mgl-name }}:

1. [Создайте инстанс {{ GL }}](#create-mgl-instance).
1. [Создайте приложение в {{ org-name }}](#create-app).
1. [Настройте интеграцию](#setup-integration).
1. [Убедитесь в корректной работе приложения](#validate).

## Создайте инстанс {{ GL }} {#create-mgl-instance}

{% list tabs group=instructions %}

- Консоль управления {#console}

   1. В консоли управления выберите [каталог](../../../resource-manager/concepts/resources-hierarchy.md#folder), в котором нужно создать [инстанс {{ GL }}](../../../managed-gitlab/concepts/index.md#instance).
   1. Выберите сервис **{{ ui-key.yacloud.iam.folder.dashboard.label_managed-gitlab }}**.
   1. Нажмите кнопку **{{ ui-key.yacloud.gitlab.button_create-instance }}**.
   1. В верхней части страницы:

      1. Введите имя инстанса. Оно должно быть уникальным в рамках {{ yandex-cloud }}.

   1. В блоке **{{ ui-key.yacloud.gitlab.label_configuration-section }}**:

      1. Выберите [тип инстанса](../../../managed-gitlab/concepts/index.md#config). После создания инстанса можно [изменить его тип](../../../managed-gitlab/operations/instance/instance-update.md) на более производительный.
      1. Укажите [зону доступности](../../../overview/concepts/geo-scope.md). После создания инстанса изменить его зону доступности невозможно.
      1. Укажите [подсеть](../../../vpc/concepts/network.md#subnet), в которой будет размещен инстанс.
      1. Выберите [группу безопасности](../../../vpc/concepts/security-groups.md) или создайте новую:

         1. Нажмите кнопку **{{ ui-key.yacloud.component.network-subnet-select.button_create-security-group }}**.
         1. Введите имя и описание группы безопасности. Правила для группы безопасности вы сможете добавить позже в сервисе **{{ vpc-name }}**.
         1. Нажмите кнопку **{{ ui-key.yacloud.common.create }}**.

      1. Выберите размер [диска](../../../compute/concepts/disk.md). После создания инстанса размер его диска [можно увеличить](../../../managed-gitlab/operations/instance/instance-update.md).
      1. Укажите [доменное имя инстанса](../../../compute/concepts/network.md#hostname) — для него будут автоматически созданы нужные DNS-записи в домене `.gitlab.yandexcloud.net`.

      1. Задайте срок хранения автоматических резервных копий (в днях).

   1. В блоке **{{ ui-key.yacloud.gitlab.label_admin-section }}** укажите:
      * **{{ ui-key.yacloud.gitlab.field_admin-email }}** — адрес электронной почты администратора инстанса {{ GL }}. На этот адрес придет письмо со ссылкой для создания пароля.
      * **{{ ui-key.yacloud.gitlab.field_admin-login }}** — логин администратора.
   1. Нажмите кнопку **{{ ui-key.yacloud.common.create }}**.
   1. Дождитесь, когда инстанс будет готов к работе: его статус на панели {{ mgl-name }} сменится на **Running**. Это может занять некоторое время.

{% endlist %}

## Создайте приложение в {{ org-name }} {#create-app}

{% list tabs group=instructions %}

- Интерфейс {{ cloud-center }} {#cloud-center}

   1. Войдите в сервис [{{ org-full-name }}]({{ link-org-cloud-center }}).
   1. На панели слева выберите ![shapes-4](../../../_assets/console-icons/shapes-4.svg) **{{ ui-key.yacloud_org.pages.apps }}**.
   1. В правом верхнем углу страницы нажмите ![Circles3Plus](../../../_assets/console-icons/circles-3-plus.svg) **{{ ui-key.yacloud_org.action.applications.components.create-app }}** и в открывшемся окне:
      1. Выберите метод единого входа **{{ ui-key.yacloud_org.organization.apps.AppCreateForm.saml-title_kyofk }}**.
      1. В поле **{{ ui-key.yacloud_org.organization.apps.AppCreateForm.field-name_1VbM1 }}** задайте имя создаваемого приложения: `managed-gitlab-app`.

      1. (Опционально) В поле **{{ ui-key.yacloud_org.organization.apps.AppCreateForm.field-description_kzkNB }}** задайте описание приложения.
      1. (Опционально) Добавьте [метки](../../../resource-manager/concepts/labels.md):

         1. Нажмите **{{ ui-key.yacloud.component.label-set.button_add-label }}**.
         1. Введите метку в формате `ключ: значение`.
         1. Нажмите **Enter**.
      1. Нажмите **{{ ui-key.yacloud_org.organization.apps.AppCreateForm.create-app-submit_myxPn }}**.
   1. Сохраните значения полей **{{ ui-key.yacloud_org.application.overview.saml_field_login }}**, **{{ ui-key.yacloud_org.application.overview.saml_field_issuer }}** и **{{ ui-key.yacloud_org.application.overview.field_cert-fingerprin }}**, они понадобятся на следующем шаге.

{% endlist %}

## Настройте интеграцию {#setup-integration}

### Настройте аутентификацию на стороне {{ GL }} с помощью OmniAuth {#setup-sp}

Чтобы интегрировать провайдер аутентификации для {{ GL }} через OmniAuth, добавьте провайдер аутентификации:

1. В [консоли управления]({{ link-console-main }}) перейдите на страницу каталога и выберите сервис **{{ ui-key.yacloud.iam.folder.dashboard.label_managed-gitlab }}**.
1. Нажмите на созданный инстанс и выберите вкладку **{{ ui-key.yacloud.gitlab.title_omniauth }}**.
1. Нажмите кнопку **{{ ui-key.yacloud.gitlab.button_setup-omniauth }}**.
1. Чтобы добавить провайдера аутентификации, нажмите кнопку **Add**.
1. Выберите тип `SAML` и укажите параметры провайдера аутентификации:

   * **Label** — название провайдера аутентификации. Может быть любым, например `Identity Hub`.
   * **Assertion consumer service URL** — HTTPS-эндпоинт инстанса {{ GL }}. Чтобы сформировать этот URL, добавьте `/users/auth/saml/callback` к адресу вашего инстанса {{ GL }}, например `https://example.gitlab.yandexcloud.net/users/auth/saml/callback`.
   * **IDP certificate fingerprint** — SHA1-отпечаток открытого ключа сертификата. Используйте значение из поля **{{ ui-key.yacloud_org.application.overview.field_cert-fingerprin }}**, полученное при создании приложения в {{ org-name }}.
   * **IDP SSO target URL** — URL провайдера идентификации. Используйте значение из поля **{{ ui-key.yacloud_org.application.overview.saml_field_login }}**.
   * **Issuer** — уникальный идентификатор приложения, в котором будет происходить аутентификация пользователя, например `https://example.gitlab.yandexcloud.net`.
   * **Name identifier format** — формат идентификатора имени, выберите значение `Persistent`.
   * **Allow single sign on** — разрешить использование SSO. Установите значение `true`. Если установить `false`, аутентифицироваться смогут только пользователи, уже созданные на стороне {{ GL }}.
   * **Auto link users by email** — установить соответствие между именем пользователя в OmniAuth и в {{ GL }}, если к ним привязан один адрес электронной почты. Установите значение `true`.
   * **Block auto-created users** — переводить автоматически созданные учетные записи в состояние [Pending approval]({{ gl.docs }}/ee/administration/moderate_users.html#users-pending-approval) до их одобрения администратором. Установите значение `false`.
   * **External provider** — установить для провайдера свойство _внешний_. Пользователи, аутентифицированные через данный провайдер, будут считаться [внешними]({{ gl.docs }}/ee/user/admin_area/external_users.html) и не будут иметь доступа к [внутренним проектам]({{ gl.docs }}/ee/user/public_access.html#internal-projects-and-groups). Установите значение `false`.
   * **Auto link LDAP user** — создавать LDAP-сущность для автоматически созданных учетных записей. Применимо только для инстансов, к которым подключен LDAP-провайдер. Установите значение `false`.

1. Нажмите кнопку **{{ ui-key.yacloud.common.create }}**.

### Настройте SAML-приложение на стороне {{ org-full-name }} {#setup-idp}

#### Настройте эндпоинты поставщика услуг {#sp-endpoints}

{% list tabs group=instructions %}

- Интерфейс {{ cloud-center }} {#cloud-center}

  1. Войдите в сервис [{{ org-full-name }}]({{ link-org-cloud-center }}).
  1. На панели слева выберите ![shapes-4](../../../_assets/console-icons/shapes-4.svg) **{{ ui-key.yacloud_org.pages.apps }}** и выберите нужное SAML-приложение.
  1. Справа сверху нажмите ![pencil](../../../_assets/console-icons/pencil.svg) **{{ ui-key.yacloud.common.edit }}** и в открывшемся окне:  
      1. В поле **{{ ui-key.yacloud_org.organization.apps.SamlAppEditForm.field-sp-entity-id_snAsX }}** вставьте адрес эндпоинта, который вы вводили в поле **Issuer** при настройке OmniAuth.
      1. В поле **{{ ui-key.yacloud_org.organization.apps.SamlAppEditForm.field-acs-urls_eQcJr }}** вставьте адрес эндпоинта, который вы вводили в поле **Assertion consumer service URL** при настройке OmniAuth, например `https://example.gitlab.yandexcloud.net/users/auth/saml/callback`.
      1. Нажмите **{{ ui-key.yacloud.common.save }}**.

{% endlist %}

#### Настройте атрибуты пользователей {#user-attributes}

{% note warning %}

Для интеграции с {{ GL }} необходимо, чтобы у пользователей был атрибут `email`.

{% endnote %}

{% list tabs group=instructions %}

- Интерфейс {{ cloud-center }} {#cloud-center}

    1. Войдите в сервис [{{ org-full-name }}]({{ link-org-cloud-center }}).
    1. На панели слева выберите ![shapes-4](../../../_assets/console-icons/shapes-4.svg) **{{ ui-key.yacloud_org.pages.apps }}** и выберите нужное приложение.
    1. Перейдите на вкладку **{{ ui-key.yacloud_org.organization.apps.AppPageLayout.attributes_to71e }}**.
    1. Нажмите на строку с атрибутом `emailaddress` и в открывшемся окне:

        1. В поле **{{ ui-key.yacloud_org.attributes.update_dialog.field_attribute_name }}** измените значение на `email`.
        1. Нажмите **{{ ui-key.yacloud.common.update }}**.

{% endlist %}

Подробнее о настройке атрибутов см. [Настройте атрибуты пользователей и групп](../../../organization/operations/applications/saml-create.md#setup-attributes).

### Добавьте пользователя {#add-user}

Чтобы пользователи вашей организации могли аутентифицироваться в {{ GL }} с помощью SAML-приложения {{ org-name }}, необходимо явно добавить в SAML-приложение нужных пользователей и/или [группы пользователей](../../../organization/concepts/groups.md).

{% note info %}

Управлять пользователями и группами, добавленными в SAML-приложение, может пользователь, которому назначена [роль](../../../organization/security/index.md#organization-manager-samlApplications-userAdmin) `organization-manager.samlApplications.userAdmin` или выше.

{% endnote %}

1. Добавьте пользователей в приложение:

    {% list tabs group=instructions %}

    - Интерфейс {{ cloud-center }} {#cloud-center}

        1. Войдите в сервис [{{ org-full-name }}]({{ link-org-cloud-center }}).
        1. На панели слева выберите ![shapes-4](../../../_assets/console-icons/shapes-4.svg) **{{ ui-key.yacloud_org.pages.apps }}** и выберите нужное приложение.
        1. Перейдите на вкладку **{{ ui-key.yacloud_org.organization.apps.AppPageLayout.assignments_kKzJS }}**.
        1. Нажмите ![person-plus](../../../_assets/console-icons/person-plus.svg) **{{ ui-key.yacloud_org.organization.apps.AppAssignmentsPage.action_add-assignments }}**.
        1. В открывшемся окне выберите нужного пользователя или группу пользователей.
        1. Нажмите **{{ ui-key.yacloud.common.add }}**.

    {% endlist %}

## Убедитесь в корректной работе приложения {#validate}

Чтобы убедиться в корректной работе SAML-приложения и интеграции с {{ GL }}, выполните аутентификацию в {{ GL }} от имени одного из добавленных в приложение пользователей. Для этого:

1. В браузере перейдите по адресу вашего инстанса {{ GL }} (например, `https://example.gitlab.yandexcloud.net`).
1. Если вы прошли аутентификацию в {{ GL }}, выйдите из профиля.
1. На странице аутентификации {{ GL }} нажмите на название созданного провайдера аутентификации, например `Identity Hub`.
1. На странице аутентификации {{ yandex-cloud }} укажите почту и пароль пользователя. Пользователь должен быть добавлен в приложение или состоять в группе, добавленной в приложение. Также у пользователя должна быть указана почта.
1. Убедитесь, что вы аутентифицировались в {{ GL }}.