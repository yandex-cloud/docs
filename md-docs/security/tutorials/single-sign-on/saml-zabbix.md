[Документация Yandex Cloud](../../../index.md) > [Безопасность в Yandex Cloud](../../index.md) > [Практические руководства](../index.md) > Настройка SSO > Настройка единого входа в Zabbix по стандарту SAML

# Создать SAML-приложение в Yandex Identity Hub для интеграции с Zabbix

[Zabbix](https://www.zabbix.com/) — это система мониторинга корпоративного уровня с открытым исходным кодом для отслеживания производительности и состояния серверов, сетей, приложений и других ИТ-ресурсов. Zabbix поддерживает SAML-аутентификацию для обеспечения безопасного единого входа пользователей организации.

Чтобы пользователи вашей [организации](../../../organization/concepts/organization.md) могли аутентифицироваться в Zabbix с помощью технологии единого входа по стандарту [SAML](https://ru.wikipedia.org/wiki/SAML), создайте [SAML-приложение](../../../organization/concepts/applications/saml.md) в Yandex Identity Hub и настройте его на стороне Yandex Identity Hub и на стороне Zabbix.

Управлять SAML-приложениями может пользователь, которому назначена [роль](../../../organization/security/index.md#organization-manager-samlApplications-admin) `organization-manager.samlApplications.admin` или выше.

Чтобы дать доступ пользователям вашей организации в Zabbix:

1. [Создайте приложение](#create-app).
1. [Настройте интеграцию](#setup-integration).
1. [Убедитесь в корректной работе приложения](#validate).

## Создайте приложение {#create-app}

{% list tabs group=instructions %}

- Интерфейс Cloud Center {#cloud-center}

    1. Войдите в сервис [Yandex Identity Hub](https://center.yandex.cloud/organization).
    1. На панели слева выберите ![shapes-4](../../../_assets/console-icons/shapes-4.svg) **Приложения**.
    1. В правом верхнем углу страницы нажмите ![Circles3Plus](../../../_assets/console-icons/circles-3-plus.svg) **Создать приложение** и в открывшемся окне:
        1. Выберите метод единого входа **SAML (Security Assertion Markup Language)**.
        1. В поле **Имя** задайте имя создаваемого приложения: `zabbix-app`.

        1. (Опционально) В поле **Описание** задайте описание приложения.
        1. (Опционально) Добавьте [метки](../../../resource-manager/concepts/labels.md):

            1. Нажмите **Добавить метку**.
            1. Введите метку в формате `ключ: значение`.
            1. Нажмите **Enter**.
        1. Нажмите **Создать приложение**.

{% endlist %}

## Настройте интеграцию {#setup-integration}

Чтобы настроить интеграцию Zabbix с созданным SAML-приложением в Yandex Identity Hub, выполните настройки на стороне Zabbix и на стороне Yandex Identity Hub.

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

    1. Настройте связь между Zabbix и Yandex Identity Hub:

        1. Войдите в сервис [Yandex Identity Hub](https://center.yandex.cloud/organization).
        1. На панели слева выберите ![shapes-4](../../../_assets/console-icons/shapes-4.svg) **Приложения** и выберите нужное SAML-приложение.
        1. На вкладке **Обзор** в блоке **Конфигурация поставщика удостоверений (IdP)** скопируйте значения полей: **Issuer / IdP EntityID**, **Login URL** и **Logout URL**.
        1. Вернитесь в Zabbix и вставьте скопированные адреса в поля: **IdP entity ID**, **SSO service URL** и **SLO service URL**. 

            {% note info %}

            Если не указать адрес для **SLO service URL**, то после выхода из Zabbix пользователь будет перенаправлен не на форму аутентификации Yandex Identity Hub, а на форму Zabbix.

            {% endnote %}

    1. В поле **Username attribute** укажите `login`.

        {% note info %}

        Атрибут, используемый в качестве имени пользователя при аутентификации в Zabbix. Название атрибута может быть произвольным, но обязательно должно совпадать с названием атрибута пользователя, содержащего значение `SubjectClaims.preferred_username` в вашем приложении Yandex Identity Hub.

        {% endnote %}

    1. В поле **SP entity ID** укажите `zabbix`.
    
        {% note warning %}

        Значение **SP entity ID** должно полностью совпадать как в Zabbix, так и в вашем приложении Yandex Identity Hub. 
        
        {% endnote %}

    1. В блоках **Sign** и **Encrypt** оставьте все опции неактивированными.
    
        {% note tip %}

        На текущий момент Yandex Identity Hub не поддерживает проверку подписей запросов, поэтому рекомендуется оставить опции блоков **Sign** и **Encrypt** неактивированными.

        {% endnote %}

    1. Активируйте опцию **Case-sensitive login**, если требуется учет регистра символов в логине.

    1. Если опция **Enable JIT provisioning** была включена, настройте параметры автоматического создания пользователей в Zabbix. Для этого активируйте опцию **Configure JIT provisioning** и выполните следующие шаги:

        1. В поле **Group name attribute** укажите `groups` — этот атрибут определяет группу пользователей в вашем приложении Yandex Identity Hub, обеспечивающую доступ к Zabbix.

        1. В поле **User name attribute** укажите `givenname`.

        1. В поле **User last name attribute** укажите `surname`.
         
        1. В блоке **User group mapping** сопоставьте группу пользователей вашего приложения Yandex Identity Hub с соответствующей группой и ролью в Zabbix. Это позволит новым пользователям автоматически получать назначенную группу и роль в Zabbix. Для этого нажмите **Add** и выполните следующие шаги:

            1. В поле **SAML group pattern** задайте шаблон для поиска названий групп SAML-приложения.

                {% note info %}

                Поле **SAML group pattern** поддерживает подстановочные знаки с символом `*`. 
                
                {% endnote %}

            1. В поле **User groups** укажите группы Zabbix, в которые будут автоматически добавляться новые пользователи при первой аутентификации. 
            
            1. В поле **User role** укажите роль Zabbix, которая будет присваиваться пользователям при первом входе в систему. 

        1. При необходимости в блоке **Media type mapping** настройте сопоставление атрибутов пользователя вашего SAML-приложения для получения уведомлений от Zabbix (опционально).

        1. Опцию **Enable SCIM provisioning** оставьте неактивированной.

            {% note tip %}

            На текущий момент Yandex Identity Hub не поддерживает протокол SCIM для автоматического управления пользователями в других приложениях, поэтому рекомендуется оставить опцию **Enable SCIM provisioning** неактивированной.

            {% endnote %}

1. В основном окне перейдите на вкладку **Authentication**. После открытия формы в поле **Deprovisioned users group** выберите группу `Disabled`.

    {% note warning %}

    Если включена опция **Enable JIT provisioning**, на вкладке **Authentication** обязательно должна быть указана группа **Deprovisioned users group**. В эту группу будут перемещаться деактивированные пользователи.

    {% endnote %}

1. Сохраните настройки, нажав кнопку **Update**.

#### Перенесите сертификат SAML-приложения и настройте Zabbix {#setup-zc}

Чтобы перенести сертификат SAML-приложения и настроить Zabbix, выполните следующие шаги:

1. Скачайте сертификат провайдера идентификации (IdP):

    1. Войдите в сервис [Yandex Identity Hub](https://center.yandex.cloud/organization).
    1. На панели слева выберите ![shapes-4](../../../_assets/console-icons/shapes-4.svg) **Приложения** и выберите нужное SAML-приложение.
    1. На вкладке **Обзор** в блоке **Сертификат приложения** нажмите на кнопку **Скачать сертификат** и сохраните файл на своем устройстве.

1. Скопируйте полученный файл сертификата в каталог `/usr/share/zabbix/ui/conf/certs` на сервере Zabbix. 
1. Настройте права доступа.
    ```bash
    chmod 644 /usr/share/zabbix/ui/conf/certs/<your_cert>.crt
    ```
1. Откройте конфигурационный файл Zabbix `/usr/share/zabbix/ui/conf/zabbix.conf.php` и укажите путь к сертификату IdP.
    ```php
    $SSO['IDP_CERT'] = 'conf/certs/<your_cert>.crt';
    ```

### Настройте SAML-приложение на стороне Yandex Identity Hub {#setup-idp}

#### Настройте эндпоинты поставщика услуг {#sp-endpoints}

{% list tabs group=instructions %}

- Интерфейс Cloud Center {#cloud-center}

  1. Войдите в сервис [Yandex Identity Hub](https://center.yandex.cloud/organization).
  1. На панели слева выберите ![shapes-4](../../../_assets/console-icons/shapes-4.svg) **Приложения** и выберите нужное SAML-приложение.
  1. Справа сверху нажмите ![pencil](../../../_assets/console-icons/pencil.svg) **Редактировать** и в открывшемся окне:  
      1. В поле **SP EntityID** укажите `zabbix`.
      1. В поле **ACS URL** укажите адрес `https://<your-domain>/zabbix/index_sso.php?acs`.
      1. Нажмите **Сохранить**.

{% endlist %}

#### Настройте атрибуты пользователей {#user-attributes}

{% note warning %}

Для интеграции с Zabbix необходимо, чтобы у пользователей был атрибут `login`.

{% endnote %}

Если у пользователей нет атрибута `login`, добавьте его:

{% list tabs group=instructions %}

- Интерфейс Cloud Center {#cloud-center}

    1. Войдите в сервис [Yandex Identity Hub](https://center.yandex.cloud/organization).
    1. На панели слева выберите ![shapes-4](../../../_assets/console-icons/shapes-4.svg) **Приложения** и выберите нужное приложение.
    1. Перейдите на вкладку **Атрибуты**.
    1. В правом верхнем углу страницы нажмите ![plus](../../../_assets/console-icons/plus.svg) **Добавить атрибут** и в открывшемся окне:

        1. В поле **Имя атрибута** введите `login`.
        1. В поле **Значение** выберите `SubjectClaims.preferred_username`.
        1. Нажмите **Добавить**.

{% endlist %}

Если вы настроили автоматическую регистрацию пользователей на стороне Zabbix, добавьте атрибут группы пользователей. Для этого:

{% list tabs group=instructions %}

- Интерфейс Cloud Center {#cloud-center}

    1. В правом верхнем углу страницы нажмите ![circles-3-plus](../../../_assets/console-icons/circles-3-plus.svg) **Добавить атрибут группы** и в открывшемся окне:
    1. В поле **Имя атрибута** укажите `groups`.
    1. В поле **Передаваемые группы** выберите `Только назначенные группы`.
    1. Нажмите **Добавить**.

{% endlist %}

Подробнее о настройке атрибутов смотрите в разделе [Настройте атрибуты пользователей и групп](../../../organization/operations/applications/saml-create.md#setup-attributes).

### Добавьте пользователей {#add-users}

Чтобы пользователи вашей организации могли аутентифицироваться в Zabbix с помощью SAML-приложения Yandex Identity Hub, необходимо явно добавить в ваше SAML-приложение нужных пользователей и/или [группы пользователей](../../../organization/concepts/groups.md).

{% note info %}

Управлять пользователями и группами, добавленными в SAML-приложение, может пользователь, которому назначена [роль](../../../organization/security/index.md#organization-manager-samlApplications-userAdmin) `organization-manager.samlApplications.userAdmin` или выше.

{% endnote %}

1. Если вы настроили автоматическую регистрацию пользователей на стороне Zabbix, [создайте](../../../organization/operations/create-group.md) необходимую [группу](../../../organization/concepts/groups.md):

    {% list tabs group=instructions %}

    - Интерфейс Cloud Center {#cloud-center}

        1. Войдите в сервис [Yandex Identity Hub](https://center.yandex.cloud/organization).
        1. На панели слева выберите ![groups](../../../_assets/console-icons/persons.svg) **Группы**.
        1. В правом верхнем углу страницы нажмите ![Circles3Plus](../../../_assets/console-icons/circles-3-plus.svg) **Создать группу**.
        1. Задайте название `zabbix-users`.
        1. Нажмите **Создать группу**.
        1. Добавьте пользователей в группу:
            1. Перейдите на вкладку **Участники**.  
            1. Нажмите **Добавить участника**.
            1. В открывшемся окне выберите нужных пользователей.
            1. Нажмите **Сохранить**.

    {% endlist %}
 
1. Добавьте пользователей в приложение:

    {% list tabs group=instructions %}

    - Интерфейс Cloud Center {#cloud-center}

        1. Войдите в сервис [Yandex Identity Hub](https://center.yandex.cloud/organization).
        1. На панели слева выберите ![shapes-4](../../../_assets/console-icons/shapes-4.svg) **Приложения** и выберите нужное приложение.
        1. Перейдите на вкладку **Пользователи и группы**.
        1. Нажмите ![person-plus](../../../_assets/console-icons/person-plus.svg) **Добавить пользователей**.
        1. В открывшемся окне выберите нужного пользователя или группу пользователей.
        1. Нажмите **Добавить**.

    {% endlist %}

{% note tip %}

Если вы хотите более тонко настроить аутентификацию пользователей в приложениях, в том числе разрешить аутентификацию только с определенных IP-адресов, используйте [политики аутентификации](*authentication_policies).

{% endnote %}

[*authentication_policies]: Политики аутентификации — это инструмент Yandex Identity Hub, позволяющий гибко настраивать доступ к приложениям, запрещая или разрешая аутентификацию определенным пользователям в определенных приложениях и/или с определенных IP-адресов. Подробнее читайте в разделе [Политики аутентификации в Yandex Identity Hub](../../../organization/concepts/authentication-policy.md).

## Убедитесь в корректной работе приложения {#validate}

Чтобы убедиться в корректной работе SAML-приложения и интеграции с Zabbix, выполните аутентификацию в Zabbix от имени одного из добавленных в приложение пользователей. Для этого:

1. В браузере перейдите по адресу вашего экземпляра Zabbix (например, `https://<your-domain>/zabbix/`).
1. Если вы были авторизованы в Zabbix, выйдите из профиля.
1. На странице аутентификации Zabbix нажмите **Sign in with Single Sign-On (SAML)**.
1. На странице аутентификации Yandex Cloud укажите адрес электронной почты и пароль пользователя. Пользователь должен быть добавлен в приложение или состоять в группе, добавленной в приложение.
1. Убедитесь, что вы аутентифицировались в Zabbix.