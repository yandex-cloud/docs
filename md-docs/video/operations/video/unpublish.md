# Снять видео с публикации

{% list tabs group=instructions %}

- Интерфейс Cloud Video {#console}

  1. Откройте [главную страницу](https://video.yandex.cloud/) Cloud Video.
  1. Выберите канал.
  1. На вкладке ![image](../../../_assets/console-icons/circle-play.svg) **Видео** выберите нужное видео.
  1. На открывшейся странице с параметрами видео в блоке **Доступ** выключите опцию **Разрешить доступ**.

      Видео перейдет в состояние `Unpublished` и станет недоступно по ссылкам.

- API {#api}

  Воспользуйтесь методом REST API [performAction](../../api-ref/Video/create.md) для ресурса [Video](../../api-ref/Video/index.md) или вызовом gRPC API [VideoService/PerformAction](../../api-ref/grpc/Video/performAction.md).

{% endlist %}

Если вы повторно [опубликуете](publish.md) видео, снятое ранее с публикации, оно вновь станет доступным по прежним ссылкам.