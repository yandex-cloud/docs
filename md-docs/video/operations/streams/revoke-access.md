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

  Воспользуйтесь методом REST API [performAction](../../api-ref/Episode/create.md) для ресурса [Episode](../../api-ref/Video/index.md) или вызовом gRPC API [Episode/PerformAction](../../api-ref/grpc/Episode/performAction.md).

{% endlist %}

Если вы повторно разрешите доступ, эпизод вновь станет доступен по прежним ссылкам.