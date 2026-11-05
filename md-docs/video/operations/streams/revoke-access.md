[Документация Yandex Cloud](../../../index.md) > [Yandex Cloud Video](../../index.md) > [Пошаговые инструкции](../index.md) > Трансляции > Отозвать доступ к трансляции

# Отозвать доступ к трансляции

{% list tabs group=instructions %}

- Интерфейс Cloud Video {#console}

  1. Откройте [главную страницу](https://video.yandex.cloud/) Cloud Video.
  1. Выберите канал.
  1. На вкладке ![image](../../../_assets/console-icons/antenna-signal.svg) **Трансляции** выберите нужную трансляцию.
  1. В блоке **Эпизоды** выберите эпизод.
  1. В настройках эпизода в блоке **Доступ** отключите опцию **Разрешить доступ**.
  
  Эпизод станет недоступен по ссылкам.

- API {#api}

    Воспользуйтесь методом REST API [performAction](../../api-ref/Episode/performAction.md) для ресурса [Episode](../../api-ref/Episode/index.md) или вызовом gRPC API [EpisodeService/PerformAction](../../api-ref/grpc/Episode/performAction.md). Передайте `unpublish: {}` в теле запроса, чтобы запретить просмотр эпизода.

{% endlist %}

Если вы повторно разрешите доступ, эпизод вновь станет доступен по прежним ссылкам.