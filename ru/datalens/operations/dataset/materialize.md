# Материализация датасета

{% include [datalens-materialization-off-unavailable](../../../_includes/datalens/datalens-materialization-off-unavailable.md) %}

Чтобы материализовать датасет:

1. На странице навигации найдите датасет и откройте его.
1. В верхней части экрана нажмите значок ![image](../../../_assets/datalens/horizontal-ellipsis.svg) и выберите ![image](../../../_assets/datalens/materialize.svg) **Материализация**.
1. В появившемся окне выберите:

   * **Прямой доступ** — все запросы к данным исполняются на стороне источника. Данные не загружаются в БД материализации.
   * **Единовременная** — данные загружаются в БД материализации единовременно.
   * **Периодическая** — данные загружаются в БД материализации по расписанию.
    
1. Укажите настройки материализации и нажмите **Сохранить**.

{% if audience == "internal" %}

## Настройка уведомления о материализации {#notify}

Чтобы настроить уведомление о падении материализации датасета:

1. Создайте датасет `dataset_id` и настройте периодическую материализацию.

   Процесс материализации отправляет в Juggler [сырое событие](https://juggler.yandex-team.ru/raw_events/?query=host%3Dint-prod-materializer-materialization%26service%3D*) с параметрами `host: int-prod-materializer-materialization` и `service: {dataset_id}`.

1. Создайте [агрегированную проверку](https://juggler.yandex-team.ru/aggregate_checks/) в Juggler.

   ```
    namespace: your_namespace
     host: dataset_materialization
     service: custom_service
     refresh_time: 600
     ttl: 93600  # 26 hours
     aggregator: logic_or
     children:
         -
             host: int-prod-materializer-materialization
             service: {dataset_id}
             type: HOST
   ```

   Другие настройки агрегата указаны в [документации Juggler](https://docs.yandex-team.ru/juggler/).

1. Настройте [уведомление](https://juggler.yandex-team.ru/notification_rules/) на созданный агрегат.

   ```
    namespace: your_namespace
     selector: host=dataset_materialization & service=custom_service
     template_name: on_status_change
     template_kwargs:
         status:
             - CRIT
         login:
             - your_login
         method:
             - telegram
     description: Materialization failed
   ```

Уведомления будут приходить вам в Telegram при падении или задержке материализации. Эта информация необходима при обращении в [чат DataLens Community](https://t.me/joinchat/BbHwRD-yeFhOUcVS1_fdsA).

{% endif %}

#### См. также {#see-also}
- [{#T}](../../concepts/dataset/settings.md#mode)
