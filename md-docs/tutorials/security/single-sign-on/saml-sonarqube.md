# Создать SAML-приложение в Yandex Identity Hub для интеграции с SonarQube

[SonarQube](https://www.sonarsource.com/products/sonarqube/) — это платформа для автоматического анализа качества исходного кода, которая выявляет ошибки, уязвимости и оценивает покрытие тестами. SonarQube поддерживает SAML-аутентификацию для обеспечения безопасного единого входа пользователей организации.

Чтобы пользователи вашей [организации](../../../organization/concepts/organization.md) могли аутентифицироваться в SonarQube с помощью технологии единого входа по стандарту [SAML](https://ru.wikipedia.org/wiki/SAML), создайте [SAML-приложение](../../../organization/concepts/applications/saml.md) в Yandex Identity Hub и настройте его на стороне Yandex Identity Hub и на стороне SonarQube.

Управлять SAML-приложениями может пользователь, которому назначена [роль](../../../organization/security/index.md#organization-manager-samlApplications-admin) `organization-manager.samlApplications.admin` или выше.

Чтобы дать доступ пользователям вашей организации в SonarQube:

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
        1. В поле **Имя** задайте имя создаваемого приложения: `sonarqube-app`.
        1. (Опционально) В поле **Описание** задайте описание приложения.
        1. (Опционально) Добавьте [метки](../../../resource-manager/concepts/labels.md):
            1. Нажмите **Добавить метку**.
            1. Введите метку в формате `ключ: значение`.
            1. Нажмите **Enter**.
        1. Нажмите **Создать приложение**.

{% endlist %}

## Настройте интеграцию {#setup-integration}

{% note info %}

Настройка SAML-интеграции доступна для SonarQube Developer Edition и выше. 

{% endnote %}

Чтобы настроить интеграцию SonarQube с созданным SAML-приложением в Yandex Identity Hub, выполните настройки на стороне SonarQube и на стороне Yandex Identity Hub.

### Настройте SAML-приложение на стороне SonarQube {#setup-sp}

{% note info %}

Настройку SAML-приложения в SonarQube может проводить пользователь с глобальным разрешением **Administer System**. 

{% endnote %}

1. Чтобы настроить аутентификацию по стандарту SAML на стороне SonarQube, в верхней панели выберите раздел **Administration**, после чего через появившееся меню перейдите в **Configuration** -> **General Settings**. В меню **General Settings** выберите раздел **Authentication** -> **SAML**.
1. Нажмите кнопку **Create configuration**.

Далее следуйте шагам, описанным ниже:

#### Подключите SonarQube к IdP {#connect-idp}

Настройте связь между SonarQube и Yandex Identity Hub:

1. Войдите в сервис [Yandex Identity Hub](https://center.yandex.cloud/organization).
1. На панели слева выберите ![shapes-4](../../../_assets/console-icons/shapes-4.svg) **Приложения** и выберите нужное SAML-приложение.
1. На вкладке **Обзор** в блоке **Конфигурация поставщика удостоверений (IdP)** скопируйте значения полей **Issuer / IdP EntityID** и **Login URL**.
1. На вкладке **Обзор** в блоке **Сертификат приложения** нажмите на кнопку **Скачать сертификат** и сохраните файл на своем устройстве.
1. Вернитесь в SonarQube, после чего в меню **Edit SAML configuration**:
    1. В поле **Application ID** оставьте значение по умолчанию — `sonarqube`.
    1. Вставьте скопированные значения в поля **Provider ID** и **SAML login url**.
    1. Откройте сохраненный файл сертификата в любом текстовом редакторе, скопируйте его содержимое и вставьте в поле **Identity provider certificate**.

#### Сопоставьте атрибуты пользователей {#user-mapping}

Настройте соответствие между полями объектов пользователей в SonarQube и Yandex Identity Hub:

1. В поле **SAML user login attribute** укажите `login`.
1. В поле **SAML user name attribute** укажите `fullname`.
1. (Опционально) В поле **SAML user email attribute** укажите `emailaddress`.
1. Если необходимо, чтобы пользователи в SonarQube при входе добавлялись в одну из групп, добавьте атрибут групп пользователей. Для этого в поле **SAML group attribute** укажите `groups`.
1. Сохраните настройки, нажав кнопку **Save configuration**.
1. Нажмите кнопку **Enable configuration**.

#### Установите публичный URL {#set-domain}

В меню **General Settings** перейдите из раздела **Authentication** в раздел **General**. В блоке **General** введите в поле **Server base URL** адрес `https://<your-domain>`.

#### Сопоставьте группы пользователей {#group-mapping}

{% note info %}

Если не настроить сопоставление групп, все пользователи будут при входе добавлены в группу по умолчанию — `sonar-users`.

{% endnote %}

Вы можете настроить, в какую группу будут добавлены пользователи при входе, для этого необходимо создать группы на стороне SonarQube:

1. Вверху страницы из раздела **Configuration** перейдите в **Security** -> **Groups**.
1. Нажмите кнопку **Create Group**.
1. В поле **Name** введите имя группы, например, `test-group`. Группу необходимо будет создать при настройке приложения на стороне Yandex Identity Hub.
1. Нажмите кнопку **Create**.
1. Чтобы настроить разрешения для группы:
    1. В меню **Security** перейдите из раздела **Groups** в раздел **Global Permissions**.
    1. Справа от группы `test-group` отметьте нужные разрешения.

### Настройте SAML-приложение на стороне Yandex Identity Hub {#setup-idp}

#### Настройте эндпоинты поставщика услуг {#sp-endpoints}

{% list tabs group=instructions %}

- Интерфейс Cloud Center {#cloud-center}

  1. Войдите в сервис [Yandex Identity Hub](https://center.yandex.cloud/organization).
  1. На панели слева выберите ![shapes-4](../../../_assets/console-icons/shapes-4.svg) **Приложения** и выберите нужное SAML-приложение.
  1. В правом верхнем углу нажмите ![pencil](../../../_assets/console-icons/pencil.svg) **Редактировать** и в открывшемся окне:  
      1. В поле **SP EntityID** укажите значение `sonarqube`.
      1. В поле **ACS URL** укажите адрес `https://<your-domain>/oauth2/callback/saml`.
      1. Нажмите **Сохранить**.

{% endlist %}

#### Настройте атрибуты пользователей {#user-attributes}

{% note warning %}

Для интеграции с SonarQube необходимо, чтобы у пользователей был атрибут `login`.

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

Если вы настроили сопоставление групп пользователей на стороне SonarQube, добавьте атрибут группы пользователей. Для этого:

{% list tabs group=instructions %}

- Интерфейс Cloud Center {#cloud-center}

    1. В правом верхнем углу страницы нажмите ![circles-3-plus](../../../_assets/console-icons/circles-3-plus.svg) **Добавить атрибут группы** и в открывшемся окне:
       1. В поле **Имя атрибута** укажите `groups`.
       1. В поле **Передаваемые группы** выберите `Только назначенные группы`.
       1. Нажмите **Добавить**.

{% endlist %}

Подробнее о настройке атрибутов смотрите [Настройте атрибуты пользователей и групп](../../../organization/operations/applications/saml-create.md#setup-attributes).

### Добавьте пользователей {#add-users}

Чтобы пользователи вашей организации могли аутентифицироваться в SonarQube с помощью SAML-приложения Yandex Identity Hub, необходимо явно добавить в ваше SAML-приложение нужных пользователей и/или [группы пользователей](../../../organization/concepts/groups.md).

{% note info %}

Управлять пользователями и группами, добавленными в SAML-приложение, может пользователь, которому назначена [роль](../../../organization/security/index.md#organization-manager-samlApplications-userAdmin) `organization-manager.samlApplications.userAdmin` или выше.

{% endnote %}

1. Если вы настроили сопоставление групп пользователей на стороне SonarQube, [создайте](../../../organization/operations/create-group.md) необходимую [группу](../../../organization/concepts/groups.md):

    {% list tabs group=instructions %}

    - Интерфейс Cloud Center {#cloud-center}

        1. Войдите в сервис [Yandex Identity Hub](https://center.yandex.cloud/organization).
        1. На панели слева выберите ![groups](../../../_assets/console-icons/persons.svg) **Группы**.
        1. В правом верхнем углу страницы нажмите ![Circles3Plus](../../../_assets/console-icons/circles-3-plus.svg) **Создать группу**.
        1. Задайте название `test-group`.
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

Чтобы убедиться в корректной работе SAML-приложения и интеграции с SonarQube, выполните аутентификацию в SonarQube от имени одного из добавленных в приложение пользователей. Для этого:

1. В браузере перейдите по адресу вашего экземпляра SonarQube (например, `https://<your-domain>`).
1. Если вы были авторизованы в SonarQube, выйдите из профиля.
1. На странице аутентификации SonarQube нажмите **Log in with SAML**.
1. На странице аутентификации Yandex Cloud укажите адрес электронной почты и пароль пользователя. Пользователь должен быть добавлен в приложение или состоять в группе, добавленной в приложение.
1. Убедитесь, что вы аутентифицировались в SonarQube.
1. Если вы настроили сопоставление групп, перейдите в профиль пользователя в SonarQube и убедитесь, что в блоке **Groups** отображается соответствующая группа.