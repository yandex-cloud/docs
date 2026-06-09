# Справочник аудитных логов {{ at-full-name }}

В {{ at-name }} для {{ alb-full-name }} поддерживается отслеживание [событий уровня конфигурации](../audit-trails/concepts/format.md) (Control Plane) и [событий уровня сервисов](../audit-trails/concepts/format-data-plane.md) (Data Plane).

Общий вид значения поля `event_type` (_тип события_):

```text
{{ at-event-prefix }}.audit.apploadbalancer.<имя_события>
```

Подробная JSON-структура записи события приведена в справочнике аудитных логов. События в нем отсортированы по алфавиту без разделения на уровни и содержат все возможные поля. В реальных логах набор полей зависит от параметров события и конкретного объекта.

## Справочник событий уровня конфигурации {#control-plane-events}

Имя события | Описание
--- | ---
`AddBackendGroupBackend` | Добавление бэкенда в группу бэкендов
`AddLoadBalancerListener` | Добавление обработчика в балансировщик
`AddLoadBalancerSniMatch` | Добавление SNI-обработчика в балансировщик
`AddTargetGroupTargets` | Добавление [ВМ](../glossary/vm.md) в целевую группу
`CancelZonalShift` | Остановка процесса вывода трафика из какой-либо зоны доступности
`CreateBackendGroup` | Создание группы бэкендов
`CreateHttpRouter` | Создание HTTP-роутера
`CreateLoadBalancer` | Создание балансировщика
`CreateTargetGroup` | Создание целевой группы
`CreateVirtualHost` | Создание виртуального хоста
`DeleteBackendGroup` | Удаление группы бэкендов
`DeleteHttpRouter` | Удаление HTTP-роутера
`DeleteLoadBalancer` | Удаление балансировщика
`DeleteTargetGroup` | Удаление целевой группы
`DeleteVirtualHost` | Удаление виртуального хоста
`RemoveBackendGroupBackend` | Удаление бэкенда из группы бэкендов
`RemoveLoadBalancerListener` | Удаление обработчика из балансировщика
`RemoveLoadBalancerSniMatch` | Удаление SNI-обработчика из балансировщика
`RemoveTargetGroupTargets` | Удаление ВМ из целевой группы
`RemoveVirtualHostRoute` | Удаление маршрута виртуального хоста
`StartLoadBalancer` | Запуск балансировщика
`StartZonalShift` | Запуск процесса вывода трафика из какой-либо зоны доступности
`StopLoadBalancer` | Остановка балансировщика
`UpdateBackendGroup` | Изменение группы бэкендов
`UpdateBackendGroupBackend` | Изменение бэкенда в группе бэкендов
`UpdateHttpRouter` | Изменение HTTP-роутера
`UpdateLoadBalancer` | Изменение балансировщика
`UpdateLoadBalancerListener` | Изменение обработчика в балансировщике
`UpdateLoadBalancerSniMatch` | Изменение SNI-обработчика в балансировщике
`UpdateTargetGroup` | Изменение целевой группы
`UpdateVirtualHost` | Изменение виртуального хоста
`UpdateVirtualHostRoute` | Изменение маршрута виртуального хоста

## Справочник событий уровня сервисов {#data-plane-events}

Имя события | Описание
--- | ---
`LoadBalancerHTTPAccessLog` | Логирование HTTP-запросов
`LoadBalancerTCPAccessLog` | Логирование TCP-запросов