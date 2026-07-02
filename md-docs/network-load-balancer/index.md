[Документация Yandex Cloud](../index.md) > Yandex Network Load Balancer > Network Load Balancer

# Yandex Network Load Balancer

Yandex Network Load Balancer (NLB) предназначен для построения отказоустойчивых и масштабируемых приложений и сервисов в Yandex Cloud. Отказоустойчивость и масштабируемость достигаются за счет распределения трафика, поступающего на балансировщик, по облачным ресурсам которые размещаются за ним.

Инфраструктура Yandex Cloud <a href="https://storage.yandexcloud.net/yc-compliance/conformance_ru_pdp.pdf">защищена</a> в соответствии с Федеральным законом Российской Федерации «О персональных данных» № 152-ФЗ.

Для сервиса действует <a href="https://yandex.ru/legal/cloud_sla">соглашение об уровне обслуживания</a>. Уровень обслуживания сервиса определен в документе <a href="https://yandex.ru/legal/cloud_sla_loadbalancer">Уровень обслуживания Yandex Network Load Balancer</a>.

# Yandex Network Load Balancer

 - [Начало работы](quickstart.md)

## Пошаговые инструкции

 - [Все инструкции](operations/index.md)

### Сетевые балансировщики

 - [Информация об имеющихся сетевых балансировщиках](operations/load-balancer-list.md)

 - [Создать балансировщик](operations/load-balancer-create.md)

 - [Создать внутренний балансировщик](operations/internal-lb-create.md)

 - [Остановить и запустить сетевой балансировщик](operations/load-balancer-start-and-stop.md)

 - [Настроить защиту от удаления](operations/deletion-protection.md)

 - [Изменить настройки балансировщика](operations/load-balancer-update.md)

 - [Переместить ВМ в целевую группу в новой зоне доступности](operations/load-balancer-change-zone.md)

 - [Удалить балансировщик](operations/load-balancer-delete.md)

 - [Проверить состояние целевых ресурсов](operations/check-resource-health.md)

 - [Добавить обработчик](operations/listener-add.md)

 - [Удалить обработчик](operations/listener-remove.md)

#### Управление зонами доступности

 - [Разрешить и запретить перенос трафика](operations/manage-zone/allow-and-deny-shift.md)

 - [Отключить и подключить зоны доступности](operations/manage-zone/disable-enable-zone.md)

### Целевые группы

 - [Информация об имеющихся целевых группах](operations/target-group-list.md)

 - [Создать целевую группу](operations/target-group-create.md)

 - [Подключить целевую группу к балансировщику](operations/target-group-attach.md)

 - [Отключить целевую группу от балансировщика](operations/target-group-detach.md)

 - [Удалить целевую группу](operations/target-group-delete.md)

 - [Посмотреть операции с ресурсами сервиса](operations/operation-logs.md)

## Практические руководства

 - [Все руководства](tutorials/index.md)

 - [Архитектура и защита базового интернет-сервиса](tutorials/web-service.md)

 - [Реализация отказоустойчивых сценариев для сетевых виртуальных машин](tutorials/route-switcher.md)

 - [Настройка отказоустойчивой архитектуры в Yandex Cloud](tutorials/fault-tolerance.md)

### Отказоустойчивый сайт с балансировкой нагрузки через Network Load Balancer

 - [Обзор](tutorials/load-balancer-website/index.md)

 - [Консоль управления](tutorials/load-balancer-website/console.md)

 - [Terraform](tutorials/load-balancer-website/terraform.md)

### Работа с группой ВМ с автоматическим масштабированием

 - [Обзор](tutorials/vm-autoscale/index.md)

 - [Консоль управления](tutorials/vm-autoscale/console.md)

 - [Terraform](tutorials/vm-autoscale/terraform.md)

 - [Обновление группы ВМ под нагрузкой](tutorials/updating-under-load.md)

 - [Интеграция Cloud DNS и корпоративного сервиса DNS](tutorials/dns-integration.md)

 - [Подключение к Object Storage из Virtual Private Cloud](tutorials/storage-vpc-access.md)

 - [Подключение к Container Registry из Virtual Private Cloud](tutorials/vpc-cr-access.md)

 - [Реализация защищенной высокодоступной сетевой инфраструктуры с выделением DMZ на основе Check Point NGFW](tutorials/high-accessible-dmz.md)

 - [Развертывание Microsoft Exchange](tutorials/exchange.md)

 - [Развертывание группы доступности Always On с внутренним сетевым балансировщиком](tutorials/mssql-alwayson-lb.md)

