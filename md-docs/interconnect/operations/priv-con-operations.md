[Документация Yandex Cloud](../../index.md) > [Yandex Cloud Interconnect](../index.md) > [Пошаговые инструкции](index.md) > Получить список операций приватного соединения

# Получить список операций приватного соединения

{% note info %}

Для выполнения операции необходима роль [cic.viewer](../security/index.md#cic-viewer).

{% endnote %}

{% list tabs group=instructions %}

- Консоль управления {#console}

  1. В [консоли управления](https://console.yandex.cloud) на панели сверху нажмите ![layout-side-content-left](../../_assets/console-icons/layout-side-content-left.svg) или ![chevron-down](../../_assets/console-icons/chevron-down.svg) и выберите нужный [каталог](../../resource-manager/concepts/resources-hierarchy.md#folder).
  1. [Перейдите](../../console/operations/select-service.md#select-service) в сервис **Cloud Interconnect**.
  1. На панели слева выберите ![nodes-left](../../_assets/console-icons/nodes-left.svg) **Приватные соединения** и в открывшемся списке приватных соединений нажмите на нужное соединение.
  1. В открывшемся окне с информацией о соединении в меню слева выберите ![list-check](../../_assets/console-icons/list-check.svg) **Операции**, чтобы посмотреть список [операций](../../api-design-guide/concepts/about-async.md) с выбранным приватным соединением.

- CLI {#cli}

  1. Посмотрите описание команды CLI для получения списка операций [приватного соединения](../concepts/priv-con.md):

      ```bash
      yc cic private-connection list-operations --help
      ```

  1. Получите список операций приватного соединения:

      ```bash
      yc cic private-connection list-operations cf3r5ke20fo0********
      ```

      Результат:

      ```text
      +----------------------+---------------------+----------------------+---------------------+---------+---------------------------+
      |          ID          |     CREATED AT      |      CREATED BY      |     MODIFIED AT     | STATUS  |       DESCRIPTION         |
      +----------------------+---------------------+----------------------+---------------------+---------+---------------------------+
      | bd6kg6j1ni92******** | 2025-03-24 10:50:43 | ajeol2afu1js******** | 2025-03-24 11:18:15 | DONE    | private connection update |
      |                      |                     |                      |                     |         |                           |
      | bd6i7jqgtaq1******** | 2025-03-24 10:18:32 | ajeol2afu1js******** | 2025-03-24 10:39:32 | DONE    | private connection create |
      +----------------------+---------------------+----------------------+---------------------+---------+---------------------------+
      ```

      Где:

      * `ID` — идентификатор выполняемой или уже выполненной операции.
      * `CREATED AT` — дата и время, когда операция была создана.
      * `CREATED BY` — идентификатор пользователя, который создал операцию.
      * `MODIFIED AT` — дата и время, когда были последние изменения в рамках выполнения операции.
      * `STATUS` — текущий статус операции (`RUNNING` — выполняется сейчас, `DONE` — уже выполнена).
      * `DESCRIPTION` — описание типа команды, которая выполнялась в данной операции. 

  1. При необходимости получите дополнительную информацию об операции по ее идентификатору:

      ```bash
      yc operation get bd6i7jqgtaq1********
      ```

{% endlist %}