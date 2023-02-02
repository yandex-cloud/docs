# Удалить контейнер

{% list tabs %}

- Консоль управления

	1. В [консоли управления]({{ link-console-main }}) перейдите в каталог, в котором находится контейнер.
	1. Выберите сервис **{{ serverless-containers-name }}**.
	1. В строке с контейнером нажмите значок ![image](../../_assets/horizontal-ellipsis.svg).
	1. В открывшемся меню нажмите кнопку **Удалить**.
	1. В открывшемся окне нажмите кнопку **Удалить**.

- CLI

	Чтобы удалить контейнер, выполните команду:

	```
	yc serverless container delete --name <имя_контейнера>
	```

	Результат:

	```
	done (2s)
	```

- API

  Удалить контейнер можно с помощью метода API [delete](../containers/api-ref/Container/delete.md).

- {{ TF }}

  {% include [terraform-definition](../../_tutorials/terraform-definition.md) %}

  Подробнее о {{ TF }} [читайте в документации](../../tutorials/infrastructure-management/terraform-quickstart.md#install-terraform).

  Чтобы удалить контейнер, созданный с помощью {{ TF }}:

  1. Откройте файл конфигурации {{ TF }} и удалите блок с описанием контейнера.

     Пример описания контейнера в конфигурации {{ TF }}:
     
     ```hcl
     ...
     resource "yandex_serverless_container" "test-container" {
       name               = "my-container"
       memory             = 256
       service_account_id = "ajec........34ova"
       image {
           url = "cr.yandex/yc/test-image:v1"
       }
     }
     ...
     ```

	 Более подробную информацию о параметрах ресурса `yandex_serverless_container` в {{ TF }}, см. в [документации провайдера]({{ tf-provider-link }}/serverless_container).

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

{% endlist %}