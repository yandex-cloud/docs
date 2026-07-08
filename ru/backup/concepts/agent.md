---
title: Агент {{ backup-full-name }}
description: Агент {{ backup-name }} обеспечивает взаимодействие защищаемых ресурсов с сервисом и провайдером резервного копирования.
---

# Агент {{ backup-name }}


Агент {{ backup-name }} устанавливается на [защищаемые ресурсы](./index.md#protected-resources) и обеспечивает их взаимодействие с сервисом {{ backup-name }} и провайдером резервного копирования.

Подробнее о провайдере резервного копирования и передаваемых ему данных читайте в разделе [{#T}](index.md#providers).

Агент {{ backup-name }} выполняет на защищаемом ресурсе следующие действия:

* регистрирует защищаемый ресурс в сервисе;
* отправляет в сервис данные о статусе подключения ресурса;
* создает резервные копии ресурса согласно [политике резервного копирования](./policy.md);
* восстанавливает резервную копию на ресурсе;
* отключает ресурс от сервиса.

{% note info %}

Чтобы выполнять операции в сервисе, в том числе удалять резервные копии, в [каталоге](../../resource-manager/concepts/resources-hierarchy.md#folder) должен быть хотя бы один активный защищаемый ресурс с установленным агентом {{ backup-name }}. Если таких ресурсов нет, на время [создайте](../operations/create-vm.md) новую ВМ {{ compute-full-name }} с подключением к {{ backup-name }} и выполните необходимые действия.

{% endnote %}

В зависимости от типа защищаемого ресурса агент {{ backup-name }} может быть установлен автоматически или вручную.

Автоматически агент можно установить на виртуальную машину {{ compute-name }} или сервер {{ baremetal-name }} при их создании, если используемый образ операционной системы поддерживает автоматическую установку агента. Вручную агент {{ backup-name }} может быть установлен на все типы защищаемых ресурсов.

Подробнее об установке агента на защищаемые ресурсы читайте в разделе [{#T}](./vm-connection/index.md).

## Примеры использования {#examples}

* [{#T}](../tutorials/backup-baremetal.md)
* [{#T}](../tutorials/vm-with-backup-policy/index.md)

#### Полезные ссылки {#see-also}

* [{#T}](./vm-connection/compute.md)
* [{#T}](./vm-connection/baremetal.md)
* [{#T}](./vm-connection/external-resources.md)
* [{#T}](../operations/connect-vm-linux.md)
* [{#T}](../operations/connect-vm-oslogin-linux.md)
* [{#T}](../operations/connect-vm-windows.md)
* [{#T}](../operations/refresh-connection.md)
* [{#T}](../operations/update-backup-agent.md)
* [{#T}](../operations/refresh-connection-oslogin-linux.md)
* [{#T}](../operations/backup-baremetal/backup-baremetal.md)
* [{#T}](../operations/backup-baremetal/refresh-connection.md)
* [{#T}](../operations/limit-agent-memory-usage.md)
