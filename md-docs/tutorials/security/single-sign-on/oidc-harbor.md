# Создать OIDC-приложение в {{ org-full-name }} для интеграции с Harbor

[Harbor](https://goharbor.io/) — open source-реестр артефактов контейнерной разработки: образов контейнеров, Helm-чартов и других типов данных. Harbor поддерживает аутентификацию по [OpenID Connect](https://ru.wikipedia.org/wiki/OpenID#OpenID_Connect) (OIDC), что позволяет использовать внешний поставщик удостоверений для единого входа пользователей.

Чтобы пользователи вашей [организации](../../../organization/concepts/organization.md) входили в Harbor с помощью OpenID Connect, создайте [OIDC-приложение](../../../organization/concepts/applications.md#oidc) в {{ org-full-name }} и настройте интеграцию на стороне {{ org-full-name }} и Harbor.

Управлять OIDC-приложениями может пользователь, которому назначена [роль](../../../organization/security/index.md#organization-manager-oauthApplications-admin) `organization-manager.oauthApplications.admin` или выше.

Чтобы дать пользователям организации доступ к Harbor:

1. [Создайте приложение](#create-app).
1. [Настройте интеграцию](#setup-integration).
1. [Убедитесь в корректной работе приложения](#validate).

## Создайте приложение {#create-app}

{% list tabs group=instructions %}

- Интерфейс {{ cloud-center }} {#cloud-center}

    1. Войдите в сервис [{{ org-full-name }}]({{ link-org-cloud-center }}).
    1. На панели слева выберите ![shapes-4](../../../_assets/console-icons/shapes-4.svg) **{{ ui-key.yacloud_org.pages.apps }}**.
    1. В правом верхнем углу страницы нажмите ![Circles3Plus](../../../_assets/console-icons/circles-3-plus.svg) **{{ ui-key.yacloud_org.action.applications.components.create-app }}** и в открывшемся окне:
        1. Выберите метод единого входа **{{ ui-key.yacloud_org.organization.apps.AppCreateForm.oauth-title_uUs4x }}**.
        1. В поле **{{ ui-key.yacloud_org.organization.apps.AppCreateForm.field-name_1VbM1 }}** задайте имя создаваемого приложения: `harbor-oidc-app`.
        1. В поле **{{ ui-key.yacloud_org.organization.apps.AppCreateForm.field-folder_rANM4 }}** выберите каталог, в котором будет создан OAuth-клиент для приложения.
        1. (Опционально) В поле **{{ ui-key.yacloud_org.organization.apps.AppCreateForm.field-description_kzkNB }}** задайте описание приложения.
        1. (Опционально) Добавьте [метки](../../../resource-manager/concepts/labels.md):

            1. Нажмите **{{ ui-key.yacloud.component.label-set.button_add-label }}**.
            1. Введите метку в формате `ключ: значение`.
            1. Нажмите **Enter**.
        1. Нажмите **{{ ui-key.yacloud_org.organization.apps.AppCreateForm.create-app-submit_myxPn }}**.

- CLI {#cli}

  Если у вас еще нет интерфейса командной строки {{ yandex-cloud }} (CLI), [установите и инициализируйте его](../../../cli/quickstart.md#install).

  По умолчанию используется каталог, указанный при [создании](../../../cli/operations/profile/profile-create.md) профиля CLI. Чтобы изменить каталог по умолчанию, используйте команду `yc config set folder-id <идентификатор_каталога>`. Также для любой команды вы можете указать другой каталог с помощью параметров `--folder-name` или `--folder-id`. Если вы обращаетесь к ресурсу по имени, поиск будет выполнен в каталоге по умолчанию. Если вы обращаетесь к ресурсу по идентификатору, поиск будет выполнен глобально — во всех каталогах с учетом прав доступа.

  1. Посмотрите описание команды CLI для создания OIDC-приложения:

     ```bash
     yc organization-manager idp application oauth application create --help
     ```

  1. Создайте OAuth-клиент:

     ```bash
     yc iam oauth-client create \
       --name harbor-oauth-client \
       --scopes openid,email,profile,groups
     ```

     Где:

     * `--name` — имя OAuth-клиента.
     * `--scopes` — набор атрибутов пользователей, которые будут доступны Harbor. Указаны атрибуты:
       * `openid` — идентификатор пользователя. Обязательный атрибут.
       * `email` — адрес электронной почты пользователя.
       * `profile` — дополнительная информация о пользователе, такая как имя, фамилия, аватар.
       * `groups` — [группы пользователей](../../../organization/concepts/groups.md) в организации.

     Результат:

     ```text
     id: ajeqqip130i1********
     name: harbor-oauth-client
     folder_id: b1g500m2195v********
     status: ACTIVE
     ```

     Сохраните значение поля `id`, оно понадобится для создания и настройки приложения.

  1. Создайте секрет для OAuth-клиента:

     ```bash
     yc iam oauth-client-secret create \
       --oauth-client-id <идентификатор_OAuth-клиента>
     ```

     Результат:

     ```text
     oauth_client_secret:
       id: ajeq9jfrmc5t********
       oauth_client_id: ajeqqip130i1********
       masked_secret: yccs__939233b8ac****
       created_at: "2025-10-21T10:14:17.861652377Z"
     secret_value: yccs__939233b8ac********
     ```

     Сохраните значение поля `secret_value`, оно понадобится для настройки Harbor.

  1. Создайте OIDC-приложение:

     ```bash
     yc organization-manager idp application oauth application create \
       --organization-id <идентификатор_организации> \
       --name harbor-oidc-app \
       --description "OIDC-приложение для интеграции с Harbor" \
       --client-id <идентификатор_OAuth-клиента> \
       --authorized-scopes openid,email,profile,groups \
       --group-distribution-type assigned-groups
     ```

     Где:

     * `--organization-id` — [идентификатор организации](../../../organization/operations/organization-get-id.md), в которой нужно создать OIDC-приложение. Обязательный параметр.
     * `--name` — имя OIDC-приложения. Обязательный параметр.
     * `--description` — описание OIDC-приложения. Необязательный параметр.
     * `--client-id` — идентификатор OAuth-клиента, полученный на втором шаге. Обязательный параметр.
     * `--authorized-scopes` — укажите те же атрибуты, которые были указаны при создании OAuth-клиента.
     * `--group-distribution-type` — укажите `assigned-groups`, чтобы передавать в Harbor только группы, добавленные в приложение.

     Результат:

     ```text
     id: ek0o663g4rs2********
     name: harbor-oidc-app
     organization_id: bpf2c65rqcl8********
     group_claims_settings:
       group_distribution_type: ASSIGNED_GROUPS
     client_grant:
       client_id: ajeqqip130i1********
       authorized_scopes:
         - openid
         - email
         - profile
         - groups
     status: ACTIVE
     created_at: "2025-10-21T10:51:28.790866Z"
     updated_at: "2025-10-21T12:37:19.274522Z"
     ```

{% endlist %}

## Настройте интеграцию {#setup-integration}

Чтобы настроить интеграцию Harbor с созданным OIDC-приложением в {{ org-full-name }}, выполните действия на стороне {{ org-full-name }} и Harbor.

Проверьте, что URL Harbor (портал и реестр) доступен по HTTPS с доверенным сертификатом: это требуется для корректных OIDC-перенаправлений.

### Настройте OIDC-приложение на стороне {{ org-full-name }} {#setup-idp}

#### Получите учетные данные приложения {#get-credentials}

{% list tabs group=instructions %}

- Интерфейс {{ cloud-center }} {#cloud-center}

  1. Войдите в сервис [{{ org-full-name }}]({{ link-org-cloud-center }}).
  1. На панели слева выберите ![shapes-4](../../../_assets/console-icons/shapes-4.svg) **{{ ui-key.yacloud_org.pages.apps }}** и выберите нужное OIDC-приложение.
  1. На вкладке **{{ ui-key.yacloud_org.organization.apps.AppPageLayout.overview_b5LJQ }}** в блоке **{{ ui-key.yacloud_org.application.overview.idp_section_title }}** разверните секцию **{{ ui-key.yacloud_org.application.overview.idp_section_closed_text }}** и скопируйте значения параметров, которые необходимо задать на стороне Harbor:

        * `{{ ui-key.yacloud_org.application.overview.oauth_field_client_id }}` — уникальный идентификатор приложения.
        * `{{ ui-key.yacloud_org.application.overview.oauth_field_open_id }}` — URL с конфигурацией всех необходимых для настройки интеграции параметров.

  1. В блоке **{{ ui-key.yacloud_org.application.overview.secret_section_title }}** нажмите кнопку **{{ ui-key.yacloud_org.application.overview.secret_section_add_new_secret_action }}** и в открывшемся окне:
     
     1. (Опционально) Добавьте произвольное описание создаваемого секрета.
     1. Нажмите **{{ ui-key.yacloud.common.create }}**.
     
     В окне отобразится сгенерированный [секрет приложения](../../../organization/concepts/applications.md#oidc-secret). Сохраните полученное значение.
     
     {% note warning %}
     
     После обновления или закрытия страницы с информацией о приложении посмотреть секрет будет невозможно.
     
     {% endnote %}
     
     Если вы закрыли или обновили страницу, не сохранив сгенерированный секрет, используйте кнопку **{{ ui-key.yacloud_org.application.overview.secret_section_add_new_secret_action }}**, чтобы создать новый.
     
     Чтобы удалить секрет, в списке секретов на странице OIDC-приложения в строке с нужным секретом нажмите значок ![ellipsis](../../../_assets/console-icons/ellipsis.svg) и выберите ![trash-bin](../../../_assets/console-icons/trash-bin.svg) **{{ ui-key.yacloud.common.delete }}**.

- CLI {#cli}

  Если у вас еще нет интерфейса командной строки {{ yandex-cloud }} (CLI), [установите и инициализируйте его](../../../cli/quickstart.md#install).

  По умолчанию используется каталог, указанный при [создании](../../../cli/operations/profile/profile-create.md) профиля CLI. Чтобы изменить каталог по умолчанию, используйте команду `yc config set folder-id <идентификатор_каталога>`. Также для любой команды вы можете указать другой каталог с помощью параметров `--folder-name` или `--folder-id`. Если вы обращаетесь к ресурсу по имени, поиск будет выполнен в каталоге по умолчанию. Если вы обращаетесь к ресурсу по идентификатору, поиск будет выполнен глобально — во всех каталогах с учетом прав доступа.

  1. Получите информацию о созданном OIDC-приложении:

     ```bash
     yc organization-manager idp application oauth application get <идентификатор_приложения>
     ```

     Где `<идентификатор_приложения>` — это ID OIDC-приложения, полученный при создании.

     В результате вы получите информацию о приложении, включая:

     ```text
     id: ek0o663g4rs2********
     name: harbor-oidc-app
     organization_id: bpf2c65rqcl8********
     client_grant:
       client_id: ajeqqip130i1********
       authorized_scopes:
         - openid
         - email
         - profile
         - groups
     ```

     Сохраните значение `client_id` — это Client ID для настройки Harbor.

  1. Получите URL с конфигурацией OpenID Connect Discovery:

     ```bash
     yc organization-manager idp application oauth application get <идентификатор_приложения> \
       --format json | jq -r '.client_grant.issuer_uri'
     ```

     Результат будет выглядеть так:

     ```text
     https://{{ auth-main-host }}/oauth/<идентификатор_OAuth-клиента>
     ```

     Сохраните этот URL для проверки доступности OpenID Connect Discovery. В поле **OIDC Provider Endpoint** в Harbor укажите базовый адрес провайдера: `https://{{ auth-main-host }}` (без суффикса `/.well-known/openid-configuration`).

  1. Используйте секрет OAuth-клиента, который был сохранен при создании приложения на предыдущем шаге. Если вы не сохранили секрет, создайте новый:

     ```bash
     yc iam oauth-client-secret create \
       --oauth-client-id <идентификатор_OAuth-клиента>
     ```

     Сохраните значение `secret_value` из результата команды — это Client Secret для настройки Harbor.

{% endlist %}

#### Настройте Redirect URI {#setup-redirect}

{% list tabs group=instructions %}

- Интерфейс {{ cloud-center }} {#cloud-center}

  1. Войдите в сервис [{{ org-full-name }}]({{ link-org-cloud-center }}).
  1. На панели слева выберите ![shapes-4](../../../_assets/console-icons/shapes-4.svg) **{{ ui-key.yacloud_org.pages.apps }}** и выберите нужное OIDC-приложение.
  1. Справа сверху нажмите ![pencil](../../../_assets/console-icons/pencil.svg) **{{ ui-key.yacloud.common.edit }}** и в открывшемся окне:
      1. В поле **{{ ui-key.yacloud_org.application.overview.oauth_field_redirect_uri }}** укажите эндпоинт в формате:

         ```text
         https://<домен_Harbor>/c/oidc/callback
         ```

      1. В поле **{{ ui-key.yacloud_org.organization.apps.OauthAppEditForm.field-scopes_hEuar }}** отметьте атрибут `{{ ui-key.yacloud_org.organization.apps.OauthAppEditForm.oauth-scope-groups_iZoa5 }}` и выберите `{{ ui-key.yacloud_org.organization.apps.field_group_assigned_amGdu }}`.

      1. Нажмите **{{ ui-key.yacloud.common.save }}**.

- CLI {#cli}

  Обновите OAuth-клиент, указав Redirect URI:

  ```bash
  yc iam oauth-client update \
    --id <идентификатор_OAuth-клиента> \
    --redirect-uris "https://<домен_Harbor>/c/oidc/callback"
  ```

  Где:

  * `<идентификатор_OAuth-клиента>` — идентификатор OAuth-клиента, полученный при его создании.
  * `--redirect-uris` — эндпоинт callback Harbor, например `https://reg.example.com/c/oidc/callback`.

  Результат:

  ```text
  id: ajeiu3otac08********
  name: harbor-oauth-client
  redirect_uris:
    - https://reg.example.com/c/oidc/callback
  scopes:
    - openid
    - email
    - profile
    - groups
  folder_id: b1gkd6dks6i1********
  status: ACTIVE
  ```

{% endlist %}

### Настройте Harbor {#setup-sp}

Выполняйте действия на стороне Harbor под учетной записью системного администратора.

#### Установите Harbor

1. Если у вас еще нет реестра Harbor, установите его на виртуальной машине: заранее установите Docker Engine версии `20.10.10` или выше и плагин `docker compose`. Инструкции по установке Docker для Ubuntu см. в [официальной документации Docker](https://docs.docker.com/engine/install/ubuntu/).
1. Подключитесь к VM по SSH, перейдите в каталог распакованного установщика Harbor и убедитесь, что Docker и `docker compose` доступны:

   ```bash
   docker --version
   docker compose version
   ```

1. Создайте файл конфигурации из шаблона:

   ```bash
   cp harbor.yml.tmpl harbor.yml
   ```

1. Откройте `harbor.yml` и задайте обязательные параметры:

   * `hostname` — FQDN VM, по которому будет доступен Harbor. Для OIDC рекомендуется использовать именно доменное имя.
   * `harbor_admin_password` — пароль администратора Harbor.
   * `database.password` — пароль локальной БД Harbor.
   * параметры секции `https` (`port`, `certificate`, `private_key`) — укажите пути к сертификату и ключу для доступа к Harbor по TLS.

   Подробнее о параметрах файла см. в руководстве Harbor: [Configure the Harbor YML File](https://goharbor.io/docs/main/install-config/configure-yml-file/).

1. Настройте внешний TLS для Harbor:

   Укажите путь к сертификату в `harbor.yml`. Подробная инструкция: [Configure HTTPS Access to Harbor](https://goharbor.io/docs/main/install-config/configure-https/).

1. (Опционально) Включите внутренний TLS между компонентами Harbor через секцию `internal_tls` в `harbor.yml`.

   Этот шаг рекомендуется для продуктивных установок с повышенными требованиями к защите внутреннего трафика. Подробнее: [Configure Internal TLS communication between Harbor Component](https://goharbor.io/docs/main/install-config/configure-internal-tls/).

1. Запустите установку Harbor из каталога установщика:

   ```bash
   sudo ./install.sh
   ```

   Подробнее: [Run the Installer Script](https://goharbor.io/docs/main/install-config/run-installer-script/).

1. Войдите в веб-интерфейс Harbor под учетной записью администратора.

#### Настройте аутентификацию

{% note info %}

Чтобы переключить Harbor на режим **OIDC**, в базе Harbor не должно быть учетных записей пользователей, кроме встроенной учетной записи администратора (после первого входа администратора это правило продолжает действовать: достаточно отсутствия прочих локальных пользователей). Подробнее см. [документацию Harbor по режиму OIDC](https://goharbor.io/docs/latest/administration/configure-authentication/oidc-auth/).

{% endnote %}

Перед настройкой OIDC убедитесь, что веб-интерфейс доступен по HTTPS. Это обязательное условие: Harbor использует callback URL вида `https://<домен_Harbor>/c/oidc/callback`.

1. Откройте раздел **Administration** и перейдите в **Configuration**.
1. Откройте вкладку **Authentication**.
1. В поле **Auth Mode** выберите **OIDC**.
1. Заполните поля провайдера OIDC:

    * **OIDC Provider Name** — произвольное имя кнопки входа, например `{{ org-full-name }}`.
    * **OIDC Provider Endpoint** — базовый адрес провайдера OIDC: `https://{{ auth-main-host }}`. Если вы копируете значение из поля **{{ ui-key.yacloud_org.application.overview.oauth_field_open_id }}**, удалите из него суффикс `/.well-known/openid-configuration`.
    * **OIDC Client ID** — значение **{{ ui-key.yacloud_org.application.overview.oauth_field_client_id }}**.
    * **OIDC Client Secret** — сохраненный ранее секрет OAuth-клиента.
    * **OIDC Scope** — укажите через запятую: `openid,profile,email,groups`.
    * **Verify Certificate** — оставьте включенным, если сертификат поставщика удостоверений доверенный для Harbor.

1. Если вы планируете передавать группы из {{ org-full-name }} в Harbor:

    * В поле **Group Claim Name** укажите `groups`.
    * При необходимости задайте **OIDC Admin Group** и **OIDC Group Filter** в соответствии с [документацией Harbor](https://goharbor.io/docs/latest/administration/configure-authentication/oidc-auth/).

1. (Опционально) Включите **Automatic onboarding**, если не хотите вручную задавать имя пользователя Harbor при первом входе. В поле **Username Claim** укажите утверждение из ID-токена, которое будет использоваться как логин (рекомендуется `preferred_username`; при необходимости можно использовать `email`. Согласуйте выбранное значение с атрибутами, которые выдает {{ org-full-name }}).

1. Убедитесь, что значение **Redirect URI** внизу страницы совпадает с тем, что вы указали в OIDC-приложении в {{ org-full-name }} (`https://<домен_Harbor>/c/oidc/callback`).

1. Нажмите **Test OIDC Server** и убедитесь, что проверка проходит без ошибок.

1. Нажмите **Save**.

Подробнее о полях и ограничениях режима OIDC см. [официальное руководство Harbor](https://goharbor.io/docs/latest/administration/configure-authentication/oidc-auth/).

### Добавьте пользователя {#add-user}

Чтобы пользователи организации входили в Harbor через OIDC-приложение {{ org-full-name }}, явно добавьте в приложение нужных пользователей и/или [группы пользователей](../../../organization/concepts/groups.md).

{% note info %}

Управлять пользователями и группами, добавленными в OIDC-приложение, может пользователь, которому назначена [роль](../../../organization/security/index.md#organization-manager-oidcApplications-userAdmin) `organization-manager.oidcApplications.userAdmin` или выше.

{% endnote %}

Добавьте пользователя в приложение:

{% list tabs group=instructions %}

- Интерфейс {{ cloud-center }} {#cloud-center}

    1. Войдите в сервис [{{ org-full-name }}]({{ link-org-cloud-center }}).
    1. На панели слева выберите ![shapes-4](../../../_assets/console-icons/shapes-4.svg) **{{ ui-key.yacloud_org.pages.apps }}** и выберите нужное приложение.
    1. Перейдите на вкладку **{{ ui-key.yacloud_org.organization.apps.AppPageLayout.assignments_kKzJS }}**.
    1. Нажмите ![person-plus](../../../_assets/console-icons/person-plus.svg) **{{ ui-key.yacloud_org.organization.apps.AppAssignmentsPage.action_add-assignments }}**.
    1. В открывшемся окне выберите нужного пользователя или группу пользователей.
    1. Нажмите **{{ ui-key.yacloud.common.add }}**.

- CLI {#cli}

  Если у вас еще нет интерфейса командной строки {{ yandex-cloud }} (CLI), [установите и инициализируйте его](../../../cli/quickstart.md#install).

  По умолчанию используется каталог, указанный при [создании](../../../cli/operations/profile/profile-create.md) профиля CLI. Чтобы изменить каталог по умолчанию, используйте команду `yc config set folder-id <идентификатор_каталога>`. Также для любой команды вы можете указать другой каталог с помощью параметров `--folder-name` или `--folder-id`. Если вы обращаетесь к ресурсу по имени, поиск будет выполнен в каталоге по умолчанию. Если вы обращаетесь к ресурсу по идентификатору, поиск будет выполнен глобально — во всех каталогах с учетом прав доступа.

  1. Получите [идентификатор пользователя](../../../organization/operations/users-get.md) или [группы пользователей](../../../organization/operations/group-get-id.md).

  1. Чтобы добавить в приложение пользователя или группу пользователей:

     1. Посмотрите описание команды CLI для добавления пользователей в приложение:

        ```bash
        yc organization-manager idp application oauth application add-assignments --help
        ```

     1. Выполните команду:

        ```bash
        yc organization-manager idp application oauth application add-assignments \
          --id <идентификатор_приложения> \
          --subject-id <идентификатор_пользователя_или_группы>
        ```

        Где:

        * `--id` — идентификатор OIDC-приложения.
        * `--subject-id` — идентификатор нужного пользователя или группы пользователей.

        Результат:

        ```text
        assignment_deltas:
          - action: ADD
            assignment:
              subject_id: ajetvnq2mil8********
        ```

{% endlist %}

## Убедитесь в корректной работе приложения {#validate}

Чтобы проверить работу OIDC-приложения и интеграции с Harbor, выполните вход в Harbor от имени пользователя, добавленного в приложение.

Для этого:

1. В браузере перейдите по адресу вашего экземпляра Harbor (например, `https://<домен_Harbor>`).
1. Если вы уже авторизованы в Harbor, выйдите из учетной записи.
1. На странице входа нажмите кнопку входа через OIDC (текст соответствует значению поля **OIDC Provider Name** в Harbor).
1. На странице аутентификации {{ yandex-cloud }} укажите email и пароль пользователя. Пользователь должен быть добавлен в приложение или состоять в группе, добавленной в приложение.
1. Убедитесь, что вы успешно вошли в Harbor.
1. При необходимости откройте профиль пользователя в Harbor и проверьте членство в группах, если вы настроили передачу групп.