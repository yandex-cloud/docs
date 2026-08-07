[Документация Yandex Cloud](../index.md) > [Yandex BareMetal](index.md) > История изменений

# История изменений в Yandex BareMetal

## II квартал 2026 {#q2-2026}

* Опубликован новый [справочник REST API v2](api-ref/authentication.md) сервиса BareMetal.
* [Yandex Cloud CLI](../cli/quickstart.md): добавлена ветка команд сервиса на новом синтаксисе `yc baremetal v2`.
* Описаны [сценарии совместного использования BareMetal с другими сервисами Yandex Cloud](concepts/integrations.md).
* Поддержана возможность [переключения типа сети](operations/servers/switch-network-type.md), подключенной к сетевому интерфейсу сервера, между публичной и приватной.
* Добавлена операция [удаления выделенной публичной подсети](operations/delete-public-subnet.md).
* Добавлена возможность [заказа готовой конфигурации сервера с предварительной сборкой](concepts/server-configurations.md) для снижения стоимости.
* Добавлена возможность предзаполнения формы заказа [своей конфигурации сервера](concepts/server-custom-configurations.md) из шаблона.
* Описаны [типы дисков](concepts/disks/disk-types.md) и [способы реализации RAID](concepts/disks/raid.md), поддерживаемые в серверах BareMetal.
* Реализован новый способ монтирования ISO-образов в [KVM-консоли](operations/servers/reinstall-os-from-own-image.md#boot-from-image).
* Обновлены [ограничения по портам](concepts/network-restrictions.md), заблокированным в сервисе.
* Добавлены [события Audit Trails](at-ref.md) уровня конфигурации сети ExternalFlow.

## I квартал 2026 {#q1-2026}

* Поддержаны [статические маршруты](operations/create-static-route.md) в приватной сети BareMetal.
* Добавлена возможность [подключения нескольких приватных подсетей к одному серверу](operations/servers/set-up-tagged-vlan.md).
* Добавлен раздел [«Консоль управления»](concepts/console.md) в концепциях сервиса.
* Добавлена возможность заказа [серверов в конфигурации по запросу](concepts/server-individual-configurations.md).
* В [жизненный цикл сервера](concepts/servers.md) добавлен статус `Deleting`.
* Добавлены предупреждения о последствиях [изменения настроек BMC и BIOS](concepts/server-advanced-settings.md).
* [Yandex Cloud CLI](../cli/quickstart.md):
  * В команды `yc baremetal server create` и `yc baremetal server update` для параметра `--network-interfaces` добавлена опция `ephemeral-public-subnet` для явного указания эфемерной публичной подсети.
  * Добавлена команда `yc baremetal public-prefix-pool` для управления набором публичных IP-префиксов.
  * Добавлена команда `yc baremetal vrf update` для управления статическими маршрутами VRF.
  * Добавлены команды `yc baremetal public-subnet create --cidr-auto-allocation` и `yc baremetal public-subnet create --cidr-manual-allocation` для выбора метода выделения CIDR-блока публичной подсети.

## IV квартал 2025 {#q4-2025}

* Реализован заказ [серверов в собственной конфигурации](concepts/server-custom-configurations.md) с индивидуальным подбором CPU, оперативной памяти, дисков и сетевых карт.
* Поддержано [подключение сервера BareMetal к кластеру Managed Service for Kubernetes](concepts/integrations.md) как внешнего узла.
* Добавлена возможность [расширения пакета трафика в публичных подсетях](concepts/network-restrictions.md), в том числе через интерфейс консоли управления.
* Обновлены [ограничения на число MAC-адресов](concepts/network-restrictions.md) для сетевых интерфейсов серверов.
* [Yandex Cloud CLI](../cli/quickstart.md): добавлена команда `yc baremetal private-cloud-connection` для управления приватными соединениями с облачными сетями.

## III квартал 2025 {#q3-2025}

* Опубликован [справочник REST API](api-ref/authentication.md) сервиса BareMetal.
* Поддержано [резервирование сети MC-LAG](concepts/mc-lag.md). Добавлено руководство по [самостоятельной настройке группы агрегации MC-LAG](operations/servers/set-up-mc-lag.md).
* Расширена документация по [образам ОС](concepts/images.md) и [установке ОС из своего ISO-образа](operations/servers/reinstall-os-from-own-image.md), в том числе с использованием Object Storage.
* Описано использование встроенного [RAID на серверах x9drw и x10drw](concepts/disks/raid.md).
* Обновлены [сетевые лимиты](concepts/limits.md) и лимиты по дискам.
* [Yandex Cloud CLI](../cli/quickstart.md):
  * Добавлена группа команд `yc baremetal image` для работы с образами.
  * Добавлена команда `yc baremetal rental-period list` для получения доступных периодов аренды сервера.

## II квартал 2025 {#q2-2025}

* Сервис Yandex BareMetal перешел в стадию [General Availability](../overview/concepts/launch-stages.md).
* Поддержано [подключение сервера к Cloud Backup](operations/backup-baremetal.md) при его заказе.
* Описан [жизненный цикл эфемерной публичной подсети](concepts/public-network.md).
* Описан скрипт [HWCheck](operations/servers/use-hwatcher.md) для самостоятельного анализа состояния серверов и раздел про [оценку состояния дисков](concepts/smart-disk-analysis.md).