---
title: Как получить информацию о точках присутствия {{ interconnect-name }}
description: Следуя этой инструкции, вы сможете получить информацию о точках присутствия {{ interconnect-name }}.
---

# Получить информацию о точках присутствия

{% note info %}

Для выполнения операции необходима роль [cic.viewer](../security/index.md#cic-viewer).

{% endnote %}

{% list tabs group=instructions %}

- Консоль управления {#console}

  1. В [консоли управления]({{ link-console-main }}) на панели сверху нажмите ![layout-side-content-left](../../_assets/console-icons/layout-side-content-left.svg) или ![chevron-down](../../_assets/console-icons/chevron-down.svg) и выберите нужный [каталог](../../resource-manager/concepts/resources-hierarchy.md#folder).
  1. [Перейдите](../../console/operations/select-service.md#select-service) в сервис **{{ ui-key.yacloud.ui.constants.label_interconnect_aUMcv }}**.
  1. На панели слева выберите ![pipeline](../../_assets/console-icons/pipeline.svg) **{{ ui-key.yacloud.interconnect.trunk-connection.trunk-connections_kBGNL }}** и в открывшемся окне нажмите кнопку **{{ ui-key.yacloud.interconnect.trunk-connection.TrunkConnectionListScreen.create-trunk-connection_oUuYo }}**.
  1. Раскройте список доступных точек присутствия в поле **{{ ui-key.yacloud.interconnect.trunk-connection.point-of-presence_265QN }}**.
  1. Нажмите **{{ ui-key.yacloud.common.cancel }}**, чтобы не создавать транковое подключение в этот раз.

- CLI {#cli}

  1. Получите информацию о [точках присутствия](../concepts/pops.md) {{ interconnect-name }}:

      ```bash
      yc cic point-of-presence list
      ```

      Результат:

      
      ```text
      +----------------+-------------+
      |       ID       |  REGION ID  |
      +----------------+-------------+
      | ru-msk-m9-0    | {{ region-id }} |
      | ru-msk-nord-0  | {{ region-id }} |
      | ru-msk-ost-0   | {{ region-id }} |
      | ru-msk-std-0   | {{ region-id }} |
      | ru-msk-tehno-0 | {{ region-id }} |
      +----------------+-------------+
      ```



      Где:

      * `ID` — идентификатор точки присутствия.
      * `REGION ID` — регион облака, к которому данная точка присутствия относится.

{% endlist %}

