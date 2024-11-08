---
title: Как получить информацию о точках присутствия {{ interconnect-name }}
---

# Получить информацию о точках присутствия

{% include [cic-api-access](../../_includes/interconnect/cic-api-access.md) %}

{% list tabs group=instructions %}

- CLI {#cli}

  {% include [cli-install](../../_includes/cli-install.md) %}

  {% include [default-catalogue](../../_includes/default-catalogue.md) %}

  1. Получите информацию о [точках присутствия](../concepts/pops.md) {{ interconnect-name }}:

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

      где,
      * `ID` — идентификатор точки присутствия.
      * `REGION ID` — регион облака к которому данная точка присутствия относится.

{% endlist %}
