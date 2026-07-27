---
title: Как получить информацию о виртуальном маршрутизаторе
description: Следуя этой инструкции, вы сможете получить информацию о виртуальном маршрутизаторе в {{ cr-name }}.
---

# Получить информацию о виртуальном маршрутизаторе

{% note info %}

Для выполнения операции необходима роль [cloud-router.viewer](../security/index.md#cloudrouter-viewer).

{% endnote %}

{% list tabs group=instructions %}

- Консоль управления {#console}

  1. В [консоли управления]({{ link-console-main }}) выберите [каталог](../../resource-manager/concepts/resources-hierarchy.md#folder), в котором находится [виртуальный маршрутизатор](../concepts/routing-instance.md).
  1. [Перейдите]({{ link-console-main }}/link/cloud-router) в сервис **{{ ui-key.yacloud.ui.constants.label_cloud-router_kBGNL }}**.
  1. Выберите виртуальный маршрутизатор.
  1. На вкладке **{{ ui-key.yacloud.common.overview }}** отобразится информация о виртуальном маршрутизаторе, а также маршрутизируемые сети и префиксы.

- CLI {#cli}

  Вы можете посмотреть информацию о виртуальном маршрутизаторе с помощью следующих команд:
  * [yc cloudrouter routing-instance get](../../cli/cli-ref/cloudrouter/cli-ref/routing-instance/get.md) — позволяет получить информацию о виртуальном маршрутизаторе по его имени или идентификатору.
  * [yc cloudrouter routing-instance get-by-cic-private-connection-id](../../cli/cli-ref/cloudrouter/cli-ref/routing-instance/get-by-cic-private-connection-id.md) — позволяет получить информацию о виртуальном маршрутизаторе по идентификатору [приватного соединения](../../interconnect/concepts/priv-con.md) {{ interconnect-full-name }}, которое подключено к виртуальному маршрутизатору.
  * [yc cloudrouter routing-instance get-by-vpc-network-id](../../cli/cli-ref/cloudrouter/cli-ref/routing-instance/get-by-vpc-network-id.md) — позволяет получить информацию о виртуальном маршрутизаторе по идентификатору [облачной сети](../../vpc/concepts/network.md#network), с которой виртуальный маршрутизатор обеспечивает сетевую связность.

  **yc cloudrouter routing-instance get**

  1. Посмотрите описание команды CLI для получения информации о виртуальном маршрутизаторе:

      ```bash
      yc cloudrouter routing-instance get --help
      ```

  1. Получите список виртуальных маршрутизаторов в заданном [каталоге](../../resource-manager/concepts/resources-hierarchy.md#folder):

      ```bash
      yc cloudrouter routing-instance list \
        --folder-id <идентификатор_каталога>
      ```

      Результат:

      ```text
      +----------------------+--------------------+--------+-----------------------+
      |          ID          |        NAME        | STATUS | PRIVATE CONNECTION ID |
      +----------------------+--------------------+--------+-----------------------+
      | cf3jqdc4gjpx******** | routing-instance   | ACTIVE | euuiog88zphg********, |
      |                      |                    |        | euucr7p47329********  |
      +----------------------+--------------------+--------+-----------------------+
      ```

  1. Получите информацию о виртуальном маршрутизаторе, указав его идентификатор, полученный на предыдущем шаге:

      ```bash
      yc cloudrouter routing-instance get cf3jqdc4gjpx********
      ```

      {% cut "Результат:" %}

      {% include [ri-get-cli-output](../../_includes/cloud-router/ri-get-cli-output.md) %}

      {% endcut %}

  **yc cloudrouter routing-instance get-by-cic-private-connection-id**

  1. Посмотрите описание команды CLI для получения информации о виртуальном маршрутизаторе:

      ```bash
      yc cloudrouter routing-instance get-by-cic-private-connection-id --help
      ```
  1. Получите список приватных соединений в заданном каталоге:

      ```bash
      yc cic private-connection list \
        --folder-id <идентификатор_каталога>
      ```

      Результат:

      ```text
      +----------------------+------+----------------------+
      |          ID          | NAME | TRUNK CONNECTION ID  |
      +----------------------+------+----------------------+
      | cf3r5ke20fo0******** |      | cf3dcodot14p******** |
      | cf3r3mfr4bm5******** |      | cf3dcodot14p******** |
      +----------------------+------+----------------------+
      ```
  1. Получите информацию о виртуальном маршрутизаторе, указав идентификатор подключенного к нему приватного соединения:

      ```bash
      yc cloudrouter routing-instance get-by-cic-private-connection-id \
        --cic-prc-id cf3r5ke20fo0********
      ```

      {% cut "Результат:" %}

      {% include [ri-get-cli-output](../../_includes/cloud-router/ri-get-cli-output.md) %}

      {% endcut %}

  **yc cloudrouter routing-instance get-by-vpc-network-id**

  1. Посмотрите описание команды CLI для получения информации о виртуальном маршрутизаторе:

      ```bash
      yc cloudrouter routing-instance get-by-vpc-network-id --help
      ```
  1. Получите список облачных сетей в заданном каталоге:

      ```bash
      yc vpc network list \
        --folder-id <идентификатор_каталога>
      ```

      Результат:

      ```
      +----------------------+-------------+
      |          ID          |    NAME     |
      +----------------------+-------------+
      | enpcfncr6uld******** | my-network1 |
      | enpcuntrql7d******** | my-network2 |
      +----------------------+-------------+
      ```
  1. Получите информацию о виртуальном маршрутизаторе, указав идентификатор облачной сети, с которой он обеспечивает сетевую связность:

      ```bash
      yc cloudrouter routing-instance get-by-vpc-network-id \
        --vpc-id enpcfncr6uld********
      ```

      {% cut "Результат:" %}

      {% include [ri-get-cli-output](../../_includes/cloud-router/ri-get-cli-output.md) %}

      {% endcut %}

{% endlist %}