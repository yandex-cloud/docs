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

      где,
      * `ID` — идентификатор партнера.
      * `REGION ID` — регион облака где можно подключиться через партнера.
      * `STATUS` — состояние партнерства. При значении `DOWN` в этом поле, подключение через такого партнера не предоставляется.

{% endlist %}

