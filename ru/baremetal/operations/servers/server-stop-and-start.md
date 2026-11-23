---
title: Как остановить, запустить или перезагрузить сервер в {{ baremetal-full-name }}
description: Узнайте, как остановить, запустить или перезагрузить сервер {{ baremetal-name }} и выбрать режим для следующей загрузки.
---

# Остановить, запустить или перезагрузить сервер

## Остановить {#stop}

Чтобы остановить сервер:

{% list tabs group=instructions %}

- Консоль управления {#console}

  1. В [консоли управления]({{ link-console-main }}) выберите каталог, которому принадлежит сервер.
  1. [Перейдите]({{ link-console-main }}/link/baremetal) в сервис **{{ ui-key.yacloud.iam.folder.dashboard.label_baremetal }}**.
  1. В строке с нужным сервером нажмите значок ![image](../../../_assets/console-icons/ellipsis.svg) и выберите **{{ ui-key.yacloud.common.stop }}**.
  1. В открывшемся окне нажмите кнопку **{{ ui-key.yacloud.common.stop }}**.

- CLI {#cli}

   {% include [cli-install](../../../_includes/cli-install.md) %}

   {% include [default-catalogue](../../../_includes/default-catalogue.md) %}

   1. Посмотрите описание команды для остановки сервера:

      ```bash
      yc baremetal v2 server power-off --help
      ```

   1. Выполните команду:

      ```bash
      yc baremetal v2 server power-off <идентификатор_сервера>
      ```

- API {#api}

  Чтобы остановить сервер, воспользуйтесь методом REST API [powerOff](../../api-ref/Server/powerOff.md) для ресурса [Server](../../api-ref/Server/index.md) или вызовом gRPC API [ServerService/PowerOff](../../api-ref/grpc/Server/powerOff.md).

{% endlist %}

## Запустить {#start}

Чтобы запустить остановленный сервер:

{% list tabs group=instructions %}

- Консоль управления {#console}

  1. В [консоли управления]({{ link-console-main }}) выберите каталог, которому принадлежит остановленный сервер.
  1. [Перейдите]({{ link-console-main }}/link/baremetal) в сервис **{{ ui-key.yacloud.iam.folder.dashboard.label_baremetal }}**.
  1. В строке с нужным сервером нажмите значок ![image](../../../_assets/console-icons/ellipsis.svg) и выберите **{{ ui-key.yacloud.common.start }}**.

- CLI {#cli}

   1. Посмотрите описание команды для запуска сервера:

      ```bash
      yc baremetal v2 server power-on --help
      ```

   1. Выполните команду:

      ```bash
      yc baremetal v2 server power-on <идентификатор_сервера>
      ```

- API {#api}

  Чтобы запустить сервер, воспользуйтесь методом REST API [powerOn](../../api-ref/Server/powerOn.md) для ресурса [Server](../../api-ref/Server/index.md) или вызовом gRPC API [ServerService/PowerOn](../../api-ref/grpc/Server/powerOn.md).

{% endlist %}

## Перезагрузить {#restart}

Чтобы перезагрузить сервер:

{% list tabs group=instructions %}

- Консоль управления {#console}

  1. В [консоли управления]({{ link-console-main }}) выберите каталог, которому принадлежит сервер.
  1. [Перейдите]({{ link-console-main }}/link/baremetal) в сервис **{{ ui-key.yacloud.iam.folder.dashboard.label_baremetal }}**.
  1. В строке с нужным сервером нажмите значок ![image](../../../_assets/console-icons/ellipsis.svg) и выберите **{{ ui-key.yacloud.baremetal.action_reboot-server }}**.
  1. В открывшемся окне нажмите кнопку **{{ ui-key.yacloud.baremetal.action_reboot-server }}**. Сервер перейдет в статус `Restarting`.

- CLI {#cli}

   1. Посмотрите описание команды для перезагрузки сервера:

      ```bash
      yc baremetal v2 server reboot --help
      ```

   1. Перезагрузите сервер:

      ```bash
      yc baremetal v2 server reboot <идентификатор_сервера>
      ```

- API {#api}

    Для обычной перезагрузки опустите поле `rebootMode` в теле запроса REST API или поле `reboot_mode` в сообщении gRPC `RebootServerRequest`:

    * Для API v1alpha используйте метод REST API [reboot](../../api-ref/Server/reboot.md) ресурса [Server](../../api-ref/Server/index.md) или вызов gRPC API [ServerService/Reboot](../../api-ref/grpc/Server/reboot.md).
    * Для API v2 используйте метод REST API [rebootServer](../../api-ref/Server/rebootServer.md) или вызов gRPC API [ServerService/RebootServer](../../api-ref/grpc/Server/rebootServer.md).

{% endlist %}

По умолчанию сервер использует заранее настроенный порядок загрузки. Через CLI или API можно выбрать режим для следующей загрузки: [загрузку по сети (PXE)](#reboot-pxe), [загрузку с CD-ROM](#reboot-cdrom) или [вход в BIOS](#reboot-bios).

### Перезагрузить в PXE {#reboot-pxe}

Чтобы перезагрузить сервер с последующей загрузкой по сети:

{% list tabs group=instructions %}

- CLI {#cli}

  ```bash
  yc baremetal v2 server reboot <идентификатор_сервера> --reboot-mode network
  ```

- API {#api}

    * REST API — передайте `{"rebootMode": "NETWORK"}` в теле запроса [reboot](../../api-ref/Server/reboot.md) (v1alpha) или [rebootServer](../../api-ref/Server/rebootServer.md) (v2).
    * gRPC API — укажите `NETWORK` в поле `reboot_mode` при вызове [ServerService/Reboot](../../api-ref/grpc/Server/reboot.md) (v1alpha) или [ServerService/RebootServer](../../api-ref/grpc/Server/rebootServer.md) (v2).

{% endlist %}

В сетях {{ baremetal-name }} по умолчанию нет PXE-серверов. Чтобы загрузить образ по сети, заранее настройте собственный PXE-сервер.

### Перезагрузить с CD-ROM {#reboot-cdrom}

Чтобы перезагрузить сервер с последующей загрузкой со смонтированного ISO-образа:

{% list tabs group=instructions %}

- CLI {#cli}

  ```bash
  yc baremetal v2 server reboot <идентификатор_сервера> --reboot-mode cdrom
  ```

- API {#api}

    * REST API — передайте `{"rebootMode": "CDROM"}` в теле запроса [reboot](../../api-ref/Server/reboot.md) (v1alpha) или [rebootServer](../../api-ref/Server/rebootServer.md) (v2).
    * gRPC API — укажите `CDROM` в поле `reboot_mode` при вызове [ServerService/Reboot](../../api-ref/grpc/Server/reboot.md) (v1alpha) или [ServerService/RebootServer](../../api-ref/grpc/Server/rebootServer.md) (v2).

{% endlist %}

Перед перезагрузкой [смонтируйте загрузочный ISO-образ](./reinstall-os-from-own-image.md#boot-from-image) на виртуальный CD-дисковод сервера.

### Перезагрузить в BIOS {#reboot-bios}

Чтобы перезагрузить сервер с последующим входом в меню настроек BIOS:

{% list tabs group=instructions %}

- CLI {#cli}

  ```bash
  yc baremetal v2 server reboot <идентификатор_сервера> --reboot-mode bios
  ```

- API {#api}

    * REST API — укажите `BIOS` в поле `rebootMode` запроса [reboot](../../api-ref/Server/reboot.md) (v1alpha) или [rebootServer](../../api-ref/Server/rebootServer.md) (v2). Для API v1alpha выполните команду:

      ```bash
      curl -X POST \
        -H "Content-Type: application/json" \
        -H "Authorization: Bearer <IAM-токен>" \
        -d '{"rebootMode": "BIOS"}' \
        "https://baremetal.api.cloud.yandex.net/baremetal/v1alpha/servers/<идентификатор_сервера>:reboot"
      ```

    * gRPC API — укажите `BIOS` в поле `reboot_mode` при вызове [ServerService/Reboot](../../api-ref/grpc/Server/reboot.md) (v1alpha) или [ServerService/RebootServer](../../api-ref/grpc/Server/rebootServer.md) (v2).

{% endlist %}

Для работы с меню BIOS [подключитесь к KVM-консоли](./server-kvm.md).

## Примеры запросов REST API {#request-examples}

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

Следующий запрос к REST API v1alpha перезагрузит сервер в обычном режиме:

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
