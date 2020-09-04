# Подключить целевую группу к балансировщику

{% list tabs %}

- Консоль управления
  
  Чтобы подключить [целевую группу](../concepts/target-resources.md) к балансировщику:
  
  1. Откройте раздел **Load Balancer** в каталоге, где требуется подключить целевую группу к балансировщику.
  1. Нажмите значок ![image](../../_assets/vertical-ellipsis.svg) в строке балансировщика, к которому требуется подключить целевую группу. Если у вас уже есть созданная целевая группа, выберите ее. Если целевой группы нет, [создайте ее](target-group-create.md).
  1. Задайте настройки проверки состояния.
  1. Нажмите кнопку **Подключить**
  
- CLI
  
  Если у вас еще нет интерфейса командной строки {{ yandex-cloud }}, [установите его](https://cloud.yandex.ru/docs/cli/quickstart#install).
  
  {% include [default-catalogue](../../_includes/default-catalogue.md) %}
  
  1. Посмотрите описание команды CLI для подключения целевой группы:
  
     ```
     $ yc load-balancer network-load-balancer attach-target-group --help
     ```
  
  1. Получите список балансировщиков:
  
     ```
     $ yc load-balancer network-load-balancer list
     +----------------------+--------------------+-------------+----------+----------------+------------------------+----------+
     |          ID          |        NAME        |  REGION ID  |   TYPE   | LISTENER COUNT | ATTACHED TARGET GROUPS |  STATUS  |
     +----------------------+--------------------+-------------+----------+----------------+------------------------+----------+
     ...
     | b7r97ah2jn5rmo6k1dsk | test-load-balancer | ru-central1 | EXTERNAL |              1 |                        | INACTIVE |
     ...
     +----------------------+--------------------+-------------+----------+----------------+------------------------+----------+
     ```
  
  1. Получите список целевых групп:
  
     ```
     $ yc load-balancer target-group list
     +----------------------+-------------------+---------------------+-------------+--------------+
     |          ID          |       NAME        |       CREATED       |  REGION ID  | TARGET COUNT |
     +----------------------+-------------------+---------------------+-------------+--------------+
     ...
     | b7roi767je4c574iivrk | test-target-group | 2018-12-03 14:41:04 | ru-central1 |            1 |
     ...
     +----------------------+-------------------+---------------------+-------------+--------------+
     ```
  
  1. Выберите идентификатор (`ID`) или имя (`NAME`) нужных балансировщика и целевой группы.
  1. Подключите нужную группу к выбранному балансировщику, указав настройки проверки состояния в соответствующих параметрах команды:
  
     ```
     $ yc load-balancer network-load-balancer attach-target-group b7r97ah2jn5rmo6k1dsk \
       --target-group target-group-id=b7roi767je4c574iivrk,healthcheck-name=test-health-check,healthcheck-interval=2s,healthcheck-timeout=1s,healthcheck-unhealthythreshold=2,healthcheck-healthythreshold=2,healthcheck-http-port=80
     ```
  
     Обратите внимание на формат параметров `healthcheck-interval` и `healthcheck-timeout`: необходимо указывать значение в формате `Ns`.
  
     Подробнее о параметрах проверок читайте в разделе [Проверка состояния ресурсов](../concepts/health-check).
  
- API
  
  Подключить целевую группу к балансировщику можно с помощью метода API [attachTargetGroup](../api-ref/NetworkLoadBalancer/attachTargetGroup.md).
  
{% endlist %}