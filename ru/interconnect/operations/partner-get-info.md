---
title: Как получить информацию о партнерах {{ interconnect-name }}
description: Следуя этой инструкции, вы сможете получить информацию о партнерах {{ interconnect-name }}.
---

# Получить информацию о партнерах {{ interconnect-name }}



Подключение услуги {{ interconnect-full-name }} через партнера пока не доступно.

{% note info %}

Для выполнения операции необходима роль [cic.viewer](../security/index.md#cic-viewer).

{% endnote %}

{% list tabs group=instructions %}

- Консоль управления {#console}

  1. В [консоли управления]({{ link-console-main }}) на панели сверху нажмите ![layout-side-content-left](../../_assets/console-icons/layout-side-content-left.svg) или ![chevron-down](../../_assets/console-icons/chevron-down.svg) и выберите нужный [каталог](../../resource-manager/concepts/resources-hierarchy.md#folder).
  1. [Перейдите](../../console/operations/select-service.md#select-service) в сервис **{{ ui-key.yacloud.ui.constants.label_interconnect_aUMcv }}**.
  1. На панели слева выберите ![pipeline](../../_assets/console-icons/pipeline.svg) **{{ ui-key.yacloud.interconnect.trunk-connection.trunk-connections_kBGNL }}** и в открывшемся окне нажмите кнопку **{{ ui-key.yacloud.interconnect.trunk-connection.TrunkConnectionListScreen.create-trunk-connection_oUuYo }}**.
  1. В поле **{{ ui-key.yacloud.interconnect.trunk-connection.connection-type_23Twp }}** выберите `{{ ui-key.yacloud.interconnect.trunk-connection.connection-type-partner_tsPPf }}`.

      В результате откроется список партнеров {{ interconnect-full-name }}, доступных для подключения, и информация о поддерживаемых ими скоростях соединения.
  1. Нажмите **{{ ui-key.yacloud.common.cancel }}**, чтобы не создавать транковое подключение в этот раз.

- CLI {#cli}

  1. Получите информацию о партнерах {{ yandex-cloud }} по предоставлению {{ interconnect-name }}:

      ```bash
      yc cic partner list
      ```

      Результат:

      ```text
      +-----------+-------------+--------+
      |    ID     |  REGION ID  | STATUS |
      +-----------+-------------+--------+
      | dwdm.ru   | {{ region-id }} | DOWN   |
      | ertelecom | {{ region-id }} | UP     |
      | mastertel | {{ region-id }} | UP     |
      | msk_ix    | {{ region-id }} | UP     |
      | obit      | {{ region-id }} | UP     |
      | retn      | {{ region-id }} | UP     |
      | tnsplus   | {{ region-id }} | UP     |
      | vimpelkom | {{ region-id }} | UP     |
      +-----------+-------------+--------+
      ```

      Где:

      * `ID` — идентификатор партнера.
      * `REGION ID` — регион облака где можно подключиться через партнера.
      * `STATUS` — состояние партнерства. При значении `DOWN` в этом поле, подключение через такого партнера не предоставляется.

{% endlist %}

