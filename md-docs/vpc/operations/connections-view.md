[Документация Yandex Cloud](../../index.md) > [Yandex Virtual Private Cloud](../index.md) > [Пошаговые инструкции](index.md) > График сетевых соединений

# График сетевых соединений

Чтобы посмотреть график [сетевых соединений](../concepts/monitoring-connections.md) вашей [виртуальной машины](../../glossary/vm.md) или кластера:

{% list tabs group=instructions %}

- Консоль управления {#console}

  1. В [консоли управления](https://console.yandex.cloud) выберите каталог с нужным ресурсом.
  1. Перейдите в нужный сервис, например, **Compute Cloud** для виртуальной машины или **Yandex Data Processing** для кластера.
  1. Выберите ресурс в списке.
  1. Перейдите на вкладку **Мониторинг**.
  1. Найдите график **Connections quota utilization**.

  Значения на графике могут превышать значения изнутри ресурса. Это происходит из-за задержки удаления записей:

  * через три минуты после передачи последнего пакета в любом направлении;
  * для TCP-соединения — через короткое время после получения пакета [RST](https://ru.wikipedia.org/wiki/Атака_TCP_Reset) или пакета с [флагом FIN](https://ru.wikipedia.org/wiki/Transmission_Control_Protocol).

{% endlist %}