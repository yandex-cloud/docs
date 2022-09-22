{% list tabs %}

- Консоль управления

   1. В [консоли управления]({{ link-console-main }}) выберите каталог, в котором находится брокер.
   1. Выберите сервис **{{ iot-short-name }}**.
   1. На панели слева выберите **Брокеры**
   1. Выберите брокер. Подробная информация о брокере отобразится на странице **Обзор**.

- CLI

  {% include [cli-install](../cli-install.md) %}

  {% include [default-catalogue](../default-catalogue.md) %}

  Получите подробную информацию о брокере:

  ```
  yc iot broker get <имя брокера>
  ```

  Результат:

  ```
  id: b91ki3851h**********
  folder_id: aoek49ghmk**********
  created_at: "2022-05-28T11:29:42.420Z"
  name: my-broker
  ```

- API

  Получить подробную информацию о брокере можно с помощью метода API [get](../../iot-core/api-ref/Broker/get).

{% endlist %}
