1. [Подготовьте облако к работе](#before-you-begin).
1. [Создайте инфраструктуру](#deploy).
1. [Авторизуйтесь в ОС Windows](#login-windows).

Если созданные ресурсы вам больше не нужны, [удалите их](#clear-out).


## Подготовьте облако к работе {#before-you-begin}

{% include [before-you-begin](../../_tutorials/_tutorials_includes/before-you-begin.md) %}

### Необходимые платные ресурсы {#paid-resources}

{% include [paid-resources](../../_tutorials/_tutorials_includes/secure-password-script/paid-resources.md) %}


## Создайте инфраструктуру {#deploy}

{% include [terraform-definition](../_tutorials_includes/terraform-definition.md) %}

Для создания инфраструктуры с помощью {{ TF }}:
1. [Установите {{ TF }}](../../tutorials/infrastructure-management/terraform-quickstart.md#install-terraform), [получите данные для аутентификации](../../tutorials/infrastructure-management/terraform-quickstart.md#get-credentials) и укажите источник для установки провайдера {{ yandex-cloud }} (раздел [{#T}](../../tutorials/infrastructure-management/terraform-quickstart.md#configure-provider), шаг 1).
1. Подготовьте файлы с описанием инфраструктуры:

   {% list tabs group=infrastructure_description %}

   - Готовая конфигурация {#ready}

     1. Клонируйте репозиторий с конфигурационными файлами.

        ```bash
        git clone https://github.com/yandex-cloud-examples/yc-secured-password.git
        ```

     1. Перейдите в директорию с репозиторием. В ней должны появиться файлы:
        * `yc-secured-password.tf` — конфигурация создаваемой инфраструктуры.
        * `script.tpl` — шаблон скрипта создания учетных записей администратора и пользователей.
        * `yc-secured-password.auto.tfvars` — файл с пользовательскими данными.

   - Вручную {#manual}

     1. Создайте папку для конфигурационных файлов.
     1. Создайте в папке:
        1. Конфигурационный файл `yc-secured-password.tf`:

           {% cut "yc-secured-password.tf" %}

           {% include [yc-secured-password-win-tf](../../_tutorials/_tutorials_includes/secure-password-script/yc-secured-password-win-tf.md) %}

           {% endcut %}

        1. `script.tpl` — шаблон скрипта создания учетных записей администратора и пользователей:

           {% cut "script.tpl" %}

           ```hcl
           #ps1

           # logging
           Start-Transcript -Path "$ENV:SystemDrive\provision2.txt" -IncludeInvocationHeader -Force
           "Bootstrap script started" | Write-Host

           # SECRET'S ID:
           $SecretID = "${MYSECRET_ID}"

           [Net.ServicePointManager]::SecurityProtocol = [Net.SecurityProtocolType]::Tls12
           $SecretURL = "https://payload.lockbox.api.cloud.yandex.net/lockbox/v1/secrets/$SecretID/payload"

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

           {% endcut %}

        1. Файл с пользовательскими данными `yc-secured-password.auto.tfvars`:

           ```hcl
           zone         = "<зона_доступности>"
           folder_id    = "<идентификатор_каталога>"
           admin_pass   = "<пароль_администратора>"
           username     = "<имя_пользователя>"
           user_pass    = "<пароль_пользователя>"
           image_family = "<семейство_образа>"
           ```

   {% endlist %}

   Подробнее о параметрах используемых ресурсов в {{ TF }} смотрите в документации провайдера:

   * [Облачная сеть](../../vpc/concepts/network.md) — [yandex_vpc_network]({{ tf-provider-resources-link }}/vpc_network). 
   * [Подсеть](../../vpc/concepts/network.md#subnet) — [yandex_vpc_subnet]({{ tf-provider-resources-link }}/vpc_subnet).
   * [Группа безопасности](../../vpc/concepts/security-groups.md) — [yandex_vpc_security_group]({{ tf-provider-resources-link }}/vpc_security_group).
   * [Сервисный аккаунт](../../iam/concepts/users/service-accounts.md) — [yandex_iam_service_account]({{ tf-provider-resources-link }}/iam_service_account).
   * [Назначение прав](../../iam/concepts/access-control/index.md#access-bindings) — [yandex_resourcemanager_folder_iam_member]({{ tf-provider-resources-link }}/resourcemanager_folder_iam_member).
   * [Симметричный ключ шифрования](../../kms/concepts/key.md) — [yandex_kms_symmetric_key]({{ tf-provider-resources-link }}/kms_symmetric_key).
   * [Секрет](../../lockbox/concepts/secret.md) — [yandex_lockbox_secret]({{ tf-provider-resources-link }}/lockbox_secret).
   * [Версия секрета](../../lockbox/concepts/secret.md#version) — [yandex_lockbox_secret_version_hashed]({{ tf-provider-resources-link }}/lockbox_secret_version_hashed).
   * [Образ](../../compute/concepts/image.md) — [yandex_compute_image]({{ tf-provider-resources-link }}/compute_image).
   * [Диск](../../compute/concepts/disk.md) — [yandex_compute_disk]({{ tf-provider-resources-link }}/compute_disk).
   * [Виртуальная машина](../../compute/concepts/vm.md) — [yandex_compute_instance]({{ tf-provider-resources-link }}/compute_instance).

1. В файле `yc-secured-password.auto.tfvars` задайте пользовательские параметры:
   * `zone` — [зона доступности](../../overview/concepts/geo-scope.md).
   * `folder_id` — [идентификатор каталога](../../resource-manager/operations/folder/get-id.md).
   * `admin_pass` — пароль администратора.

       {% include [userpass-warn](../../_tutorials/_tutorials_includes/secure-password-script/userpass-warn.md) %}

   * `username` — имя пользователя.
   * `user_pass` — пароль пользователя.
   * `image_family` — семейство одного из [образов](../../compute/concepts/image.md) ВМ с нужной версией ОС.

1. Создайте ресурсы:

   {% include [terraform-validate-plan-apply](../_tutorials_includes/terraform-validate-plan-apply.md) %}

После создания инфраструктуры [авторизуйтесь в ОС Windows](#login-windows).


## Авторизуйтесь в ОС Windows {#login-windows}

{% include [login-windows](../../_tutorials/_tutorials_includes/secure-password-script/login-windows.md) %}


## Как удалить созданные ресурсы {#clear-out}

Чтобы перестать платить за созданные ресурсы:

1. Откройте конфигурационный файл `yc-secured-password.tf` и удалите описание создаваемой инфраструктуры из файла.
1. Примените изменения:

    {% include [terraform-validate-plan-apply](../_tutorials_includes/terraform-validate-plan-apply.md) %}
