# Создать SAML-приложение в {{ org-full-name }} для интеграции с Zabbix

{% include [note-preview](../../../_includes/note-preview.md) %}

[Zabbix](https://www.zabbix.com/) — это система мониторинга корпоративного уровня с открытым исходным кодом для отслеживания производительности и состояния серверов, сетей, приложений и других ИТ-ресурсов. Zabbix поддерживает SAML-аутентификацию для обеспечения безопасного единого входа пользователей организации.

Чтобы пользователи вашей [организации](../../../organization/concepts/organization.md) могли аутентифицироваться в Zabbix с помощью технологии единого входа по стандарту [SAML](https://ru.wikipedia.org/wiki/SAML), создайте [SAML-приложение](../../../organization/concepts/applications.md#saml) в {{ org-name }} и настройте его на стороне {{ org-name }} и на стороне Zabbix.

{% include [saml-app-admin-role](../../../_includes/organization/saml-app-admin-role.md) %}

Чтобы дать доступ пользователям вашей организации в Zabbix:

1. [Создайте приложение](#create-app).
1. [Настройте интеграцию](#setup-integration).
1. [Убедитесь в корректной работе приложения](#validate).

## Создайте приложение {#create-app}

{% list tabs group=instructions %}

- Интерфейс {{ cloud-center }} {#cloud-center}

    1. Войдите в сервис [{{ org-full-name }}]({{ link-org-cloud-center }}).
    1. На панели слева выберите ![shapes-4](../../../_assets/console-icons/shapes-4.svg) **{{ ui-key.yacloud_org.pages.apps }}**.
    1. В правом верхнем углу страницы нажмите ![Circles3Plus](../../../_assets/console-icons/circles-3-plus.svg) **{{ ui-key.yacloud_org.action.applications.components.create-app }}** и в открывшемся окне:
        1. Выберите метод единого входа **{{ ui-key.yacloud_org.organization.apps.AppCreateForm.saml-title_kyofk }}**.
        1. В поле **{{ ui-key.yacloud_org.organization.apps.AppCreateForm.field-name_1VbM1 }}** задайте имя создаваемого приложения: `zabbix-app`.

        1. (Опционально) В поле **{{ ui-key.yacloud_org.organization.apps.AppCreateForm.field-description_kzkNB }}** задайте описание приложения.
        1. (Опционально) Добавьте [метки](../../../resource-manager/concepts/labels.md):

            1. Нажмите **{{ ui-key.yacloud.component.label-set.button_add-label }}**.
            1. Введите метку в формате `ключ: значение`.
            1. Нажмите **Enter**.
        1. Нажмите **{{ ui-key.yacloud_org.organization.apps.AppCreateForm.create-app-submit_myxPn }}**.

{% endlist %}

## Настройте интеграцию {#setup-integration}

Чтобы настроить интеграцию Zabbix с созданным SAML-приложением в {{ org-name }}, выполните настройки на стороне Zabbix и на стороне {{ org-name }}.

### Настройте SAML-приложение на стороне Zabbix {#setup-sp}

{% note info %}

Настройку SAML-приложения в Zabbix может проводить пользователь с ролью **Super admin role**. 

{% endnote %}

#### Настройте аутентификацию по стандарту SAML на стороне Zabbix {#setup-za}

1. Чтобы настроить аутентификацию по стандарту SAML на стороне Zabbix, в левой панели выберите раздел **Users** и в нем подраздел **Authentication**.
1. В основном окне перейдите на вкладку **SAML Settings**. После открытия формы выполните указанные ниже шаги:

    1. Активируйте опцию **Enable SAML authentication**.
    1. Активируйте опцию **Enable JIT provisioning**.

        {% note info %}

        Опция **Enable JIT provisioning** отвечает за автоматическое создание пользователей на стороне Zabbix при аутентификации через SSO. Если опция неактивна, пройти аутентификацию смогут только пользователи, уже созданные на стороне Zabbix. 

        {% endnote %}

    1. Настройте связь между Zabbix и {{ org-name }}:

        1. Войдите в сервис [{{ org-full-name }}]({{ link-org-cloud-center }}).
        1. На панели слева выберите ![shapes-4](../../../_assets/console-icons/shapes-4.svg) **{{ ui-key.yacloud_org.pages.apps }}** и выберите нужное SAML-приложение.
        1. На вкладке **{{ ui-key.yacloud_org.organization.apps.AppPageLayout.overview_b5LJQ }}** в блоке **{{ ui-key.yacloud_org.application.overview.idp_section_title }}** скопируйте значения полей: **{{ ui-key.yacloud_org.application.overview.saml_field_issuer }}**, **{{ ui-key.yacloud_org.application.overview.saml_field_login }}** и **{{ ui-key.yacloud_org.application.overview.saml_field_logout }}**.
        1. Вернитесь в Zabbix и вставьте скопированные адреса в поля: **IdP entity ID**, **SSO service URL** и **SLO service URL**. 

            {% note info %}

            Если не указать адрес для **SLO service URL**, то после выхода из Zabbix пользователь будет перенаправлен не на форму аутентификации {{ org-name }}, а на форму Zabbix.

            {% endnote %}

    1. В поле **Username attribute** укажите `login`.

        {% note info %}

        Атрибут, используемый в качестве имени пользователя при аутентификации в Zabbix. Название атрибута может быть произвольным, но обязательно должно совпадать с названием атрибута пользователя, содержащего значение `SubjectClaims.preferred_username` в вашем приложении {{ org-name }}.

        {% endnote %}

    1. В поле **SP entity ID** укажите `zabbix`.
    
        {% note warning %}

        Значение **SP entity ID** должно полностью совпадать как в Zabbix, так и в вашем приложении {{ org-name }}. 
        
        {% endnote %}

    1. В блоках **Sign** и **Encrypt** оставьте все опции неактивированными.
    
        {% note tip %}

        На текущий момент {{ org-full-name }} не поддерживает проверку подписей запросов, поэтому рекомендуется оставить опции блоков **Sign** и **Encrypt** неактивированными.

        {% endnote %}

    1. Активируйте опцию **Case-sensitive login**, если требуется учет регистра символов в логине.

    1. Если опция **Enable JIT provisioning** была включена, настройте параметры автоматического создания пользователей в Zabbix. Для этого активируйте опцию **Configure JIT provisioning** и выполните следующие шаги:

        1. В поле **Group name attribute** укажите `groups` — этот атрибут определяет группу пользователей в вашем приложении {{ org-name }}, обеспечивающую доступ к Zabbix.

        1. В поле **User name attribute** укажите `givenname`.

        1. В поле **User last name attribute** укажите `surname`.
         
        1. В блоке **User group mapping** сопоставьте группу пользователей вашего приложения {{ org-name }} с соответствующей группой и ролью в Zabbix. Это позволит новым пользователям автоматически получать назначенную группу и роль в Zabbix. Для этого нажмите **Add** и выполните следующие шаги:

            1. В поле **SAML group pattern** задайте шаблон для поиска названий групп SAML-приложения.

                {% note info %}

                Поле **SAML group pattern** поддерживает подстановочные знаки с символом `*`. 
                
                {% endnote %}

            1. В поле **User groups** укажите группы Zabbix, в которые будут автоматически добавляться новые пользователи при первой аутентификации. 
            
            1. В поле **User role** укажите роль Zabbix, которая будет присваиваться пользователям при первом входе в систему. 

        1. При необходимости в блоке **Media type mapping** настройте сопоставление атрибутов пользователя вашего SAML-приложения для получения уведомлений от Zabbix (опционально).

        1. Опцию **Enable SCIM provisioning** оставьте неактивированной.

            {% note tip %}

            На текущий момент {{ org-full-name }} не поддерживает протокол SCIM для автоматического управления пользователями в других приложениях, поэтому рекомендуется оставить опцию **Enable SCIM provisioning** неактивированной.

            {% endnote %}

1. В основном окне перейдите на вкладку **Authentication**. После открытия формы в поле **Deprovisioned users group** выберите группу `Disabled`.

    {% note warning %}

    Если включена опция **Enable JIT provisioning**, на вкладке **Authentication** обязательно должна быть указана группа **Deprovisioned users group**. В эту группу будут перемещаться деактивированные пользователи.

    {% endnote %}

1. Сохраните настройки, нажав кнопку **Update**.

#### Перенесите сертификат SAML-приложения и настройте Zabbix {#setup-zc}

Чтобы перенести сертификат SAML-приложения и настроить Zabbix, выполните следующие шаги:

1. Скачайте сертификат провайдера идентификации (IdP):

    1. Войдите в сервис [{{ org-full-name }}]({{ link-org-cloud-center }}).
    1. На панели слева выберите ![shapes-4](../../../_assets/console-icons/shapes-4.svg) **{{ ui-key.yacloud_org.pages.apps }}** и выберите нужное SAML-приложение.
    1. На вкладке **{{ ui-key.yacloud_org.organization.apps.AppPageLayout.overview_b5LJQ }}** в блоке **{{ ui-key.yacloud_org.application.overview.certificate_section_title }}** нажмите на кнопку **{{ ui-key.yacloud_org.application.overview.certificate_action_download_cert }}** и сохраните файл на своем устройстве.

1. Скопируйте полученный файл сертификата в каталог `/usr/share/zabbix/ui/conf/certs` на сервере Zabbix. 
1. Настройте права доступа.
    ```bash
    chmod 644 /usr/share/zabbix/ui/conf/certs/<your_cert>.crt
    ```
1. Откройте конфигурационный файл Zabbix `/usr/share/zabbix/ui/conf/zabbix.conf.php` и укажите путь к сертификату IdP.
    ```php
    $SSO['IDP_CERT'] = 'conf/certs/<your_cert>.crt';
    ```

### Настройте SAML-приложение на стороне {{ org-full-name }} {#setup-idp}

#### Настройте эндпоинты поставщика услуг {#sp-endpoints}

{% list tabs group=instructions %}

- Интерфейс {{ cloud-center }} {#cloud-center}

  1. Войдите в сервис [{{ org-full-name }}]({{ link-org-cloud-center }}).
  1. На панели слева выберите ![shapes-4](../../../_assets/console-icons/shapes-4.svg) **{{ ui-key.yacloud_org.pages.apps }}** и выберите нужное SAML-приложение.
  1. Справа сверху нажмите ![pencil](../../../_assets/console-icons/pencil.svg) **{{ ui-key.yacloud.common.edit }}** и в открывшемся окне:  
      1. В поле **{{ ui-key.yacloud_org.organization.apps.SamlAppEditForm.field-sp-entity-id_snAsX }}** укажите `zabbix`.
      1. В поле **{{ ui-key.yacloud_org.organization.apps.SamlAppEditForm.field-acs-urls_eQcJr }}** укажите адрес `https://<your-domain>/zabbix/index_sso.php?acs`.
      1. Нажмите **{{ ui-key.yacloud.common.save }}**.

{% endlist %}

#### Настройте атрибуты пользователей {#user-attributes}

{% note warning %}

Для интеграции с Zabbix необходимо, чтобы у пользователей был атрибут `login`.

{% endnote %}

Если у пользователей нет атрибута `login`, добавьте его:

{% list tabs group=instructions %}

- Интерфейс {{ cloud-center }} {#cloud-center}

    1. Войдите в сервис [{{ org-full-name }}]({{ link-org-cloud-center }}).
    1. На панели слева выберите ![shapes-4](../../../_assets/console-icons/shapes-4.svg) **{{ ui-key.yacloud_org.pages.apps }}** и выберите нужное приложение.
    1. Перейдите на вкладку **{{ ui-key.yacloud_org.organization.apps.AppPageLayout.attributes_to71e }}**.
    1. В правом верхнем углу страницы нажмите ![plus](../../../_assets/console-icons/plus.svg) **{{ ui-key.yacloud_org.organization.apps.AppPageLayout.action_add_attribute }}** и в открывшемся окне:

        1. В поле **{{ ui-key.yacloud_org.attributes.update_dialog.field_attribute_name }}** введите `login`.
        1. В поле **{{ ui-key.yacloud_org.attributes.update_dialog.field_attribute_value }}** выберите `SubjectClaims.preferred_username`.
        1. Нажмите **{{ ui-key.yacloud.common.add }}**.

{% endlist %}

Если вы настроили автоматическую регистрацию пользователей на стороне Zabbix, добавьте атрибут группы пользователей. Для этого:

{% list tabs group=instructions %}

- Интерфейс {{ cloud-center }} {#cloud-center}

    1. В правом верхнем углу страницы нажмите ![circles-3-plus](../../../_assets/console-icons/circles-3-plus.svg) **{{ ui-key.yacloud_org.organization.apps.AppPageLayout.action_add_group_attribute }}** и в открывшемся окне:
    1. В поле **{{ ui-key.yacloud_org.attributes.update_dialog.field_attribute_name }}** укажите `groups`.
    1. В поле **{{ ui-key.yacloud_org.attributes.update_dialog.field_group_attribute_value }}** выберите `{{ ui-key.yacloud_org.field-data.attributes.update_dialog.field_group_assigned }}`.
    1. Нажмите **{{ ui-key.yacloud.common.add }}**.

{% endlist %}

Подробнее о настройке атрибутов см. [Настройте атрибуты пользователей и групп](../../../organization/operations/applications/saml-create.md#setup-attributes).

### Добавьте пользователей {#add-users}

Чтобы пользователи вашей организации могли аутентифицироваться в Zabbix с помощью SAML-приложения {{ org-name }}, необходимо явно добавить в ваше SAML-приложение нужных пользователей и/или [группы пользователей](../../../organization/concepts/groups.md).

{% note info %}

Управлять пользователями и группами, добавленными в SAML-приложение, может пользователь, которому назначена [роль](../../../organization/security/index.md#organization-manager-samlApplications-userAdmin) `organization-manager.samlApplications.userAdmin` или выше.

{% endnote %}

1. Если вы настроили автоматическую регистрацию пользователей на стороне Zabbix, [создайте](../../../organization/operations/create-group.md) необходимую [группу](../../../organization/concepts/groups.md):

    {% list tabs group=instructions %}

    - Интерфейс {{ cloud-center }} {#cloud-center}

        1. Войдите в сервис [{{ org-full-name }}]({{ link-org-cloud-center }}).
        1. На панели слева выберите ![groups](../../../_assets/console-icons/persons.svg) **{{ ui-key.yacloud_org.pages.groups }}**.
        1. В правом верхнем углу страницы нажмите ![Circles3Plus](../../../_assets/console-icons/circles-3-plus.svg) **{{ ui-key.yacloud_org.entity.group.action_create }}**.
        1. Задайте название `zabbix-users`.
        1. Нажмите **{{ ui-key.yacloud_org.groups.action_create-group }}**.
        1. Добавьте пользователей в группу:
            1. Перейдите на вкладку **{{ ui-key.yacloud_org.entity.group.title_tab-members }}**.  
            1. Нажмите **{{ ui-key.yacloud_org.entity.group.action_add-member }}**.
            1. В открывшемся окне выберите нужных пользователей.
            1. Нажмите **{{ ui-key.yacloud_org.component.subject-select-dialog.action_apply }}**.

    {% endlist %}
 
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

Чтобы убедиться в корректной работе SAML-приложения и интеграции с Zabbix, выполните аутентификацию в Zabbix от имени одного из добавленных в приложение пользователей. Для этого:

1. В браузере перейдите по адресу вашего экземпляра Zabbix (например, `https://<your-domain>/zabbix/`).
1. Если вы были авторизованы в Zabbix, выйдите из профиля.
1. На странице аутентификации Zabbix нажмите **Sign in with Single Sign-On (SAML)**.
1. На странице аутентификации {{ yandex-cloud }} укажите адрес электронной почты и пароль пользователя. Пользователь должен быть добавлен в приложение или состоять в группе, добавленной в приложение.
1. Убедитесь, что вы авторизовались в Zabbix.
