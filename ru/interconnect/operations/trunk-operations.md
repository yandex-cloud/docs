---
title: Как получить список операций транкового подключения в {{ interconnect-name }}
description: Следуя этой инструкции, вы сможете получить список операций транкового подключения в {{ interconnect-name }}.
---

# Получить список операций транкового подключения

{% note info %}

Для выполнения операции необходима роль [cic.viewer](../security/index.md#cic-viewer).

{% endnote %}

{% include [cic-cr-access](../../_includes/interconnect/cic-cr-access.md) %}

{% list tabs group=instructions %}

- Консоль управления {#console}

  1. В [консоли управления]({{ link-console-main }}) на панели сверху нажмите ![layout-side-content-left](../../_assets/console-icons/layout-side-content-left.svg) или ![chevron-down](../../_assets/console-icons/chevron-down.svg) и выберите нужный [каталог](../../resource-manager/concepts/resources-hierarchy.md#folder).
  1. [Перейдите](../../console/operations/select-service.md#select-service) в сервис **{{ ui-key.yacloud.ui.constants.label_interconnect_aUMcv }}**.
  1. На панели слева выберите ![pipeline](../../_assets/console-icons/pipeline.svg) **{{ ui-key.yacloud.interconnect.trunk-connection.trunk-connections_kBGNL }}** и в открывшемся списке транковых подключений нажмите на нужное подключение.
  1. В открывшемся окне с информацией о подключении в меню слева выберите ![list-check](../../_assets/console-icons/list-check.svg) **{{ ui-key.yacloud.common.operations-key-value }}**, чтобы посмотреть список [операций](../../api-design-guide/concepts/about-async.md) с выбранным транковым подключением.

- CLI {#cli}

  1. Посмотрите описание команды CLI для получения списка операций [транкового подключения](../concepts/trunk.md):

      ```bash
      yc cic trunk-connection list-operations --help
      ```

  1. Получите список операций транкового подключения:

      ```bash
      yc cic trunk-connection list-operations cf3dcodot14p********
      ```

      Результат:

      ```text
      +----------------------+---------------------+----------------------+---------------------+---------+--------------+
      |          ID          |     CREATED AT      |      CREATED BY      |     MODIFIED AT     | STATUS  | DESCRIPTION  |
      +----------------------+---------------------+----------------------+---------------------+---------+--------------+
      | bd6a0267a1vf******** | 2025-03-24 15:24:15 | ajeol2afu1js******** | 2025-03-24 15:24:15 | RUNNING | trunk update |
      |                      |                     |                      |                     |         |              |
      | bd6rbsr1gaj9******** | 2025-03-24 08:53:16 | ajeol2afu1js******** | 2025-03-24 09:13:11 | DONE    | trunk create |
      +----------------------+---------------------+----------------------+---------------------+---------+--------------+
      ```

      Где:

      * `ID` — идентификатор выполняемой или уже выполненной операции.
      * `CREATED AT` — дата и время, когда операция была создана.
      * `CREATED BY` — идентификатор пользователя, который создал операцию.
      * `MODIFIED AT` — дата и время, когда были последние изменения в рамках выполнения операции.
      * `STATUS` — текущий статус операции (`RUNNING` — выполняется сейчас, `DONE` — уже выполнена).
      * `DESCRIPTION` — описание типа команды, которая выполнялась в данной операции. 

  1. При необходимости получите дополнительную информацию об операции по ее идентификатору:

      ```text
      yc operation get bd6rbsr1gaj9********
      ```

{% endlist %}