### Миграция сервисов с балансировщика NLB на L7-балансировщик ALB для подключения защиты Smart Web Security

 - [Обзор](tutorials/migration-from-nlb-to-alb/index.md)

#### Балансировщик NLB с целевыми ресурсами из виртуальных машин

 - [Обзор](tutorials/migration-from-nlb-to-alb/nlb-with-target-resource-vm/index.md)

 - [Консоль управления](tutorials/migration-from-nlb-to-alb/nlb-with-target-resource-vm/console.md)

 - [Terraform](tutorials/migration-from-nlb-to-alb/nlb-with-target-resource-vm/terraform.md)

#### Балансировщик NLB с целевыми ресурсами из группы виртуальных машин

 - [Обзор](tutorials/migration-from-nlb-to-alb/nlb-with-target-resource-group-vm/index.md)

 - [Консоль управления](tutorials/migration-from-nlb-to-alb/nlb-with-target-resource-group-vm/console.md)

 - [Terraform](tutorials/migration-from-nlb-to-alb/nlb-with-target-resource-group-vm/terraform.md)

#### Балансировщик NLB с целевыми ресурсами из кластера Managed Service for Kubernetes

 - [Обзор](tutorials/migration-from-nlb-to-alb/nlb-with-target-resource-k8s/index.md)

 - [Консоль управления](tutorials/migration-from-nlb-to-alb/nlb-with-target-resource-k8s/console.md)

 - [Terraform](tutorials/migration-from-nlb-to-alb/nlb-with-target-resource-k8s/terraform.md)

#### Балансировщик NLB как целевой ресурс для ALB

 - [Обзор](tutorials/migration-from-nlb-to-alb/nlb-as-target-resource-alb/index.md)

 - [Консоль управления](tutorials/migration-from-nlb-to-alb/nlb-as-target-resource-alb/console.md)

 - [Terraform](tutorials/migration-from-nlb-to-alb/nlb-as-target-resource-alb/terraform.md)

## Концепции

 - [Обзор](concepts/index.md)

 - [Типы сетевых балансировщиков](concepts/nlb-types.md)

 - [Обработчик трафика](concepts/listener.md)

 - [Целевые группы и ресурсы](concepts/target-resources.md)

 - [Проверка доступности ресурсов](concepts/health-check.md)

 - [Особенности реализации](concepts/specifics.md)

 - [Сценарии использования](concepts/scenarios.md)

 - [Рекомендации по применению](concepts/best-practices.md)

 - [Квоты и лимиты](concepts/limits.md)

 - [Управление доступом](security/index.md)

 - [Правила тарификации](pricing.md)

## Справочник CLI (англ.)

 - [Overview](cli-ref/index.md)

### network-load-balancer

 - [Overview](cli-ref/network-load-balancer/index.md)

 - [add-listener](cli-ref/network-load-balancer/add-listener.md)

 - [attach-target-group](cli-ref/network-load-balancer/attach-target-group.md)

 - [create](cli-ref/network-load-balancer/create.md)

 - [delete](cli-ref/network-load-balancer/delete.md)

 - [detach-target-group](cli-ref/network-load-balancer/detach-target-group.md)

 - [disable-zones](cli-ref/network-load-balancer/disable-zones.md)

 - [enable-zones](cli-ref/network-load-balancer/enable-zones.md)

 - [get](cli-ref/network-load-balancer/get.md)

 - [list](cli-ref/network-load-balancer/list.md)

 - [list-operations](cli-ref/network-load-balancer/list-operations.md)

 - [remove-listener](cli-ref/network-load-balancer/remove-listener.md)

 - [start](cli-ref/network-load-balancer/start.md)

 - [stop](cli-ref/network-load-balancer/stop.md)

 - [target-states](cli-ref/network-load-balancer/target-states.md)

 - [update](cli-ref/network-load-balancer/update.md)

