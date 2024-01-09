{% list tabs group=instructions %}

- Консоль управления {#console}

	1. В [консоли управления]({{ link-console-main }}) выберите каталог, в котором находится реестр.
	1. Выберите сервис **{{ ui-key.yacloud.iam.folder.dashboard.label_iot-core }}**.
	1. Выберите реестр.
	1. Перейдите на вкладку **{{ ui-key.yacloud.iot.label_devices }}**.

- CLI {#cli}
  
	{% include [cli-install](../cli-install.md) %}

	{% include [default-catalogue](../default-catalogue.md) %}

	Получите список устройств в реестре:

	```
	yc iot device list --registry-name my-registry
	```

	Результат:
	
	```
	+----------------------+-----------+
	|          ID          |   NAME    |
	+----------------------+-----------+
	| b9135goeh1uc******** | my-device |
	+----------------------+-----------+
	```

- API {#api}

    Чтобы получить список устройств в реестре, воспользуйтесь методом REST API [list](../../iot-core/api-ref/Device/list.md) для ресурса [Device](../../iot-core/api-ref/Device/index.md) или вызовом gRPC API [DeviceService/List](../../iot-core/api-ref/grpc/device_service.md#List).

{% endlist %}