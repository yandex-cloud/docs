---
title: Как остановить, запустить или перезапустить сервер в {{ baremetal-full-name }}
description: 'Следуя данной инструкции, вы сможете управлять арендованным сервером {{ baremetal-full-name }}: остановить, запустить или перезапустить его.'
---

# Остановить, запустить или перезапустить сервер

## Остановить {#stop}

Чтобы остановить сервер:

{% list tabs group=instructions %}

- Консоль управления {#console}

  1. В [консоли управления]({{ link-console-main }}) выберите каталог, которому принадлежит сервер.
  1. [Перейдите](../../../console/operations/select-service.md#select-service) в сервис **{{ ui-key.yacloud.iam.folder.dashboard.label_baremetal }}**.
  1. В строке с нужным сервером нажмите значок ![image](../../../_assets/console-icons/ellipsis.svg) и выберите **{{ ui-key.yacloud.common.stop }}**.
  1. В открывшемся окне нажмите кнопку **{{ ui-key.yacloud.common.stop }}**.

- CLI {#cli}

   {% include [cli-install](../../../_includes/cli-install.md) %}

   {% include [default-catalogue](../../../_includes/default-catalogue.md) %}

   1. Посмотрите описание команды для остановки сервера:

      ```bash
      yc baremetal server power-off --help
      ```

   1. Выполните команду:

      ```bash
      yc baremetal server power-off <имя_или_идентификатор_сервера>
      ```

- API {#api}

  Чтобы остановить сервер, воспользуйтесь методом REST API [powerOff](../../api-ref/Server/powerOff.md) для ресурса [Server](../../api-ref/Server/index.md) или вызовом gRPC API [ServerService/PowerOff](../../api-ref/grpc/Server/powerOff.md).

{% endlist %}

## Запустить {#start}

Чтобы запустить остановленный сервер:

{% list tabs group=instructions %}

- Консоль управления {#console}

  1. В [консоли управления]({{ link-console-main }}) выберите каталог, которому принадлежит остановленный сервер.
  1. [Перейдите](../../../console/operations/select-service.md#select-service) в сервис **{{ ui-key.yacloud.iam.folder.dashboard.label_baremetal }}**.
  1. В строке с нужным сервером нажмите значок ![image](../../../_assets/console-icons/ellipsis.svg) и выберите **{{ ui-key.yacloud.common.start }}**.

- CLI {#cli}

   1. Посмотрите описание команды для запуска сервера:

      ```bash
      yc baremetal server power-on --help
      ```

   1. Выполните команду:

      ```bash
      yc baremetal server power-on <имя_или_идентификатор_сервера>
      ```

- API {#api}

  Чтобы запустить сервер, воспользуйтесь методом REST API [powerOn](../../api-ref/Server/powerOn.md) для ресурса [Server](../../api-ref/Server/index.md) или вызовом gRPC API [ServerService/PowerOn](../../api-ref/grpc/Server/powerOn.md).

{% endlist %}

## Перезапустить {#restart}

Чтобы перезапустить сервер:

{% list tabs group=instructions %}

- Консоль управления {#console}

  1. В [консоли управления]({{ link-console-main }}) выберите каталог, которому принадлежит сервер.
  1. [Перейдите](../../../console/operations/select-service.md#select-service) в сервис **{{ ui-key.yacloud.iam.folder.dashboard.label_baremetal }}**.
  1. В строке с нужным сервером нажмите значок ![image](../../../_assets/console-icons/ellipsis.svg) и выберите **{{ ui-key.yacloud.baremetal.action_reboot-server }}**.
  1. В открывшемся окне нажмите кнопку **{{ ui-key.yacloud.baremetal.action_reboot-server }}**. Сервер перейдет в статус `Restarting`.

- CLI {#cli}

   1. Посмотрите описание команды для перезапуска сервера:

      ```bash
      yc baremetal server reboot --help
      ```

   1. Выполните команду:

      ```bash
      yc baremetal server reboot <имя_или_идентификатор_сервера>
      ```

- API {#api}

  Чтобы перезапустить сервер, воспользуйтесь методом REST API [reboot](../../api-ref/Server/reboot.md) для ресурса [Server](../../api-ref/Server/index.md) или вызовом gRPC API [ServerService/Reboot](../../api-ref/grpc/Server/reboot.md).

{% endlist %}

### Примеры запросов {#request-examples}

Чтобы остановить сервер, выполните команду:

```bash
curl -X POST \
-H "Content-Type: application/json" \
-H "Authorization: Bearer <IAM-токен>" \
-d '{}' \
"https://baremetal.api.cloud.yandex.net/baremetal/v1alpha/servers/<идентификатор_сервера>:powerOff"
```

Где:

* `<IAM-токен>` — IAM-токен для аутентификации.
* `<идентификатор_сервера>` — идентификатор сервера, который нужно изменить. Чтобы узнать идентификатор, воспользуйтесь [инструкцией](get-info.md).

Результат:

```bash
{
  "done": false,
  "metadata": {
    "@type": "type.googleapis.com/yandex.cloud.baremetal.v1alpha.PowerOffServerMetadata",
    "serverId": "ly56xpblirh4********"
  },
  "id": "ly5rqxit432m********",
  "description": "Server power off",
  "createdAt": "2025-12-07T19:55:40.399275Z",
  "createdBy": "ajeb9l33h6mu********",
  "modifiedAt": "2025-12-07T19:55:40.399275Z"
}
```

Чтобы запустить сервер, выполните команду:

```bash
curl -X POST \
-H "Content-Type: application/json" \
-H "Authorization: Bearer <IAM-токен>" \
-d '{}' \
"https://baremetal.api.cloud.yandex.net/baremetal/v1alpha/servers/<идентификатор_сервера>:powerOn"
```
Результат:

```bash
{
  "done": false,
  "metadata": {
    "@type": "type.googleapis.com/yandex.cloud.baremetal.v1alpha.PowerOnServerMetadata",
    "serverId": "ly56xpblirh4********"
  },
  "id": "ly5rqxit432m********",
  "description": "Server power on",
  "createdAt": "2025-12-07T19:55:40.399275Z",
  "createdBy": "ajeb9l33h6mu********",
  "modifiedAt": "2025-12-07T19:55:40.399275Z"
}
```
Чтобы перезапустить сервер, выполните команду:

```bash
curl -X POST \
  -H "Content-Type: application/json" \
  -H "Authorization: Bearer <IAM-токен>" \
  -d '{}' \
  "https://baremetal.api.cloud.yandex.net/baremetal/v1alpha/servers/<идентификатор_сервера>:reboot"
```

Результат:

```bash
{
"done": false,
"metadata": {
  "@type": "type.googleapis.com/yandex.cloud.baremetal.v1alpha.RebootServerMetadata",
  "serverId": "ly56xpblirh4********"
},
"id": "ly54ebp4hozz********",
"description": "Server reboot",
"createdAt": "2025-12-07T19:39:42.667128Z",
"createdBy": "ajeb9l33h6mu********",
"modifiedAt": "2025-12-07T19:39:42.667128Z"
}
```

  Отслеживайте статус операций по полю `done`.