### target-group

 - [Overview](cli-ref/target-group/index.md)

 - [add-targets](cli-ref/target-group/add-targets.md)

 - [create](cli-ref/target-group/create.md)

 - [delete](cli-ref/target-group/delete.md)

 - [get](cli-ref/target-group/get.md)

 - [list](cli-ref/target-group/list.md)

 - [list-operations](cli-ref/target-group/list-operations.md)

 - [remove-targets](cli-ref/target-group/remove-targets.md)

 - [update](cli-ref/target-group/update.md)

### v0

 - [Overview](cli-ref/v0/index.md)

#### network-load-balancer

 - [Overview](cli-ref/v0/network-load-balancer/index.md)

 - [add-listener](cli-ref/v0/network-load-balancer/add-listener.md)

 - [attach-target-group](cli-ref/v0/network-load-balancer/attach-target-group.md)

 - [create](cli-ref/v0/network-load-balancer/create.md)

 - [delete](cli-ref/v0/network-load-balancer/delete.md)

 - [detach-target-group](cli-ref/v0/network-load-balancer/detach-target-group.md)

 - [disable-zones](cli-ref/v0/network-load-balancer/disable-zones.md)

 - [enable-zones](cli-ref/v0/network-load-balancer/enable-zones.md)

 - [get](cli-ref/v0/network-load-balancer/get.md)

 - [list](cli-ref/v0/network-load-balancer/list.md)

 - [list-operations](cli-ref/v0/network-load-balancer/list-operations.md)

 - [remove-listener](cli-ref/v0/network-load-balancer/remove-listener.md)

 - [start](cli-ref/v0/network-load-balancer/start.md)

 - [stop](cli-ref/v0/network-load-balancer/stop.md)

 - [target-states](cli-ref/v0/network-load-balancer/target-states.md)

 - [update](cli-ref/v0/network-load-balancer/update.md)

#### target-group

 - [Overview](cli-ref/v0/target-group/index.md)

 - [add-targets](cli-ref/v0/target-group/add-targets.md)

 - [create](cli-ref/v0/target-group/create.md)

 - [delete](cli-ref/v0/target-group/delete.md)

 - [get](cli-ref/v0/target-group/get.md)

 - [list](cli-ref/v0/target-group/list.md)

 - [list-operations](cli-ref/v0/target-group/list-operations.md)

 - [remove-targets](cli-ref/v0/target-group/remove-targets.md)

 - [update](cli-ref/v0/target-group/update.md)

 - [Справочник Terraform](tf-ref.md)

## Справочник API

 - [Аутентификация в API](api-ref/authentication.md)

### gRPC (англ.)

 - [Overview](api-ref/grpc/index.md)

#### NetworkLoadBalancer

 - [Overview](api-ref/grpc/NetworkLoadBalancer/index.md)

 - [Get](api-ref/grpc/NetworkLoadBalancer/get.md)

 - [List](api-ref/grpc/NetworkLoadBalancer/list.md)

 - [Create](api-ref/grpc/NetworkLoadBalancer/create.md)

 - [Update](api-ref/grpc/NetworkLoadBalancer/update.md)

 - [Delete](api-ref/grpc/NetworkLoadBalancer/delete.md)

 - [Start](api-ref/grpc/NetworkLoadBalancer/start.md)

 - [Stop](api-ref/grpc/NetworkLoadBalancer/stop.md)

 - [AttachTargetGroup](api-ref/grpc/NetworkLoadBalancer/attachTargetGroup.md)

 - [DetachTargetGroup](api-ref/grpc/NetworkLoadBalancer/detachTargetGroup.md)

 - [GetTargetStates](api-ref/grpc/NetworkLoadBalancer/getTargetStates.md)

 - [AddListener](api-ref/grpc/NetworkLoadBalancer/addListener.md)

 - [RemoveListener](api-ref/grpc/NetworkLoadBalancer/removeListener.md)

 - [ListOperations](api-ref/grpc/NetworkLoadBalancer/listOperations.md)

 - [DisableZones](api-ref/grpc/NetworkLoadBalancer/disableZones.md)

 - [EnableZones](api-ref/grpc/NetworkLoadBalancer/enableZones.md)

