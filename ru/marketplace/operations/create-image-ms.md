# Создание образа продукта на базе Windows Server для загрузки в {{ marketplace-name }}

Чтобы добавить в Marketplace продукт для {{ compute-full-name }}, нужно загрузить образ в {{ yandex-cloud }}. Продукты для {{ compute-full-name }} могут быть созданы на базе ОС Linux и Windows Server. Этот раздел поможет создать образ на базе Windows Server. Чтобы создать образ на базе Linux, воспользуйтесь инструкцией [{#T}](create-image.md). 

Если вы хотите добавить продукт для {{ managed-k8s-full-name }}, воспользуйтесь [соответствующей инструкцией](create-container.md).

## Создать ВМ {#create}

Для образов продуктов на базе Windows Server в качестве базового используйте образы из [публичного каталога](../../compute/operations/images-with-pre-installed-software/get-list.md). Они уже подготовлены для работы в {{ yandex-cloud }}.

Если у вас еще нет созданной ВМ, которую вы будете использовать в качестве базовой, [создайте](../../compute/operations/vm-create/create-windows-vm.md) ее.

## Общие рекомендации для создания образов {#advices}

* Установите приложения до запуска [утилиты `sysprep`](https://ru.wikipedia.org/wiki/Sysprep), если они это поддерживают.
* Если `sysprep` затрагивает работу установленного приложения, но внесенные ею изменения можно исправить, используйте [SetupComplete](#setupcomplete) или [TaskScheduler](#taskscheduler) для конфигурации приложения при первом старте окружения операционной системы.
* Если установка приложения до `sysprep` невозможна и конфигурация при старте не поможет, используйте SetupComplete или TaskScheduler для установки приложения при первом старте окружения операционной системы.
* Чтобы образ не оказался недоступен для подключения из внешней сети, установите параметр `passwordneverexpires` для локальной учетной записи администратора с помощью SetupComplete или TaskScheduler. Сбросить пароль извне ВМ невозможно.

## Требования к образу {#requirements}

После установки приложений убедитесь, что создаваемый вами образ по-прежнему соответствует следующим требованиям:

* В образе установлена утилита `cloudbase-init`, настроенная для работы с нашим [сервисом метаданных](../../compute/operations/vm-info/get-info.md#inside-instance), а также драйверы `virtIO` для сетевых и дисковых устройств.
* В реестре системы разрешен протокол RDP.
* В настройках системного файрвола открыты порты, необходимые для работы ваших приложений. Также должны быть созданы разрешающие правила для пакетов ICMP и WinRM по протоколу HTTPS. Кроме того, необходимо настроить разрешающие правила для протокола RDP и открыть соответствующий порт (по умолчанию — TCP-порт 3389).

С полным списком преобразований базовых образов можно ознакомиться в разделе [Изменения в образах ВМ с операционной системой Windows](../../microsoft/list-of-instances.md#changes).

## Подготовить образ к тиражированию {#preparing-image}

Перед загрузкой образа в Marketplace вам нужно подготовить образ с помощью утилиты `sysprep` и повторно очистить его от временных файлов и персональных данных.

### Подготовить файл ответов {#preparing-file}

В каждой версии ОС Windows установлена своя копия `sysprep`. Запустите локально установленную утилиту, расположенную в `$env:SystemRoot\System32\Sysprep\Sysprep.exe`, с ключами `/oobe /generalize /quiet /quit /unattend:<unattend_answer_file_path>`, где `<unattend_answer_file_path>` — путь к [файлу ответов](https://docs.microsoft.com/ru-ru/windows-hardware/manufacture/desktop/use-answer-files-with-sysprep). Файл ответов необходим для настройки и автоматизации обезличивания ОС. Если при запуске `sysprep` вы не укажете явный путь к файлу ответов, утилита попробует найти предыдущий файл ответов в кеше или запустится без него. Запуск `sysprep` без файла ответов может повредить подготовленный вами образ.

{% cut "Пример содержимого файла ответов" %}

  ```xml
  <?xml version="1.0" encoding="utf-8"?>
  <unattend xmlns="urn:schemas-microsoft-com:unattend">
      <settings pass="generalize">
          <component name="Microsoft-Windows-PnpSysprep" processorArchitecture="amd64" publicKeyToken="31bf3856ad364e35" language="neutral" versionScope="nonSxS" xmlns:wcm="http://schemas.microsoft.com/WMIConfig/2002/State" xmlns:xsi="http://www.w3.org/2001/XMLSchema-instance">
              <PersistAllDeviceInstalls>true</PersistAllDeviceInstalls>
          </component>
      </settings>
      <settings pass="oobeSystem">
          <component name="Microsoft-Windows-Shell-Setup" processorArchitecture="amd64" publicKeyToken="31bf3856ad364e35" language="neutral" versionScope="nonSxS" xmlns:wcm="http://schemas.microsoft.com/WMIConfig/2002/State">
              <OOBE>
                  <HideEULAPage>true</HideEULAPage>
                  <HideLocalAccountScreen>true</HideLocalAccountScreen>
                  <HideOEMRegistrationScreen>true</HideOEMRegistrationScreen>
                  <HideOnlineAccountScreens>true</HideOnlineAccountScreens>
                  <HideWirelessSetupInOOBE>true</HideWirelessSetupInOOBE>
                  <NetworkLocation>Work</NetworkLocation>
                  <ProtectYourPC>1</ProtectYourPC>
                  <SkipMachineOOBE>true</SkipMachineOOBE>
                  <SkipUserOOBE>true</SkipUserOOBE>
              </OOBE>
              <TimeZone>UTC</TimeZone>
          </component>
      </settings>
      <settings pass="specialize">
          <component name="Microsoft-Windows-Deployment" processorArchitecture="amd64" publicKeyToken="31bf3856ad364e35" language="neutral" versionScope="nonSxS" xmlns:wcm="http://schemas.microsoft.com/WMIConfig/2002/State" xmlns:xsi="http://www.w3.org/2001/XMLSchema-instance">
              <RunSynchronous>
                  <RunSynchronousCommand wcm:action="add">
                      <Order>1</Order>
                      <Path>cmd.exe /c ""C:\Program Files\Cloudbase Solutions\Cloudbase-Init\Python\Scripts\cloudbase-init.exe" --config-file "C:\Program Files\Cloudbase Solutions\Cloudbase-Init\conf\cloudbase-init-unattend.conf" &amp;&amp; exit 1 || exit 2"</Path>
                      <Description>Run Cloudbase-Init to set the hostname</Description>
                  </RunSynchronousCommand>
              </RunSynchronous>
          </component>
      </settings>
  </unattend>  
  ```

{% endcut %}

В приведенном выше примере файла ответов:
* сохранены установленные драйверы, которые не входят в дистрибутив ОС;
* заполнены ответы секции [OOBE](https://en.wikipedia.org/wiki/Out-of-box_experience) (Out-of-box Experience — инструмент первичной настройки системы, который требует ответы сразу после установки ОС Windows);
* настроен запуск утилиты [cloubase-init](https://cloudbase-init.readthedocs.io/en/latest/tutorial.html) для автоматизации конфигурирования первого старта ОС.

В процессе настройки на этапе _specialize_ может быть необходимо запустить powershell-скрипт. Для этого используйте секцию:

```xml
    <settings pass="specialize">
        <component name="Microsoft-Windows-Deployment" processorArchitecture="amd64" publicKeyToken="31bf3856ad364e35" language="neutral" versionScope="nonSxS" xmlns:wcm="http://schemas.microsoft.com/WMIConfig/2002/State" xmlns:xsi="http://www.w3.org/2001/XMLSchema-instance">
            <RunSynchronous>
                <RunSynchronousCommand wcm:action="add">
                    <Order>1</Order>
                    <Path>%WinDir%\System32\WindowsPowerShell\v1.0\powershell.exe -NoProfile -NoLogo -ExecutionPolicy Unrestricted -File c:\example\script\path.ps1</Path>
                </RunSynchronousCommand>
            </RunSynchronous>
        </component>
    </settings>
 ```

Шаги этапа могут быть описаны как синхронные и асинхронные действия. Подробнее о способах запуска читайте в [официальной документации](https://docs.microsoft.com/en-us/windows-hardware/customize/desktop/unattend/microsoft-windows-deployment-runsynchronous) Microsoft.

{% note info %}

Действия на этапе _specialize_ выполняются в ограниченной среде. Например, вы не сможете управлять файрволом из скрипта powershell.

{% endnote %}

### Запустить утилиту sysprep {#run-sysprep}

1. Перед запуском `sysprep` удалите предыдущий файл-тег:
  
    ```powershell
    if (Test-Path "C:\Windows\System32\Sysprep\Sysprep_succeeded.tag") {
      "Found sysprep succeeded tag, removing it" | Out-Default
      rm "C:\Windows\System32\Sysprep\Sysprep_succeeded.tag" -Confirm:$false -ea:Stop
    }
    ```

1. Запустите `sysprep` и дождитесь перехода в состояние `IMAGE_STATE_GENERALIZE_RESEAL_TO_OOBE`.
  
    ```powershell
    & $env:SystemRoot\System32\Sysprep\Sysprep.exe /oobe /generalize /quiet /quit /unattend:"<путь к файлу ответов>"
    while ($true) {
      Start-Sleep -s 5
      $ImageState = Get-ItemProperty "HKLM:\SOFTWARE\Microsoft\Windows\CurrentVersion\Setup\State" | `
        Select-Object -ExpandProperty ImageState    
      $ImageState | Out-Default
      if($ImageState -eq 'IMAGE_STATE_GENERALIZE_RESEAL_TO_OOBE') { break }
    }
    ```

1. Найдите файл-тег, созданный на предыдущем этапе, чтобы убедиться, что ОС готова к перезагрузке:
  
    ```powershell
    while ( -not (Test-Path $global:__SETUP_SYSPREP_TAG) ) {
      "Sysprep succeeded tag not yet exist, wait 5s..." | Out-Default
      Start-Sleep -s 5
    }
    ```

1. Выключите ОС после записи последних логов:
  
    ```powershell
    & shutdown /s /t 0
    ```

### Завершающая настройка ОС {#advanced-configure}

После проведения `sysprep` вам может потребоваться дополнительная настройка образа, особенно если полноценная работа ваших приложений невозможна. 

#### SetupComplete {#setupcomplete}

После завершения `sysprep` Windows загрузится с полноценным окружением. При первом запуске ОС будет искать файл `$env:SystemRoot\Setup\Scripts\SetupComplete.cmd`, чтобы его выполнить. Это можно использовать для настройки вашего образа ([пример](https://github.com/yandex-cloud/examples/tree/master/packer-ansible-windows/setup_complete)).

#### TaskScheduler {#taskscheduler}

Планировщик заданий TaskScheduler также может быть полезен при настройке образа. 

Например, следующая команда создаст задание, которое будет выполнять скрипт в поле `user-data` сервиса `metadata`:

```powershell
& schtasks /Create /TN "userdata" /RU SYSTEM /SC ONSTART /RL HIGHEST /TR "Powershell -NoProfile -ExecutionPolicy Bypass -Command \`"& {iex (irm -H @{\\\`"Metadata-Flavor\\\`"=\\\`"Google\\\`"} \\\`"http://169.254.169.254/computeMetadata/v1/instance/attributes/user-data\\\`")}\`"" | Out-Null
```

## Создать образ {#create-image}

Создайте образ из загрузочного диска ВМ. 

{% list tabs %}

- CLI

  ```powershell
    yc compute image create `
    --name             my_image_for_marketplace `
    --source-disk-name my_bootdisk_of_my_instance
  ```

{% endlist %}
