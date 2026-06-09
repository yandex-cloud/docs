# Создать SAML-приложение в Yandex Identity Hub для интеграции с VK Cloud

[VK Cloud](https://cloud.vk.com/) — российская облачная платформа, предоставляющая IaaS- и PaaS-сервисы, инструменты для работы с данными и AI/ML, а также решения для построения облачной инфраструктуры. VK Cloud поддерживает аутентификацию пользователей через федерацию удостоверений по стандарту [SAML](https://ru.wikipedia.org/wiki/SAML).

Чтобы пользователи вашей [организации](../../../organization/concepts/organization.md) могли аутентифицироваться в VK Cloud с помощью технологии единого входа по стандарту SAML, создайте [SAML-приложение](../../../organization/concepts/applications.md#saml) в Yandex Identity Hub и настройте его на стороне Yandex Cloud и на стороне VK Cloud.

Управлять SAML-приложениями может пользователь, которому назначена [роль](../../../organization/security/index.md#organization-manager-samlApplications-admin) `organization-manager.samlApplications.admin` или выше.

Чтобы дать доступ пользователям вашей организации в VK Cloud:

1. [Создайте приложение](#create-app).
1. [Настройте интеграцию](#setup-integration).
1. [Добавьте пользователей и настройте права](#add-users).
1. [Убедитесь в корректной работе приложения](#validate).

## Создайте приложение {#create-app}

{% list tabs group=instructions %}

- Интерфейс Cloud Center {#cloud-center}

    1. Войдите в сервис [Yandex Identity Hub](https://center.yandex.cloud/organization).
    1. На панели слева выберите ![shapes-4](../../../_assets/console-icons/shapes-4.svg) **Приложения**.
    1. В правом верхнем углу страницы нажмите ![Circles3Plus](../../../_assets/console-icons/circles-3-plus.svg) **Создать приложение** и в открывшемся окне:
        1. Выберите метод единого входа **SAML (Security Assertion Markup Language)**.
        1. В поле **Имя** задайте имя создаваемого приложения: `vkcloud-saml`.

        1. (Опционально) В поле **Описание** задайте описание приложения.
        1. (Опционально) Добавьте [метки](../../../resource-manager/concepts/labels.md):

            1. Нажмите **Добавить метку**.
            1. Введите метку в формате `ключ: значение`.
            1. Нажмите **Enter**.
        1. Нажмите **Создать приложение**.

{% endlist %}

## Настройте интеграцию {#setup-integration}

Чтобы настроить интеграцию VK Cloud с созданным SAML-приложением в Yandex Identity Hub, выполните настройки на стороне VK Cloud и на стороне Yandex Identity Hub.

### Настройте федерацию удостоверений на стороне VK Cloud {#setup-sp}

{% note info %}

Создать федерацию удостоверений в VK Cloud может только владелец проекта.

{% endnote %}

1. Получите метаданные для [созданного ранее приложения](#create-app):

    1. Войдите в сервис [Yandex Identity Hub](https://center.yandex.cloud/organization).
    1. На панели слева выберите ![shapes-4](../../../_assets/console-icons/shapes-4.svg) **Приложения** и выберите нужное SAML-приложение.
    1. На вкладке **Обзор** в блоке **Конфигурация поставщика удостоверений (IdP)** нажмите кнопку **Скачать файл с метаданными**.

      Скачанный [XML](https://ru.wikipedia.org/wiki/XML)-файл содержит необходимые метаданные и сертификат, который используется для проверки подписи SAML-ответов.

1. Создайте федерацию удостоверений в VK Cloud, используя метаданные Yandex Identity Hub:

    1. Перейдите в [аккаунт VK Cloud](https://cloud.vk.com/account).
    1. Откройте раздел **Федерация удостоверений** и перейдите на вкладку **Федерации**.
    1. Нажмите **Создать**.
    1. Нажмите **Загрузить метаданные IdP** и загрузите XML-файл метаданных, который вы скачали в Yandex Identity Hub.
    1. Нажмите **Загрузить**.

1. В данных созданной федерации скопируйте и сохраните ID федерации. Он понадобится для настройки SAML-приложения в Yandex Identity Hub и для входа федеративных пользователей.

### Настройте SAML-приложение на стороне Yandex Identity Hub {#setup-idp}

#### Настройте эндпоинты поставщика услуг {#sp-endpoints}

{% list tabs group=instructions %}

- Интерфейс Cloud Center {#cloud-center}

    1. Войдите в сервис [Yandex Identity Hub](https://center.yandex.cloud/organization).
    1. На панели слева выберите ![shapes-4](../../../_assets/console-icons/shapes-4.svg) **Приложения** и выберите нужное SAML-приложение.
    1. Справа сверху нажмите ![pencil](../../../_assets/console-icons/pencil.svg) **Редактировать** и в открывшемся окне:
        1. В поле **SP EntityID** укажите адрес `https://msk.cloud.vk.com/federation-service/v1/federation/saml/<ID_федерации>/metadata`, где `<ID_федерации>` — ID федерации, который вы скопировали при [создании федерации в VK Cloud](#setup-sp).
        1. В поле **ACS URL** укажите адрес `https://msk.cloud.vk.com/federation-service/v1/federation/saml/<ID_федерации>/acs`.
        1. Нажмите **Сохранить**.

{% endlist %}

#### Настройте атрибуты пользователей {#user-attributes}

{% note warning %}

Для корректной работы федерации в VK Cloud имена SAML-атрибутов нужно указывать с URI-префиксами: для пользовательских атрибутов — `http://schemas.xmlsoap.org/ws/2005/05/identity/claims/`, для группового — `http://schemas.xmlsoap.org/claims/`.
Без этих префиксов (и при изменении регистра, например `Group`) сопоставление атрибутов в VK Cloud может не работать.

{% endnote %}

Настройте атрибуты пользователей для интеграции с VK Cloud:

{% list tabs group=instructions %}

- Интерфейс Cloud Center {#cloud-center}

    1. Войдите в сервис [Yandex Identity Hub](https://center.yandex.cloud/organization).
    1. На панели слева выберите ![shapes-4](../../../_assets/console-icons/shapes-4.svg) **Приложения** и выберите нужное приложение.
    1. Перейдите на вкладку **Атрибуты**.
    1. Убедитесь, что атрибуты настроены следующим образом:

        Атрибут | Значение
        --- | ---
        `http://schemas.xmlsoap.org/ws/2005/05/identity/claims/emailaddress` | `SubjectClaims.email`
        `http://schemas.xmlsoap.org/ws/2005/05/identity/claims/name` | `SubjectClaims.firstName`
        `http://schemas.xmlsoap.org/ws/2005/05/identity/claims/surname` | `SubjectClaims.lastName`

    1. Если вы планируете использовать маппинг групп, добавьте атрибут для передачи групп:

        1. Нажмите **Имя атрибута**.
        1. В поле **Имя атрибута** введите `http://schemas.xmlsoap.org/claims/Group`.
        1. В поле **Значение** укажите `SubjectClaims.groups`.
        1. Нажмите **Сохранить**.

{% endlist %}

## Добавьте пользователей и настройте права {#add-users}

Чтобы предоставить пользователям вашей организации доступ к аутентификации в VK Cloud через SAML-приложение в Yandex Identity Hub, добавьте их в приложение и настройте права доступа в VK Cloud.

{% note info %}

Управлять пользователями и группами, добавленными в SAML-приложение, может пользователь, которому назначена [роль](../../../organization/security/index.md#organization-manager-samlApplications-userAdmin) `organization-manager.samlApplications.userAdmin` или выше.

{% endnote %}

### Добавьте пользователей в SAML-приложение Yandex Identity Hub {#add-app-users}

{% list tabs group=instructions %}

- Интерфейс Cloud Center {#cloud-center}

    1. Войдите в сервис [Yandex Identity Hub](https://center.yandex.cloud/organization).
    1. На панели слева выберите ![shapes-4](../../../_assets/console-icons/shapes-4.svg) **Приложения** и выберите нужное приложение.
    1. Перейдите на вкладку **Пользователи и группы**.
    1. Нажмите ![person-plus](../../../_assets/console-icons/person-plus.svg) **Добавить пользователей**.
    1. В открывшемся окне выберите требуемых пользователей.
    1. Нажмите **Добавить**.

{% endlist %}

### Настройте связь групп и ролей в VK Cloud {#vkcloud-groups-roles}

Чтобы определить права доступа федеративных пользователей в VK Cloud, настройте связь между группами IdP и ролями VK Cloud.

1. Перейдите в [аккаунт VK Cloud](https://cloud.vk.com/account).
1. Откройте раздел **Федерация удостоверений** и перейдите на вкладку **Группы**.
1. Выберите проект, для которого настраивается федерация.
1. Нажмите **Добавить** (или **Добавить группу**, если группы уже есть).
1. Укажите имя группы IdP в нижнем регистре и выберите уровень действия прав (**Домен** или **Проект**), затем назначьте роли.
1. Нажмите **Добавить**.

## Убедитесь в корректной работе приложения {#validate}

Чтобы проверить корректность работы SAML-приложения и интеграции с VK Cloud, выполните вход в VK Cloud под учетной записью одного из пользователей, добавленных в приложение.

Для этого:

1. В браузере откройте URL для входа федеративных пользователей: `https://cloud.vk.com/v1/federation/saml/<ID_федерации>/signin`, где `<ID_федерации>` — ID федерации, который вы скопировали при [создании федерации в VK Cloud](#setup-sp).
1. Аутентифицируйтесь в Yandex Cloud под учетной записью пользователя из вашей организации.
1. Убедитесь, что после успешной аутентификации вы вошли в VK Cloud.