# Запустить сетевой балансировщик

{% list tabs %}

- Консоль управления
  
  Чтобы запустить [сетевой балансировщик](../concepts/index.md):
  
  1. В [консоли управления]({{ link-console-main }}) выберите каталог, где требуется запустить балансировщик.
  1. В списке сервисов выберите **{{ network-load-balancer-name }}**.
  1. В строке балансировщика, который требуется запустить, нажмите значок ![image](../../_assets/horizontal-ellipsis.svg) и выберите **Запустить**.
  1. Подтвердите действие.
  
- CLI
  
  Если у вас еще нет интерфейса командной строки {{ yandex-cloud }}, [установите его](https://cloud.yandex.ru/docs/cli/quickstart#install).
  
  {% include [default-catalogue](../../_includes/default-catalogue.md) %}
  
  1. Посмотрите описание команды CLI для запуска сетевого балансировщика:
  
     ```
     yc load-balancer network-load-balancer start --help
     ```
  
  1. Получите список всех балансировщиков:
  
     ```
     yc load-balancer network-load-balancer list
     ```
	 
	 Результат:
	 
	 ```
     +----------------------+--------------------+-------------+----------+----------------+------------------------+----------+
     |          ID          |        NAME        |  REGION ID  |   TYPE   | LISTENER COUNT | ATTACHED TARGET GROUPS |  STATUS  |
     +----------------------+--------------------+-------------+----------+----------------+------------------------+----------+
     ...
     | b7r97ah2jn5rmo6k1dsk | test-load-balancer | ru-central1 | EXTERNAL |              1 | b7r97ah2jn5rmo6k1dsk   | INACTIVE |
     ...
     +----------------------+--------------------+-------------+----------+----------------+------------------------+----------+
     ```
  
  1. Выберите идентификатор (`ID`) или имя (`NAME`) нужного балансировщика, находящегося в состоянии `INACTIVE`.
  1. Запустите балансировщик:
  
     ```
     yc load-balancer network-load-balancer start b7r97ah2jn5rmo6k1dsk
     ```
  
- API
  
  Запустить сетевой балансировщик можно с помощью метода API [start](../api-ref/NetworkLoadBalancer/start.md).
  
{% endlist %}