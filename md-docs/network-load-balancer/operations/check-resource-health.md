[Документация Yandex Cloud](../../index.md) > [Yandex Network Load Balancer](../index.md) > [Пошаговые инструкции](index.md) > Сетевые балансировщики > Проверить состояние целевых ресурсов

# Проверить состояние целевых ресурсов

{% list tabs group=instructions %}

- Консоль управления {#console}

  1. В [консоли управления](https://console.yandex.cloud) перейдите на страницу каталога.
  1. [Перейдите](https://console.yandex.cloud/link/network-load-balancer/) в сервис **Network Load Balancer**.
  1. Нажмите на имя нужного сетевого балансировщика.

- CLI {#cli}
  
  Если у вас еще нет интерфейса командной строки Yandex Cloud (CLI), [установите и инициализируйте его](../../cli/quickstart.md#install).
  
  По умолчанию используется каталог, указанный при [создании](../../cli/operations/profile/profile-create.md) профиля CLI. Чтобы изменить каталог по умолчанию, используйте команду `yc config set folder-id <идентификатор_каталога>`. Также для любой команды вы можете указать другой каталог с помощью параметров `--folder-name` или `--folder-id`.
  
  Если вы обращаетесь к ресурсу по имени, поиск будет выполнен в каталоге по умолчанию. Если вы обращаетесь к ресурсу по идентификатору, поиск будет выполнен глобально — во всех каталогах с учетом прав доступа.
  
  Запросите состояния ресурсов целевой группы:
  
  ```bash
  yc load-balancer network-load-balancer target-states <имя_или_идентификатор_балансировщика> \
    --target-group-id=<идентификатор_целевой_группы>
  ```

  Идентификатор, имя балансировщика и идентификаторы подключенных целевых групп можно получить со [списком сетевых балансировщиков в каталоге](load-balancer-list.md#list).

- API {#api}

  Воспользуйтесь методом REST API [getTargetStates](../api-ref/NetworkLoadBalancer/getTargetStates.md) для ресурса [NetworkLoadBalancer](../api-ref/NetworkLoadBalancer/index.md) или вызовом gRPC API [NetworkLoadBalancerService/GetTargetStates](../api-ref/grpc/NetworkLoadBalancer/getTargetStates.md) и передайте в запросе:

  * Идентификатор балансировщика в параметре `networkLoadBalancerId` (REST API) или `network_load_balancer_id` (gRPC API).
  * Идентификатор целевой группы в параметре `targetGroupId` (REST API) или `target_group_id` (gRPC API).

  Идентификатор балансировщика и идентификаторы подключенных целевых групп можно получить со [списком сетевых балансировщиков в каталоге](load-balancer-list.md#list).

{% endlist %}