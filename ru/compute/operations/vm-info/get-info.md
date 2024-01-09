# Получить информацию о виртуальной машине

Вы можете получить основную информацию о каждой созданной вами [ВМ](../../concepts/vm.md) в [консоли управления]({{ link-console-main }}), на странице ВМ. Чтобы получить детальную информацию вместе с пользовательскими [метаданными](../../concepts/vm-metadata.md), воспользуйтесь CLI или API.

Также основную информацию и метаданные можно получить [изнутри ВМ](#inside-instance).

## Получить информацию снаружи ВМ {#outside-instance}

{% list tabs group=instructions %}

- Консоль управления {#console}

  В сервисе **{{ ui-key.yacloud.iam.folder.dashboard.label_compute }}**, на странице **{{ ui-key.yacloud.compute.instances.label_title }}**, приводится список ВМ в [каталоге](../../../resource-manager/concepts/resources-hierarchy.md#folder) с краткой информацией о них.

  Для получения подробной информации о ВМ нажмите на строку с ее именем.

  На вкладке:
  * **{{ ui-key.yacloud.compute.instance.switch_overview }}** приводится общая информация о ВМ, в том числе [IP-адреса](../../../vpc/concepts/address.md), присвоенные ВМ.
  * **{{ ui-key.yacloud.compute.instance.switch_disks }}** приводится информация о [дисках](../../concepts/disk.md), подключенных к ВМ.

  
  * **{{ ui-key.yacloud.compute.instance.switch_file-storages }}** приводится информация о подключенных [файловых хранилищах](../../concepts/filesystem.md).


  * **{{ ui-key.yacloud.compute.instance.switch_operations }}** приводится список операций с ВМ и подключенными к ней ресурсами, например дисками.
  * **{{ ui-key.yacloud.compute.instance.switch_monitoring }}** приводится информация о потреблении ресурсов на ВМ. Эту информацию можно получить только в консоли управления или изнутри ВМ.
  * **{{ ui-key.yacloud.compute.instance.switch_console }}** предоставлен доступ к [серийной консоли](../../operations/serial-console/index.md), если при [создании](../../operations/index.md#vm-create) ВМ вы разрешили к ней доступ.
  * **{{ ui-key.yacloud.compute.instance.switch_service-console }}** приводится информация, которую ВМ выводит в последовательный порт. Чтобы получить эту информацию через API или CLI, воспользуйтесь инструкцией [{#T}](get-serial-port-output.md).

- CLI {#cli}

  {% include [default-catalogue](../../../_includes/default-catalogue.md) %}

  1. Посмотрите описание команды для получения [вывода последовательного порта](get-serial-port-output.md):

     ```bash
     yc compute instance get --help
     ```

  1. Выберите ВМ, например `first-instance`:

     {% include [compute-instance-list](../../_includes_service/compute-instance-list.md) %}

  1. Получите основную информацию о ВМ:

     ```bash
     yc compute instance get first-instance
     ```

     Чтобы получить информацию о ВМ вместе с метаданными, используйте флаг `--full`:

     ```bash
     yc compute instance get --full first-instance
     ```

- API {#api}

  Чтобы получить основную информацию о ВМ, воспользуйтесь методом REST API [get](../../api-ref/Instance/get.md) для ресурса [Instance](../../api-ref/Instance/index.md) или вызовом gRPC API [InstanceService/Get](../../api-ref/grpc/instance_service.md#Get).

  Основная информация не включает пользовательские метаданные, которые были переданы при создании или [изменении](../../operations/vm-control/vm-update.md) ВМ. Чтобы получить информацию вместе с метаданными, укажите в параметрах `view=FULL`.

{% endlist %}

## Получить информацию изнутри ВМ {#inside-instance}

{% include [vm-metadata](../../../_includes/vm-metadata.md) %}

### Google Compute Engine {#gce-metadata}

Сервис метаданных {{ yandex-cloud }} позволяет возвращать метаданные в формате Google Compute Engine.

#### HTTP-запрос {#gce-http}

```http request
GET http://169.254.169.254/computeMetadata/v1/instance/
  ? alt=<json|text>
  & recursive=<true|false>
  & wait_for_change=<true|false>
  & last_etag=<string>
  & timeout_sec=<int>
Metadata-Flavor: Google
```

Где:
* `alt` — формат ответа (по умолчанию `text`).
* `recursive` — если `true`, возвращает все значения по дереву рекурсивно. По умолчанию `false`.
* `wait_for_change` — если `true`, ответ будет возвращен только когда один из параметров метаданных изменится. По умолчанию `false`.
* `last_etag` — значение ETag из предыдущего ответа на аналогичный запрос. Используйте при `wait_for_change="true"`.
* `timeout_sec` — максимальное время ожидания запроса. Используйте при `wait_for_change="true"`.

#### Примеры запросов {#request-examples}

Узнать идентификатор ВМ изнутри ВМ:

```
curl -H Metadata-Flavor:Google 169.254.169.254/computeMetadata/v1/instance/id
```

Получить метаданные в формате JSON:

```
curl -H Metadata-Flavor:Google 169.254.169.254/computeMetadata/v1/instance/?recursive=true
```

Получить метаданные в удобном для чтения формате. Воспользуйтесь утилитой [jq](https://stedolan.github.io/jq/):

```
curl -H Metadata-Flavor:Google 169.254.169.254/computeMetadata/v1/instance/?recursive=true | jq -r '.'
```

Получить [идентификационный документ](../../concepts/vm-metadata.md#identity-document):

```
curl -H Metadata-Flavor:Google 169.254.169.254/computeMetadata/v1/instance/vendor/identity/document
```

#### Список возвращаемых элементов {#list-of-returned-items}

Список элементов, которые доступны по этому запросу:
* `attributes/` — пользовательские метаданные, переданные при создании или изменении ВМ в поле `metadata`.
* `attributes/ssh-keys` — список открытых [SSH-ключей](../../../glossary/ssh-keygen.md), переданных при создании ВМ в поле `metadata` в значении ключа `ssh-keys`.
* `description` — текстовое описание, переданное при создании или изменении ВМ.
* `disks/` — диски, подключенные к ВМ.
* `hostname` — [FQDN](../../concepts/network.md#hostname), назначенный ВМ.
* `id` — идентификатор ВМ. ID генерируется автоматически при создании ВМ и уникален в пределах {{ yandex-cloud }}.
* `name` — имя, переданное при создании или изменении ВМ.
* `networkInterfaces/` — сетевые интерфейсы, подключенные к ВМ.
* `service-accounts` — [сервисные аккаунты](../../../iam/concepts/users/service-accounts.md), привязанные к ВМ.
* `service-accounts/default/token` — [{{ iam-full-name }}-токен](../../../iam/concepts/authorization/iam-token.md) привязанного сервисного аккаунта.

Другие элементы, например `project`, используются для обратной совместимости и остаются пустыми.

### Amazon EC2 {#ec2-metadata}

Сервис метаданных {{ yandex-cloud }} позволяет возвращать метаданные в формате Amazon EC2. При этом формат не поддерживает работу с пользовательскими полями метаданных.

#### HTTP-запрос {#ec2-http}

```http request
GET http://169.254.169.254/latest/meta-data/<элемент>
```

Где: `<элемент>` — путь к элементу, который вы хотите получить. Если элемент не задан, в ответе вернется список доступных элементов.

#### Список возвращаемых элементов {#list-of-returned-items}

Список элементов, которые доступны по этому запросу.

{% note info %}

В угловых скобках выделены параметры, которые необходимо заменить значениями. Например, вместо `<mac>` следует подставить MAC-адрес сетевого интерфейса.

{% endnote %}

* `hostname` — имя хоста, присвоенное ВМ.
* `instance-id` — идентификатор ВМ.
* `local-ipv4` — [внутренний IPv4-адрес](../../../vpc/concepts/address.md#internal-addresses).
* `local-hostname` — имя хоста, присвоенное ВМ.
* `mac` — MAC-адрес сетевого интерфейса ВМ.
* `network/interfaces/macs/<mac>/ipv6s` — внутренние IPv6-адреса, ассоциированные с сетевым интерфейсом.
* `network/interfaces/macs/<mac>/local-hostname` — имя хоста, ассоциированное с сетевым интерфейсом.
* `network/interfaces/macs/<mac>/local-ipv4s` — внутренние IPv4-адреса, ассоциированные с сетевым интерфейсом.
* `network/interfaces/macs/<mac>/mac` — MAC-адрес сетевого интерфейса ВМ.
* `public-ipv4` — [внешний IPv4-адрес](../../../vpc/concepts/address.md#public-addresses).

#### Примеры запросов {#request-examples}

Получить внутренний IP-адрес изнутри ВМ:

```
curl http://169.254.169.254/latest/meta-data/local-ipv4
```

Получить [идентификационный документ](../../concepts/vm-metadata.md#identity-document):

```
curl http://169.254.169.254/latest/vendor/instance-identity/document
```

## Настроить параметры сервиса метаданных ВМ {#metadata-options}

Вы можете настроить параметры сервиса метаданных при создании или изменении ВМ.

Доступны следующие настройки:
* `aws-v1-http-endpoint` — обеспечивает доступ к метаданным с использованием формата AWS (IMDSv1). Возможные значения: `enabled`, `disabled`.
* `aws-v1-http-token` — обеспечивает доступ к учетным данным {{ iam-name }} с использованием формата AWS (IMDSv1). Возможные значения: `enabled`, `disabled`.

  {% note info %}

  Формат IMDSv1 имеет ряд недостатков со стороны безопасности, поэтому по умолчанию параметр `aws-v1-http-token` выключен (`disabled`). Наиболее критичный недостаток IMDSv1 — повышенный риск реализации некоторых атак, например [SSRF](https://portswigger.net/web-security/ssrf) (подробнее в [официальном блоге AWS](https://aws.amazon.com/blogs/security/defense-in-depth-open-firewalls-reverse-proxies-ssrf-vulnerabilities-ec2-instance-metadata-service/)). Для изменения поведения по умолчанию этого параметра обратитесь в [поддержку]({{ link-console-support }}).

  Наиболее безопасным методом получения токена в {{ yandex-cloud }} является использование [Google Compute Engine](#gce-metadata) формата (он использует дополнительный заголовок для защиты от SSRF).

  {% endnote %}

* `gce-http-endpoint` — обеспечивает доступ к метаданным с использованием формата Google Compute Engine. Возможные значения: `enabled`, `disabled`.
* `gce-http-token` — обеспечивает доступ к учетным данным {{ iam-name }} с использованием формата Google Compute Engine. Возможные значения: `enabled`, `disabled`.

Чтобы настроить параметры сервиса метаданных ВМ:

{% list tabs group=instructions %}

- CLI {#cli}

  {% include [cli-install](../../../_includes/cli-install.md) %}

  {% include [default-catalogue](../../../_includes/default-catalogue.md) %}

  1. Посмотрите описание команды CLI для обновления параметров ВМ:

     ```bash
     yc compute instance update --help
     ```

  1. Получите список ВМ в каталоге по умолчанию:

     ```bash
     yc compute instance list
     ```

  1. Выберите идентификатор (`ID`) или имя (`NAME`) нужной ВМ.
  1. Задайте настройки сервиса метаданных с помощью параметра `--metadata-options`:

     ```bash
     yc compute instance update <ID ВМ> \
       --metadata-options gce-http-endpoint=enabled
     ```

- {{ TF }} {#tf}

  {% include [terraform-install](../../../_includes/terraform-install.md) %}

  {% include [terraform-definition](../../../_tutorials/terraform-definition.md) %}

  1. Откройте файл конфигурации {{ TF }} и измените параметр `metadata_options` в описании ВМ:

     ```hcl
     ...
     resource "yandex_compute_instance" "test-vm" {
       ... 
       metadata_options {
         aws_v1_http_endpoint = 2
         aws_v1_http_token    = 2
         gce_http_endpoint    = 0
         gce_http_token       = 0
       }
       ...
     }
     ...
     ```

     Где:
     * `yandex_compute_instance` — описание ВМ:
       * `metadata_options` — параметры метаданных:
         * `aws_v1_http_endpoint` — обеспечивает доступ к метаданным с использованием формата AWS (IMDSv1). Возможные значения: `0` и `1` — `enabled`, `2` — `disabled`.
         * `aws_v1_http_token` — обеспечивает доступ к учетным данным {{ iam-name }} с использованием формата AWS (IMDSv1). Возможные значения: `0` и `1` — `enabled`, `2` — `disabled`.
         * `gce_http_endpoint` — обеспечивает доступ к метаданным с использованием формата Google Compute Engine. Возможные значения: `0` и `1` — `enabled`, `2` — `disabled`.
         * `gce_http_token` — обеспечивает доступ к учетным данным {{ iam-name }} с использованием формата Google Compute Engine. Возможные значения: `0` и `1` — `enabled`, `2` — `disabled`.

     Более подробную информацию о параметрах ресурса `yandex_compute_instance` в {{ TF }} см. в [документации провайдера]({{ tf-provider-resources-link }}/compute_instance).

  1. Создайте ресурсы:

     {% include [terraform-validate-plan-apply](../../../_tutorials/terraform-validate-plan-apply.md) %}

     После этого в указанном каталоге будут созданы все требуемые ресурсы с заданными настройками. Проверить появление ресурсов и их настройки можно в [консоли управления]({{ link-console-main }}) или с помощью команды CLI:

     ```bash
     yc compute instance get <имя_ВМ>
     ```

- API {#api}

  Воспользуйтесь методом REST API [update](../../api-ref/Instance/update.md) для ресурса [Instance](../../api-ref/Instance/) или вызовом gRPC API [InstanceService/Update](../../api-ref/grpc/instance_service.md#Update).

{% endlist %}

### Удалить SSH-ключи из метаданных {#delete-keys-from-metadata}

{% include [delete-keys-from-metadata](../../../_includes/compute/delete-keys-from-metadata.md) %}
