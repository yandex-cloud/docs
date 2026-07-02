[Документация Yandex Cloud](../../index.md) > [Yandex Cloud Interconnect](../index.md) > [Пошаговые инструкции](index.md) > Получить информацию о партнерах Cloud Interconnect

# Получить информацию о партнерах Cloud Interconnect



Подключение услуги Yandex Cloud Interconnect через партнера пока не доступно.

{% note info %}

Для выполнения операции необходима роль [cic.viewer](../security/index.md#cic-viewer).

{% endnote %}

{% list tabs group=instructions %}

- Консоль управления {#console}

  1. В [консоли управления](https://console.yandex.cloud) на панели сверху нажмите ![layout-side-content-left](../../_assets/console-icons/layout-side-content-left.svg) или ![chevron-down](../../_assets/console-icons/chevron-down.svg) и выберите нужный [каталог](../../resource-manager/concepts/resources-hierarchy.md#folder).
  1. [Перейдите](../../console/operations/select-service.md#select-service) в сервис **Cloud Interconnect**.
  1. На панели слева выберите ![pipeline](../../_assets/console-icons/pipeline.svg) **Транковые подключения** и в открывшемся окне нажмите кнопку **Создать транковое подключение**.
  1. В поле **Тип подключения** выберите `Через партнёра`.

      В результате откроется список партнеров Yandex Cloud Interconnect, доступных для подключения, и информация о поддерживаемых ими скоростях соединения.
  1. Нажмите **Отменить**, чтобы не создавать транковое подключение в этот раз.

- CLI {#cli}

  1. Получите информацию о партнерах Yandex Cloud по предоставлению Cloud Interconnect:

      ```bash
      yc cic partner list
      ```

      Результат:

      ```text
      +-----------+-------------+--------+
      |    ID     |  REGION ID  | STATUS |
      +-----------+-------------+--------+
      | dwdm.ru   | ru-central1 | DOWN   |
      | ertelecom | ru-central1 | UP     |
      | mastertel | ru-central1 | UP     |
      | msk_ix    | ru-central1 | UP     |
      | obit      | ru-central1 | UP     |
      | retn      | ru-central1 | UP     |
      | tnsplus   | ru-central1 | UP     |
      | vimpelkom | ru-central1 | UP     |
      +-----------+-------------+--------+
      ```

      Где:

      * `ID` — идентификатор партнера.
      * `REGION ID` — регион облака где можно подключиться через партнера.
      * `STATUS` — состояние партнерства. При значении `DOWN` в этом поле, подключение через такого партнера не предоставляется.

{% endlist %}