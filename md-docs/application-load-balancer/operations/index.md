# Пошаговые инструкции для Application Load Balancer

## Визард {#application-load-balancer-wizard}

* [Создание инфраструктуры Application Load Balancer с помощью визарда](../quickstart-wizard.md)

## Целевые группы {#target-group-operations}

* [Создать целевую группу Application Load Balancer](target-group-create.md)
* [Получить информацию о целевой группе](target-group-get.md)
* [Изменить целевую группу](target-group-update.md)
* [Удалить целевую группу Application Load Balancer](target-group-delete.md)

## Группы бэкендов {#backend-group-operations}

* [Создать группу бэкендов](backend-group-create.md)
* [Получить информацию о группе бэкендов](backend-group-get.md)
* [Изменить группу бэкендов](backend-group-update.md)
* [Удалить группу бэкендов](backend-group-delete.md)

## HTTP-роутеры {#http-router-operations}

* [Создать HTTP-роутер для HTTP-трафика](http-router-create.md)
* [Создать HTTP-роутер для gRPC-трафика](http-router-create-grpc.md)
* [Получить информацию об HTTP-роутере](http-router-get.md)
* [Изменить параметры HTTP-роутера](http-router-update.md)
* [Управлять виртуальными хостами](manage-virtual-hosts.md)
* [Управлять маршрутами](manage-routes.md)
* [Удалить HTTP-роутер](http-router-delete.md)

## L7-балансировщики {#application-load-balancer-operations}

* [Создать L7-балансировщик](application-load-balancer-create.md)
* [Изменить L7-балансировщик](application-load-balancer-update.md)
* [Получить информацию об L7-балансировщике](application-load-balancer-get.md)
* [Посмотреть статистику L7-балансировщика](application-load-balancer-get-stats.md)
* [Посмотреть логи L7-балансировщика](application-load-balancer-get-logs.md)
* [Настроить запись логов L7-балансировщика](application-load-balancer-manage-logs.md)
* [Получить идентификатор лог-группы L7-балансировщика](application-load-balancer-get-log-group-id.md)
* [Остановить и запустить L7-балансировщик](application-load-balancer-stop-and-start.md)
* [Переместить виртуальную машину в целевую группу в новой зоне доступности](application-load-balancer-relocate.md)
* [Удалить L7-балансировщик](application-load-balancer-delete.md)

### Управление зоной доступности {#manage-zone}

* [Разрешить и запретить отключение зоны доступности](manage-zone/allow-and-deny-shift.md)
* [Отключить и включить зону доступности](manage-zone/start-and-cancel-shift.md)

## Инструменты для Managed Service for Kubernetes {#k8s-ingress-controller}

* [Установить Ingress-контроллер Application Load Balancer для Managed Service for Kubernetes](k8s-ingress-controller-install.md)
* [Обновить Ingress-контроллер Application Load Balancer для Managed Service for Kubernetes](k8s-ingress-controller-upgrade.md)
* [Установить Gateway API Application Load Balancer для Managed Service for Kubernetes](k8s-gateway-api-install.md)
* [Создать или изменить ресурсы Application Load Balancer по конфигурации для Managed Service for Kubernetes](k8s-ingress-controller-apply.md)

## Получение дополнительной информации {#get-additional-info}

* [Посмотреть операции с ресурсами сервиса Application Load Balancer](operation-logs.md)