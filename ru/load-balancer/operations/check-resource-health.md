# Проверить состояние целевых ресурсов

{% list tabs %}

- CLI
  
  Если у вас еще нет интерфейса командной строки {{ yandex-cloud }}, [установите его](https://cloud.yandex.ru/docs/cli/quickstart#install).
  
  {% include [default-catalogue](../../_includes/default-catalogue.md) %}
  
  1. Посмотрите описание команды CLI для получения состояний подключенных ресурсов:
  
     ```
     $ yc load-balancer network-load-balancer target-states --help
     ```
  
  1. Получите список всех балансировщиков:
  
     ```
     $ yc load-balancer network-load-balancer list
     +----------------------+--------------------+-------------+----------+----------------+------------------------+----------+
     |          ID          |        NAME        |  REGION ID  |   TYPE   | LISTENER COUNT | ATTACHED TARGET GROUPS |  STATUS  |
     +----------------------+--------------------+-------------+----------+----------------+------------------------+----------+
     ...
     | b7r97ah2jn5rmo6k1dsk | test-load-balancer | ru-central1 | EXTERNAL |              1 | b7roi767je4c574iivrk   |  ACTIVE  |
     ...
     +----------------------+--------------------+-------------+----------+----------------+------------------------+----------+
     ```
  
  1. Выберите `ID` балансировщика и `ID` подключенной к нему целевой группы.
  1. Запросите состояния ресурсов целевой группы:
  
     ```
     $ yc load-balancer network-load-balancer target-states b7r97ah2jn5rmo6k1dsk --target-group-id b7roi767je4c574iivrk
     +----------------------+-----------+-----------+
     |      SUBNET ID       |  ADDRESS  |  STATUS   |
     +----------------------+-----------+-----------+
     | e9bc0iisdf7b00b7d4v0 | 10.10.0.4 | UNHEALTHY |
     | e9bc0iisdf7b00b7d4v0 | 10.10.0.7 | UNHEALTHY |
     +----------------------+-----------+-----------+
     ```
{% endlist %}