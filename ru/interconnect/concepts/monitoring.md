# Мониторинг {{ interconnect-name }}
 
Сервис {{ monium-full-name }} позволяет оценить состояние и потребление ресурсов {{ interconnect-full-name }}.

## Мониторинг состояния транкового подключения {#trunk-mon}

Чтобы оценить состояние физического порта [транкового подключения](trunk.md) с помощью {{ monium-name }}:

{% list tabs group=instructions %}

- Консоль управления {#console}

  1. [Перейдите]({{ link-monium }}) на главную страницу сервиса {{ monium-name }}.
  1. На панели слева выберите ![alt](../../_assets/console-icons/layout-cells-large.svg) **{{ ui-key.yacloud_monitoring.aside-navigation.menu-item.dashboards.title }}**.
  1. Перейдите на вкладку **{{ ui-key.yacloud_monitoring.dashboard.tab.service-dashboards }}**.
  1. В списке дашбордов выберите `Interconnect — Direct Trunk Connection Overview`.
  1. В левом верхнем углу в поле **Resource ID** выберите идентификатор нужного транка.

{% endlist %}

Значение метрики `Connection State` должно быть равным `1`. Это означает, что транковый порт находится в рабочем состоянии.

## Мониторинг состояния приватного или публичного соединения {#private-mon}

Чтобы оценить состояние BGP-связности для [приватного](priv-con.md) или [публичного](pub-con.md) соединения с помощью {{ monium-name }}:

{% list tabs group=instructions %}

- Консоль управления {#console}

  1. [Перейдите]({{ link-monium }}) на главную страницу сервиса {{ monium-name }}.
  1. На панели слева выберите ![alt](../../_assets/console-icons/layout-cells-large.svg) **{{ ui-key.yacloud_monitoring.aside-navigation.menu-item.dashboards.title }}**.
  1. Перейдите на вкладку **{{ ui-key.yacloud_monitoring.dashboard.tab.service-dashboards }}**.
  1. В списке дашбордов выберите `Interconnect — Private/Public Connection Overview`.
  1. В левом верхнем углу в поле **Resource ID** выберите идентификатор нужного приватного или публичного соединения.

{% endlist %}

Значение метрики `BGP State` должно быть равным `1`, и это означает, что BGP-взаимодействие для данного приватного соединения находится в рабочем состоянии.

## Типы метрик {#metric-types}

Для {{ interconnect-name }} в {{ monium-name }} собираются следующие типы метрик:

* [Метрики транкового подключения](#trunk-metrics).
* [Метрики приватного или публичного соединения](#private-metrics).

### Метрики транкового подключения {#trunk-metrics}

Имя метрики | Единицы измерения | Размерность | Пояснения
--- | --- | --- | ---
`connection_state_up_down` | N/A | bool | Текущий операционный статус физического порта или LAG.
`lag_health` | Процент | Uint64 | Соотношение активных портов в LAG к общему количеству портов в составе LAG.
`light_level_to_cloud_current_dbm` | дБм | float | Уровень входящего оптического сигнала на порте оборудования {{ yandex-cloud }}.
`light_level_to_cloud_min_dbm` | дБм | float | Минимально допустимый для корректной работы физического порта уровень входящего оптического сигнала на оборудования {{ yandex-cloud }}.
`light_level_to_cloud_max_dbm` | дБм | float | Максимально допустимый для корректной работы физического порта уровень входящего оптического сигнала на оборудования {{ yandex-cloud }}.
`light_level_from_cloud_current_dbm` | дБм | float | Уровень исходящего оптического сигнала от порта оборудования {{ yandex-cloud }}.
`light_level_from_cloud_min_dbm` | дБм | float | Минимально возможный уровень исходящего оптического сигнала от порта на оборудования {{ yandex-cloud }}.
`light_level_from_cloud_max_dbm` | дБм | float | Максимально возможный уровень исходящего оптического сигнала от порта на оборудования {{ yandex-cloud }}.
`bitrate_to_cloud_bps` | Биты в секунду | Uint64 | Скорость передачи трафика от клиента в {{ yandex-cloud }} (с учетом L2-заголовков).
`bitrate_from_cloud_bps` | Биты в секунду | Uint64 | Скорость передачи трафика от {{ yandex-cloud }} клиенту (с учетом L2-заголовков).
`bytes_to_cloud_num` | Байты | Uint64 | Объем переданного трафика от клиента в {{ yandex-cloud }} (с учетом L2-заголовков).
`bytes_from_cloud_num` | Байты | Uint64 | Объем переданного трафика от {{ yandex-cloud }} клиенту (с учетом L2-заголовков).
`packet_rate_to_cloud_pps` | Пакеты в секунду | Uint64 | Скорость передачи пакетов от клиента в {{ yandex-cloud }}.
`packet_rate_from_cloud_pps` | Пакеты в секунду | Uint64 | Скорость передачи пакетов из {{ yandex-cloud }} клиенту.
`packets_to_cloud_num` | Пакеты | Uint64 | Количество переданных пакетов от клиента в {{ yandex-cloud }}.
`packets_from_cloud_num` | Пакеты | Uint64 | Количество переданных пакетов из {{ yandex-cloud }} клиенту.
`dropped_packets_to_cloud_num` | Пакеты | Uint64 | Количество пакетов, переданных клиентом в {{ yandex-cloud }}, но отброшенных из-за переполнения буфера.
`dropped_packets_from_cloud_num` | Пакеты | Uint64 | Количество пакетов, переданных из {{ yandex-cloud }} клиенту, но отброшенных из-за переполнения буфера.
`error_packets_to_cloud_num` | Пакеты | Uint64 | Количество пакетов, переданных клиентом в {{ yandex-cloud }}, но отброшенных из-за некорректного значения контрольной суммы Ethernet-кадра.
`error_packets_from_cloud_num` | Пакеты | Uint64 | Количество пакетов, переданных из {{ yandex-cloud }} клиенту, но отброшенных из-за некорректного значения контрольной суммы Ethernet-кадра.

### Метрики приватного или публичного соединения {#private-metrics}

Имя метрики | Единицы измерения | Размерность | Пояснения
--- | --- | --- | ---
`ipv4_announces_received_by_cloud_num` | Маршруты | Uint32 | Текущее количество BGP-анонсов, полученных оборудованием {{ interconnect-name }} от клиента.
`ipv4_announces_advertised_from_cloud_num` | Маршруты | Uint32 | Текущее количество BGP-анонсов, отправленных оборудованием {{ interconnect-name }} клиенту.
`bgp_ipv4_session_lifetime_seconds` | Секунды | Uint24 | Период времени, в течение которого BGP-сессия пребывает в установленном соединении.
`bgp_ipv4_session_state_up_down` | N/A | bool | Текущее состояние BGP-сессии.
`bitrate_to_cloud_bps` | Биты в секунду | Uint64 | Скорость передачи трафика от клиента в {{ yandex-cloud }} (без учета L2-заголовков).
`bitrate_from_cloud_bps` | Биты в секунду | Uint64 | Скорость передачи трафика от {{ yandex-cloud }} клиенту (без учета L2-заголовков).
`bytes_to_cloud_num` | Байты | Uint64 | Объем переданного трафика от клиента в {{ yandex-cloud }} (без учета L2-заголовков).
`bytes_from_cloud_num` | Байты | Uint64 | Объем переданного трафика от {{ yandex-cloud }} клиенту (без учета L2-заголовков).
`packet_rate_to_cloud_pps` | Пакеты в секунду | Uint64 | Скорость передачи пакетов от клиента в {{ yandex-cloud }}.
`packet_rate_from_cloud_pps` | Пакеты в секунду | Uint64 | Скорость передачи пакетов из {{ yandex-cloud }} клиенту.
`packets_to_cloud_num` | Пакеты | Uint64 | Количество переданных пакетов от клиента в {{ yandex-cloud }}.
`packets_from_cloud_num` | Пакеты | Uint64 | Количество переданных пакетов из {{ yandex-cloud }} клиенту.

### Примечания {#notes}

* Если значения метрик с `dropped_packets_` и `error_packets_` в именах не увеличиваются, это говорит об отсутствии потерь пакетов на оборудовании {{ interconnect-name }}, но не гарантирует отсутствие потерь пакетов вдоль всего пути прохождения пользовательского трафика (от ресурсов пользователя в {{ yandex-cloud }} до пользовательской инфраструктуры).
* Значения метрик с `num` и `seconds` в именах могут быть обнулены из-за намеренных или вынужденных действий со стороны команды {{ yandex-cloud }} или из-за превышения диапазона измерения метрики.
* Метрики транкового подключения доступны пользователю в случае организации прямого транкового подключения и недоступны в случае партнерского транкового подключения.

## Точка сбора метрик {#collect-point}

Метрики собираются непосредственно с оборудования {{ interconnect-name }}, то есть наиболее близко к точке подключения клиента.

## Частота обновления метрик {#update-frequency}

Обновление значений метрик для ресурсов услуги {{ interconnect-name }} производится один раз в минуту.
