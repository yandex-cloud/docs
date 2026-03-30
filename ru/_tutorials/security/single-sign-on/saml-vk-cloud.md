# Создать SAML-приложение в {{ org-full-name }} для интеграции с VK Cloud

[VK Cloud](https://cloud.vk.com/) — российская облачная платформа, предоставляющая IaaS- и PaaS-сервисы, инструменты для работы с данными и AI/ML, а также решения для построения облачной инфраструктуры. VK Cloud поддерживает аутентификацию пользователей через федерацию удостоверений по стандарту [SAML](https://ru.wikipedia.org/wiki/SAML).

Чтобы пользователи вашей [организации](../../../organization/concepts/organization.md) могли аутентифицироваться в VK Cloud с помощью технологии единого входа по стандарту SAML, создайте [SAML-приложение](../../../organization/concepts/applications.md#saml) в {{ org-full-name }} и настройте его на стороне {{ yandex-cloud }} и на стороне VK Cloud.

{% include [saml-app-admin-role](../../../_includes/organization/saml-app-admin-role.md) %}

Чтобы дать доступ пользователям вашей организации в VK Cloud:

1. [Создайте приложение](#create-app).
1. [Настройте интеграцию](#setup-integration).
1. [Добавьте пользователей и настройте права](#add-users).
1. [Убедитесь в корректной работе приложения](#validate).

## Создайте приложение {#create-app}

{% list tabs group=instructions %}

- Интерфейс {{ cloud-center }} {#cloud-center}

    1. Войдите в сервис [{{ org-full-name }}]({{ link-org-cloud-center }}).
    1. На панели слева выберите ![shapes-4](../../../_assets/console-icons/shapes-4.svg) **{{ ui-key.yacloud_org.pages.apps }}**.
    1. В правом верхнем углу страницы нажмите ![Circles3Plus](../../../_assets/console-icons/circles-3-plus.svg) **{{ ui-key.yacloud_org.action.applications.components.create-app }}** и в открывшемся окне:
        1. Выберите метод единого входа **{{ ui-key.yacloud_org.organization.apps.AppCreateForm.saml-title_kyofk }}**.
        1. В поле **{{ ui-key.yacloud_org.organization.apps.AppCreateForm.field-name_1VbM1 }}** задайте имя создаваемого приложения: `vkcloud-saml`.

        1. (Опционально) В поле **{{ ui-key.yacloud_org.organization.apps.AppCreateForm.field-description_kzkNB }}** задайте описание приложения.
        1. (Опционально) Добавьте [метки](../../../resource-manager/concepts/labels.md):

            1. Нажмите **{{ ui-key.yacloud.component.label-set.button_add-label }}**.
            1. Введите метку в формате `ключ: значение`.
            1. Нажмите **Enter**.
        1. Нажмите **{{ ui-key.yacloud_org.organization.apps.AppCreateForm.create-app-submit_myxPn }}**.

{% endlist %}

## Настройте интеграцию {#setup-integration}

Чтобы настроить интеграцию VK Cloud с созданным SAML-приложением в {{ org-full-name }}, выполните настройки на стороне VK Cloud и на стороне {{ org-full-name }}.

### Настройте федерацию удостоверений на стороне VK Cloud {#setup-sp}

{% note info %}

Создать федерацию удостоверений в VK Cloud может только владелец проекта.

{% endnote %}

1. Получите метаданные для [созданного ранее приложения](#create-app):

    1. Войдите в сервис [{{ org-full-name }}]({{ link-org-cloud-center }}).
    1. На панели слева выберите ![shapes-4](../../../_assets/console-icons/shapes-4.svg) **{{ ui-key.yacloud_org.pages.apps }}** и выберите нужное SAML-приложение.
    1. На вкладке **{{ ui-key.yacloud_org.organization.apps.AppPageLayout.overview_b5LJQ }}** в блоке **{{ ui-key.yacloud_org.application.overview.idp_section_title }}** нажмите кнопку **{{ ui-key.yacloud_org.application.overview.idp_section_download_metadata_action }}**.

      Скачанный [XML](https://ru.wikipedia.org/wiki/XML)-файл содержит необходимые метаданные и сертификат, который используется для проверки подписи SAML-ответов.

1. Создайте федерацию удостоверений в VK Cloud, используя метаданные {{ org-full-name }}:

    1. Перейдите в [аккаунт VK Cloud](https://cloud.vk.com/account).
    1. Откройте раздел **Федерация удостоверений** и перейдите на вкладку **Федерации**.
    1. Нажмите **Создать**.
    1. Нажмите **Загрузить метаданные IdP** и загрузите XML-файл метаданных, который вы скачали в {{ org-full-name }}.
    1. Нажмите **Загрузить**.

1. В данных созданной федерации скопируйте и сохраните ID федерации. Он понадобится для настройки SAML-приложения в {{ org-full-name }} и для входа федеративных пользователей.

### Настройте SAML-приложение на стороне {{ org-full-name }} {#setup-idp}

#### Настройте эндпоинты поставщика услуг {#sp-endpoints}

{% list tabs group=instructions %}

- Интерфейс {{ cloud-center }} {#cloud-center}

    1. Войдите в сервис [{{ org-full-name }}]({{ link-org-cloud-center }}).
    1. На панели слева выберите ![shapes-4](../../../_assets/console-icons/shapes-4.svg) **{{ ui-key.yacloud_org.pages.apps }}** и выберите нужное SAML-приложение.
    1. Справа сверху нажмите ![pencil](../../../_assets/console-icons/pencil.svg) **{{ ui-key.yacloud.common.edit }}** и в открывшемся окне:
        1. В поле **{{ ui-key.yacloud_org.organization.apps.SamlAppEditForm.field-sp-entity-id_snAsX }}** укажите адрес `https://msk.cloud.vk.com/federation-service/v1/federation/saml/<ID_федерации>/metadata`, где `<ID_федерации>` — ID федерации, который вы скопировали при [создании федерации в VK Cloud](#setup-sp).
        1. В поле **{{ ui-key.yacloud_org.organization.apps.SamlAppEditForm.field-acs-urls_eQcJr }}** укажите адрес `https://msk.cloud.vk.com/federation-service/v1/federation/saml/<ID_федерации>/acs`.
        1. Нажмите **{{ ui-key.yacloud.common.save }}**.

{% endlist %}

#### Настройте атрибуты пользователей {#user-attributes}

{% note warning %}

Для корректной работы федерации в VK Cloud имена SAML-атрибутов нужно указывать с URI-префиксами: для пользовательских атрибутов — `http://schemas.xmlsoap.org/ws/2005/05/identity/claims/`, для группового — `http://schemas.xmlsoap.org/claims/`.
Без этих префиксов (и при изменении регистра, например `Group`) сопоставление атрибутов в VK Cloud может не работать.

{% endnote %}

Настройте атрибуты пользователей для интеграции с VK Cloud:

{% list tabs group=instructions %}

- Интерфейс {{ cloud-center }} {#cloud-center}

    1. Войдите в сервис [{{ org-full-name }}]({{ link-org-cloud-center }}).
    1. На панели слева выберите ![shapes-4](../../../_assets/console-icons/shapes-4.svg) **{{ ui-key.yacloud_org.pages.apps }}** и выберите нужное приложение.
    1. Перейдите на вкладку **{{ ui-key.yacloud_org.organization.apps.AppPageLayout.attributes_to71e }}**.
    1. Убедитесь, что атрибуты настроены следующим образом:

        Атрибут | Значение
        --- | ---
        `http://schemas.xmlsoap.org/ws/2005/05/identity/claims/emailaddress` | `SubjectClaims.email`
        `http://schemas.xmlsoap.org/ws/2005/05/identity/claims/name` | `SubjectClaims.firstName`
        `http://schemas.xmlsoap.org/ws/2005/05/identity/claims/surname` | `SubjectClaims.lastName`

    1. Если вы планируете использовать маппинг групп, добавьте атрибут для передачи групп:

        1. Нажмите **{{ ui-key.yacloud_org.attributes.update_dialog.field_attribute_name }}**.
        1. В поле **{{ ui-key.yacloud_org.attributes.update_dialog.field_attribute_name }}** введите `http://schemas.xmlsoap.org/claims/Group`.
        1. В поле **{{ ui-key.yacloud_org.attributes.update_dialog.field_attribute_value }}** укажите `SubjectClaims.groups`.
        1. Нажмите **{{ ui-key.yacloud.common.save }}**.

{% endlist %}

## Добавьте пользователей и настройте права {#add-users}

Чтобы предоставить пользователям вашей организации доступ к аутентификации в VK Cloud через SAML-приложение в {{ org-full-name }}, добавьте их в приложение и настройте права доступа в VK Cloud.

{% note info %}

Управлять пользователями и группами, добавленными в SAML-приложение, может пользователь, которому назначена [роль](../../../organization/security/index.md#organization-manager-samlApplications-userAdmin) `organization-manager.samlApplications.userAdmin` или выше.

{% endnote %}

### Добавьте пользователей в SAML-приложение {{ org-full-name }} {#add-app-users}

{% list tabs group=instructions %}

- Интерфейс {{ cloud-center }} {#cloud-center}

    1. Войдите в сервис [{{ org-full-name }}]({{ link-org-cloud-center }}).
    1. На панели слева выберите ![shapes-4](../../../_assets/console-icons/shapes-4.svg) **{{ ui-key.yacloud_org.pages.apps }}** и выберите нужное приложение.
    1. Перейдите на вкладку **{{ ui-key.yacloud_org.organization.apps.AppPageLayout.assignments_kKzJS }}**.
    1. Нажмите ![person-plus](../../../_assets/console-icons/person-plus.svg) **{{ ui-key.yacloud_org.organization.apps.AppAssignmentsPage.action_add-assignments }}**.
    1. В открывшемся окне выберите требуемых пользователей.
    1. Нажмите **{{ ui-key.yacloud.common.add }}**.

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
1. Аутентифицируйтесь в {{ yandex-cloud }} под учетной записью пользователя из вашей организации.
1. Убедитесь, что после успешной аутентификации вы вошли в VK Cloud.
