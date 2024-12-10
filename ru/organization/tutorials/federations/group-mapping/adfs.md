---
title: Сопоставление групп пользователей в {{ microsoft-idp.adfs-full }}
description: Как настроить сопоставление групп пользователей при аутентификации пользователей в организации.
---

# Сопоставление групп пользователей в {{ microsoft-idp.adfs-full }}

Вы можете использовать сервис [{{ microsoft-idp.adfs-short }}](https://learn.microsoft.com/ru-ru/windows-server/identity/ad-fs/ad-fs-overview) ({{ microsoft-idp.adfs-abbreviated }}) для аутентификации пользователей в организации.

Чтобы настроить сопоставление групп пользователей в {{ microsoft-idp.adfs-abbreviated }} и групп пользователей в [федерации удостоверений](../../../concepts/add-federation.md):

1. [Соберите данные о ферме {{ microsoft-idp.adfs-abbreviated }}](#get-adfs-info).
1. [Создайте федерацию {{ org-full-name }}](#create-federation).
1. [Добавьте сертификат {{ microsoft-idp.adfs-abbreviated }} в федерацию](#add-certificate).
1. [Создайте и настройте отношение доверия на стороне {{ microsoft-idp.adfs-abbreviated }}](#create-relying-party-trust).
1. [Настройте сопоставление атрибутов на стороне {{ microsoft-idp.adfs-abbreviated }}](#adfs-mapping).
1. [Настройте сопоставление групп на стороне федерации](#org-mapping).
1. [Проверьте работу аутентификации](#test-auth).

## Перед началом работы {#before-you-begin}

Убедитесь, что выполнены следующие условия:

1. Есть доступ к MMC-оснастке **Active Directory Users and Computers**, через которую можно управлять доменными компьютерами, пользователями и группами.

1. Есть настроенная ферма {{ microsoft-idp.adfs-abbreviated }} с одним или несколькими действующими сертификатами типа `Token-signing` для подписи токенов.

1. Есть доступ к следующим инструментам для управления этой фермой:

    * MMC-оснастка **{{ microsoft-idp.adfs-abbreviated }} Management**.
    * [Модуль PowerShell](https://learn.microsoft.com/en-us/powershell/module/adfs/) для управления {{ microsoft-idp.adfs-abbreviated }}.

## Соберите данные о ферме {{ microsoft-idp.adfs-abbreviated }} {#get-adfs-info}

1. Получите и сохраните сертификат, который будет использоваться для подписи сообщений от {{ microsoft-idp.adfs-abbreviated }}.

    Чтобы получить сертификат типа `Token-Signing` в формате Base64, выполните команды с помощью PowerShell, указав путь, по которому нужно сохранить сертификат:

    {% include [adfs-cert-guide-powershell](../../../../_includes/organization/adfs-cert-guide-powershell.md) %}

1. Получите и сохраните реквизиты, которые потребуются при настройке федерации удостоверений:

    1. Получите идентификатор сервиса федераций (**Federation Service identifier**):

        ```powershell
        Get-AdfsProperties | Select Identifier
        ```

        Идентификатор содержит в себе FQDN фермы {{ microsoft-idp.adfs-abbreviated }} и имеет вид:

        ```text
        http://<FQDN_фермы_AD_FS>/adfs/services/trust
        ```

    1. {% include [get-adfs-endpoint](../../../../_includes/organization/get-adfs-endpoint.md) %}

    {% note info %}

    Присутствие `http://` в идентификаторе не означает, что данные будут передаваться в открытом виде по протоколу HTTP.

    Все взаимодействие между {{ microsoft-idp.adfs-abbreviated }} и {{ yandex-cloud }} будет происходить через эндпоинт по протоколу HTTPS.

    {% endnote %}

## Создайте федерацию {{ org-full-name }} {#create-federation}

{% list tabs group=instructions %}

- Интерфейс {{ cloud-center }} {#cloud-center}

  1. Перейдите в сервис [{{ org-full-name }}]({{ link-org-cloud-center }}).

  1. На панели слева выберите ![icon-federation](../../../../_assets/console-icons/vector-square.svg) **{{ ui-key.yacloud_org.pages.federations }}**.

  1. В правом верхнем углу страницы нажмите кнопку ![Circles3Plus](../../../../_assets/console-icons/circles-3-plus.svg) **{{ ui-key.yacloud_org.form.federation.action.create }}**. В открывшемся окне:

      1. Задайте имя федерации, например `demo-federation`. Имя должно быть уникальным в каталоге.

      1. При необходимости добавьте описание.

      1. В поле **{{ ui-key.yacloud_org.entity.federation.field.cookieMaxAge }}** укажите время, в течение которого браузер не будет требовать у пользователя повторной аутентификации.

      1. В поле **{{ ui-key.yacloud_org.entity.federation.field.issuer }}** вставьте идентификатор сервиса федераций, [полученный при сборе данных о ферме {{ microsoft-idp.adfs-abbreviated }}](#get-adfs-info).

      1. В выпадающем списке **{{ ui-key.yacloud_org.entity.federation.field.ssoBinding }}** выберите `POST`.

      1. В поле **{{ ui-key.yacloud_org.entity.federation.field.ssoUrl }}** вставьте эндпоинт сервиса федераций, полученный при сборе данных о ферме {{ microsoft-idp.adfs-abbreviated }}.

      1. Включите опцию **{{ ui-key.yacloud_org.entity.federation.field.autocreateUsers }}**, чтобы автоматически добавлять пользователя в организацию после аутентификации. Если опция отключена, федеративных пользователей потребуется [добавить вручную](../../../operations/add-account.md#add-user-sso).

          {% include [fed-users-note](../../../../_includes/organization/fed-users-note.md) %}

      1. (Опционально) Чтобы все запросы аутентификации от {{ yandex-cloud }} содержали цифровую подпись, включите опцию **{{ ui-key.yacloud_org.entity.federation.field.encryptedAssertions }}**. Потребуется установить SAML-сертификат {{ yandex-cloud }} на стороне поставщика удостоверений.

          {% include [download-saml-cert-when-creating-fed](../../../../_includes/organization/download-saml-cert-when-creating-fed.md) %}

          {% include [setup-cert-for-idp](../../../../_includes/organization/setup-cert-for-idp.md) %}

          Сертификат потребуется в дальнейшем при настройке отношения доверия {{ microsoft-idp.adfs-abbreviated }}.

      1. {% include [forceauthn-option-enable](../../../../_includes/organization/forceauthn-option-enable.md) %}

      1. Нажмите кнопку **{{ ui-key.yacloud_org.form.federation.create.action.create }}**.

{% endlist %}

## Добавьте сертификат {{ microsoft-idp.adfs-abbreviated }} в федерацию {#add-certificate}

Чтобы при аутентификации сервис {{ org-name }} мог проверить сертификат {{ microsoft-idp.adfs-abbreviated }}, добавьте сертификат в федерацию:

{% list tabs group=instructions %}

- Интерфейс {{ cloud-center }} {#cloud-center}

  1. Войдите в сервис [{{ org-full-name }}]({{ link-org-cloud-center }}).

  1. На панели слева выберите ![VectorSquare](../../../../_assets/console-icons/vector-square.svg) **{{ ui-key.yacloud_org.pages.federations }}**.

  1. Нажмите на строку с федерацией, для которой нужно добавить сертификат — `demo-federation`.

  1. Внизу страницы в блоке **{{ ui-key.yacloud_org.page.federation.section.certificates }}** нажмите кнопку **{{ ui-key.yacloud_org.entity.certificate.action.add }}**.

  1. Введите название сертификата и укажите путь к файлу `adfs_certificate.cer`, который был [сохранен ранее](#get-adfs-info).

  1. Нажмите кнопку **{{ ui-key.yacloud_org.actions.add }}**.

{% endlist %}

{% include [federation-certificates-note](../../../../_includes/organization/federation-certificates-note.md) %}

## Создайте и настройте отношение доверия на стороне {{ microsoft-idp.adfs-abbreviated }} {#create-relying-party-trust}

В роли поставщика удостоверений (IdP) выступает {{ microsoft-idp.adfs-abbreviated }}, в котором настроено отношение доверия с проверяющей стороной (Relying Party Trust). Чтобы создать такое отношение и настроить его:

1. Откройте MMC-оснастку **{{ microsoft-idp.adfs-abbreviated }} Management**.

1. Откройте в дереве консоли контекстное меню элемента **{{ microsoft-idp.adfs-abbreviated }}** → **Relying Party Trusts** и выберите пункт **Add Relying Party Trust**.

    Откроется мастер добавления отношения доверия с проверяющей стороной (Add Relying Party Trust Wizard).

1. Выберите опцию **Claims aware** на шаге **Welcome**. Нажмите кнопку **Start**.

1. Выберите опцию **Enter data about the relying party manually** на шаге **Select Data Source**. Нажмите кнопку **Next**.

1. Укажите имя отношения доверия (например, `{{ yandex-cloud }}`) и, при необходимости, его описание на шаге **Specify Display Name**. Нажмите кнопку **Next**.

1. Пропустите шаг **Configure Certificate**, нажав кнопку **Next**.

1. Укажите URL для перенаправления на шаге **Configure URL**:

    1. Включите опцию **Enable support for the SAML 2.0 Web SSO protocol**.
    1. Укажите URL для перенаправления в поле **Relying party SAML 2.0 SSO service URL**.

        URL для перенаправления имеет вид:

        ```text
        https://{{ auth-host }}/federations/<идентификатор_федерации>
        ```

        {% cut "Как получить идентификатор федерации" %}

        {% include [get-federation-id](../../../../_includes/organization/get-federation-id.md) %}

        {% endcut %}

    1. Нажмите кнопку **Next**.

1. Укажите идентификатор проверяющей стороны на шаге **Configure Identifiers**:

    1. Укажите тот же URL для перенаправления, который использовался на предыдущем шаге, в поле **Relying party identifier**.

    1. Нажмите кнопку **Add**.

    1. Нажмите кнопку **Next**.

1. Включите опцию **I do not want to configure access control policies at this time. No user will be permitted access for this application** на шаге **Choose Access Control Policy**. Нажмите кнопку **Next**.

    Политики контроля доступа [будут настроены позднее](#configure-access-control-policy).

1. Проверьте на шаге **Ready to Add Trust**, что все параметры заданы корректно. Нажмите кнопку **Next**.

1. Отключите опцию **Configure claims issuance policy for this application** на шаге **Finish**. Нажмите кнопку **Close**.

    Политики для утверждений (claims) [будут настроены позднее](#map-adfs-ldap).

1. {% include [adfs-postinstall-setup-additional-encryption-settings](../../../../_includes/organization/adfs-postinstall-setup-additional-encryption-settings.md) %}

## Настройте сопоставление атрибутов на стороне {{ microsoft-idp.adfs-abbreviated }} {#adfs-mapping}

### Создайте пользователя {#create-user}

1. Откройте MMC-оснастку **Active Directory Users and Computers**.

1. Выберите в дереве консоли организационное подразделение (Organization Unit, OU), в котором нужно создать пользователя, затем откройте контекстное меню подразделения и выберите пункт **New** → **User**.

    Откроется мастер добавления нового объекта (New Object - User).

1. Укажите сведения о пользователе:

    * **User logon name** — логин пользователя (например `adfs_demo_user`) в комбинации с доменом (например `example.com`).

        {% note info %}

        Далее будет использоваться имя домена `example.com`. Если ваш домен имеет другое имя — скорректируйте дальнейшие шаги.

        {% endnote %}

    * **Full name** — полное имя пользователя, например `Ivan Ivanov`.

    При необходимости можно заполнить другие сведения о пользователе.

1. Нажмите кнопку **Next**.

1. Укажите пароль и настройте связанные с ним политики:

    1. Введите пароль и подтверждение пароля.

    1. (Опционально) Отключите опцию **User must change password at next login**.

        Если этого не сделать, то пользователю потребуется сменить пароль при первой аутентификации в {{ microsoft-idp.adfs-abbreviated }}.

    1. Убедитесь, что опция **Account is disabled** отключена.

        {% note warning %}

        В противном случае учетная запись этого пользователя будет отключена.

        Пользователь не сможет выполнять аутентификацию в {{ microsoft-idp.adfs-abbreviated }} и работать с {{ yandex-cloud }}.

        {% endnote %}

    1. (Опционально) Выберите другие опции, соответствующие нужным парольным политикам.

1. Нажмите кнопку **Next**, затем — кнопку **Finish**.

### Создайте группу {#create-group}

1. Откройте MMC-оснастку **Active Directory Users and Computers**.

1. Выберите в дереве консоли организационное подразделение, в котором нужно создать группу, затем откройте контекстное меню подразделения и выберите пункт **New** → **Group**.

    Откроется мастер добавления нового объекта (New Object - Group).

1. Укажите сведения о группе:

    * **Group name** — имя группы, например `adfs_group`.
    * **Group name (pre-Windows 2000)** — имя группы в устаревшем формате для использования с системами старше Windows 2000.

        По умолчанию это имя совпадает с выбранным именем группы. При необходимости можно выбрать другое значение.

1. Задайте настройки группы:

    * **Group scope** — `Global`.
    * **Group type** — `Security`.

1. Нажмите кнопку **OK**.

### Добавьте пользователя в группу {#add-user-to-group}

1. Откройте MMC-оснастку **Active Directory Users and Computers**.

1. Выберите в дереве консоли организационное подразделение, в котором находится группа `adfs_group`.

1. Выберите группу `adfs_group` в панели результатов, затем откройте контекстное меню группы и выберите пункт **Properties**.

    Откроется окно со свойствами группы.

1. Перейдите на вкладку **Members** и нажмите кнопку **Add**.

1. Введите логин пользователя `adfs_demo_user` и нажмите кнопку **OK**.

1. Нажмите кнопку **ОК**.

### Настройте политику контроля доступа {#configure-access-control-policy}

Эта политика разрешает выполнять аутентификацию пользователей из [созданной ранее группы](#create-group).

Чтобы настроить политику:

1. Откройте MMC-оснастку **{{ microsoft-idp.adfs-abbreviated }} Management**.

1. Выберите в дереве консоли элемент **{{ microsoft-idp.adfs-abbreviated }}** → **Relying Party Trusts**.

1. Выберите [отношение доверия](#create-relying-party-trust) `{{ yandex-cloud }}` в панели результатов.

1. Откройте контекстное меню этого отношения доверия и выберите пункт **Edit Access Control Policy**.

    Откроется окно со списком политик.

1. Выберите политику `Permit Specific Group` из списка **Choose an access control policy**.

1. Нажмите на ссылку `parameter` в поле **Policy** с описанием выбранной политики.

1. Нажмите кнопку **Add**.

1. Введите имя группы `adfs_group` и нажмите кнопку **OK**.

1. Нажмите кнопку **OK** в окне **Select Groups**.

1. Нажмите кнопку **OK** в окне **Edit Access Control Policy for {{ yandex-cloud }}**.

### Настройте сопоставление атрибутов LDAP {#map-adfs-ldap}

1. Откройте MMC-оснастку **{{ microsoft-idp.adfs-abbreviated }} Management**.

1. Выберите в дереве консоли элемент **{{ microsoft-idp.adfs-abbreviated }}** → **Relying Party Trusts**.

1. Выберите [отношение доверия](#create-relying-party-trust) `{{ yandex-cloud }}` в панели результатов.

1. Откройте контекстное меню этого отношения доверия и выберите пункт **Edit Claim Issuance Policy**.

    Откроется окно со списком политик.

1. Нажмите кнопку **Add Rule**.

    Откроется мастер добавления правила для трансформации утверждения.

1. Выберите пункт `Send LDAP Attributes as Claims` из выпадающего списка **Claim rule template** на шаге **Choose rule type**. Нажмите кнопку **Next**.

1. Задайте настройки правила на шаге **Configure Claim Rule**:

    * **Claim rule name** — имя правила, например `LDAP Mappings`.

    * **Attribute store** — `Active Directory`.

    * **Mapping of LDAP attributes to outgoing claim types** — список сопоставлений в виде пар «атрибут/тип исходящего утверждения».

        Добавьте в список следующие обязательные сопоставления, которые необходимы для корректного взаимодействия с {{ yandex-cloud }}:

        #|
        || **Атрибут** | **Тип исходящего утверждения** ||
        || `User-Principal-Name`

        Атрибут, по которому будет идентифицироваться пользователь.

        В данном случае пользователь будет идентифицироваться по [User Principal Name (UPN)](https://learn.microsoft.com/en-us/windows/win32/ad/naming-properties#userprincipalname). UPN для [созданного ранее пользователя](#create-user) имеет вид:

        ```text
        adfs_demo_user@example.com
        ```

        Вы можете использовать другой атрибут при условии, что он будет неизменным и уникальным, чтобы можно было однозначно идентифицировать пользователя по этому атрибуту. В этом случае скорректируйте дальнейшие шаги.

        | `Name ID` ||

        || `Token-Groups - Unqualified Names`

        Перечень групп, к которым принадлежит пользователь. Этот перечень будет использоваться в ходе сопоставления групп при аутентификации пользователя в {{ yandex-cloud }}.

        В данном случае будут передаваться короткие имена групп (например `adfs_group`, `Domain Users`) без указания их принадлежности к домену.

        Вы можете использовать другой атрибут из семейства `Token-Groups`, например `Token-Groups as SIDs`. В этом случае скорректируйте дальнейшие шаги.

        | `Group` ||

        |#

        {% note tip %}

        При необходимости добавьте дополнительные сопоставления для передачи [других поддерживаемых атрибутов пользователя](../integration-adfs.md#configure-claims-mapping).

        {% endnote %}

1. Нажмите кнопку **Finish**.
1. Нажмите кнопку **OK**.

## Настройте сопоставление групп на стороне федерации {#org-mapping}

{% list tabs group=instructions %}

- Интерфейс {{ cloud-center }} {#cloud-center}

  1. Войдите в сервис [{{ org-full-name }}]({{ link-org-cloud-center }}).

  1. [Создайте группу пользователей](../../../operations/create-group.md) `yc-demo-group` в {{ org-name }} и [выдайте ей права](../../../operations/access-group.md) на просмотр ресурсов в облаке или отдельном каталоге (роль `viewer`).

  1. На панели слева выберите ![VectorSquare](../../../../_assets/console-icons/vector-square.svg) **{{ ui-key.yacloud_org.pages.federations }}**.

  1. Выберите [созданную ранее федерацию](#create-federation) `demo-federation` и перейдите на вкладку **{{ ui-key.yacloud_org.form.group-mapping.note.tab-idp }}**.

  1. Включите опцию **{{ ui-key.yacloud_org.form.group-mapping.field.idp }}**.

  1. Нажмите кнопку **{{ ui-key.yacloud_org.form.group-mapping.create.add }}**.

  1. В поле **{{ ui-key.yacloud_org.form.group-mapping.note.group-name }}** введите идентификатор нужной группы, который передается в [утверждениях со стороны {{ microsoft-idp.adfs-abbreviated }}](#map-adfs-ldap).

      Если используется атрибут `Token-Groups - Unqualified Names`, то укажите в качестве идентификатора короткое имя группы — `adfs_group`.

  1. В поле **{{ ui-key.yacloud_org.form.group-mapping.note.iam-group }}** выберите из списка имя группы в {{ org-full-name }} — `yc-demo-group`.

  1. Нажмите кнопку **{{ ui-key.yacloud_org.actions.save-changes }}**.

{% endlist %}

## Проверьте работу аутентификации {#test-auth}

1. Откройте браузер в гостевом режиме или режиме инкогнито.

    Это действие необходимо выполнять с компьютера, который входит в домен и имеет доступ к {{ microsoft-idp.adfs-abbreviated }}.

1. Перейдите по URL для входа в консоль:

    ```text
    https://{{ console-host }}/federations/<идентификатор_федерации>
    ```

    {% cut "Как получить идентификатор федерации" %}

    {% include [get-federation-id](../../../../_includes/organization/get-federation-id.md) %}

    {% endcut %}

    Если все настроено правильно, браузер перенаправит вас на страницу аутентификации в {{ microsoft-idp.adfs-abbreviated }}.

1. Введите реквизиты пользователя `adfs_demo_user@example.com`, [созданного ранее](#create-user), и нажмите кнопку **Sign in**.

    После успешной аутентификации IdP-сервер перенаправит вас по URL `https://{{ auth-host }}/federations/<идентификатор_федерации>`, который вы указали в настройках [отношения доверия](#create-relying-party-trust), а после — на главную страницу [консоли управления]({{ link-console-main }}).

1. Убедитесь, что пользователь, от имени которого был выполнен вход, входит в группу `yc-demo-group` и у него есть права на просмотр ресурсов в соответствии с ролью, назначенной для группы.
