# Начало работы с плагином {{ yandex-cloud }} для Citrix Virtual Apps and Desktops

Если вы пользуетесь платформой [Citrix Virtual Apps and Desktops](https://www.citrix.com/products/citrix-virtual-apps-and-desktops/), вы можете разворачивать рабочие места под ее управлением на виртуальных машинах {{ compute-full-name }}. Для этого нужно установить плагин, разработанный командой {{ yandex-cloud }}.

{% if product == "cloud-il" %}

## Подготовьте ресурсы {{ yandex-cloud }} {#setup-resources}

{% note warning %}
   
Все виртуальные машины, создаваемые в этом разделе, должны находиться в одном [каталоге](../resource-manager/concepts/resources-hierarchy.md#folder) и в одной [подсети](../vpc/concepts/network.md#subnet). Для подсети должна быть [включена функция NAT в интернет](../vpc/operations/enable-nat.md).
   
{% endnote %}

1. [Создайте сервисный аккаунт](../iam/operations/sa/create.md) для работы с компонентом Citrix Delivery Controller. Также вы можете использовать уже существующий сервисный аккаунт.
1. [Создайте статические ключи доступа](../iam/operations/sa/create-access-key.md) для сервисного аккаунта.
1. [Создайте бакет](../storage/operations/buckets/create.md) в {{ objstorage-full-name }}.
1. [Отредактируйте список управления доступа (ACL) бакета](../storage/operations/buckets/edit-acl.md) и выдайте сервисному аккаунту [разрешения](../storage/concepts/acl.md#permissions-types) `READ` и `WRITE`.
1. [Создайте виртуальную машину с операционной системой Windows](../compute/operations/vm-create/create-windows-vm.md) в {{ compute-name }} для установки компонента Citrix Delivery Controller. В блоке **Доступ** выберите сервисный аккаунт, настроенный в предыдущих пунктах.
1. (опционально) Создайте ВМ с ОС Windows для установки компонентов Citrix Studio, Citrix Storefront и Citrix License Server. Вы можете использовать для каждого из этих компонентов свою ВМ, установить их на одну отдельную ВМ или на ВМ для компонента Citrix Delivery Controller (в этом случае создавать новые ВМ не нужно).
1. Подключитесь к созданным ВМ (например, [по RDP](../compute/operations/vm-connect/rdp.md)) и установите на них компоненты по [инструкции](https://docs.citrix.com/en-us/citrix-virtual-apps-desktops/install-configure/install-core.html) в документации Citrix.
1. [Создайте виртуальную машину с ОС Windows](../compute/operations/vm-create/create-windows-vm.md), которая будет служить образцом для создаваемых рабочих мест.
1. Подключитесь к созданной ВМ (например, [по RDP](../compute/operations/vm-connect/rdp.md)) и установите на нее:

   * компонент Citrix Virtual Delivery Agent (VDA) версии не выше 1912.0.0.24265 по [инструкции](https://docs.citrix.com/en-us/citrix-virtual-apps-desktops/1912/install-configure/install-vdas.html) в документации Citrix;
   * приложения, необходимые на рабочих местах.

## Установите плагин {#install-plugin}

1. Подключитесь к ВМ, на которой установлен Citrix Delivery Controller (например, [по RDP](../compute/operations/vm-connect/rdp.md)).
1. Загрузите на ВМ архив с плагином и разархивируйте его в папку `C:\Program Files\Common Files\Citrix\HCLPlugins\CitrixMachineCreation\v1.0.0.0`.
1. Создайте в папке `C:\Program Files\Common Files\Citrix\HCLPlugins\CitrixMachineCreation\v1.0.0.0\YandexCloud` папку `Logs` и разрешите полный доступ к ней всем пользователям.
1. В той же папке `YandexCloud` запустите файл `RegisterPlugin.cmd` и дождитесь завершения работы скрипта.
1. Перезапустите службы Citrix Host Service, Citrix Broker Service и Citrix Machine Creation Service, выполнив следующие команды::

   ```powershell
   Restart-Service -DisplayName "Citrix Host Service"
   Restart-Service -DisplayName "Citrix Broker Service"
   Restart-Service -DisplayName "Citrix Machine Creation Service"
   ```
   
1. Чтобы проверить, что плагин установился, выполните следующую команду: 

   ```powershell
   Get-HypHypervisorPlugin
   ```
   
   В появившемся списке должен быть плагин `Yandex.Cloud`.

## Создайте каталог рабочих мест {#create-machine-catalog}

1. Подключитесь к ВМ, на которой установлен Citrix Studio (например, [по RDP](../compute/operations/vm-connect/rdp.md)).
1. Создайте площадку (Site) с помощью Citrix Studio по [инструкции](https://docs.citrix.com/en-us/citrix-virtual-apps-desktops/install-configure/site-create.html) в документации Citrix.
1. Скачайте на ВМ файл со скриптом создания каталога машин — рабочих мест (machine catalog) `Citrix-Provisioning.ps1`.
1. Запустите скрипт, выполнив следующую команду:

   ```powershell
   .\Citrix-Provisioning.ps1 `
     -ConnectionName <имя соединения> `
     -CloudId <идентификатор облака> `
     -FolderId <идентификатор каталога> `
     -AvailabilityZoneId <идентификатор зоны доступности> `
     -TemplateVM <имя ВМ-образца> `
     -NetworkName <имя подсети> `
     -StorageBucket <имя бакета> `
     -StorageAccessKey <идентификатор ключа доступа> `
     -StorageSecret <значение ключа доступа> `
     -ActiveDirectoryDomain <доменное имя Active Directory> `
     -ActiveDirectoryAccountNamingScheme <схема именования рабочих мест>
   ```
   
   Все параметры скрипта обязательны, кроме:
   
   * `-ConnectionName` (значение по умолчанию — `YandexCloud_Pvd`);
   * `-ActiveDirectoryDomain` (значение по умолчанию — `citrix.local`);
   * `-ActiveDirectoryAccountNamingScheme` (значение по умолчанию — `CITRIX-VM-####`: аккаунты в Active Directory, соответствующие рабочим местам, получат имена `CITRIX-VM-0001`, `CITRIX-VM-0002` и т. д.; подробнее см. в [описании параметра NamingScheme](https://developer-docs.citrix.com/projects/citrix-virtual-apps-desktops-sdk/en/latest/ADIdentity/New-AcctIdentityPool/#parameters) в документации Citrix).

1. Добавьте рабочие места в созданный каталог с помощью Citrix Studio по [инструкции](https://docs.citrix.com/en-us/citrix-virtual-apps-desktops/install-configure/machine-catalogs-manage.html#add-machines-to-a-catalog) в документации Citrix.

{% endif %}
