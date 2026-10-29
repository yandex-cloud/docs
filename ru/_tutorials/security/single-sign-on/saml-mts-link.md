# Создать SAML-приложение в {{ org-full-name }} для интеграции с МТС Линк


[МТС Линк](https://mts-link.ru/) — платформа для онлайн-встреч, вебинаров и обучения. Вы можете настроить единый вход в МТС Линк по стандарту SAML: {{ org-full-name }} будет выступать поставщиком удостоверений (IdP), а МТС Линк — поставщиком услуг (SP).

Чтобы пользователи вашей [организации](*organization) могли входить в МТС Линк с помощью учетных записей {{ org-full-name }}:

1. [Перед началом работы](#before-you-begin).
1. [Создайте SAML-приложение](#create-app).
1. [Настройте поставщика удостоверений в МТС Линк](#setup-sp).
1. [Настройте приложение в {{ org-full-name }}](#setup-idp).
1. [Добавьте пользователей в приложение](#add-users).
1. [Настройте сопоставление групп](#setup-group-mapping) (опционально).
1. [Подтвердите домен и включите SSO в МТС Линк](#enable-sso).
1. [Проверьте единый вход](#validate).

## Перед началом работы {#before-you-begin}

Для настройки интеграции вам понадобятся:

* Организация в {{ org-full-name }}. Если у вас еще нет организации, [создайте ее](../../../organization/operations/enable-org.md).
* Учетная запись с доступом к настройкам SSO организации в МТС Линк.
* Домен электронной почты вашей организации, который вы сможете подтвердить в МТС Линк.
* Тестовый пользователь в {{ org-full-name }} с адресом электронной почты в этом домене. Если в организации нет подходящего пользователя, [добавьте его](../../../organization/operations/add-account.md). Проверьте, что в профиле пользователя заполнены адрес электронной почты, имя и фамилия.

{% include [saml-app-admin-role](../../../_includes/organization/saml-app-admin-role.md) %}

## Создайте SAML-приложение {#create-app}

{% list tabs group=instructions %}

- Интерфейс {{ cloud-center }} {#cloud-center}

    1. Войдите в сервис [{{ org-full-name }}]({{ link-org-cloud-center }}) и выберите нужную организацию.
    1. На панели слева выберите ![shapes-4](../../../_assets/console-icons/shapes-4.svg) **{{ ui-key.yacloud_org.pages.apps }}**.
    1. Нажмите ![circles-3-plus](../../../_assets/console-icons/circles-3-plus.svg) **{{ ui-key.yacloud_org.action.applications.components.create-app }}**.
    1. Выберите метод единого входа **{{ ui-key.yacloud_org.organization.apps.AppCreateForm.saml-title_kyofk }}**.
    1. В поле **{{ ui-key.yacloud_org.organization.apps.AppCreateForm.field-name_1VbM1 }}** задайте имя приложения: `mts-link-saml`.
    1. Нажмите **{{ ui-key.yacloud_org.organization.apps.AppCreateForm.create-app-submit_myxPn }}**.
    1. На странице созданного приложения в блоке **{{ ui-key.yacloud_org.application.overview.oauth_idp_section_title }}** скопируйте и сохраните значения полей:

        * **{{ ui-key.yacloud_org.application.overview.saml_field_issuer }}**;
        * **{{ ui-key.yacloud_org.application.overview.saml_field_login }}**;
        * **{{ ui-key.yacloud_org.application.overview.saml_field_logout }}**.

    1. В блоке **{{ ui-key.yacloud_org.application.overview.certificate_section_title }}** нажмите **{{ ui-key.yacloud_org.application.overview.certificate_action_download_cert }}**.

{% endlist %}

Сохраненные значения и сертификат понадобятся на следующем шаге — при настройке поставщика удостоверений в МТС Линк.

## Настройте поставщика удостоверений в МТС Линк {#setup-sp}

1. Войдите в МТС Линк с учетной записью, у которой есть доступ к настройкам SSO организации.
1. Откройте раздел **Настройки SSO** в настройках организации МТС Линк. Если организация размещена на отдельном поддомене, откройте адрес `https://<поддомен_организации>.mts-link.ru/business/sso-settings`, в остальных случаях — `https://my.mts-link.ru/business/sso-settings`.
1. В блоке **Выбор протокола и настройки провайдера идентификации** выберите:

    * **Протокол** — **SAML**.
    * **SSO провайдер** — **Active Directory**. Этот вариант используется для настройки интеграции с {{ org-full-name }}.

1. Заполните поля значениями, которые вы сохранили при [создании SAML-приложения](#create-app):

    #|
    || **Поле в МТС Линк** | **Значение из {{ org-full-name }}** ||
    || Идентификатор объекта (Identity Provider (IdP) Entity ID) | {{ ui-key.yacloud_org.application.overview.saml_field_issuer }} ||
    || URL Системы единого входа (Sign-in page URL) | {{ ui-key.yacloud_org.application.overview.saml_field_login }} ||
    || URL Системы единого выхода (Sign-out page URL) | {{ ui-key.yacloud_org.application.overview.saml_field_logout }} ||
    || Сертификат (Identity provider certificate) | Полное содержимое скачанного сертификата, включая строки `-----BEGIN CERTIFICATE-----` и `-----END CERTIFICATE-----` ||
    |#

1. Сохраните настройки. В блоке **Введите эти данные в провайдер SSO** появятся параметры МТС Линк. Скопируйте и сохраните значения:

    * **Идентификатор объекта (Entity ID)**;
    * **URL ACS**;
    * **URL SLS**.

Скопируйте значения целиком, включая все параметры URL. Они понадобятся на следующем шаге.

## Настройте приложение в {{ org-full-name }} {#setup-idp}

### Укажите параметры поставщика услуг {#setup-sp-settings}

{% list tabs group=instructions %}

- Интерфейс {{ cloud-center }} {#cloud-center}

    1. В [{{ org-full-name }}]({{ link-org-cloud-center }}) откройте раздел **{{ ui-key.yacloud_org.pages.apps }}** и выберите приложение `mts-link-saml`.
    1. Справа сверху нажмите ![pencil](../../../_assets/console-icons/pencil.svg) **{{ ui-key.yacloud.common.edit }}**.
    1. В блоке **{{ ui-key.yacloud_org.organization.apps.SamlAppEditForm.section-service-provider_83p1J }}** укажите значения, скопированные из МТС Линк:

        #|
        || **Поле в {{ org-full-name }}** | **Значение из МТС Линк** ||
        || {{ ui-key.yacloud_org.organization.apps.SamlAppEditForm.field-sp-entity-id_snAsX }} | Идентификатор объекта (Entity ID) ||
        || {{ ui-key.yacloud_org.organization.apps.SamlAppEditForm.field-acs-urls_eQcJr }} | URL ACS ||
        || {{ ui-key.yacloud_org.organization.apps.SamlAppEditForm.field-sp-logout-url_sLuRl }} | URL SLS ||
        |#

    1. В поле **{{ ui-key.yacloud_org.organization.apps.SamlAppEditForm.field-signature-mode_ipXQ7 }}** выберите **{{ ui-key.yacloud_org.organization.apps.SamlAppEditForm.signature-mode-response-and-assertions_u2j6T }}**.

        {% note warning %}

        Для интеграции с МТС Линк необходимо подписывать и SAML-ответ, и содержащиеся в нем утверждения. Используйте режим **Assertions and Response**.

        {% endnote %}

    1. В этой интеграции оставьте выключенными опции **{{ ui-key.yacloud_org.organization.apps.SamlAppEditForm.RequestSigningSection.field-request-signing }}** и **{{ ui-key.yacloud_org.organization.apps.SamlAppEditForm.EncryptResponseSection.field-encrypt-response }}**.
    1. Нажмите **{{ ui-key.yacloud.common.save }}**.

{% endlist %}

### Настройте атрибуты пользователей {#setup-attributes}

МТС Линк получает данные пользователя из [атрибутов SAML](../../../organization/concepts/applications/saml.md#saml-attributes). Настройте их в приложении:

{% list tabs group=instructions %}

- Интерфейс {{ cloud-center }} {#cloud-center}

    1. На странице приложения `mts-link-saml` перейдите на вкладку **{{ ui-key.yacloud_org.organization.apps.AppPageLayout.attributes_to71e }}**.
    1. Приведите атрибуты к следующему виду:

        #|
        || **Атрибут** | **Значение** ||
        || `NameID` (обязательный) | `SubjectClaims.preferred_username` ||
        || `fullname` | `SubjectClaims.name` ||
        || `emailAddress` | `SubjectClaims.email` ||
        || `firstName` | `SubjectClaims.given_name` ||
        || `secondName` | `SubjectClaims.family_name` ||
        |#

        Чтобы изменить существующий атрибут, нажмите на строку с атрибутом, укажите имя и значение из таблицы и нажмите **{{ ui-key.yacloud.common.update }}**. Имя обязательного атрибута `NameID` менять не нужно.

        Чтобы добавить отсутствующий атрибут, нажмите **{{ ui-key.yacloud_org.organization.apps.AppPageLayout.action_add_attribute }}**, заполните поля **{{ ui-key.yacloud_org.organization.apps.GroupAttributeFormDialog.field_attribute_name_rPYTn }}** и **{{ ui-key.yacloud_org.organization.apps.AttributeFormDialogNew.field_attribute_value_dgUAv }}**, затем нажмите **{{ ui-key.yacloud.common.add }}**.

{% endlist %}

Соблюдайте регистр в именах атрибутов. Если в приложении уже есть атрибут `emailaddress`, переименуйте его в `emailAddress`. Атрибут `secondName` должен передавать фамилию пользователя, а не отчество.

## Добавьте пользователей в приложение {#add-users}

Чтобы разрешить пользователям вход в МТС Линк, явно добавьте их или их [группы](../../../organization/concepts/groups.md) в SAML-приложение.

{% include [saml-manage-users](../../../_includes/organization/saml-manage-users.md) %}

{% list tabs group=instructions %}

- Интерфейс {{ cloud-center }} {#cloud-center}

    1. На странице приложения `mts-link-saml` перейдите на вкладку **{{ ui-key.yacloud_org.organization.apps.AppPageLayout.assignments_kKzJS }}**.
    1. Нажмите ![person-plus](../../../_assets/console-icons/person-plus.svg) **{{ ui-key.yacloud_org.organization.apps.AppAssignmentsPage.action_add-assignments }}**.
    1. Выберите нужных пользователей или группы. Для проверки добавьте тестового пользователя.
    1. Нажмите **{{ ui-key.yacloud.common.add }}**.

{% endlist %}

## Настройте сопоставление групп {#setup-group-mapping}

Если вы хотите объединять пользователей в группы МТС Линк при входе через SSO, настройте передачу групп из {{ org-full-name }} и сопоставление с группами МТС Линк. Если сопоставление групп не требуется, [перейдите к подтверждению домена](#enable-sso).

### Сопоставьте группы в МТС Линк {#setup-mts-groups}

1. В разделе **Группы** МТС Линк создайте нужные группы организации, если их еще нет.
1. В разделе **Настройки SSO** найдите блок **Группы SAML** и нажмите **Добавить**.
1. В открывшемся окне заполните поля:

    * **Группа SAML** — имя группы в {{ org-full-name }}, например `mts-link-users`. Имя должно совпадать с именем группы, которое будет передаваться в SAML-ответе.
    * **Группа организации** — соответствующая группа в МТС Линк.

1. Нажмите **Добавить**.
1. Повторите действия для остальных групп, например `mts-link-admins`.

### Настройте передачу групп в {{ org-full-name }} {#setup-idp-groups}

1. Если нужных групп в {{ org-full-name }} еще нет, [создайте их](../../../organization/operations/create-group.md) с именами, которые вы указали в поле **Группа SAML** в МТС Линк. 
1. [Добавьте в группы пользователей](../../../organization/operations/add-member-group.md).
1. [Добавьте эти группы в SAML-приложение](#add-users) `mts-link-saml`.

Настройте атрибут группы в приложении:

{% list tabs group=instructions %}

- Интерфейс {{ cloud-center }} {#cloud-center}

    1. На странице приложения `mts-link-saml` перейдите на вкладку **{{ ui-key.yacloud_org.organization.apps.AppPageLayout.attributes_to71e }}**.
    1. Нажмите **{{ ui-key.yacloud_org.organization.apps.AppPageLayout.action_add_group_attribute }}**. Если атрибут группы уже существует, нажмите на строку с ним.
    1. Укажите параметры атрибута:

        * **{{ ui-key.yacloud_org.organization.apps.GroupAttributeFormDialog.field_attribute_name_rPYTn }}** — `http://schemas.xmlsoap.org/claims/Group`.
        * **{{ ui-key.yacloud_org.organization.apps.GroupAttributeFormDialog.field_group_attribute_value_oxrpu }}** — **{{ ui-key.yacloud_org.organization.apps.field_group_assigned_amGdu }}**.
        * **Значение для групп** — `GroupClaims.name`.

    1. Нажмите **{{ ui-key.yacloud.common.add }}**. Если вы изменяли существующий атрибут, нажмите **{{ ui-key.yacloud.common.update }}**.

{% endlist %}

В SAML-ответе будут передаваться имена только тех групп, в которые входит пользователь и которые добавлены в приложение. Эти имена должны совпадать со значениями поля **Группа SAML** в настройках МТС Линк.

## Подтвердите домен и включите SSO в МТС Линк {#enable-sso}

1. Вернитесь в раздел **Настройки SSO** в МТС Линк. На странице с параметрами поставщика услуг нажмите **Далее**.
1. В блоке **Укажите домен электронной почты** введите домен корпоративной почты пользователей и нажмите **Добавить**.
1. Подтвердите домен по инструкции МТС Линк. Убедитесь, что рядом с доменом появился статус **Подтвержден**.
1. Включите опцию **Использовать SSO для входа в личный кабинет**.

    При первом входе через SSO МТС Линк автоматически зарегистрирует сотрудника, добавит его в организацию и подключит к тарифному плану компании.

1. При необходимости включите дополнительные ограничения:

    * **Регистрировать пользователей с подтвержденными доменами моей организации только через SSO** — чтобы пользователи с такими доменами регистрировались только через единый вход.
    * **Использовать SSO для ограничения доступа к курсам и вебинарам для всех аккаунтов организации** — чтобы вход на курсы и вебинары организации был доступен только через SSO.

    {% note tip %}

    Включайте дополнительные ограничения после [проверки единого входа](#validate) тестовым пользователем, чтобы ошибка в настройках не помешала работе сотрудников.

    {% endnote %}

## Проверьте единый вход {#validate}

1. Перейдите на страницу входа в МТС Линк: `https://my.mts-link.ru/` или на страницу вашей организации на поддомене. Если вы уже вошли в МТС Линк, выйдите из профиля.
1. Для входа укажите адрес электронной почты тестового пользователя с подтвержденным доменом.
1. Убедитесь, что МТС Линк перенаправил вас на страницу аутентификации {{ org-full-name }}.
1. Пройдите аутентификацию под учетной записью тестового пользователя, которого вы добавили в SAML-приложение.
1. Убедитесь, что после аутентификации вы вернулись в МТС Линк и получили доступ к личному кабинету нужной организации. Проверьте имя, фамилию и адрес электронной почты в профиле.
1. Если вы [настроили сопоставление групп](#setup-group-mapping), убедитесь в разделе **Группы** МТС Линк, что тестовый пользователь добавлен в соответствующую группу организации.

Если вход не работает, проверьте, что:

* Домен почты подтвержден в МТС Линк, а опция входа в личный кабинет через SSO включена.
* Пользователь или его группа добавлены в SAML-приложение.
* Параметры поставщика услуг и поставщика удостоверений скопированы без изменений, а сертификат соответствует созданному приложению.
* Выбран режим подписи **Assertions and Response**.
* Имена и значения атрибутов совпадают с [таблицей](#setup-attributes), а в профиле пользователя заполнен адрес электронной почты.

Если вход работает, но пользователь не попал в нужную группу МТС Линк, проверьте [настройки сопоставления групп](#setup-group-mapping): имя атрибута должно быть `http://schemas.xmlsoap.org/claims/Group`, значение для групп — `GroupClaims.name`. Убедитесь, что пользователь входит в группу в {{ org-full-name }}, эта группа добавлена в SAML-приложение, а ее имя совпадает со значением поля **Группа SAML** в МТС Линк.

#### Полезные ссылки {#see-also}

* [{#T}](../../../organization/concepts/applications/saml.md)
* [{#T}](../../../organization/operations/applications/saml-update.md)
* [Инструкция по настройке SSO через Azure AD на сайте МТС Линк](https://help.mts-link.ru/article/19520)

[*organization]: {% include [organization-definition](../../../_popups/identity-hub/organization-definition.md) %}
