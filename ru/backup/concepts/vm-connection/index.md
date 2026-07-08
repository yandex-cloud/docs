---
title: Подключение защищаемых ресурсов к {{ backup-name }}
description: Из этой статьи вы узнаете, какие защищаемые ресурсы можно подключить к {{ backup-name }}.
---

# Подключение защищаемых ресурсов к {{ backup-name }}


Чтобы создавать резервные копии [виртуальных машин](../../../compute/concepts/vm.md) [{{ compute-full-name }}](../../../compute/index.yaml), [серверов {{ baremetal-name }}](../../../baremetal/concepts/servers.md) или других [защищаемых ресурсов](../index.md#protected-resources) в сервисе {{ backup-name }}, эти ресурсы необходимо подключить к сервису и корректно настроить.

Подключение ресурса к сервису происходит путем установки в [операционную систему](#os) защищаемого ресурса [агента {{ backup-name }}](../agent.md). В зависимости от типа защищаемого ресурса агент может быть установлен автоматически или вручную.

Подробнее о подключении к сервису {{ backup-name }} защищаемых ресурсов различных типов читайте в разделах:

* [Подключение виртуальных машин {{ compute-name }}](./compute.md).
* [Подключение серверов {{ baremetal-name }}](./baremetal.md).
* [Подключение виртуальных машин и серверов, расположенных за пределами {{ yandex-cloud }}](./external-resources.md).

## Операционные системы, поддерживаемые {{ backup-name }} {#os}

Автоматическая установка агента {{ backup-name }} возможна только на виртуальные машины {{ compute-full-name }} и серверы {{ baremetal-full-name }}, работающие под управлением определенных операционных систем. Подробнее читайте в разделах [Подключение виртуальной машины {{ compute-name }}](./compute.md) и [Подключение сервера {{ baremetal-name }}](./baremetal.md).

Вручную агент {{ backup-name }} можно установить на все поддерживаемые типы защищаемых ресурсов. С полным списком поддерживаемых операционных систем для установки агента можно ознакомиться в [документации провайдера резервного копирования](https://docs.cyberprotect.ru/ru-RU/CyberBackupCloud/21.06/user/#supported-operating-systems-and-environments.html).

## Требования к техническим характеристикам защищаемых ресурсов {#requirements}

{% include [vm-requirements](../../../_includes/backup/vm-requirements.md) %}

## Поддерживаемые файловые системы {#file-systems}

{% include [fss-supported](../../../_includes/backup/fss-supported.md) %}

#### См. также {#see-also}

* [{#T}](./compute.md)
* [{#T}](./baremetal.md)
* [{#T}](./external-resources.md)