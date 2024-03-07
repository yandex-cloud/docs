# Получить вывод последовательного порта

Вы можете получить информацию, которую виртуальная машина выводит в последовательный порт, и использовать ее, например, для диагностики неполадок.

Для доступа к выводимым данным необходима [роль](../../security/index.md) `сompute.operator` или `{{ roles-viewer }}`.

{% list tabs group=instructions %}

- Консоль управления {#console}

  1. Выберите каталог, которому принадлежит виртуальная машина.
  1. Выберите сервис **{{ ui-key.yacloud.iam.folder.dashboard.label_compute }}**.
  1. Нажмите на строку с нужной виртуальной машиной.
  1. Перейдите на вкладку **{{ ui-key.yacloud.compute.instance.switch_service-console }}**.
  1. Чтобы воспользоваться поиском с помощью сочетания клавиш **Ctrl** + **F**, включите переключатель **{{ ui-key.yacloud.compute.instance.service-console.raw-mode }}** в правом верхнем углу.

- CLI {#cli}

  {% include [default-catalogue](../../../_includes/default-catalogue.md) %}

  1. Посмотрите описание команды для получения вывода последовательного порта:

      ```
      yc compute instance get-serial-port-output --help
      ```

  1. Выберите виртуальную машину, например `first-instance`:

      {% include [compute-instance-list](../../_includes_service/compute-instance-list.md) %}

  1. Получите вывод последовательного порта. Вывод последовательного порта обычно длинный, поэтому его стоит писать в файл:

      ```
      yc compute instance get-serial-port-output first-instance > output.txt
      ```

- API {#api}

  Чтобы получить вывод последовательного порта, воспользуйтесь методом REST API [getSerialPortOutput](../../api-ref/Instance/getSerialPortOutput.md) ресурса [Instance](../../api-ref/Instance/index.md) или вызовом gRPC API [InstanceService/GetSerialPortOutput](../../api-ref/grpc/instance_service.md#GetSerialPortOutput).

{% endlist %}
