# Отключить целевую группу от балансировщика

---

**[!TAB Консоль управления]**

Чтобы отключить [целевую группу](../concepts/target-resources.md) от балансировщика:

1. Откройте раздел **Yandex Load Balancer** в каталоге, где требуется отключить целевую группу от балансировщика.
1. Нажмите значок ![image](../../_assets/vertical-ellipsis.svg) в строке балансировщика, от которого требуется отключить целевую группу.
1. В открывшемся меню нажмите **Отключить целевую группу**.

**[!TAB CLI]**

Если у вас еще нет интерфейса командной строки Яндекс.Облака, [установите его](https://cloud.yandex.ru/docs/cli/quickstart#install).

[!INCLUDE [default-catalogue](../../_includes/default-catalogue.md)]

1. Посмотрите описание команды CLI для отключения целевой группы:

   ```
   $ yc load-balancer network-load-balancer detach-target-group --help
   ```

1. Получите список балансировщиков:

   ```
   $ load-balancer network-load-balancer list
   +----------------------+--------------------+-------------+----------+----------------+------------------------+----------+
   |          ID          |        NAME        |  REGION ID  |   TYPE   | LISTENER COUNT | ATTACHED TARGET GROUPS |  STATUS  |
   +----------------------+--------------------+-------------+----------+----------------+------------------------+----------+
   ...
   | b7r97ah2jn5rmo6k1dsk | test-load-balancer | ru-central1 | EXTERNAL |              1 | b7roi767je4c574iivrk   | INACTIVE |
   ...
   +----------------------+--------------------+-------------+----------+----------------+------------------------+----------+
   ```

1. Выберите `ID` балансировщика и подключенной к нему целевой группы.
1. Отключите выбранную группу от балансировщика:

   ```
   $ yc load-balancer network-load-balancer detach-target-group b7r97ah2jn5rmo6k1dsk \
     --target-group-id=b7roi767je4c574iivrk
   ```

**[!TAB API]**

Отключить целевую группу от балансировщика можно с помощью метода API [detachTargetGroup](../api-ref/NetworkLoadBalancer/detachTargetGroup.md).

---
