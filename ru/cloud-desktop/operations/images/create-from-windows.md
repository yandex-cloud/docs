---
title: Как создать образ операционной системы Windows и добавить его в {{ cloud-desktop-name }}
description: Следуя данной инструкции, вы сможете добавить образ на основе своего образа Windows.
---

# Создать образ на основе Windows

В {{ cloud-desktop-name }} вы можете создавать рабочие столы из предустановленных [системных образов](../../concepts/images.md) или собственных [пользовательских образов](../../concepts/images.md#custom-images). Пользовательские образы могут быть с [ОС Linux](create-from-compute-linux.md) или Windows.

Образ Windows создается на базе вашего образа Windows с вашей лицензией. Перед установкой необходимо уточнить в Microsoft, подходит ли ваша лицензия для работы в облачных средах. При этом лицензионные отношения действуют только между вами как клиентом и Microsoft как вендором лицензии. Вы несете полную ответственность за соблюдение [условий лицензирования Microsoft](https://www.microsoft.com/en-us/legal).

{% note info %}

Информация в этой статье не имеет юридической силы и носит ознакомительный характер.

{% endnote %}

Для создания образа в {{ cloud-desktop-name }}:

1. [Подготовьте оборудование](#prerequisites).
1. [Установите и настройте образ Windows](#windows-installation) для ваших пользователей.
1. [Настройте образ Windows](#windows-cloud) для работы в облаке.
1. [Установите облачный агент](#agent-install).
1. (Опционально) [Установите Cloudbase-Init](#cloudbase-init).
1. (Опционально) [Генерализируйте образ](#generalize).
1. [Добавьте образ в {{ compute-name }}](#image-to-compute).
1. [Создайте образ в {{ cloud-desktop-name }}](#image-to-desktop).

## Предварительные требования {#prerequisites}

Чтобы использовать образ с операционной системой семейства Windows в {{ cloud-desktop-name }}, вы создадите и настроите его с помощью системы виртуализации [QEMU](https://www.qemu.org/).

Чтобы настроить образ, вам потребуются:

* Компьютер с архитектурой процессора x86-64.
* Операционная система Linux. При использовании других ОС:

    * Для macOS в качестве ускорителя QEMU можно использовать `hvf`.
    * Для Windows, чтобы работать с QEMU:
        * Включите поддержку виртуализации в BIOS/UEFI.
        * Активируйте поддержку Hyper-V. Для серверных ОС установите компонент Virtual Machine Platform.
        * Используйте ускоритель `whpx`.
* Установочный образ Windows в формате [ISO](https://ru.wikipedia.org/wiki/ISO-образ).
* Набор драйверов [Virtio для Windows](https://fedorapeople.org/groups/virt/virtio-win/direct-downloads/stable-virtio/virtio-win.iso).

{% note warning %}

Убедитесь, что операционная система в создаваемом образе поддерживает подключение к удаленному рабочему столу по протоколу [Remote Desktop Protocol](https://{{ lang }}.wikipedia.org/wiki/Remote_Desktop_Protocol) (RDP).

{% endnote %}

## Установка и настройка образа Windows {#windows-installation}

1. На вашем компьютере создайте файл будущего образа загрузочного диска. Для этого выполните команду:

    ```bash
    qemu-img create -f qcow2 image.qcow2 20480M
    ```

    Где:
    * `image.qcow2` — имя файла образа загрузочного диска.
    * `20480M` — размер загрузочного диска ОС в образе в мегабайтах.

        {% note info %}

        Рекомендуется указывать размер не менее `16384M`. Иначе при установке или последующей настройке ОС на загрузочном диске может оказаться недостаточно места.

        {% endnote %}

1. Запустите виртуальную машину для установки и настройки Windows. Для этого выполните команду:

    ```bash
    qemu-kvm \
      -cpu "qemu64,hv-relaxed,hv-vapic,hv-spinlocks=0x1fff,hv-time" \
      -name win-image \
      -device "virtio-net,netdev=user.0" \
      -netdev user,id=user.0 \
      -drive "file=image.qcow2,if=virtio,cache=writeback,discard=ignore,format=qcow2" \
      -drive "file=windows.iso,media=cdrom" \
      -drive "file=virtio-win.iso,media=cdrom" \
      -parallel none -smp "cpus=2" \
      -boot "once=d" \
      -machine "type=q35,accel=kvm" \
      -m "4096M" \
      -nic "none" \
      -device qemu-xhci \
      -device usb-tablet \
      -vnc "0.0.0.0:85"
    ```

    Где:

    * `file=image.qcow2` — путь к созданному ранее файлу образа загрузочного диска.
    * `file=windows.iso` — путь к ISO-файлу с установочным образом Windows.
    * `file=virtio-win.iso` — путь к ISO-файлу с набором драйверов `Virtio для Windows`.
    * `-vnc "0.0.0.0:85"` — необязательный параметр. Используйте его, если ваша сборка QEMU не поддерживает графический режим управления виртуальной машиной. 

    {% note info %}

    Если вы настраиваете образ в macOS, замените `type=q35,accel=kvm` на `type=q35,accel=hvf`, если в Windows — `type=q35,accel=whpx`.

    Если потребуется указать полный путь к файлу запуска QEMU, учитывайте, что название файла может различаться в зависимости от ОС и вариантов сборки QEMU. Наиболее распространенные имена файлов: `qemu-x86_64`, `qemu-system-x86_64`, `qemu-system-x86_64w`, `qemu-gtk`, `qemu`.

    {% endnote %}

    Если ваша сборка QEMU не поддерживает графический режим управления виртуальной машиной, вы можете подключиться к ВМ по [VNC](https://ru.wikipedia.org/wiki/Virtual_Network_Computing) на локальный порт `tcp/5985` (`localhost:5985`). Для подключения используйте любой VNC-клиент, например `RealVNC`, `Remmina` или `ultraVNC`. В macOS можно использовать предустановленный VNC-клиент **Общий экран**.

1. Следуйте инструкциям на экране, чтобы установить ОС Windows из образа ISO.

    На этапе выбора хранилища для установки операционной системы выберите **Load driver**, чтобы установить драйвер `virtio-storage`.

    {% note tip %}

    Нужный драйвер находится в директории `viostor` на виртуальном CD-дисководе, в который смонтирован ISO-файл с набором драйверов `Virtio для Windows`. Внутри директории `viostor` выберите поддиректорию, соответствующую версии устанавливаемой операционной системы.

    {% endnote %}

1. После завершения установки ОС войдите в систему и установите необходимые драйверы оборудования, запустив файл `virtio-win-guest-tools.exe`, расположенный в корневой директории смонтированного CD-диска с драйверами `Virtio для Windows`.
1. Убедитесь, что в операционной системе установлен и работает сервис **Подключение к удаленному рабочему столу** (RDP).
1. Настройте Windows и установите программное обеспечение в соответствии с потребностями ваших пользователей.

## Настройка образа для работы в {{ yandex-cloud }} {#windows-cloud}

1. Запустите командную строку `cmd` от имени администратора.
1. Активируйте `serial console` для загрузчика ОС:

    ```cmd
    bcdedit /ems "{current}" on
    bcdedit /emssettings EMSPORT:2 EMSBAUDRATE:115200
    ```
1. Отключите функции энергосбережения:

    ```cmd
    powercfg -setactive "8c5e7fda-e8bf-4a96-9a85-a6e23a8c635c"
    powercfg -change -monitor-timeout-ac 0
    powercfg -change -standby-timeout-ac 0
    powercfg -change -hibernate-timeout-ac 0
    ```
1. Запустите терминал `PowerShell` от имени администратора.
1. Для виртуализованных аппаратных часов установите формат времени UTC:

    ```powershell
    #ps1
    Set-ItemProperty -Path "HKLM:\SYSTEM\CurrentControlSet\Control\TimeZoneInformation" -Name "RealTimeIsUniversal" -Value 1 -Type DWord -Force
    ```
1. Отключите автоматическое назначение локальных IPv4-адресов для сетевых интерфейсов, которым не удалось назначить IP-адрес (APIPA):

    ```powershell
    #ps1
    Set-ItemProperty -Path "HKLM:\SYSTEM\CurrentControlSet\Services\Tcpip\Parameters" -Name "IPAutoconfigurationEnabled" -Value 0 -Type DWord -Force
    ```
1. Разрешите выключение ОС без активных пользовательских сессий:

    ```powershell
    #ps1
    Set-ItemProperty -Path "HKLM:\SOFTWARE\Microsoft\Windows\CurrentVersion\Policies\System" -Name "ShutdownWithoutLogon" -Value 1
    ```
1. Установите минимальное время показа сообщения о выключении ОС при наличии активных пользовательских процессов:

    ```powershell
    #ps1
    Set-ItemProperty -Path "HKLM:\SOFTWARE\Microsoft\Windows NT\CurrentVersion\Windows" -Name "ShutdownWarningDialogTimeout" -Value 1
    ```
1. Отключите автоматическую оптимизацию дисков (дефрагментация/TRIM):

    ```powershell
    #ps1
    Get-ScheduledTask -TaskName "ScheduledDefrag" | Disable-ScheduledTask
    ```
1. Разрешите трафик ICMPv4 (если Windows Firewall не отключен):

    ```powershell
    #ps1
    Get-NetFirewallRule -Name "vm-monitoring-icmpv4" | Enable-NetFirewallRule
    ```
1. (Опционально) Разрешите подключение по RDP с обязательной аутентификацией пользователей при подключении:

    {% note info %}

    Приведенный набор команд разрешает подключение к встроенному RDP-серверу в ОС Windows. Если RDP-сервер недоступен в операционной системе, команда вернет ошибку.

    В русскоязычной версии Windows группа правил брандмауэра `Remote Desktop` может называться по-русски. Если команда с параметром `-DisplayGroup "Remote Desktop"` завершится ошибкой, укажите локализованное имя этой группы.

    {% endnote %}

    ```powershell
    #ps1
    Get-CimInstance -ClassName Win32_TSGeneralSetting -Namespace root\cimv2\terminalservices | Invoke-CimMethod -MethodName SetUserAuthenticationRequired -Arguments @{ UserAuthenticationRequired = 1 }
    Set-ItemProperty -Path "HKLM:\System\CurrentControlSet\Control\Terminal Server" -Name "fDenyTSConnections" -Value 0
    Enable-NetFirewallRule -DisplayGroup "Remote Desktop"
    ```

## Установка облачного агента {#agent-install}

1. Запустите терминал `PowerShell` от имени администратора.
1. Установите облачный агент:

    ```powershell
    Invoke-WebRequest 'https://{{ s3-storage-host }}/yandexcloud-vdi-agent/install.ps1' -OutFile "$($Env:temp)\install.ps1"
    cd $($Env:temp)
    Powershell.exe -ExecutionPolicy Bypass -File .\install.ps1
    mkdir "C:\Program Files\Yandex.Cloud\Cloud Desktop\"
    cp .\desktopagentInstall\desktopagent.exe 'C:\Program Files\Yandex.Cloud\Cloud Desktop\'

    # Create Desktop Agent service
    $ServiceName = "cloud-desktop-agent"
    $ServicePort = 5050
    $ServicePath = "C:\Program Files\Yandex.Cloud\Cloud Desktop\desktopagent.exe"

    $p = @{
        Name = $ServiceName
        DisplayName = "Yandex Desktop Agent"
        BinaryPathName = "$ServicePath start --address :$ServicePort"
        Description = "Yandex Desktop Agent, automates actions from Yandex Desktop control plane service."
        StartupType = "Automatic"
    }
    New-Service @p

    & sc.exe config $ServiceName start= delayed-auto
    & sc.exe failure $ServiceName reset= 86400 actions= restart/1000/restart/1000/restart/1000

    ### The agent startup is commented because starting the agent outside the Cloud Desktop will fail. Do not start the agent during the image preparation stage.
    # Start-Service $ServiceName

    # Create firewall rule for Desktop Agent
    if ($Rule = Get-NetFirewallRule -Name "DESKTOP-AGENT-HTTPS-In-TCP" -ErrorAction SilentlyContinue) {
        $Rule | Remove-NetFirewallRule
    }

    New-NetFirewallRule `
        -Group "Yandex Desktop Agent" `
        -DisplayName "Yandex Desktop Agent (HTTPS-In)" `
        -Name "DESKTOP-AGENT-HTTPS-In-TCP" `
        -LocalPort $ServicePort `
        -Action "Allow" `
        -Protocol "TCP" `
        -Program "$ServicePath"
    ```
1. Создайте задачу для корректной работы ВМ после первого запуска в сервисе:

    ```powershell
    & mkdir "C:\Scripts"
    & schtasks /Create /TN "SetNetSettings" /RU System /SC ONSTART /RL HIGHEST /TR "Powershell -NoProfile -ExecutionPolicy Bypass -File \`"C:\Scripts\StartupSettings.ps1`"" | Out-Null
    ```
1. В папке `C:\Scripts` создайте файл `StartupSettings.ps1` со следующим содержимым:
  
    ```powershell
    # Find the default gateway to route metadata service to it
    $output = Get-WmiObject -Class Win32_IP4RouteTable | Where-Object { $_.Destination -eq '0.0.0.0' -and $_.Mask -eq '0.0.0.0' } | Sort-Object Metric1 | Select-Object -ExpandProperty NextHop

    if (-not $output) {
        # Practically unreachable
        Write-Error "Default gateway was not found!"
        exit
    }

    # If a route for the metadata address already exists, we will replace it
    $routeToRemove = Get-WmiObject -Class Win32_IP4RouteTable | Where-Object { $_.Destination -eq '169.254.169.254' } | Select-Object -ExpandProperty Destination

    if ($routeToRemove) {
        Write-Output "Route for 169.254.169.254 already exists"
        $routeToRemove | ForEach-Object {
          route delete $routeToRemove
        }
        Write-Output "Deleted old route for metadata address"
    }

    route -p add 169.254.169.254 mask 255.255.255.255 $output metric 1

    # Getting IPv6 Net Adapter
    $IPv6Adapter = Get-NetAdapter | where {$_.Linklayeraddress -like "D0-1D*"}

    if($IPv6Adapter) {
        if((Get-NetAdapterBinding -Name $IPv6Adapter.Name -ComponentID ms_tcpip).Enabled -eq "True") {
            $outNull = Set-NetAdapterBinding -Name $IPv6Adapter.Name -ComponentID ms_tcpip -Enabled $false -Confirm:$false
            Start-Sleep 5
        }
    }

    if(!$(Get-Service -DisplayName "Yandex Desktop Agent") -or !$(Get-Item -Path "C:\Program Files\Yandex.Cloud\Cloud Desktop\desktopagent.exe" -ErrorAction SilentlyContinue)) {
        Invoke-WebRequest 'https://{{ s3-storage-host }}/yandexcloud-vdi-agent/install.ps1' -OutFile "$($Env:temp)\install.ps1"
        cd $($Env:temp)
        Powershell.exe -ExecutionPolicy Bypass -File .\install.ps1
        mkdir "C:\Program Files\Yandex.Cloud\Cloud Desktop\"
        cp .\desktopagentInstall\desktopagent.exe 'C:\Program Files\Yandex.Cloud\Cloud Desktop\'

        # Create Desktop Agent service
        $ServiceName = "cloud-desktop-agent"
        $ServicePort = 5050
        $ServicePath = "C:\Program Files\Yandex.Cloud\Cloud Desktop\desktopagent.exe"

        $p = @{
            Name = $ServiceName
            DisplayName = "Yandex Desktop Agent"
            BinaryPathName = "$ServicePath start --address :$ServicePort"
            Description = "Yandex Desktop Agent, automates actions from Yandex Desktop control plane service."
            StartupType = "Automatic"
        }
        New-Service @p

        & sc.exe config $ServiceName start= delayed-auto
        & sc.exe failure $ServiceName reset= 86400 actions= restart/1000/restart/1000/restart/1000

        Start-Service $ServiceName

        # Create firewall rule for Desktop Agent
        if ($Rule = Get-NetFirewallRule -Name "DESKTOP-AGENT-HTTPS-In-TCP" -ErrorAction SilentlyContinue) {
            $Rule | Remove-NetFirewallRule
        }

        New-NetFirewallRule `
            -Group "Yandex Desktop Agent" `
            -DisplayName "Yandex Desktop Agent (HTTPS-In)" `
            -Name "DESKTOP-AGENT-HTTPS-In-TCP" `
            -LocalPort $ServicePort `
            -Action "Allow" `
            -Protocol "TCP" `
            -Program "$ServicePath"
    }
    
    # Stores Windows RE (WinRE) configuration info $nfo string
    [string]$nfo = reagentc /info

    # Checks if Windows RE (WinRE) is enabled and extracts its disk/partition info
    # If enabled, disables WinRE via reagentc and deletes its partition using DiskPart
    if($nfo -match ".*Windows RE status:.*Enabled.*"){
        # Locate the disk number it is on
        $nfo -match ".*Windows RE location.*harddisk(\d+)" | Out-Null
        $disk = $Matches[1]
        # Locate the partition it is on
        $nfo -match ".*Windows RE location.*partition(\d+)" | Out-Null
        $partition = $Matches[1]

        $WinREInfo = New-Object -TypeName psobject -Property $([ordered]@{Enabled='True';Disk=$disk;Partition=$partition;Resizable=(((Get-Disk -Number $disk | Get-Partition).PartitionNumber | Measure-Object -Maximum).Maximum -eq $partition);CurrentSize=([string]((Get-Disk -Number $disk | Get-Partition | Where-Object PartitionNumber -eq $partition).Size / 1MB) +'MB');A1_Key=[System.GUID]::NewGuid()})
    } else {
        $WinREInfo = New-Object -TypeName psobject -Property $([ordered]@{Enabled='False';Disk='N/A';Partition='N/A';Resizable='N/A';CurrentSize='N/A';A1_Key=[System.GUID]::NewGuid()})
    }

    if($WinREInfo.Enabled -eq "True" -and $WinREInfo.Partition -ne "N/A") {
        & reagentc /disable
        $outScript = "select disk $($WinREInfo.Disk)
    select partition $($WinREInfo.Partition)
    delete partition override
    exit
    "
        $outScript | Out-File C:\Scripts\winre.txt -Encoding ascii
        & diskpart /s C:\Scripts\winre.txt
        $outNull = Remove-Item "C:\Scripts\winre.txt" -Force -Confirm:$false
    }

    # Force extend partition
    $DiskSpace = Get-PartitionSupportedSize -DriveLetter "C"
    if((Get-Partition -DriveLetter "C").Size -lt $DiskSpace.SizeMax) {
        $outNull = Resize-Partition -DriveLetter "C" -Size $DiskSpace.SizeMax
    }

    # Format RAW disks
    $RAWDisks = Get-Disk | where {$_.PartitionStyle -eq "RAW"} 
    if($RAWDisks) { 
        foreach($RAWDisk in $RAWDisks) { 
            $outNull = Initialize-Disk -Number $RAWDisk.Number -PartitionStyle GPT -PassThru | New-Partition -AssignDriveLetter -UseMaximumSize | Format-Volume -FileSystem NTFS -NewFileSystemLabel "UserData" -Confirm:$false
        } 
    }  


    if ($LASTEXITCODE -eq 0) {
        Write-Output "Successfully create route for metadata service"
    } else {
        Write-Error "Error on creating route for metadata service! Exit code: $LASTEXITCODE"
    }
    ```

    Приведенный скрипт содержит настройки запуска и работы системной службы облачного агента {{ cloud-desktop-name }}, а также настройку сетевого маршрута к [сервису метаданных](../../../compute/concepts/vm-metadata.md), доступному изнутри ВМ.

    {% note warning %}

    Сервис метаданных доступен по адресу `http://169.254.169.254`.
    
    Не ограничивайте сетевой доступ к этому адресу из операционной системы. Доступ к метаданным виртуальной машины необходим для корректной работы рабочего стола {{ cloud-desktop-name }}.

    {% endnote %}


## Установка Cloudbase-Init {#cloudbase-init}

В подготовленный образ вы можете установить [Cloudbase-Init](https://cloudbase.it/cloudbase-init/). При использовании образа в {{ cloud-desktop-name }} эта программа автоматически расширяет файловую систему и загрузочный раздел ОС до фактического размера загрузочного диска.

Чтобы установить Cloudbase-Init, выполните следующие команды в терминале PowerShell, запущенном от имени администратора:

```powershell
# Install Cloudbase-Init
$WorkDirectory = "C:\Scripts"
$outNull = Start-BITSTransfer -Source "https://www.cloudbase.it/downloads/CloudbaseInitSetup_Stable_x64.msi" -Destination $WorkDirectory
$outNull = Start-Process -FilePath 'msiexec.exe' -ArgumentList "/i $WorkDirectory\CloudbaseInitSetup_Stable_x64.msi /qn" -Wait
Start-Sleep 60

$outScript = "[DEFAULT]
username=Admin
groups=Administrators
inject_user_password=true
config_drive_raw_hhd=true
config_drive_cdrom=true
config_drive_vfat=true
bsdtar_path=C:\Program Files\Cloudbase Solutions\Cloudbase-Init\bin\bsdtar.exe
mtools_path=C:\Program Files\Cloudbase Solutions\Cloudbase-Init\bin\
verbose=true
debug=true
logdir=C:\Program Files\Cloudbase Solutions\Cloudbase-Init\log\
logfile=cloudbase-init-unattend.log
default_log_levels=comtypes=INFO,suds=INFO,iso8601=WARN,requests=WARN
logging_serial_port_settings=COM1,115200,N,8
mtu_use_dhcp_config=true
ntp_use_dhcp_config=true
local_scripts_path=C:\Program Files\Cloudbase Solutions\Cloudbase-Init\LocalScripts\
metadata_services=cloudbaseinit.metadata.services.ec2service.EC2Service
plugins=cloudbaseinit.plugins.common.mtu.MTUPlugin,cloudbaseinit.plugins.common.sethostname.SetHostNamePlugin,cloudbaseinit.plugins.windows.extendvolumes.ExtendVolumesPlugin,cloudbaseinit.plugins.common.userdata.UserDataPlugin
allow_reboot=false
stop_service_on_exit=false
check_latest_version=false"
$outScript | Out-File -FilePath "C:\Program Files\Cloudbase Solutions\Cloudbase-Init\conf\cloudbase-init.conf" -Confirm:$false -Force
$outScript | Out-File -FilePath "C:\Program Files\Cloudbase Solutions\Cloudbase-Init\conf\cloudbase-init-unattend.conf" -Confirm:$false -Force
```

## Завершение работы с образом {#generalize}

После настройки рекомендуем выполнить [генерализацию образа](https://learn.microsoft.com/en-us/windows-hardware/manufacture/desktop/sysprep--generalize--a-windows-installation) при помощи утилиты `Sysrep`. Это подготовит Windows для клонирования и последующего использования на других компьютерах. 

Чтобы генерализировать образ, запустите терминал PowerShell от имени администратора и выполните команды:

```powershell
# Global vars
$WorkDirectory = "C:\sysprep"

# Download the unattend.xml file for Sysprep
New-Item -Path $WorkDirectory -ItemType Directory
Start-BitsTransfer https://{{ s3-storage-host }}/cloudbase/sysprepunattend-cloudbase-init.xml -Destination $WorkDirectory\unattend.xml

# Start Sysprep
& $env:SystemRoot\System32\Sysprep\Sysprep.exe /oobe /generalize /quiet /quit /unattend:"$WorkDirectory\unattend.xml"

# Wait for correct system state
do {
    Start-Sleep -s 5
    $SetupState = Get-ItemProperty "HKLM:\SOFTWARE\Microsoft\Windows\CurrentVersion\Setup\State"
    $ImageState = $SetupState | Select-Object -ExpandProperty ImageState
} while ($ImageState -ne 'IMAGE_STATE_GENERALIZE_RESEAL_TO_OOBE')

Remove-Item $WorkDirectory -Recurse -Force
Remove-Item "C:\Windows\Setup\Scripts\*" -Force -ErrorAction SilentlyContinue

# Wait for Sysprep tag
while (-not (Test-Path 'C:\Windows\System32\Sysprep\Sysprep_succeeded.tag') ) {
    Start-Sleep -s 1
}

Stop-Computer -Force
```

В результате выполнения последней команды сценария виртуальная машина будет остановлена, а на вашем компьютере в созданном ранее файле `image.qcow2` будет сохранен загрузочный образ ВМ в формате [QCOW2](https://ru.wikipedia.org/wiki/Qcow2).

## Добавление образа в {{ compute-name }} {#image-to-compute}

1. [Загрузите образ](../../../storage/operations/objects/upload.md) в {{ objstorage-full-name }}.
1. [Получите ссылку](../../../storage/operations/objects/link-for-download.md) на загруженный образ.
1. [Импортируйте образ](../../../compute/operations/image-create/upload.md) в {{ compute-full-name }}.

    Если вы используете [{{ yandex-cloud }} CLI](../../../cli/quickstart.md), вы можете импортировать образ с помощью команды, указав в ней полученную ранее ссылку:

    {% list tabs group=instructions %}

    - {{ yandex-cloud }} CLI {#cli}

      ```bash
      yc compute image create \
        --name <имя_образа> \
        --description <описание_образа> \
        --os-type windows \
        --source-uri "<ссылка_на_образ_в_Object_Storage>"
      ```

    {% endlist %}

## Добавление образа в {{ cloud-desktop-name }} {#image-to-desktop}

{% list tabs group=instructions %}

- Консоль управления {#console}

  1. В [консоли управления]({{ link-console-main }}) перейдите в каталог, в котором будет создан образ. 
  1. [Перейдите](../../../console/operations/select-service.md#select-service) в сервис **{{ ui-key.yacloud.iam.folder.dashboard.label_cloud-desktop }}**.
  1. На панели слева выберите ![image](../../../_assets/console-icons/layers.svg) **{{ ui-key.yacloud.vdi.label_desktop-images }}**.
  1. Нажмите кнопку **{{ ui-key.yacloud.vdi.button_add-image }}**.
  1. В поле **{{ ui-key.yacloud.vdi.label_image-source }}** выберите `{{ ui-key.yacloud.iam.folder.dashboard.label_compute }}`.
  1. В поле **{{ ui-key.yacloud.vdi.label_image }}** выберите образ, добавленный ранее.
  1. Задайте имя создаваемого образа.
  1. Нажмите кнопку **{{ ui-key.yacloud.common.add }}**.

{% endlist %}

После создания образа вы сможете использовать его как образ загрузочного диска для групп рабочих столов.

## Изменение размера загрузочного диска без Cloudbase-Init {#resize-disk}

Если вы не используете Cloudbase-Init и хотите изменить размер загрузочного диска в группе рабочих столов:

1. Расширьте размер файловой системы загрузочного диска на рабочем столе. Например, с помощью оснастки `diskmgmt.msc`.
1. На основе этого рабочего стола [создайте](/.create-from-desktop.md) новый образ {{ cloud-desktop-name }}.
1. Используйте новый образ как образ загрузочного диска для групп рабочих столов.