#### Operation

 - [Overview](api-ref/grpc/Operation/index.md)

 - [Get](api-ref/grpc/Operation/get.md)

 - [Cancel](api-ref/grpc/Operation/cancel.md)

#### TargetGroup

 - [Overview](api-ref/grpc/TargetGroup/index.md)

 - [Get](api-ref/grpc/TargetGroup/get.md)

 - [List](api-ref/grpc/TargetGroup/list.md)

 - [Create](api-ref/grpc/TargetGroup/create.md)

 - [Update](api-ref/grpc/TargetGroup/update.md)

 - [Delete](api-ref/grpc/TargetGroup/delete.md)

 - [AddTargets](api-ref/grpc/TargetGroup/addTargets.md)

 - [RemoveTargets](api-ref/grpc/TargetGroup/removeTargets.md)

 - [ListOperations](api-ref/grpc/TargetGroup/listOperations.md)

### REST (англ.)

 - [Overview](api-ref/index.md)

#### NetworkLoadBalancer

 - [Overview](api-ref/NetworkLoadBalancer/index.md)

 - [Get](api-ref/NetworkLoadBalancer/get.md)

 - [List](api-ref/NetworkLoadBalancer/list.md)

 - [Create](api-ref/NetworkLoadBalancer/create.md)

 - [Update](api-ref/NetworkLoadBalancer/update.md)

 - [Delete](api-ref/NetworkLoadBalancer/delete.md)

 - [Start](api-ref/NetworkLoadBalancer/start.md)

 - [Stop](api-ref/NetworkLoadBalancer/stop.md)

 - [AttachTargetGroup](api-ref/NetworkLoadBalancer/attachTargetGroup.md)

 - [DetachTargetGroup](api-ref/NetworkLoadBalancer/detachTargetGroup.md)

 - [GetTargetStates](api-ref/NetworkLoadBalancer/getTargetStates.md)

 - [AddListener](api-ref/NetworkLoadBalancer/addListener.md)

 - [RemoveListener](api-ref/NetworkLoadBalancer/removeListener.md)

 - [ListOperations](api-ref/NetworkLoadBalancer/listOperations.md)

 - [DisableZones](api-ref/NetworkLoadBalancer/disableZones.md)

 - [EnableZones](api-ref/NetworkLoadBalancer/enableZones.md)

#### Operation

 - [Overview](api-ref/Operation/index.md)

 - [Get](api-ref/Operation/get.md)

 - [Cancel](api-ref/Operation/cancel.md)

#### TargetGroup

 - [Overview](api-ref/TargetGroup/index.md)

 - [Get](api-ref/TargetGroup/get.md)

 - [List](api-ref/TargetGroup/list.md)

 - [Create](api-ref/TargetGroup/create.md)

 - [Update](api-ref/TargetGroup/update.md)

 - [Delete](api-ref/TargetGroup/delete.md)

 - [AddTargets](api-ref/TargetGroup/addTargets.md)

 - [RemoveTargets](api-ref/TargetGroup/removeTargets.md)

 - [ListOperations](api-ref/TargetGroup/listOperations.md)

## Справочник инструментов для Managed Service for Kubernetes

 - [Обзор](k8s-ref/index.md)

 - [Service](k8s-ref/service.md)

 - [NetworkPolicy](k8s-ref/networkpolicy.md)

 - [Метрики Monitoring](metrics.md)

 - [Аудитные логи Audit Trails](at-ref.md)

 - [История изменений](release-notes.md)

 - [Вопросы и ответы](qa/index.md)

 - [Обучающие курсы](training.md)