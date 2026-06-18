# Сопоставление групп пользователей в Microsoft Active Directory Federation Services

Вы можете использовать сервис [Active Directory Federation Services](https://learn.microsoft.com/ru-ru/windows-server/identity/ad-fs/ad-fs-overview) (AD FS) для аутентификации пользователей в организации.

Чтобы настроить сопоставление групп пользователей в AD FS и групп пользователей в [федерации удостоверений](../../../concepts/add-federation.md):

1. [Соберите данные о ферме AD FS](#get-adfs-info).
1. [Создайте федерацию Yandex Identity Hub](#create-federation).
1. [Добавьте сертификат AD FS в федерацию](#add-certificate).
1. [Создайте и настройте отношение доверия на стороне AD FS](#create-relying-party-trust).
1. [Настройте сопоставление атрибутов на стороне AD FS](#adfs-mapping).
1. [Настройте сопоставление групп на стороне федерации](#org-mapping).
1. [Проверьте работу аутентификации](#test-auth).

## Перед началом работы {#before-you-begin}

Убедитесь, что выполнены следующие условия:

1. Есть доступ к MMC-оснастке **Active Directory Users and Computers**, через которую можно управлять доменными компьютерами, пользователями и группами.

1. Есть настроенная ферма AD FS с одним или несколькими действующими сертификатами типа `Token-signing` для подписи токенов.

1. Есть доступ к следующим инструментам для управления этой фермой:

    * MMC-оснастка **AD FS Management**.
    * [Модуль PowerShell](https://learn.microsoft.com/en-us/powershell/module/adfs/) для управления AD FS.

## Соберите данные о ферме AD FS {#get-adfs-info}

1. Получите и сохраните сертификат, который будет использоваться для подписи сообщений от AD FS.

    Чтобы получить сертификат типа `Token-Signing` в формате Base64, выполните команды с помощью PowerShell, указав путь, по которому нужно сохранить сертификат:

    ```powershell
    $ADFS_CERT_PATH = "<путь_к_сертификату>/adfs_certificate.cer"
    
    $TEMP_CERT = (Get-AdfsCertificate -CertificateType Token-Signing |
                    where {$_.IsPrimary -eq $true} | Select-Object -First 1
                 ).Certificate.Export([System.Security.Cryptography.X509Certificates.X509ContentType]::Cert)
    
    @(
        '-----BEGIN CERTIFICATE-----'
        [System.Convert]::ToBase64String($TEMP_CERT, 'InsertLineBreaks')
        '-----END CERTIFICATE-----'
    ) | Out-File -FilePath $ADFS_CERT_PATH -Encoding ascii
    
    ```
    
    Сертификат будет сохранен под именем `adfs_certificate.cer`.

1. Получите и сохраните реквизиты, которые потребуются при настройке федерации удостоверений:

    1. Получите идентификатор сервиса федераций (**Federation Service identifier**):

        ```powershell
        Get-AdfsProperties | Select Identifier
        ```

        Идентификатор содержит в себе FQDN фермы AD FS и имеет вид:

        ```text
        http://<FQDN_фермы_AD_FS>/adfs/services/trust
        ```

    1. Получите эндпоинт сервиса федераций:
       
        ```powershell
        Get-AdfsEndpoint -AddressPath /adfs/ls/ | Select FullUrl
        ```
       
       Эндпоинт содержит в себе FQDN фермы AD FS и имеет следующий вид:
       
       ```text
       https://<FQDN_фермы_AD_FS>/adfs/ls/
       ```

    {% note info %}

    Присутствие `http://` в идентификаторе не означает, что данные будут передаваться в открытом виде по протоколу HTTP.

    Все взаимодействие между AD FS и Yandex Cloud будет происходить через эндпоинт по протоколу HTTPS.

    {% endnote %}

## Создайте федерацию Yandex Identity Hub {#create-federation}

{% list tabs group=instructions %}

- Интерфейс Cloud Center {#cloud-center}

  1. Перейдите в сервис [Yandex Identity Hub](https://center.yandex.cloud/organization).

  1. На панели слева выберите ![icon-federation](../../../../_assets/console-icons/vector-square.svg) **Федерации**.

  1. В правом верхнем углу страницы нажмите кнопку ![Circles3Plus](../../../../_assets/console-icons/circles-3-plus.svg) **Создать федерацию**. В открывшемся окне:

      1. Задайте имя федерации, например `demo-federation`. Имя должно быть уникальным в каталоге.

      1. При необходимости добавьте описание.

      1. В поле **Время жизни cookie** укажите время, в течение которого браузер не будет требовать у пользователя повторной аутентификации.

      1. В поле **IdP Issuer** вставьте идентификатор сервиса федераций, [полученный при сборе данных о ферме AD FS](#get-adfs-info).

      1. В выпадающем списке **Single Sign-On метод** выберите `POST`.

      1. В поле **Ссылка на страницу для входа в IdP** вставьте эндпоинт сервиса федераций, полученный при сборе данных о ферме AD FS.

      1. Включите опцию **Автоматически создавать пользователей**, чтобы автоматически добавлять пользователя в организацию после аутентификации. Если опция отключена, федеративных пользователей потребуется [добавить вручную](../../../operations/add-account.md#add-user-sso).

          Автоматически федеративный пользователь создается только при первом входе пользователя в облако. Если вы исключили пользователя из федерации, вернуть его туда можно будет только вручную.

      1. (Опционально) Чтобы все запросы аутентификации от Yandex Cloud содержали цифровую подпись, включите опцию **Подписывать запросы аутентификации**. Потребуется установить SAML-сертификат Yandex Cloud на стороне поставщика удостоверений.

          В появившемся блоке **Сертификаты SAML** появится информация о действующем SAML-сертификате Yandex Cloud.
          
          Нажмите ![ArrowDownToLine](../../../../_assets/console-icons/arrow-down-to-line.svg) **Скачать** и сохраните скачанный файл сертификата. Он потребуется для установки на ваш IdP-сервер.
          
          {% note tip %}
          
          Следите за сроком действия сертификатов и устанавливайте новые сертификаты до истечения срока действия используемых. Перевыпущенный SAML-сертификат Yandex Cloud необходимо заранее [скачать и установить](../../../operations/renew-yc-certificate.md) на стороне IdP-провайдера и в вашей федерации.
          
          {% endnote %}

          [Скачать и установить сертификат](../../../operations/setup-federation.md#add-certificate-idp) Yandex Cloud вы можете и после создания федерации.

          Сертификат потребуется в дальнейшем при настройке отношения доверия AD FS.

      1. Включите опцию **Принудительная повторная аутентификация (ForceAuthn) в IdP**, чтобы задать значение `true` для параметра [ForceAuthn](../../../saml/api-ref/Federation/index.md) в запросе аутентификации SAML. При включении этой опции поставщик удостоверений (Identity Provider, IdP) запрашивает у пользователя аутентификацию по истечении сессии в Yandex Cloud. Необязательный параметр.

      1. Нажмите кнопку **Создать федерацию**.

{% endlist %}

## Добавьте сертификат AD FS в федерацию {#add-certificate}

Чтобы при аутентификации сервис Yandex Identity Hub мог проверить сертификат AD FS, добавьте сертификат в федерацию:

{% list tabs group=instructions %}

- Интерфейс Cloud Center {#cloud-center}

  1. Войдите в сервис [Yandex Identity Hub](https://center.yandex.cloud/organization).

  1. На панели слева выберите ![VectorSquare](../../../../_assets/console-icons/vector-square.svg) **Федерации**.

  1. Нажмите на строку с федерацией, для которой нужно добавить сертификат — `demo-federation`.

  1. Внизу страницы в блоке **Сертификаты** нажмите кнопку **Добавить сертификат**.

  1. Введите название сертификата и укажите путь к файлу `adfs_certificate.cer`, который был [сохранен ранее](#get-adfs-info).

  1. Нажмите кнопку **Добавить**.

{% endlist %}

{% note tip %}

Не забывайте своевременно перевыпускать сертификаты и добавлять их в федерацию.

Чтобы не пропустить момент окончания срока действия сертификата, [подпишитесь](../../../operations/subscribe-user-for-notifications.md) на уведомления от организации. Уведомления направляются подписанным пользователям за 60, 30 и 5 дней до момента прекращения действия сертификата, а также после того, как сертификат становится недействительным.

{% endnote %}

## Создайте и настройте отношение доверия на стороне AD FS {#create-relying-party-trust}

В роли поставщика удостоверений (IdP) выступает AD FS, в котором настроено отношение доверия с проверяющей стороной (Relying Party Trust). Чтобы создать такое отношение и настроить его:

1. Откройте MMC-оснастку **AD FS Management**.

1. Откройте в дереве консоли контекстное меню элемента **AD FS** → **Relying Party Trusts** и выберите пункт **Add Relying Party Trust**.

    Откроется мастер добавления отношения доверия с проверяющей стороной (Add Relying Party Trust Wizard).

1. Выберите опцию **Claims aware** на шаге **Welcome**. Нажмите кнопку **Start**.

1. Выберите опцию **Enter data about the relying party manually** на шаге **Select Data Source**. Нажмите кнопку **Next**.

1. Укажите имя отношения доверия (например, `Yandex Cloud`) и, при необходимости, его описание на шаге **Specify Display Name**. Нажмите кнопку **Next**.

1. Пропустите шаг **Configure Certificate**, нажав кнопку **Next**.

1. Укажите URL для перенаправления на шаге **Configure URL**:

    1. Включите опцию **Enable support for the SAML 2.0 Web SSO protocol**.
    1. Укажите URL для перенаправления в поле **Relying party SAML 2.0 SSO service URL**.

        URL для перенаправления имеет вид:

        ```text
        https://console.cloud.yandex.ru/federations/<идентификатор_федерации>
        ```

        {% cut "Как получить идентификатор федерации" %}

        1. Войдите в сервис [Yandex Identity Hub](https://center.yandex.cloud/organization).
        1. На панели слева выберите ![VectorSquare](../../../../_assets/console-icons/vector-square.svg) **Федерации**.
        1. Выберите нужную федерацию и на странице с информацией о ней скопируйте значение поля **Идентификатор**.

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

1. (Опционально) Если при [создании федерации](#create-federation) в Yandex Identity Hub вы включили опцию **Подписывать запросы аутентификации**, настройте связанные с этим параметры для отношения доверия:
   
   1. Откройте контекстное меню созданного отношения доверия и выберите пункт **Properties**.
   
       Откроется окно со свойствами отношения доверия.
   
   1. Перейдите на вкладку **Encryption** и добавьте скачанный [ранее](#create-federation) SAML-сертификат Yandex Cloud для подписи запросов аутентификации:
   
       1. Нажмите кнопку **Browse**.
       1. Выберите файл с сертификатом (например, `YandexCloud.cer`).
   
            Если вы не скачивали SAML-сертификат при создании федерации, вы можете скачать его на странице сведений о федерации в Yandex Identity Hub, нажав кнопку ![ArrowDownToLine](../../../../_assets/console-icons/arrow-down-to-line.svg) **Скачать сертификат** в поле **Подписывать запросы аутентификации**.
   
   1. Перейдите на вкладку **Signature** и добавьте этот же сертификат:
   
       1. Нажмите кнопку **Add**.
       1. Выберите файл с сертификатом.
   
   1. Нажмите кнопку **OK**.
   
   1. Включите обязательные шифрование утверждений и подпись запросов для созданного отношения доверия:
   
       ```powershell
       Set-AdfsRelyingPartyTrust `
           -TargetName "Yandex Cloud" `
           -EncryptClaims $true `
           -SignedSamlRequestsRequired $true `
           -SamlResponseSignature MessageAndAssertion
       ```

## Настройте сопоставление атрибутов на стороне AD FS {#adfs-mapping}

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

        Если этого не сделать, то пользователю потребуется сменить пароль при первой аутентификации в AD FS.

    1. Убедитесь, что опция **Account is disabled** отключена.

        {% note warning %}

        В противном случае учетная запись этого пользователя будет отключена.

        Пользователь не сможет выполнять аутентификацию в AD FS и работать с Yandex Cloud.

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

1. Откройте MMC-оснастку **AD FS Management**.

1. Выберите в дереве консоли элемент **AD FS** → **Relying Party Trusts**.

1. Выберите [отношение доверия](#create-relying-party-trust) `Yandex Cloud` в панели результатов.

1. Откройте контекстное меню этого отношения доверия и выберите пункт **Edit Access Control Policy**.

    Откроется окно со списком политик.

1. Выберите политику `Permit Specific Group` из списка **Choose an access control policy**.

1. Нажмите на ссылку `parameter` в поле **Policy** с описанием выбранной политики.

1. Нажмите кнопку **Add**.

1. Введите имя группы `adfs_group` и нажмите кнопку **OK**.

1. Нажмите кнопку **OK** в окне **Select Groups**.

1. Нажмите кнопку **OK** в окне **Edit Access Control Policy for Yandex Cloud**.

### Настройте сопоставление атрибутов LDAP {#map-adfs-ldap}

1. Откройте MMC-оснастку **AD FS Management**.

1. Выберите в дереве консоли элемент **AD FS** → **Relying Party Trusts**.

1. Выберите [отношение доверия](#create-relying-party-trust) `Yandex Cloud` в панели результатов.

1. Откройте контекстное меню этого отношения доверия и выберите пункт **Edit Claim Issuance Policy**.

    Откроется окно со списком политик.

1. Нажмите кнопку **Add Rule**.

    Откроется мастер добавления правила для трансформации утверждения.

1. Выберите пункт `Send LDAP Attributes as Claims` из выпадающего списка **Claim rule template** на шаге **Choose rule type**. Нажмите кнопку **Next**.

1. Задайте настройки правила на шаге **Configure Claim Rule**:

    * **Claim rule name** — имя правила, например `LDAP Mappings`.

    * **Attribute store** — `Active Directory`.

    * **Mapping of LDAP attributes to outgoing claim types** — список сопоставлений в виде пар «атрибут/тип исходящего утверждения».

        Добавьте в список следующие обязательные сопоставления, которые необходимы для корректного взаимодействия с Yandex Cloud:

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

        Перечень групп, к которым принадлежит пользователь. Этот перечень будет использоваться в ходе сопоставления групп при аутентификации пользователя в Yandex Cloud.

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

{% note info %}

Чтобы настроить сопоставление [групп пользователей](../../../concepts/user-pools.md) на стороне Yandex Cloud, [назначьте](../../../../iam/operations/roles/grant.md#resource) пользователю одну из следующих [ролей](../../../../iam/concepts/access-control/roles.md):

* [`organization-manager.federations.editor`](../../../security/index.md#organization-manager-federations-editor);
* [`organization-manager.federations.admin`](../../../security/index.md#organization-manager-federations-admin);
* [`organization-manager.editor`](../../../security/index.md#organization-manager-editor);
* [`organization-manager.admin`](../../../security/index.md#organization-manager-admin);

Роль должна быть назначена на те группы, для которых настраивается сопоставление.

{% endnote %}

{% list tabs group=instructions %}

- Интерфейс Cloud Center {#cloud-center}

  1. Войдите в сервис [Yandex Identity Hub](https://center.yandex.cloud/organization).

  1. [Создайте группу пользователей](../../../operations/create-group.md) `yc-demo-group` в Yandex Identity Hub и [выдайте ей права](../../../operations/access-group.md) на просмотр ресурсов в облаке или отдельном каталоге (роль `viewer`).

  1. На панели слева выберите ![VectorSquare](../../../../_assets/console-icons/vector-square.svg) **Федерации**.

  1. Выберите [созданную ранее федерацию](#create-federation) `demo-federation` и перейдите на вкладку **IdP-группы**.

  1. Включите опцию **Маппинг групп в IdP**.

  1. Нажмите кнопку **Добавить группу**.

  1. В поле **Имя группы** введите идентификатор нужной группы, который передается в [утверждениях со стороны AD FS](#map-adfs-ldap).

      Если используется атрибут `Token-Groups - Unqualified Names`, то укажите в качестве идентификатора короткое имя группы — `adfs_group`.

  1. В поле **IAM-группа** выберите из списка имя группы в Yandex Identity Hub — `yc-demo-group`.

  1. Нажмите кнопку **Сохранить**.

- Terraform {#tf}

  1. Опишите в конфигурационном файле Terraform параметры создаваемых ресурсов:

      ```hcl
      # Создание группы пользователей
      resource "yandex_organizationmanager_group" "my-group" {
        name            = "yc-demo-group"
        organization_id = "demo-federation"
      }

      # Назначение роли viewer на каталог
      resource "yandex_resourcemanager_folder_iam_member" "viewers" {
        folder_id = "<идентификатор_каталога>"
        role      = "viewer"
        member    = "group:${yandex_organizationmanager_group.my-group.id}"
      }

      # Включение сопоставления групп федеративных пользователей
      resource "yandex_organizationmanager_group_mapping" "my_group_map" {
        federation_id = "demo-federation"
        enabled       = true
      }

      # Настройка сопоставления групп федеративных пользователей
      resource "yandex_organizationmanager_group_mapping_item" "group_mapping_item" {
        federation_id     = "demo-federation"
        internal_group_id = yandex_organizationmanager_group.my-group.id
        external_group_id = "<идентификатор_группы_adfs_group>"

        depends_on = [yandex_organizationmanager_group_mapping.group_mapping]
      }
      ```

      Где:
      * `folder_id` — каталог, на который назначается роль.
      * `external_group_id` — идентификатор нужной группы, который передается в [утверждениях со стороны AD FS](#map-adfs-ldap).

         Если используется атрибут `Token-Groups - Unqualified Names`, то укажите в качестве идентификатора короткое имя группы — `adfs_group`.

      Подробнее в описаниях ресурсов [yandex_organizationmanager_group_mapping](../../../../terraform/resources/organizationmanager_group_mapping.md) и [yandex_organizationmanager_group_mapping_item](../../../../terraform/resources/organizationmanager_group_mapping_item.md) в документации провайдера Terraform.

  1. Создайте ресурсы:

     1. В терминале перейдите в директорию с конфигурационным файлом.
     1. Проверьте корректность конфигурации с помощью команды:
     
        ```bash
        terraform validate
        ```
     
        Если конфигурация является корректной, появится сообщение:
     
        ```bash
        Success! The configuration is valid.
        ```
     
     1. Выполните команду:
     
        ```bash
        terraform plan
        ```
     
        В терминале будет выведен список ресурсов с параметрами. На этом этапе изменения не будут внесены. Если в конфигурации есть ошибки, Terraform на них укажет.
     1. Примените изменения конфигурации:
     
        ```bash
        terraform apply
        ```
     
     1. Подтвердите изменения: введите в терминале слово `yes` и нажмите **Enter**.

{% endlist %}

## Проверьте работу аутентификации {#test-auth}

1. Откройте браузер в гостевом режиме или режиме инкогнито.

    Это действие необходимо выполнять с компьютера, который входит в домен и имеет доступ к AD FS.

1. Перейдите по URL для входа в консоль:

    ```text
    https://console.cloud.yandex.ru/federations/<идентификатор_федерации>
    ```

    {% cut "Как получить идентификатор федерации" %}

    1. Войдите в сервис [Yandex Identity Hub](https://center.yandex.cloud/organization).
    1. На панели слева выберите ![VectorSquare](../../../../_assets/console-icons/vector-square.svg) **Федерации**.
    1. Выберите нужную федерацию и на странице с информацией о ней скопируйте значение поля **Идентификатор**.

    {% endcut %}

    Если все настроено правильно, браузер перенаправит вас на страницу аутентификации в AD FS.

1. Введите реквизиты пользователя `adfs_demo_user@example.com`, [созданного ранее](#create-user), и нажмите кнопку **Sign in**.

    После успешной аутентификации IdP-сервер перенаправит вас по URL `https://console.cloud.yandex.ru/federations/<идентификатор_федерации>`, который вы указали в настройках [отношения доверия](#create-relying-party-trust), а после — на главную страницу [консоли управления](https://console.yandex.cloud).

1. Убедитесь, что пользователь, от имени которого был выполнен вход, входит в группу `yc-demo-group` и у него есть права на просмотр ресурсов в соответствии с ролью, назначенной для группы.