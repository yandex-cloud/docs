Метрики сервиса {{ baremetal-name }} автоматически передаются в [{{ monium-name }}](../../../monium/metrics/overview.md) в [проект каталога](*monium-folder-project), в котором находится сервер.

{% include [metrics-search-labels](../../monium/metrics-search-labels.md) %}

Чтобы посмотреть графики в консоли управления, [откройте страницу сервера](../../../baremetal/operations/servers/get-info.md) и перейдите на вкладку **{{ ui-key.yacloud.baremetal.label_server-monitoring }}**.

Чтобы открыть готовый дашборд, в [{{ monium-name }}]({{ link-monium }}) выберите проект каталога с сервером. Откройте раздел **{{ ui-key.yacloud_monitoring.aside-navigation.menu-item.dashboards.title }}**. На вкладке **{{ ui-key.yacloud_monitoring.dashboard.tab.service-dashboards }}** найдите дашборд по названию сервиса {{ baremetal-name }}.

Общие метки для метрик сервиса {{ baremetal-name }}:

Метка | Значение
----|----
service | Идентификатор сервиса: `baremetal`.
server_id | Идентификатор [сервера {{ baremetal-name }}](../../../baremetal/concepts/servers.md).
server_subnet_type | Тип [подсети](../../../baremetal/concepts/network.md): `private` или `public`. 

Метрики сервиса:

Имя метрики<br/>Тип, единицы измерения | Описание
--- | ---
`server_cpu0_temperature_celsius`<br/>`DGAUGE`, градусы Цельсия | Температура центрального процессора `CPU0` сервера.
`server_cpu1_temperature_celsius`<br/>`DGAUGE`, градусы Цельсия | Температура центрального процессора `CPU1` сервера.
`server_fan1_speed_rpm`<br/>`DGAUGE`, тыс. об./мин. | Скорость вращения первого вентилятора сервера.
`server_fan2_speed_rpm`<br/>`DGAUGE`, тыс. об./мин. | Скорость вращения второго вентилятора сервера.
`server_fan3_speed_rpm`<br/>`DGAUGE`, тыс. об./мин. | Скорость вращения третьего вентилятора сервера.
`server_fan4_speed_rpm`<br/>`DGAUGE`, тыс. об./мин. | Скорость вращения четвертого вентилятора сервера.
`server_network_status`<br/>`DGAUGE` | Статус сетевого интерфейса сервера: `1`, если интерфейс активен.
`server_power_status`<br/>`DGAUGE` | Статус питания сервера: `1`, если питание сервера включено.
`server_received_bits`<br/>`DGAUGE`, биты/с | Количество бит в секунду, полученных на сетевом интерфейсе.
`server_received_drop_packets`<br/>`DGAUGE`, пакеты/с | Количество пакетов в секунду, потерянных и не полученных на сетевом интерфейсе.
`server_received_error_packets`<br/>`DGAUGE`, пакеты/с | Количество пакетов в секунду, полученных с ошибками на сетевом интерфейсе.
`server_received_packets`<br/>`DGAUGE`, пакеты/с | Количество пакетов в секунду, полученных на сетевом интерфейсе.
`server_sent_bits`<br/>`DGAUGE`, биты/с | Количество бит в секунду, отправленных с сетевого интерфейса.
`server_sent_drop_packets`<br/>`DGAUGE`, пакеты/с | Количество пакетов в секунду, потерянных при отправке с сетевого интерфейса.
`server_sent_error_packets`<br/>`DGAUGE`, пакеты/с | Количество пакетов в секунду, отправленных с ошибками с сетевого интерфейса.
`server_sent_packets`<br/>`DGAUGE`, пакеты/с | Количество пакетов в секунду, отправленных с сетевого интерфейса.

[*monium-folder-project]: {% include [folder-project](../../monium/folder-project.md) %}
