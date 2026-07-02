[Документация Yandex Cloud](../../index.md) > [Yandex Cloud Interconnect](../index.md) > [Пошаговые инструкции](index.md) > Получить информацию о точках присутствия Cloud Interconnect

# Получить информацию о точках присутствия

{% note info %}

Для выполнения операции необходима роль [cic.viewer](../security/index.md#cic-viewer).

{% endnote %}

{% list tabs group=instructions %}

- Консоль управления {#console}

  1. В [консоли управления](https://console.yandex.cloud) на панели сверху нажмите ![layout-side-content-left](../../_assets/console-icons/layout-side-content-left.svg) или ![chevron-down](../../_assets/console-icons/chevron-down.svg) и выберите нужный [каталог](../../resource-manager/concepts/resources-hierarchy.md#folder).
  1. [Перейдите](../../console/operations/select-service.md#select-service) в сервис **Cloud Interconnect**.
  1. На панели слева выберите ![pipeline](../../_assets/console-icons/pipeline.svg) **Транковые подключения** и в открывшемся окне нажмите кнопку **Создать транковое подключение**.
  1. Раскройте список доступных точек присутствия в поле **Точка присутствия**.
  1. Нажмите **Отменить**, чтобы не создавать транковое подключение в этот раз.

- CLI {#cli}

  1. Получите информацию о [точках присутствия](../concepts/pops.md) Cloud Interconnect:

      ```bash
      yc cic point-of-presence list
      ```

      Результат:

      
      ```text
      +----------------+-------------+
      |       ID       |  REGION ID  |
      +----------------+-------------+
      | ru-msk-m9-0    | ru-central1 |
      | ru-msk-nord-0  | ru-central1 |
      | ru-msk-ost-0   | ru-central1 |
      | ru-msk-std-0   | ru-central1 |
      | ru-msk-tehno-0 | ru-central1 |
      +----------------+-------------+
      ```



      Где:

      * `ID` — идентификатор точки присутствия.
      * `REGION ID` — регион облака, к которому данная точка присутствия относится.

{% endlist %}