# Масштабирование функции

Поступающие запросы обрабатываются функцией по одному. Если функция вызывается быстрее, чем один экземпляр успевает обрабатывать запрос, {{ sf-name }} масштабирует функцию — запускает ее дополнительные экземпляры. Вы можете задать:
*  `zone_instances_limit` — количество экземпляров функции в [зоне доступности](../../../overview/concepts/geo-scope.md);
* `zone_requests_limit` — количество одновременно выполняемых вызовов функции в зоне доступности.

{% note info %}

Вызовы распределяются по зонам доступности случайным образом. Cloud Functions не гарантирует равномерное распределение вызовов по зонам. Например, все вызовы вне зависимости от их количества могут попасть в одну зону.

{% endnote %}

Когда количество экземпляров функции достигает значения `zone_instances_limit`, {{ sf-name }} перестает ее масштабировать. Если вызовов функции больше, чем доступных экземпляров, вызов становится в очередь, но при этом считается выполняемым. Когда количество выполняемых вызовов достигает значения `zone_requests_limit`, сервис перестает ставить вызовы в очередь и возвращает ошибку `429 TooManyRequests`.

Для разных [версий](../../concepts/function.md#version) функции можно задать свои настройки масштабирования, используя [теги](../../concepts/function.md#tag). Настройки масштабирования будут действовать для той версии функции, которой присвоен указанный тег. Версии функции масштабируются независимо друг от друга.

Настройки масштабирования не могут превышать [квоты](../../concepts/limits.md#functions-quotas). Если настройка равна нулю, функция масштабируется в пределах квот.

## Посмотреть настройки масштабирования {#list}

{% list tabs %}

- CLI

	{% include [cli-install](../../../_includes/cli-install.md) %}

    {% include [default-catalogue](../../../_includes/default-catalogue.md) %}

	Чтобы посмотреть настройки масштабирования функции, выполните команду:

	```
	yc serverless function list-scaling-policies --id=d4eokpuol55h********
	```

	* `--id` — идентификатор функции. Чтобы узнать его, [получите](./version-manage.md#function-list) список функций.

	Результат:

	```
	+----------------------+---------+----------------------+---------------------+
	|     FUNCTION ID      |   TAG   | ZONE INSTANCES LIMIT | ZONE REQUESTS LIMIT |
	+----------------------+---------+----------------------+---------------------+
	| d4eokpuol55hmj15k7g1 | $latest |                    1 |                   2 |
	+----------------------+---------+----------------------+---------------------+
	```

- API

    Посмотреть настройки масштабирования функции можно с помощью метода API [listScalingPolicies](../../functions/api-ref/Function/listScalingPolicies.md).

- Yandex.Cloud Toolkit

    Посмотреть настройки масштабирования функции можно с помощью [плагина Yandex.Cloud Toolkit]{% if lang == "ru" %}(https://github.com/yandex-cloud/ide-plugin-jetbrains){% endif %}{% if lang == "en" %}(https://github.com/yandex-cloud/ide-plugin-jetbrains/blob/master/README.en.md){% endif %} для семейства IDE на [платформе Intellij]{% if lang == "ru" %}(https://www.jetbrains.com/ru-ru/opensource/idea/){% endif %}{% if lang == "en" %}(https://www.jetbrains.com/opensource/idea/){% endif %} от [JetBrains](https://www.jetbrains.com/).

{% endlist %}

## Добавить настройки масштабирования {#add}

{% list tabs %}

- CLI

	Чтобы добавить настройки масштабирования для функции, выполните команду:

	```
	yc serverless function set-scaling-policy \
		--id=d4eokpuol55h******** \
		--tag=\$latest \
		--zone-instances-limit=1 \
		--zone-requests-limit=2
	```

	* `--id` — идентификатор функции. Чтобы узнать его, [получите](./version-manage.md#function-list) список функций.
	* `--tag` —  [тег](../../concepts/function.md#tag) версии функции.
	* `--zone-instances-limit` — количество экземпляров функции.
	* `--zone-requests-limit` — количество выполняемых вызовов.

	Результат:

	```
	function_id: d4eokpuol55h********
	tag: $latest
	zone_instances_limit: "1"
	zone_requests_limit: "2"
	```

- Terraform

   {% include [terraform-definition](../../../_includes/solutions/terraform-definition.md) %}

   Если у вас ещё нет Terraform, [установите его и настройте провайдер {{ yandex-cloud }}](../../../solutions/infrastructure-management/terraform-quickstart.md#install-terraform).  

   Чтобы добавить настройки масштабирования: 
     
   1. Опишите в конфигурационном файле параметры ресурсов, которые необходимо создать:
      
        * `yandex_function_scaling_policy` — описание настроек масштабирования функции.
            * `function_id` — идентификатор функции.
            * `policy` — настройки масштабирования.
            * `policy.0.tag` — [тег](../../concepts/function.md#tag) версии функции.
            * `policy.0.zone_instances_limit` — количество экземпляров функции.
            * `policy.0.zone_requests_limit` — количество выполняемых вызовов.
             
        Пример структуры конфигурационного файла:
      
        ```
        provider "yandex" {
            token     = "<OAuth или статический ключ сервисного аккаунта>"
            folder_id = "<идентификатор каталога>"
            zone      = "ru-central1-a"
        }

		resource "yandex_function_scaling_policy" "my_scaling_policy" {
			function_id = "are1samplefu********"
			policy {
				tag = "$latest"
				zone_instances_limit = 2
				zone_requests_limit  = 1
		  	}
		}
        ```
      
        Более подробную информацию о ресурсах, которые вы можете создать с помощью Terraform, см. в [документации провайдера](https://www.terraform.io/docs/providers/yandex/index.html).
      
    1. Проверьте корректность конфигурационных файлов.
      
        1. В командной строке перейдите в папку, где вы создали конфигурационный файл.
        1. Выполните проверку с помощью команды:
            ```
            terraform plan
            ```
        Если конфигурация описана верно, в терминале отобразится список создаваемых ресурсов и их параметров. Если в конфигурации есть ошибки, Terraform на них укажет. 
         
   1. Разверните облачные ресурсы.

        1. Если в конфигурации нет ошибок, выполните команду:
            ```
            terraform apply
            ```
        1. Подтвердите создание ресурсов.
      
        После этого в указанном каталоге будут созданы все требуемые ресурсы. Проверить появление ресурсов и их настройки можно в [консоли управления]({{ link-console-main }}).

- API

    Добавить настройки масштабирования для функции можно с помощью метода API [setScalingPolicy](../../functions/api-ref/Function/setScalingPolicy.md).

- Yandex.Cloud Toolkit

    Добавить настройки масштабирования для функции можно с помощью [плагина Yandex.Cloud Toolkit]{% if lang == "ru" %}(https://github.com/yandex-cloud/ide-plugin-jetbrains){% endif %}{% if lang == "en" %}(https://github.com/yandex-cloud/ide-plugin-jetbrains/blob/master/README.en.md){% endif %} для семейства IDE на [платформе Intellij]{% if lang == "ru" %}(https://www.jetbrains.com/ru-ru/opensource/idea/){% endif %}{% if lang == "en" %}(https://www.jetbrains.com/opensource/idea/){% endif %} от [JetBrains](https://www.jetbrains.com/).

{% endlist %}

## Удалить настройки масштабирования {#delete}

{% list tabs %}

- CLI

	Чтобы удалить настройки масштабирования для функции, выполните команду:

	```
	yc serverless function remove-scaling-policy \
		--id=d4eokpuol55h******** \
		--tag=\$latest
	```

	* `--id` — идентификатор функции. Чтобы узнать его, [получите](./version-manage.md#function-list) список функций.
	* `--tag` —  [тег](../../concepts/function.md#tag) версии функции.

- API

    Удалить настройки масштабирования для функции можно с помощью метода API [removeScalingPolicy](../../functions/api-ref/Function/removeScalingPolicy.md).

- Yandex.Cloud Toolkit

    Удалить настройки масштабирования для функции можно с помощью [плагина Yandex.Cloud Toolkit]{% if lang == "ru" %}(https://github.com/yandex-cloud/ide-plugin-jetbrains){% endif %}{% if lang == "en" %}(https://github.com/yandex-cloud/ide-plugin-jetbrains/blob/master/README.en.md){% endif %} для семейства IDE на [платформе Intellij]{% if lang == "ru" %}(https://www.jetbrains.com/ru-ru/opensource/idea/){% endif %}{% if lang == "en" %}(https://www.jetbrains.com/opensource/idea/){% endif %} от [JetBrains](https://www.jetbrains.com/).

{% endlist %}
