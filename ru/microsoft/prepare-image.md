# Подготовка собственных образов с продуктами Microsoft

Вы можете подготовить свои образы продуктов Microsoft, чтобы использовать их в {{ yandex-cloud }} с [вашей собственной лицензией](byol.md). Обязательно свяжитесь с Microsoft и уточните, что ваша лицензия подходит для использования в облачных средах. Рекомендуем собирать образы на ОС Linux.

## Подготовка образа {#prepare}

Чтобы создать образ, готовый к использованию в {{ yandex-cloud }}:

1. [Установите QEMU](https://www.qemu.org/download/).
1. [Установите Packer](../tutorials/infrastructure-management/packer-quickstart#install-packer).
1. Загрузите архив с [конфигурациями для Packer](https://{{ s3-storage-host }}/packer-recipies/windows-packer.zip) и распакуйте его в нужную папку, например `windows-packer`.
1. Загрузите [образ с драйверами](https://fedorapeople.org/groups/virt/virtio-win/direct-downloads/stable-virtio/virtio-win.iso) и откройте его. Переместите папки `NetKVM`, `vioserial` и `viostor` в папку `windows-packer/drivers`. Папки содержат драйверы для разных ОС — обязательно используйте драйверы для вашей.
1. Выберите подходящую для вашего продукта Microsoft конфигурацию для Packer и внесите следующие изменения в ее конфигурационный файл:
   1. Укажите в параметре `iso_url` путь к вашему дистрибутиву. 
   1. В блоке `cd_files` укажите пути к распакованным драйверам для вашей версии ОС, например:

      ```
      cd_files = [
          "../drivers/NetKVM/2k19/amd64/*",
          "../drivers/viostor/2k19/amd64/*",
          "../drivers/vioserial/2k19/amd64/*",
          "../scripts/qemu/*",
          "Autounattend.xml"
        ]
      ```

      Обратите внимание, что Packer чувствителен к регистру. Если вы поместили папки с драйверами в другое место, укажите соответствующие пути.
      
   1. Узнайте контрольную сумму вашего дистрибутива (например, выполните `openssl dgst -sha256 <путь к дистрибутиву>`). Вставьте полученное значение в параметр `iso_checksum` после `sha256:`.
   1. (Опционально) Если вы работаете на MacOS, вам потребуется заменить значение `accelerator  = "kvm"` на `accelerator  = "hvf"`.
1. Задайте пароль пользователя `Administrator`. Для этого в файле `Autounattend.xml` в секцию `oobeSystem` добавьте раздел `UserAccounts`, указав пароль внутри тега `Value`:

   ```xml
   <settings pass="oobeSystem">
       <component name="Microsoft-Windows-Shell-Setup" processorArchitecture="amd64" publicKeyToken="31bf3856ad364e35" language="neutral" versionScope="nonSxS" xmlns:wcm="http://schemas.microsoft.com/WMIConfig/2002/State" xmlns:xsi="http://www.w3.org/2001/XMLSchema-instance">
           <OOBE>
               <HideEULAPage>true</HideEULAPage>
               <HideLocalAccountScreen>true</HideLocalAccountScreen>
               <HideOEMRegistrationScreen>true</HideOEMRegistrationScreen>
               <HideOnlineAccountScreens>true</HideOnlineAccountScreens>
               <HideWirelessSetupInOOBE>true</HideWirelessSetupInOOBE>
               <ProtectYourPC>1</ProtectYourPC>
           </OOBE>
           <RegisteredOwner />
           <TimeZone>UTC</TimeZone>
           <UserAccounts>
               <AdministratorPassword>
                   <Value><пароль_администратора></Value>
                   <PlainText>true</PlainText>
               </AdministratorPassword>
           </UserAccounts>
       </component>
   </settings>
   ```

1. Перейдите в каталог с нужной конфигурацией образа (например, `external-windows-packer/ws22gui-qemu`) и выполните команду `packer build .`. 

{% note info %}

Чтобы отслеживать сборку образа и видеть ошибки, вы можете подключиться к ВМ по VNC. Например, с помощью VNC-клиента от [RealVNC](https://www.realvnc.com/en/connect/download/viewer/).

{% endnote %}

После выполнения команды будет создан дисковый образ в формате `.qcow2`.

## Загрузите образ в {{ objstorage-name }} {#upload-to-storage}

Загрузите созданный образ в {{ objstorage-name }} с помощью одного из [поддерживаемых инструментов](../storage/tools).

## Импортируйте образ в {{ compute-name }} {#import-to-compute-cloud}

С помощью [API {{ compute-name }}](../compute/api-ref/Image/create.md) вы можете импортировать образ в сервис:

{% list tabs group=programming_language %}

- CLI {#cli}
  
  ```
  yc compute image create --name <название образа> --description <описание образа> --os-type windows --source-uri <ссылка на образ в Object Storage>
  ```

- Bash {#bash}

  ```bash
  curl -H "Authorization: Bearer `yc iam create-token`" -H  "accept: application/json" -X POST https://compute.{{ api-host }}/compute/v1/images -d '{"folderId": "<ID вашего каталога>", "name": "<название образа>", "description": "<описание образа>", "os": {"type": "WINDOWS"}, "pooled": false, "uri": "<ссылка на образ в Object Storage>"}'
  ```

- PowerShell {#powershell}

  ```powershell
  function Create-YCImage {
    param(
      [ValidateNotNullOrEmpty()]
      [string]$folderId = "",

      [ValidateNotNullOrEmpty()]
      [string]$name = "",

      [string]$description = "",

      [ValidateNotNullOrEmpty()]
      [string]$os_type = "WINDOWS",

      [int64]$minDiskSizeGb = 50GB,

      [ValidateNotNullOrEmpty()]
      [string]$uri = ""
    )

    $body = @"
  {
    "folderId": "$folderId",
    "name": "$name",
    "description": "$description",
    "os.type": "$os_type",
    "minDiskSize": "$minDiskSizeGb",
    "os": {
      "type": "$os_type"
    },
    "uri": "$uri"
  }
  "@

    Invoke-WebRequest `
      -Method POST `
      -URI https://compute.{{ api-host }}/compute/v1/images `
      -header @{ "Authorization" = "Bearer $(& yc iam create-token)" } `
      -ContentType 'Application/json' `
      -body $body
  }


  $folderId = "<ID вашего каталога>"

  Create-YCImage `
    -folderId $folderId `
    -name "<название образа>" `
    -uri "<ссылка на образ в Object Storage>"

  ```

{% endlist %}

Импортированный образ можно использовать при создании загрузочного диска [ВМ](../glossary/vm.md).
