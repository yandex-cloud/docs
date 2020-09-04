# Удаление обработчика

{% list tabs %}

- Консоль управления
  
  Чтобы удалить [обработчик](../concepts/listener.md) сетевого балансировщика:
  
  1. Откройте раздел **Load Balancer** в каталоге, где требуется удалить обработчик.
  1. Выберите сетевой балансировщик, у которого требуется удалить обработчик.
  1. В блоке **Обработчики** нажмите значок ![image](../../_assets/vertical-ellipsis.svg) в строке обработчика, который нужно удалить.
  1. В открывшемся меню нажмите кнопку **Удалить обработчик**.
  
- CLI
  
  Если у вас еще нет интерфейса командной строки {{ yandex-cloud }}, [установите его](https://cloud.yandex.ru/docs/cli/quickstart#install).
  
  {% include [default-catalogue](../../_includes/default-catalogue.md) %}
  
  Чтобы удалить обработчик балансировщика:
  
  1. Посмотрите список балансировщиков:
  
     ```
     $ yc load-balancer network-load-balancer list
     +----------------------+--------------------+-------------+----------+----------------+------------------------+----------+
     |          ID          |        NAME        |  REGION ID  |   TYPE   | LISTENER COUNT | ATTACHED TARGET GROUPS |  STATUS  |
     +----------------------+--------------------+-------------+----------+----------------+------------------------+----------+
     ...
     | c58r8boim8qfkcqtuioj | test-load-balancer | ru-central1 | EXTERNAL |              1 |                        | INACTIVE |
     ...
     +----------------------+--------------------+-------------+----------+----------------+------------------------+----------+
     ```
  
  1. Выберите `ID` балансировщика, у которого требуется удалить обработчик.
  1. Получите сведения о выбранном балансировщике:
  
     ```
     $ yc load-balancer network-load-balancer get c58r8boim8qfkcqtuioj
     id: c58r8boim8qfkcqtuioj
     folder_id: aoerb349v3h4bupphtaf
     created_at: "2019-04-01T09:29:25Z"
     name: test-load-balancer
     region_id: ru-central1
     status: INACTIVE
     type: EXTERNAL
     listeners:
     - name: test-listener
       address: 130.193.32.39
       port: "80"
       protocol: TCP
     ```
  
  1. Удалите выбранный обработчик, указав идентификатор балансировщика и имя удаляемого обработчика:
  
     ```
     $ yc load-balancer network-load-balancer remove-listener c58r8boim8qfkcqtuioj --listener-name test-listener
     .......done
     id: c58r8boim8qfkcqtuioj
     folder_id: aoerb349v3h4bupphtaf
     created_at: "2019-04-01T09:29:25Z"
     name: test-load-balancer
     region_id: ru-central1
     status: INACTIVE
     type: EXTERNAL
     ```
  
- API
  
  Удалить обработчик можно с помощью метода API [removeListener](../api-ref/NetworkLoadBalancer/removeListener.md).
  
{% endlist %}