# Получить информацию о партнерах Cloud Interconnect



Подключение услуги Yandex Cloud Interconnect через партнера пока не доступно.

{% note info %}

Для выполнения операции необходима роль [cic.viewer](../security/index.md#cic-viewer).

{% endnote %}

{% list tabs group=instructions %}

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

      где,
      * `ID` — идентификатор партнера.
      * `REGION ID` — регион облака где можно подключиться через партнера.
      * `STATUS` — состояние партнерства. При значении `DOWN` в этом поле, подключение через такого партнера не предоставляется.

{% endlist %}