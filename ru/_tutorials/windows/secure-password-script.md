# Безопасная передача пароля в скрипт инициализации

При создании виртуальной машины из образа с операционной системой Windows вы можете использовать скрипт инициализации. Например, в скрипте можно задать логин и пароль администратора и других пользователей системы. Чтобы защитить чувствительные данные, вместо явного указания в скрипте используйте возможности сервиса [{{ lockbox-full-name }}](../../lockbox/) и ключи {{ kms-full-name }}.

В данном руководстве вы создадите ВМ с ОС Windows используя скрипт инициализации, в котором логины и пароли пользователей системы будут получены из сервиса {{ lockbox-name }}.

Чтобы создать ВМ и защитить конфиденциальную информацию в скрипте инициализации:

1. [Создайте сервисный аккаунт](#create-account)
1. [Создайте ключ {{ kms-short-name }}](#create-key)
1. [Создайте секрет](#create-secret)
1. [Создайте ВМ](#create-vm)
1. [Авторизуйтесь в ОС Windows](#login-windows)

Если созданные ресурсы вам больше не нужны, [удалите их](#clear-out).

## Перед началом работы {#before-you-begin}

{% include [before-you-begin](../../_tutorials/_tutorials_includes/before-you-begin.md) %}

### Необходимые платные ресурсы {#paid-resources}

В стоимость поддержки инфраструктуры входит:

* плата за ВМ (см. [тарифы {{ compute-full-name }}](../../compute/pricing.md));
* плата за использование образа (зависит от образа);
* плата за использование ключа {{ kms-short-name }} (см. [тарифы {{ kms-short-name }}](../../kms/pricing.md));
* плата за использование секрета (см. [тарифы {{ lockbox-name }}](../../lockbox/pricing.md)).

## Создайте сервисный аккаунт {#create-account}

{% list tabs group=instructions %}

- Консоль управления {#console}

   1. В [консоли управления]({{ link-console-main }}) выберите каталог, в котором хотите создать сервисный аккаунт.
   1. В списке сервисов выберите **{{ ui-key.yacloud.iam.folder.dashboard.label_iam }}**.
   1. Нажмите кнопку **{{ ui-key.yacloud.iam.folder.service-accounts.button_add }}**.
   1. Введите имя сервисного аккаунта, например, `win-secret-sa`.
   1. Нажмите кнопку **{{ ui-key.yacloud.iam.folder.service-account.popup-robot_button_add }}**.

- CLI {#cli}

   {% include [default-catalogue](../../_includes/default-catalogue.md) %}

   Выполните команду для создания сервисного аккаунта, указав имя `win-secret-sa`:

   ```bash
   yc iam service-account create --name win-secret-sa
   ```

   Где `name` — имя сервисного аккаунта.

   Результат:

   ```text
   id: ajehr0to1g8b********
   folder_id: b1gv87ssvu49********
   created_at: "2024-03-15T09:03:11.665153755Z"
   name: win-secret-sa
   ```

- API {#api}

  Чтобы создать сервисный аккаунт, воспользуйтесь вызовом gRPC API [ServiceAccountService/Create](../../iam/api-ref/grpc/ServiceAccount/create.md) или методом [create](../../iam/api-ref/ServiceAccount/create.md) для ресурса `ServiceAccount` REST API.

{% endlist %}

## Создайте ключ {{ kms-short-name }} {#create-key}

1. Создайте [ключ шифрования](../../kms/concepts/key.md):

   {% list tabs group=instructions %}

   - Консоль управления {#console}

     1. В [консоли управления]({{ link-console-main }}) выберите [каталог](../../resource-manager/concepts/resources-hierarchy.md#folder), в котором будет создан ключ.
     1. Выберите сервис **{{ ui-key.yacloud.iam.folder.dashboard.label_kms }}**.
     1. На панели слева выберите ![image](../../_assets/console-icons/key.svg) **{{ ui-key.yacloud.kms.switch_symmetric-keys }}**.
     1. Нажмите **{{ ui-key.yacloud.kms.symmetric-keys.button_empty-create }}** и задайте атрибуты ключа:
         * **{{ ui-key.yacloud.common.name }}** — `win-secret-key`.
         * **{{ ui-key.yacloud.kms.symmetric-key.form.field_algorithm }}** — `AES-256`.
         * Для остальных параметров оставьте значения по умолчанию.
     1. Нажмите **{{ ui-key.yacloud.common.create }}**.

     Вместе с ключом создается его первая версия: кликните ключ в списке, чтобы открыть страницу с его атрибутами.

   - CLI {#cli}

     Выполните команду:

     ```bash
     yc kms symmetric-key create \
       --name win-secret-key \
       --default-algorithm aes-256
     ```

     Где:

     * `--name` — имя ключа.
     * `--default-algorithm` — алгоритм шифрования: `aes-128`, `aes-192` или `aes-256`.

   - {{ TF }} {#tf}

     {% include [terraform-definition](../../_tutorials/_tutorials_includes/terraform-definition.md) %}

     {% include [terraform-install](../../_includes/terraform-install.md) %}

     {% include [terraform-key-create](../../_includes/kms/terraform-key-create.md) %}

   - API {#api}

     Воспользуйтесь методом REST API [create](../../kms/api-ref/SymmetricKey/create.md) для ресурса [SymmetricKey](../../kms/api-ref/SymmetricKey/index.md) или вызовом gRPC API [SymmetricKeyService/Create](../../kms/api-ref/grpc/SymmetricKey/create.md).

   {% endlist %}

1. Назначьте сервисному аккаунту `win-secret-sa` [роль](../../iam/concepts/access-control/roles.md) `kms.keys.encrypterDercrypter`:

   {% list tabs group=instructions %}

   - Консоль управления {#console}

      1. На странице ключа перейдите на вкладку **Права доступа**.
      1. Перейдите на вкладку **{{ ui-key.yacloud.common.resource-acl.label_access-bindings }}**.
      1. Найдите аккаунт `win-secret-sa` в списке и нажмите значок ![image](../../_assets/options.svg).
      1. Нажмите кнопку **{{ ui-key.yacloud.common.resource-acl.button_assign-binding }}**.
      1. В открывшемся диалоге нажмите кнопку **Добавить роль** и выберите роль `kms.keys.encrypterDercrypter`.

   - CLI {#cli}

      Выполните команду:

      ```bash
      yc resource-manager folder add-access-binding <идентификатор_каталога> \
         --role kms.keys.encrypterDercrypter \
         --subject serviceAccount:<идентификатор_сервисного_аккаунта>
      ```

   - API {#api}

      Чтобы назначить сервисному аккаунту роль на каталог, воспользуйтесь методом REST API [setAccessBindings](../../iam/api-ref/ServiceAccount/setAccessBindings.md) для ресурса [ServiceAccount](../../iam/api-ref/ServiceAccount/index.md) или вызовом gRPC API [ServiceAccountService/SetAccessBindings](../../iam/api-ref/grpc/ServiceAccount/setAccessBindings.md).

   {% endlist %}

## Создайте секрет {#create-secret}

Создайте секрет в сервисе {{ lockbox-name }} и сохраните в нем логины и пароли пользователей, для которых будут созданы учетные записи в ОС Windows.

{% note warning %}

При выборе пароля обязательно соблюдайте требования к безопасности пароля, иначе учетная запись для пользователя не будет создана.
Пароль должен:

* быть не короче восьми символов;
* не содержать в себе имени учетной записи;
* содержать знаки минимум трех из четырех групп:
   - латинские заглавные буквы (A-Z);
   - латинские строчные буквы (a-z);
   - цифры (0-9);
   - неалфавитные символы (!, ?, %, $, # и т. д.).

{% endnote %}

{% list tabs group=instructions %}

- Консоль управления {#console}

   1. В [консоли управления]({{ link-console-main }}) выберите [каталог](../../resource-manager/concepts/resources-hierarchy.md#folder), в котором будет создан секрет.
   1. В списке сервисов выберите **{{ ui-key.yacloud.iam.folder.dashboard.label_lockbox }}**.
   1. Нажмите кнопку **{{ ui-key.yacloud.lockbox.button_create-secret }}**.
   1. В поле **{{ ui-key.yacloud.common.name }}** введите имя секрета: `win-secret`.
   1. В поле **{{ ui-key.yacloud.lockbox.forms.title_kms-key }}** укажите ключ `win-secret-key`.
   1. В блоке **{{ ui-key.yacloud.lockbox.label_version-dialog-title }}**:
      * В поле **{{ ui-key.yacloud.lockbox.forms.label_key }}** введите логин для администратора `Administrator`.
      * В поле **{{ ui-key.yacloud.lockbox.forms.label_value }}** введите пароль для администратора.
   1. При желании, добавьте еще пользователей. Для этого нажмите кнопку **{{ ui-key.yacloud.lockbox.forms.button_add-pair }}** и введите логин и пароль для следующего пользователя.
   1. Нажмите кнопку **{{ ui-key.yacloud.common.create }}**.

- CLI {#cli}

   1. Выполните команду:

      ```bash
      yc lockbox secret create \
         --name win-secret \
         --kms-key-id <идентификатор_ключа> \
         --payload "[{'key': 'Administrator', 'text_value': '<пароль_администратора>'},{'key': 'user1', 'text_value': '<пароль_пользователя>'}]" \
         --cloud-id <идентификатор_облака> \
         --folder-id <идентификатор_каталога>
      ```

      Где:

      * `--name` — имя секрета. Обязательный параметр.
      * `--kms-key-id` — идентификатор ключа {{ kms-short-name }}.
      * `--description` — описание секрета. Необязательный параметр.
      * `--payload` — содержимое секрета в виде массива формата YAML или JSON.
      * `--cloud-id` — [идентификатор облака](../../resource-manager/operations/cloud/get-id.md), в котором будет создан секрет.
      * `--folder-id` — [идентификатор каталога](../../resource-manager/operations/folder/get-id.md), в котором будет создан секрет.

- {{ TF }} {#tf}

   {% include [terraform-install](../../_includes/terraform-install.md) %}

   1. Опишите в конфигурационном файле параметры ресурсов, которые необходимо создать:

      ```hcl
      resource "yandex_lockbox_secret" "win_secret" {
         name                = "<имя_секрета>"
         folder_id           = "<идентификатор_каталога>"
         kms_key_id          = "<идентификатор_ключа_шифрования>"
      }
      resource "yandex_lockbox_secret_version" "win_secret_version" {
        secret_id = yandex_lockbox_secret.win_secret.id
        entries {
          key        = "Administrator"
          text_value = "<пароль_администратора>"
        }
        entries {
          key        = "user1"
          text_value = "<пароль_пользователя>"
        }
      }
      ```

      Где:

      * `name` — имя секрета. Обязательный параметр.
      * `folder_id` — [идентификатор](../../resource-manager/operations/folder/get-id.md) [каталога](../../resource-manager/concepts/resources-hierarchy.md#folder) в котором будет создан секрет. Необязательный параметр.
      * `kms_key_id` — идентификатор [ключа шифрования {{ kms-name }}](../../kms/concepts/key.md). Указанный ключ {{ kms-name }} используется для шифрования секрета.
      * `entries` — содержимое секрета.

      {% include [secret-version-tf-note](../../_includes/lockbox/secret-version-tf-note.md) %}

      {% note warning %}

      Для повышения безопасности пароль в конфигурационном файле лучше задавать через переменную окружения.

      {% endnote %}

   1. Создайте ресурсы:

      {% include [terraform-validate-plan-apply](../../_tutorials/_tutorials_includes/terraform-validate-plan-apply.md) %}

- API {#api}

  Чтобы создать секрет, воспользуйтесь методом REST API [create](../../lockbox/api-ref/Secret/create.md) для ресурса [Secret](../../lockbox/api-ref/Secret/index.md) или вызовом gRPC API [SecretService/Create](../../lockbox/api-ref/grpc/Secret/create.md).

{% endlist %}

1. Назначьте сервисному аккаунту `win-secret-sa` [роль](../../iam/concepts/access-control/roles.md) `lockbox.payloadViewer`:

   {% list tabs group=instructions %}

   - Консоль управления {#console}

      1. На странице секрета перейдите на вкладку **Права доступа**.
      1. Перейдите на вкладку **{{ ui-key.yacloud.common.resource-acl.label_access-bindings }}**.
      1. Найдите аккаунт `win-secret-sa` в списке и нажмите значок ![image](../../_assets/options.svg).
      1. Нажмите кнопку **{{ ui-key.yacloud.common.resource-acl.button_assign-binding }}**.
      1. В открывшемся диалоге нажмите кнопку **Добавить роль** и выберите роль `lockbox.payloadViewer`.

   - CLI {#cli}

      Выполните команду:

      ```bash
      yc resource-manager folder add-access-binding <идентификатор_каталога> \
         --role lockbox.payloadViewer \
         --subject serviceAccount:<идентификатор_сервисного_аккаунта>
      ```

   - API {#api}

      Чтобы назначить сервисному аккаунту роль на каталог, воспользуйтесь методом REST API [setAccessBindings](../../iam/api-ref/ServiceAccount/setAccessBindings.md) для ресурса [ServiceAccount](../../iam/api-ref/ServiceAccount/index.md) или вызовом gRPC API [ServiceAccountService/SetAccessBindings](../../iam/api-ref/grpc/ServiceAccount/setAccessBindings.md).

   {% endlist %}

## Создайте ВМ {#create-vm}

Создайте ВМ с ОС Windows и учетными записями администратора и пользователей.

1. Создайте файл `init.ps1` и сохраните в него код:

   ```text
   #ps1

   # logging
   Start-Transcript -Path "$ENV:SystemDrive\provision2.txt" -IncludeInvocationHeader -Force
   "Bootstrap script started" | Write-Host

   # SECRET'S ID:
   $SecretID = "<secret_id>"

   [Net.ServicePointManager]::SecurityProtocol = [Net.SecurityProtocolType]::Tls12
   $SecretURL = "https://payload.lockbox.{{ api-host }}/lockbox/v1/secrets/$SecretID/payload"

   "Secret ID is $SecretID"
   "Payload URL is $SecretURL"

   $YCToken = (Invoke-RestMethod -Headers @{'Metadata-Flavor'='Google'} -Uri "http://169.254.169.254/computeMetadata/v1/instance/service-accounts/default/token").access_token
   if (!$YCToken) {
       throw "Service Account doesn't connected to VM. Please, add Service account with roles lockbox.payloadViewer and kms.key.encryptorDecryptor to VM and try again."
   }

   # Creating parameters for REST-invokations
   $Headers = @{
       Authorization="Bearer $YCToken"
   }

   $Params = @{
       Uri = $SecretURL
       Method = "GET"
       Headers = $Headers
   }

   # Getting secret via REST invoke
   $Secret = Invoke-RestMethod @Params
   $SecretAdministratorPlainTextPassword = $Secret.entries[0].textValue

   # inserting value's from terraform
   if (-not [string]::IsNullOrEmpty($SecretAdministratorPlainTextPassword)) {
       "Set local administrator password" | Write-Host
       $SecretAdministratorPassword = $SecretAdministratorPlainTextPassword | ConvertTo-SecureString -AsPlainText -Force
       # S-1-5-21domain-500 is a well-known SID for Administrator
       # https://docs.microsoft.com/en-us/troubleshoot/windows-server/identity/security-identifiers-in-windows
       $Administrator = Get-LocalUser | Where-Object -Property "SID" -like "S-1-5-21-*-500"
       $Administrator | Set-LocalUser -Password $SecretAdministratorPassword
   }

   # Creating new users if any
   if($Secret.entries.count -gt 1) {
       foreach($User in $Secret.entries[1..($Secret.entries.count-1)]){
           $SecretUserPassword = $User.textValue | ConvertTo-SecureString -AsPlainText -Force
           New-LocalUser -Name $User.key -Password $SecretUserPassword -FullName $User.key
           Add-LocalGroupMember -Group Users -Member $User.key
           Add-LocalGroupMember -Group "Remote Desktop Users" -Member $User.key
       }
   }

   "Bootstrap script ended" | Write-Host
   ```

1. В файле `init.ps1` замените `<secret_id>` на реальный идентификатор секрета, в котором вы сохранили учетные записи пользователей.

1. Создайте ВМ:

   {% list tabs group=instructions %}

   - Консоль управления {#console}

      1. В [консоли управления]({{ link-console-main }}) откройте [каталог](../../resource-manager/concepts/resources-hierarchy.md#folder), в котором будет создана ВМ.
      1. Справа сверху нажмите кнопку **{{ ui-key.yacloud.iam.folder.dashboard.button_add }}** и выберите `{{ ui-key.yacloud.iam.folder.dashboard.value_compute }}`.
      1. В блоке **{{ ui-key.yacloud.compute.instances.create.section_image }}** выберите [образ](../../compute/concepts/image.md) с ОС Windows.
      1. В блоке **{{ ui-key.yacloud.k8s.node-groups.create.section_allocation-policy }}** выберите [зону доступности](../../overview/concepts/geo-scope.md), в которой будет находиться ВМ.
      1. В блоке **{{ ui-key.yacloud.compute.instances.create.section_base }}** задайте имя ВМ, например, `win-test`.
      1. В блоке **{{ ui-key.yacloud.compute.instances.create.field_access-advanced }}** укажите данные для доступа на ВМ:

          * Выберите [сервисный аккаунт](../../iam/concepts/index.md#sa) `win-secret-sa`.
          * Разрешите доступ к [серийной консоли](../../compute/operations/serial-console/index.md).
      1. В блоке **{{ ui-key.yacloud.common.metadata }}**:

          * В поле **{{ ui-key.yacloud.component.key-values-input.label_key }}** укажите `user-data`.
          * В поле **{{ ui-key.yacloud.component.key-values-input.label_value }}** вставьте содержимое файла `init.ps1`.
      1. Нажмите кнопку **{{ ui-key.yacloud.compute.instances.create.button_create }}**.

   - CLI {#cli}

      Выполните команду:

      ```bash
      yc compute instance create --name win-test --hostname windows10 --zone {{ region-id }}-a --create-boot-disk image-id=<imade_id> --cores 2 --core-fraction 100 --memory 4 --metadata-from-file user-data=init.ps1  --network-interface subnet-name=<subnet_name>,nat-ip-version=ipv4 --service-account-name win-test-sa --platform standard-v3
      ```

      Где:

      * imade_id — идентификатор образа с ОС Windows.
      * subnet_name — имя подсети в каталоге, в которой вы хотите разместить ВМ.

      {% include [cli-metadata-variables-substitution-notice](../../_includes/compute/create/cli-metadata-variables-substitution-notice.md) %}

   {% endlist %}


## Авторизуйтесь в ОС Windows {#login-windows}

Чтобы проверить, что данные из секрета были успешно использованы для создания пользователей, авторизуйтесь в ОС виртуальной машины:

1. В [консоли управления]({{ link-console-main }}) выберите каталог, которому принадлежит виртуальная машина.
1. Выберите сервис **{{ ui-key.yacloud.iam.folder.dashboard.label_compute }}**.
1. Выберите виртуальную машину `win-test`.
1. Перейдите на вкладку **{{ ui-key.yacloud.compute.instance.switch_console }}**.
1. В блоке **{{ ui-key.yacloud.compute.instance.switch_console }}** выберите `COM2` и нажмите кнопку **{{ ui-key.yacloud.compute.instance.console.connect }}**. В командной строке отобразится приглашение ввода команд:

    ```bash
    SAC>
    ```

1. Просмотрите список открытых каналов:

    ```bash
    SAC>ch
    Channel List

    (Use "ch -?" for information on using channels)

    # Status  Channel Name
    0 (AV)    SAC
    1 (AV)    Cmd0001
    ```

1. Чтобы перейти на канал нажмите сочетание клавиш **ESC** + **TAB** или выполните команду:

    ```bash
    SAC>ch -sn Cmd0001
    Name:                  Cmd0001
    Description:           Command
    Type:                  VT-UTF8
    Channel GUID:          e203fb79-d80d-11ea-87e3-c2679e14957d
    Application Type GUID: 63d02271-8aa4-11d5-bccf-00b0d014a2d0

    Press <esc><tab> for next channel.
    Press <esc><tab>0 to return to the SAC channel.
    Use any other key to view this channel.
    ```

1. Нажмите **Enter** и последовательно введите:

    - Имя пользователя.
    - Домен, если вход выполняется под доменной учетной записью. Иначе введите имя хоста либо оставьте пустым.
    - Пароль.

    ```bash
    Please enter login credentials.
    Username: Administrator
    Domain  :
    Password: ***************
    ```

1. Если авторизация прошла успешно, запустится экземпляр интерпретатора командной строки:

    ```bash
    C:\Windows\system32>
    ```

    Успешная авторизация означает, что данные из секрета были использованы при создании виртуальной машины.

## Как удалить созданные ресурсы {#clear-out}

Чтобы перестать платить за созданные ресурсы:
* [Удалите](../../compute/operations/vm-control/vm-delete.md) ВМ.
* [Удалите](../../lockbox/operations/secret-delete.md) секрет
* [Удалите](../../kms/operations/key.md#delete) ключ.
