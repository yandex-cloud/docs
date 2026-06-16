# Справочник аудитных логов Yandex Audit Trails

В Audit Trails поддерживается отслеживание событий уровня конфигурации (Control Plane) для Yandex Network Load Balancer. Подробнее в разделе [Аудитный лог событий уровня конфигурации](../audit-trails/concepts/format.md).

Общий вид значения поля `event_type` (_тип события_):

```text
yandex.cloud.audit.loadbalancer.<имя_события>
```

Имя события | Описание
--- | ---
`AddNetworkLoadBalancerListener` | Добавление обработчика к сетевому балансировщику
`AddTargetGroupTargets` | Добавление ВМ к целевой группе
`AttachNetworkLoadBalancerTargetGroup` | Подключение целевой группы к сетевому балансировщику
`CreateNetworkLoadBalancer` | Создание сетевого балансировщика
`CreateTargetGroup` | Создание целевой группы
`DeleteNetworkLoadBalancer` | Удаление сетевого балансировщика
`DeleteTargetGroup` | Удаление целевой группы
`DetachNetworkLoadBalancerTargetGroup` | Отсоединение целевой группы от сетевого балансировщика
`DisableNetworkLoadBalancerZones` | Отключение зоны доступности 
`EnableNetworkLoadBalancerZones` | Включение зоны доступности
`RemoveNetworkLoadBalancerListener` | Удаление обработчика из сетевого балансировщика
`RemoveTargetGroupTargets` | Удаление ВМ из целевой группы
`StartNetworkLoadBalancer` | Запуск сетевого балансировщика
`StopNetworkLoadBalancer` | Остановка сетевого балансировщика
`UpdateNetworkLoadBalancer` | Изменение сетевого балансировщика
`UpdateTargetGroup` | Изменение целевой группы