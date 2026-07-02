[Документация Yandex Cloud](../index.md) > [Yandex BareMetal](index.md) > Концепции > Настройка и управление > Аудитные логи Audit Trails > Обзор

# Справочник аудитных логов Yandex Audit Trails

В Audit Trails для Yandex BareMetal поддерживается отслеживание [событий уровня конфигурации](../audit-trails/concepts/format.md) (Control Plane) и [событий уровня сервисов](../audit-trails/concepts/format-data-plane.md) (Data Plane).

Общий вид значения поля `event_type` (_тип события_):

```text
yandex.cloud.audit.baremetal.<имя_события>
```

Подробная JSON-структура записи события приведена в справочнике аудитных логов. События в нем отсортированы по алфавиту без разделения на уровни и содержат все возможные поля. В реальных логах набор полей зависит от параметров события и конкретного объекта.

## Справочник событий уровня конфигурации {#control-plane-events}

Имя события | Описание
--- | ---
`ApplyUpdatePrivateCloudConnection` | Применение измений приватного соединения с подсетями в VPC или в on-prem инфраструктуре
`BatchCreateServer` | Аренда одновременно нескольких [серверов](concepts/servers.md) BareMetal
`CreateImage` | Создание загрузочного образа
`CreatePrivateCloudConnection` | Создание [приватного соединения](concepts/private-network.md#private-connection-to-vpc) с подсетями в VPC или в on-prem инфраструктуре
`CreatePrivateSubnet` | Создание [приватной подсети](concepts/private-network.md#private-subnet)
`CreatePublicPrefixPool` | Создание пула публичных префиксов
`CreatePublicSubnet` | Создание [публичной подсети](concepts/public-network.md)
`CreateServer` | Аренда сервера BareMetal
`CreateVRF` | Создание [виртуального сегмента сети](concepts/private-network.md#vrf-segment) (VRF)
`DeleteImage` | Удаление загрузочного образа
`DeletePrivateCloudConnection` | Удаление приватного соединения с подсетями в VPC или в on-prem инфраструктуре
`DeletePrivateSubnet` | Удаление приватной подсети
`DeletePublicPrefixPool` | Удаление пула публичных префиксов
`DeletePublicSubnet` | Удаление публичной подсети
`DeleteServer` | Полное удаление сервера BareMetal, очистка дисков и всех пользовательских данных
`DeleteVRF` | Удаление виртуального сегмента сети (VRF)
`PowerOffServer` | Выключение питания сервера BareMetal
`PowerOnServer` | Включение питания сервера BareMetal
`RebootServer` | Перезапуск сервера BareMetal
`RegisterServerBackupAgent` | Регистрация [агента](../backup/concepts/agent.md) Yandex Cloud Backup на сервере BareMetal
`ReinstallServer` | Переустановка операционной системы сервера BareMetal
`StartServerProlongation` | Включение автопродления аренды сервера BareMetal
`StopServerProlongation` | Выключение автопродления аренды сервера BareMetal
`UpdateImage` | Изменение загрузочного образа
`UpdatePrivateCloudConnection` | Изменение приватного соединения с подсетями в VPC или в on-prem инфраструктуре
`UpdatePrivateSubnet` | Изменение приватной подсети
`UpdatePublicPrefixPool` | Изменение пула публичных префиксов
`UpdatePublicSubnet` | Изменение публичной подсети
`UpdateServer` | Изменение сервера BareMetal
`UpdateVRF` | Изменение виртуального сегмента сети (VRF)

## Справочник событий уровня сервисов {#data-plane-events}

Имя события | Описание
--- | ---
`flowlogs.ExternalFlow` | Поток трафика серверов BareMetal во внешние сети

### Событие flowlogs.ExternalFlow {#external-flow}

Событие `flowlogs.ExternalFlow` содержит агрегированную информацию о потоках сетевого трафика серверов BareMetal во внешние сети.

{% note warning %}

События `ExternalFlow` собираются на основе каждого тысячного пакета и агрегируются за пятиминутный период.

{% endnote %}

Объект `details` события `flowlogs.ExternalFlow` содержит следующие поля:

#|
|| Поле | Тип | Описание ||
|| `vers` | int64 | Версия IP-протокола: `4` — IPv4, `6` — IPv6 ||
|| `proto` | int64 | Номер транспортного протокола по [IANA](https://www.iana.org/assignments/protocol-numbers/protocol-numbers.xhtml). Например, `6` — TCP, `17` — UDP ||
|| `srcAddr` | string | IP-адрес источника ||
|| `dstAddr` | string | IP-адрес назначения ||
|| `direction` | string | Направление трафика: `INGRESS` — входящий, `EGRESS` — исходящий ||
|| `srcPort` | int64 | Порт источника ||
|| `dstPort` | int64 | Порт назначения ||
|| `aggStart` | timestamp | Время начала периода агрегации в формате [RFC 3339](https://www.ietf.org/rfc/rfc3339.txt) ||
|| `aggEnd` | timestamp | Время окончания периода агрегации в формате [RFC 3339](https://www.ietf.org/rfc/rfc3339.txt) ||
|| `packets` | int64 | Количество пакетов за период агрегации ||
|| `bytes` | int64 | Количество байт за период агрегации ||
|| `tcpFlags` | string | TCP-флаги в шестнадцатеричном формате, например `0x02` ||
|| `subnetId` | string | Идентификатор подсети ||
|| `folderId` | string | Идентификатор каталога ||
|#