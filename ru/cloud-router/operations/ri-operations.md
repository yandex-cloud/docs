---
title: Как получить список операций Routing Instance
---

# Получить список операций Routing Instance

{% include [cic-cr-access](../../_includes/interconnect/cic-cr-access.md) %}

{% note info %}

Для выполнения операции необходима роль [cloud-router.viewer](../security/index.md#cloudrouter-viewer).

{% endnote %}

{% list tabs group=instructions %}

- CLI {#cli}

  1. Посмотрите описание команды CLI для получения списка операций [Routing Instance (RI)](../concepts/routing-instance.md):

      ```bash
      yc cloudrouter routing-instance list-operations --help
      ```

  1. Получите список операций Routing Instance:

      ```bash
      yc cloudrouter routing-instance list-operations cca5e**********vie8c
      ```

      Результат:

      ```text
     +----------------------+---------------------+----------------------+---------------------+---------+---------------------------+
     |          ID          |     CREATED AT      |      CREATED BY      |     MODIFIED AT     | STATUS  |       DESCRIPTION         |
     +----------------------+---------------------+----------------------+---------------------+---------+---------------------------+
     | al49a**********ft8lq | 2025-03-23 07:34:27 | bfbud**********v7dfn | 2025-03-23 07:52:59 | DONE    | routing instance add      |
     |                      |                     |                      |                     |         | private connection        |
     | al4f3**********koifj | 2025-03-19 13:35:56 | bfbud**********v7dfn | 2025-03-19 15:24:58 | DONE    | routing instance create   |
     +----------------------+---------------------+----------------------+---------------------+---------+---------------------------+
      ```

      где,
      * `ID` — идентификатор выполняемой или уже выполненной операции.
      * `CREATED AT` — дата и время, когда операция была создана.
      * `CREATED BY` — идентификатор пользователя, который создал операцию.
      * `MODIFIED AT` — дата и время, когда были последние изменения в рамках выполнения операции.
      * `STATUS` — текущий статус операции (`RUNNING` — выполняется сейчас, `DONE` — уже выполнена).
      * `DESCRIPTION` — описание типа команды, которая выполнялась в данной операции. 

  1. При необходимости получите дополнительную информацию об операции по ее идентификатору:

    ```bash
    yc operation get al49a**********ft8lq
    ```
  
{% endlist %}

