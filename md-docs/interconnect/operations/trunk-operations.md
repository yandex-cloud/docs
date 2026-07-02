[Документация Yandex Cloud](../../index.md) > [Yandex Cloud Interconnect](../index.md) > [Пошаговые инструкции](index.md) > Получить список операций транкового подключения

# Получить список операций транкового подключения

{% note info %}

Для выполнения операции необходима роль [cic.viewer](../security/index.md#cic-viewer).

{% endnote %}

{% list tabs group=instructions %}

- Консоль управления {#console}

  1. В [консоли управления](https://console.yandex.cloud) на панели сверху нажмите ![layout-side-content-left](../../_assets/console-icons/layout-side-content-left.svg) или ![chevron-down](../../_assets/console-icons/chevron-down.svg) и выберите нужный [каталог](../../resource-manager/concepts/resources-hierarchy.md#folder).
  1. [Перейдите](../../console/operations/select-service.md#select-service) в сервис **Cloud Interconnect**.
  1. На панели слева выберите ![pipeline](../../_assets/console-icons/pipeline.svg) **Транковые подключения** и в открывшемся списке транковых подключений нажмите на нужное подключение.
  1. В открывшемся окне с информацией о подключении в меню слева выберите ![list-check](../../_assets/console-icons/list-check.svg) **Операции**, чтобы посмотреть список [операций](../../api-design-guide/concepts/about-async.md) с выбранным транковым подключением.

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