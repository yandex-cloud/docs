# Создать SAML-приложение в Yandex Identity Hub для интеграции с Jenkins

[Jenkins](https://www.jenkins.io/) — программная система с открытым исходным кодом на Java, предназначенная для обеспечения процесса непрерывной интеграции программного обеспечения.

Чтобы пользователи вашей [организации](../../../../organization/concepts/organization.md) могли аутентифицироваться в Jenkins с помощью технологии единого входа по стандарту [SAML](https://ru.wikipedia.org/wiki/SAML), создайте [SAML-приложение](../../../../organization/concepts/applications/saml.md) в Yandex Identity Hub и настройте его на стороне Yandex Identity Hub и на стороне Jenkins.

Управлять SAML-приложениями может пользователь, которому назначена [роль](../../../../organization/security/index.md#organization-manager-samlApplications-admin) `organization-manager.samlApplications.admin` или выше.

{% note info %}

Для интеграции с помощью SAML для вашего экземпляра Jenkins должен быть настроен корректный SSL-сертификат.

{% endnote %}

Чтобы дать доступ пользователям вашей организации в Jenkins:

1. [Создайте приложение в Yandex Identity Hub](#create-app).
1. [Настройте интеграцию](#setup-integration).
1. [Убедитесь в корректной работе приложения](#validate).

## Создайте приложение в Yandex Identity Hub {#create-app}

{% list tabs group=instructions %}

- Интерфейс Cloud Center {#cloud-center}

   1. Войдите в сервис [Yandex Identity Hub](https://center.yandex.cloud/organization).
   1. На панели слева выберите ![shapes-4](../../../../_assets/console-icons/shapes-4.svg) **Приложения**.
   1. В правом верхнем углу страницы нажмите ![Circles3Plus](../../../../_assets/console-icons/circles-3-plus.svg) **Создать приложение** и в открывшемся окне:
      1. Выберите метод единого входа **SAML (Security Assertion Markup Language)**.
      1. В поле **Имя** задайте имя создаваемого приложения: `jenkins-saml`.

      1. (Опционально) В поле **Описание** задайте описание приложения.
      1. (Опционально) Добавьте [метки](../../../../resource-manager/concepts/labels.md):

         1. Нажмите **Добавить метку**.
         1. Введите метку в формате `ключ: значение`.
         1. Нажмите **Enter**.
      1. Нажмите **Создать приложение**.
   1. Сохраните значение поля **Metadata URL**, оно понадобится на следующем шаге.

{% endlist %}

## Настройте интеграцию {#setup-integration}

### Установите плагин SAML в Jenkins {#install-saml-plugin}

Чтобы настроить аутентификацию в Jenkins с помощью SAML, установите плагин SAML:

1. Войдите в Jenkins под пользователем с правами администратора.
1. В меню слева выберите **Manage Jenkins** > **Plugins**.
1. Перейдите на вкладку **Available** и в строке поиска введите `SAML`.
1. Найдите плагин [**SAML Plugin**](https://plugins.jenkins.io/saml) и установите его, нажав **Install**.
1. Дождитесь завершения установки и перезапустите Jenkins, если это потребуется.

После установки плагина в разделе **Manage Jenkins** > **Security** появится новый вариант **Security Realm** – `SAML 2.0`.

### Настройте SAML-приложение на стороне Yandex Identity Hub {#setup-idp}

#### Настройте эндпоинты поставщика услуг {#sp-endpoints}

{% list tabs group=instructions %}

- Интерфейс Cloud Center {#cloud-center}

  1. Войдите в сервис [Yandex Identity Hub](https://center.yandex.cloud/organization).
  1. На панели слева выберите ![shapes-4](../../../../_assets/console-icons/shapes-4.svg) **Приложения** и выберите нужное SAML-приложение.
  1. Справа сверху нажмите ![pencil](../../../../_assets/console-icons/pencil.svg) **Редактировать** и в открывшемся окне:  
      1. В поле **SP EntityID** вставьте любое значение, например `<адрес_инстанса_jenkins>/`.
      1. В поле **ACS URL** вставьте значение `<адрес_инстанса_jenkins>/securityRealm/finishLogin`.
      1. (Опционально) В поле **SP Logout URL** вставьте значение `<адрес_инстанса_jenkins>/securityRealm/finishLogin`.
      1. Нажмите **Сохранить**.

{% endlist %}

### Настройте аутентификацию на стороне Jenkins {#setup-sp}

1. Войдите в Jenkins под пользователем с правами администратора.
1. В меню слева выберите **Manage Jenkins** > **Security**.
1. В разделе **Security Realm** выберите `SAML 2.0`.
1. В поле **IdP Metadata URL** введите адрес файла с метаданными, скопированный ранее.
1. В поле **Display Name Attribute** введите `fullname`.
1. В поле **Username Attribute** введите `preferred_username`.
1. В поле **Email Attribute** введите `emailaddress`.
1. Включите опцию **Advanced Configuration** и в поле **SP Entity ID** введите значение, которое вы указали в поле **SP EntityID** на стороне Yandex Identity Hub, например `<адрес_инстанса_jenkins>/`.
1. Нажмите **Save**.

### Настройте атрибуты пользователей {#user-attributes}

Добавьте пользователям атрибут `preferred_username`, который будет использоваться в качестве имени пользователя при аутентификации в Jenkins. Для этого:

{% list tabs group=instructions %}

- Интерфейс Cloud Center {#cloud-center}

    1. Войдите в сервис [Yandex Identity Hub](https://center.yandex.cloud/organization).
    1. На панели слева выберите ![shapes-4](../../../../_assets/console-icons/shapes-4.svg) **Приложения** и выберите нужное приложение.
    1. Перейдите на вкладку **Атрибуты**.
    1. В правом верхнем углу страницы нажмите ![plus](../../../../_assets/console-icons/plus.svg) **Добавить атрибут** и в открывшемся окне:

        1. В поле **Имя атрибута** введите `preferred_username`.
        1. В поле **Значение** выберите `SubjectClaims.preferred_username`.
        1. Нажмите **Добавить**.

{% endlist %}

Подробнее о настройке атрибутов смотрите в разделе [Настройте атрибуты пользователей и групп](../../../../organization/operations/applications/saml-create.md#setup-attributes).

### Добавьте пользователя {#add-user}

Чтобы пользователи вашей организации могли аутентифицироваться в Jenkins с помощью SAML-приложения Yandex Identity Hub, необходимо явно добавить в SAML-приложение нужных пользователей и/или [группы пользователей](../../../../organization/concepts/groups.md).

{% note info %}

Управлять пользователями и группами, добавленными в SAML-приложение, может пользователь, которому назначена [роль](../../../../organization/security/index.md#organization-manager-samlApplications-userAdmin) `organization-manager.samlApplications.userAdmin` или выше.

{% endnote %}

1. Добавьте пользователей в приложение:

   {% list tabs group=instructions %}

   - Интерфейс Cloud Center {#cloud-center}

      1. Войдите в сервис [Yandex Identity Hub](https://center.yandex.cloud/organization).
      1. На панели слева выберите ![shapes-4](../../../../_assets/console-icons/shapes-4.svg) **Приложения** и выберите нужное приложение.
      1. Перейдите на вкладку **Пользователи и группы**.
      1. Нажмите ![person-plus](../../../../_assets/console-icons/person-plus.svg) **Добавить пользователей**.
      1. В открывшемся окне выберите нужного пользователя или группу пользователей.
      1. Нажмите **Добавить**.

   {% endlist %}

{% note tip %}

Если вы хотите более тонко настроить аутентификацию пользователей в приложениях, в том числе разрешить аутентификацию только с определенных IP-адресов, используйте [политики аутентификации](*authentication_policies).

{% endnote %}

[*authentication_policies]: Политики аутентификации — это инструмент Yandex Identity Hub, позволяющий гибко настраивать доступ к приложениям, запрещая или разрешая аутентификацию определенным пользователям в определенных приложениях и/или с определенных IP-адресов. Подробнее читайте в разделе [Политики аутентификации в Yandex Identity Hub](../../../../organization/concepts/authentication-policy.md).

## Убедитесь в корректной работе приложения {#validate}

Чтобы убедиться в корректной работе SAML-приложения и интеграции с Jenkins, выполните аутентификацию в Jenkins от имени одного из добавленных в приложение пользователей. Для этого:

1. В браузере перейдите по адресу вашего экземпляра Jenkins.
1. Вы будете перенаправлены на страницу аутентификации Yandex Cloud. Укажите почту и пароль пользователя, которого вы добавили в приложение. Также у пользователя должна быть указана почта.
1. Убедитесь, что вы аутентифицировались в Jenkins.