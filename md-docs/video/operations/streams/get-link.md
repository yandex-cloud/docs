# Получить код вставки или ссылку на трансляцию

{% list tabs group=instructions %}

- Интерфейс Cloud Video {#console}

  1. Откройте [главную страницу](https://video.yandex.cloud/) Cloud Video.
  1. Выберите канал.
  1. На вкладке ![image](../../../_assets/console-icons/antenna-signal.svg) **Трансляции** выберите нужную трансляцию.
  1. В блоке **Эпизоды** выберите эпизод.

  1. Задайте необходимые параметры воспроизведения эпизода трансляции:

      1. `По умолчанию воспроизводить без звука`;
      1. `Запускать видео автоматически`;
      1. `Скрывать элементы управления в плеере`.

      С помощью [Cloud Video Player SDK для IFrame](../../sdk/iframe/index.md) вы можете задать дополнительные настройки управления видеоплеером и параметры воспроизведения видео на HTML-странице, такие как размер и зацикливание видео, уровень звука и др.

  1. Выберите нужный формат ссылки на трансляцию:

      * `html` — HTML-код для вставки трансляции в формате Iframe.
      * `link` — прямая ссылка на трансляцию.

  1. Нажмите кнопку ![copy](../../../_assets/console-icons/copy.svg) **Скопировать**.

- API {#api}

  Воспользуйтесь методом REST API [getPlayerURL](../../api-ref/Episode/getPlayerURL.md) для ресурса [Episode](../../api-ref/Episode/index.md) или вызовом gRPC API [EpisodeService/GetPlayerURL](../../api-ref/grpc/Episode/getPlayerURL.md).

{% endlist %}