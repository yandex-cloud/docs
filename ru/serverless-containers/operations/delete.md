---
title: "Удалить контейнер"
description: "Следуя данной инструкции, вы сможете удалить контейнер."
---

# Удалить контейнер

{% list tabs group=instructions %}

- Консоль управления {#console}

	1. В [консоли управления]({{ link-console-main }}) перейдите в каталог, в котором находится контейнер.
	1. Выберите сервис **{{ ui-key.yacloud.iam.folder.dashboard.label_serverless-containers }}**.
	1. В строке с контейнером нажмите значок ![image](../../_assets/console-icons/ellipsis.svg).
	1. В открывшемся меню нажмите кнопку **{{ ui-key.yacloud.common.delete }}**.
	1. В открывшемся окне нажмите кнопку **{{ ui-key.yacloud.common.delete }}**.

- CLI {#cli}

	Чтобы удалить контейнер, выполните команду:

	```
	yc serverless container delete --name <имя_контейнера>
	```

	Результат:

	```
	done (2s)
	```

- {{ TF }} {#tf}

  {% include [terraform-definition](../../_tutorials/_tutorials_includes/terraform-definition.md) %}

  {% include [terraform-install](../../_includes/terraform-install.md) %}

  Чтобы удалить контейнер, созданный с помощью {{ TF }}:

  1. Откройте файл конфигурации {{ TF }} и удалите блок с описанием контейнера.

     Пример описания контейнера в конфигурации {{ TF }}:
     
     ```hcl
     ...
     resource "yandex_serverless_container" "test-container" {
       name               = "my-container"
       memory             = 256
       service_account_id = "ajecvjv1lv01********"
       image {
           url = "{{ registry }}/yc/test-image:v1"
       }
     }
     ...
     ```

	 Более подробную информацию о параметрах ресурса `yandex_serverless_container` в {{ TF }}, см. в [документации провайдера]({{ tf-provider-resources-link }}/serverless_container).

  1. Проверьте конфигурацию командой:
     ```
     terraform validate
     ```
     
     Если конфигурация является корректной, появится сообщение:
     
     ```
     Success! The configuration is valid.
     ```

  1. Выполните команду:
     ```
     terraform plan
     ```
  
     В терминале будет выведен список ресурсов с параметрами. На этом этапе изменения не будут внесены. Если в конфигурации есть ошибки, {{ TF }} на них укажет.

  1. Примените изменения конфигурации:
     ```
     terraform apply
     ```
     
  1. Подтвердите изменения: введите в терминал слово `yes` и нажмите **Enter**.

  Проверить удаление контейнера можно в [консоли управления]({{ link-console-main }}) или с помощью команды [CLI](../../cli/):

  ```
  yc serverless container list
  ```

- API {#api}

  Чтобы удалить контейнер, воспользуйтесь методом REST API [delete](../containers/api-ref/Container/delete.md) для ресурса [Container](../containers/api-ref/Container/index.md) или вызовом gRPC API [ContainerService/Delete](../containers/api-ref/grpc/container_service.md#Delete).

{% endlist %}