# Безопасная передача пароля в скрипт инициализации с помощью консоли управления, CLI или API

Чтобы [создать ВМ и защитить конфиденциальную информацию в скрипте инициализации](index.md) с помощью консоли управления, CLI или API:

1. [Подготовьте облако к работе](#before-you-begin).
1. [Создайте сервисный аккаунт](#create-account).
1. [Создайте ключ KMS](#create-key).
1. [Создайте секрет](#create-secret).
1. [Создайте ВМ](#create-vm).
1. [Авторизуйтесь в ОС Windows](#login-windows).

Если созданные ресурсы вам больше не нужны, [удалите их](#clear-out).


## Подготовьте облако к работе {#before-you-begin}

Зарегистрируйтесь в Yandex Cloud и создайте [платежный аккаунт](../../../billing/concepts/billing-account.md):
1. Перейдите в [консоль управления](https://console.yandex.cloud), затем войдите в Yandex Cloud или зарегистрируйтесь.
1. На странице **[Yandex Cloud Billing](https://center.yandex.cloud/billing/accounts)** убедитесь, что у вас подключен платежный аккаунт, и он находится в [статусе](../../../billing/concepts/billing-account-statuses.md) `ACTIVE` или `TRIAL_ACTIVE`. Если платежного аккаунта нет, [создайте его](../../../billing/quickstart/index.md) и [привяжите](../../../billing/operations/pin-cloud.md) к нему облако.

Если у вас есть активный платежный аккаунт, вы можете создать или выбрать [каталог](../../../resource-manager/concepts/resources-hierarchy.md#folder), в котором будет работать ваша инфраструктура, на [странице облака](https://console.yandex.cloud/cloud).

[Подробнее об облаках и каталогах](../../../resource-manager/concepts/resources-hierarchy.md).


### Необходимые платные ресурсы {#paid-resources}

В стоимость поддержки инфраструктуры входит:
* плата за постоянно запущенные [ВМ](../../../compute/concepts/vm.md) (см. [тарифы Yandex Compute Cloud](../../../compute/pricing.md));
* плата за использование [образа](../../../compute/concepts/image.md) (зависит от образа);
* плата за использование [ключа](../../../kms/concepts/key.md) KMS (см. [тарифы KMS](../../../kms/pricing.md));
* плата за использование [секрета](../../concepts/secret.md) (см. [тарифы Yandex Lockbox](../../pricing.md)).


## Создайте сервисный аккаунт {#create-account}

{% list tabs group=instructions %}

- Консоль управления {#console}

  1. В [консоли управления](https://console.yandex.cloud) выберите [каталог](../../../resource-manager/concepts/resources-hierarchy.md#folder), в котором хотите создать сервисный аккаунт.
  1. Перейдите в сервис **Identity and Access Management**.
  1. Нажмите кнопку **Создать сервисный аккаунт**.
  1. Введите имя сервисного аккаунта, например, `win-secret-sa`.
  1. Нажмите кнопку **Создать**.

- CLI {#cli}

  По умолчанию используется каталог, указанный при [создании](../../../cli/operations/profile/profile-create.md) профиля CLI. Чтобы изменить каталог по умолчанию, используйте команду `yc config set folder-id <идентификатор_каталога>`. Также для любой команды вы можете указать другой каталог с помощью параметров `--folder-name` или `--folder-id`. Если вы обращаетесь к ресурсу по имени, поиск будет выполнен в каталоге по умолчанию. Если вы обращаетесь к ресурсу по идентификатору, поиск будет выполнен глобально — во всех каталогах с учетом прав доступа.

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

  Чтобы создать сервисный аккаунт, воспользуйтесь вызовом gRPC API [ServiceAccountService/Create](../../../iam/api-ref/grpc/ServiceAccount/create.md) или методом [create](../../../iam/api-ref/ServiceAccount/create.md) для ресурса `ServiceAccount` REST API.

{% endlist %}
  
## Создайте ключ KMS {#create-key}

1. Создайте [ключ шифрования](../../../kms/concepts/key.md):

   {% list tabs group=instructions %}

   - Консоль управления {#console}

     1. В [консоли управления](https://console.yandex.cloud) выберите [каталог](../../../resource-manager/concepts/resources-hierarchy.md#folder), в котором будет создана ключевая пара.
     1. Перейдите в сервис **Key Management Service**.
     1. На панели слева выберите ![image](../../../_assets/console-icons/key.svg) **Симметричные ключи**.
     1. Нажмите **Создать ключ** и задайте атрибуты ключа:
         * **Имя** — `win-secret-key`.
         * **Алгоритм шифрования** — `AES-256`.
         * Для остальных параметров оставьте значения по умолчанию.
     1. Нажмите **Создать**.

     Вместе с ключом создается его первая версия: кликните по ключу в списке, чтобы открыть страницу с его атрибутами.

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

   - API {#api}

     Воспользуйтесь методом REST API [create](../../../kms/api-ref/SymmetricKey/create.md) для ресурса [SymmetricKey](../../../kms/api-ref/SymmetricKey/index.md) или вызовом gRPC API [SymmetricKeyService/Create](../../../kms/api-ref/grpc/SymmetricKey/create.md).

   {% endlist %}

1. Назначьте сервисному аккаунту `win-secret-sa` [роль](../../../iam/concepts/access-control/roles.md) `kms.keys.encrypterDecrypter`:

   {% list tabs group=instructions %}

   - Консоль управления {#console}

     1. На странице ключа перейдите на вкладку **Права доступа**.
     1. На странице **Права доступа к сервисному аккаунту** найдите аккаунт `win-secret-sa` в списке и нажмите значок ![image](../../../_assets/options.svg).
     1. Нажмите кнопку **Изменить роли**.
     1. В открывшемся диалоге нажмите кнопку **Добавить роль** и выберите роль `kms.keys.encrypterDecrypter`.

   - CLI {#cli}

     Выполните команду:

     ```bash
     yc resource-manager folder add-access-binding <идентификатор_каталога> \
       --role kms.keys.encrypterDecrypter \
       --subject serviceAccount:<идентификатор_сервисного_аккаунта>
     ```

   - API {#api}

     Чтобы назначить сервисному аккаунту роль на каталог, воспользуйтесь методом REST API [setAccessBindings](../../../iam/api-ref/ServiceAccount/setAccessBindings.md) для ресурса [ServiceAccount](../../../iam/api-ref/ServiceAccount/index.md) или вызовом gRPC API [ServiceAccountService/SetAccessBindings](../../../iam/api-ref/grpc/ServiceAccount/setAccessBindings.md).

   {% endlist %}

## Создайте секрет {#create-secret}

Создайте секрет в сервисе Yandex Lockbox и сохраните в нем логины и пароли пользователей, для которых будут созданы учетные записи в ОС Windows.

{% note warning %}

При выборе пароля обязательно соблюдайте требования к безопасности пароля, иначе учетная запись для пользователя не будет создана.
Пароль должен:

* быть не короче восьми символов;
* не содержать в себе имени учетной записи;
* содержать знаки минимум трех из четырех групп:
   * латинские заглавные буквы (A-Z);
   * латинские строчные буквы (a-z);
   * цифры (0-9);
   * неалфавитные символы (!, ?, %, $, # и т. д.).

{% endnote %}

{% list tabs group=instructions %}

- Консоль управления {#console}

  1. Перейдите в сервис **Lockbox**.
  1. Нажмите кнопку **Создать секрет**.
  1. В поле **Имя** введите имя секрета: `win-secret`.
  1. В поле **Ключ KMS** укажите ключ `win-secret-key`.
  1. В поле **Ключ** введите логин администратора `Administrator`.
  1. В поле **Значение** введите пароль для администратора.
  1. При желании добавьте еще пользователей. Для этого нажмите кнопку **Добавить ключ/значение** и введите логин и пароль для следующего пользователя.
  1. Нажмите кнопку **Создать**.

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
      * `--kms-key-id` — идентификатор ключа KMS.
      * `--description` — описание секрета. Необязательный параметр.
      * `--payload` — содержимое секрета в виде массива формата YAML или JSON.
      * `--cloud-id` — [идентификатор облака](../../../resource-manager/operations/cloud/get-id.md), в котором будет создан секрет.
      * `--folder-id` — [идентификатор каталога](../../../resource-manager/operations/folder/get-id.md), в котором будет создан секрет.

- API {#api}

  Чтобы создать секрет, воспользуйтесь методом REST API [create](../../api-ref/Secret/create.md) для ресурса [Secret](../../api-ref/Secret/index.md) или вызовом gRPC API [SecretService/Create](../../api-ref/grpc/Secret/create.md).

{% endlist %}

1. Назначьте сервисному аккаунту `win-secret-sa` [роль](../../../iam/concepts/access-control/roles.md) `lockbox.payloadViewer`:

   {% list tabs group=instructions %}

   - Консоль управления {#console}

     1. На странице секрета перейдите на вкладку **Права доступа**.
     1. Перейдите на вкладку **Права доступа**.
     1. Найдите аккаунт `win-secret-sa` в списке и нажмите значок ![image](../../../_assets/options.svg).
     1. Нажмите кнопку **Изменить роли**.
     1. В открывшемся диалоге нажмите кнопку **Добавить роль** и выберите роль `lockbox.payloadViewer`.

   - CLI {#cli}

     Выполните команду:

     ```bash
     yc resource-manager folder add-access-binding <идентификатор_каталога> \
       --role lockbox.payloadViewer \
       --subject serviceAccount:<идентификатор_сервисного_аккаунта>
     ```

   - API {#api}

   Чтобы назначить сервисному аккаунту роль на каталог, воспользуйтесь методом REST API [setAccessBindings](../../../iam/api-ref/ServiceAccount/setAccessBindings.md) для ресурса [ServiceAccount](../../../iam/api-ref/ServiceAccount/index.md) или вызовом gRPC API [ServiceAccountService/SetAccessBindings](../../../iam/api-ref/grpc/ServiceAccount/setAccessBindings.md).

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
    $SecretURL = "https://payload.lockbox.api.cloud.yandex.net/lockbox/v1/secrets/$SecretID/payload"

    "Secret ID is $SecretID"
    "Payload URL is $SecretURL"

    $YCToken = (Invoke-RestMethod -Headers @{'Metadata-Flavor'='Google'} -Uri "http://169.254.169.254/computeMetadata/v1/instance/service-accounts/default/token").access_token
    if (!$YCToken) {
        throw "Service Account doesn't connected to VM. Please, add Service account with roles lockbox.payloadViewer and kms.keys.encrypterDecrypter to VM and try again."
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

     1. В [консоли управления](https://console.yandex.cloud) откройте [каталог](../../../resource-manager/concepts/resources-hierarchy.md#folder), в котором будет создана ВМ.
     1. Справа сверху нажмите кнопку **Создать ресурс** и выберите `Виртуальная машина`.
     1. В блоке **Образ загрузочного диска** выберите [образ](../../../compute/concepts/image.md) с ОС Windows.
     1. В блоке **Расположение** выберите [зону доступности](../../../overview/concepts/geo-scope.md), в которой будет находиться ВМ.
     1. В блоке **Общая информация** задайте имя ВМ, например, `win-test`.
     1. В блоке **Дополнительно** укажите данные для доступа на ВМ:
         * Выберите [сервисный аккаунт](../../../iam/concepts/index.md#sa) `win-secret-sa`.
         * Разрешите доступ к [серийной консоли](../../../compute/concepts/serial-console.md).
     1. В блоке **Метаданные**:
         * В поле **Ключ** укажите `user-data`.
         * В поле **Значение** вставьте содержимое файла `init.ps1`.
     1. Нажмите кнопку **Создать ВМ**.

   - CLI {#cli}

     Выполните команду:

     ```bash
     yc compute instance create \
       --name win-test \
       --hostname windows10 \
       --zone ru-central1-a \
       --create-boot-disk image-id=<идентификатор_образа> \
       --cores 2 \
       --core-fraction 100 \
       --memory 4 \
       --metadata-from-file user-data=init.ps1  \
       --network-interface subnet-name=<имя_подсети>,nat-ip-version=ipv4 \
       --service-account-name win-secret-sa \
       --platform standard-v3
     ```

     Где:

     * `image_id` — идентификатор образа с ОС Windows.
     * `subnet_name` — имя подсети, в которой вы хотите разместить ВМ.

     {% note info %}
     
     Команды [`yc compute instance create`](../../../cli/cli-ref/compute/cli-ref/instance/create.md) | [`create-with-container`](../../../cli/cli-ref/compute/cli-ref/instance/create-with-container.md) | [`update`](../../../cli/cli-ref/compute/cli-ref/instance/update.md) | [`add-metadata`](../../../cli/cli-ref/compute/cli-ref/instance/add-metadata.md) поддерживают подстановку в метаданные ВМ значений переменных окружения. Эти значения, заданные в ключе `user-data` в формате `$<имя_переменной>`, в момент выполнения команды Yandex Cloud CLI будут подставлены в метаданные ВМ из переменных окружения среды, в которой выполняется команда. 
     
     Чтобы изменить такое поведение, не подставлять значение переменной из среды выполнения команды CLI и передать в метаданные ВМ имя переменной в формате `$<имя_переменной>`, используйте синтаксис с двумя символами доллара. Например: `$$<имя_переменной>`.
     
     Подробнее см. в разделе [Особенности передачи переменных окружения в метаданных через CLI](../../../compute/concepts/metadata/sending-metadata.md#environment-variables).
     
     {% endnote %}

   {% endlist %}


## Авторизуйтесь в ОС Windows {#login-windows}

Чтобы проверить, что данные из секрета были успешно использованы для создания пользователей, авторизуйтесь в ОС виртуальной машины:

1. В [консоли управления](https://console.yandex.cloud) выберите каталог, которому принадлежит виртуальная машина.
1. Перейдите в сервис **Compute Cloud**.
1. Выберите виртуальную машину `win-test`.
1. Перейдите на вкладку **Серийная консоль**.
1. В блоке **Серийная консоль** выберите `COM2` и нажмите кнопку **Подключиться**. В командной строке отобразится приглашение ввода команд:

    ```bash
    Computer is booting, SAC started and initialized.                               
                                                                                    
    Use the "ch -?" command for information about using channels.                   
    Use the "?" command for general help.                                           
                                                                                    
                                                                                    
    SAC>                                                                            
    EVENT: The CMD command is now available.                                         
    ```

1. Просмотрите список открытых каналов:

    ```bash
    SAC>ch
    Channel List

    (Use "ch -?" for information on using channels)

    # Status  Channel Name
    0 (AV)    SAC
    ```

1. При необходимости создайте новый канал с экземпляром командной оболочки:

    ```bash
    SAC>cmd
    The Command Prompt session was successfully launched.
    SAC>
    EVENT:   A new channel has been created.  Use "ch -?" for channel help.
    Channel: Cmd0001
    ```

1. Чтобы перейти на канал, нажмите сочетание клавиш **ESC** + **TAB** или выполните команду:

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

    * Имя пользователя.
    * Домен, если вход выполняется под доменной учетной записью. Иначе введите имя хоста либо оставьте пустым.
    * Пароль.

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
* [Удалите](../../../compute/operations/vm-control/vm-delete.md) ВМ.
* [Удалите](../../operations/secret-delete.md) секрет.
* [Удалите](../../../kms/operations/key.md#delete) ключ.

#### См. также {#see-also}

* [Безопасная передача пароля в скрипт инициализации с помощью Terraform](terraform.md)