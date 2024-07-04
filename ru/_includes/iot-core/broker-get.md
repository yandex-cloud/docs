{% list tabs group=instructions %}

- Консоль управления {#console}

   1. В [консоли управления]({{ link-console-main }}) выберите каталог, в котором находится брокер.
   1. Выберите сервис **{{ ui-key.yacloud.iam.folder.dashboard.label_iot-core }}**.
   1. На панели слева выберите **{{ ui-key.yacloud.iot.label_brokers }}**.
   1. Выберите брокер. Подробная информация о брокере отобразится на странице **{{ ui-key.yacloud.common.overview }}**.

- CLI {#cli}

  {% include [cli-install](../cli-install.md) %}

  {% include [default-catalogue](../default-catalogue.md) %}

  1. Посмотрите описание команды CLI для получения информации о брокере:
	
      ```bash
      yc iot broker get --help
      ```

  1. Получите подробную информацию о брокере, указав его имя или идентификатор:

      ```bash
      yc iot broker get <имя_брокера>
      ```

      Результат:

      ```text
      id: b91ki3851h**********
      folder_id: aoek49ghmk**********
      created_at: "2022-05-28T11:29:42.420Z"
      name: my-broker
      ```

- {{ TF }} {#tf}

  {% include [terraform-definition](../../_tutorials/_tutorials_includes/terraform-definition.md) %}

  {% include [terraform-install](../../_includes/terraform-install.md) %}

  Чтобы получить информацию о брокере с помощью {{ TF }}:
  1. Добавьте в конфигурационный файл {{ TF }} блоки `data` и `output`:

      ```hcl
      data "yandex_iot_core_broker" "my_broker" {
        broker_id = "<идентифкатор_брокера>"
      }

      output "broker_params" {
        value = data.yandex_iot_core_broker.my_broker.created_at
      }
      ```

      Где:
      * `data "yandex_iot_core_broker"` — описание брокера в качестве источника данных:
        * `broker_id` — идентификатор брокера.
      * `output "broker_params"` — выходная переменная, которая содержит информацию о временной метке создания брокера:
        * `value` — возвращаемое значение.

      Вместо `created_at` вы можете выбрать любой другой параметр для получения информации. Более подробно о параметрах источника данных `yandex_iot_core_broker` см. в [документации провайдера]({{ tf-provider-datasources-link }}/datasource_iot_core_broker).
  1. Создайте ресурсы:

      {% include [terraform-validate-plan-apply](../../_tutorials/_tutorials_includes/terraform-validate-plan-apply.md) %}

      {{ TF }} создаст все требуемые ресурсы и отобразит значения выходных переменных в терминале. Чтобы проверить результат, выполните команду:

      ```bash
      terraform output
      ```

      Результат:

      ```text
      broker_params = "2024-05-09T17:39:54Z"
      ```

- API {#api}

  Чтобы получить подробную информацию о брокере, воспользуйтесь методом REST API [get](../../iot-core/broker/api-ref/Broker/get.md) для ресурса [Broker](../../iot-core/broker/api-ref/Broker/index.md) или вызовом gRPC API [BrokerService/Get](../../iot-core/broker/api-ref/grpc/broker_service.md#Get).

{% endlist %}
