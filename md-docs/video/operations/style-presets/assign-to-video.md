# Выбрать шаблон плеера

## Шаблон для видео

Чтобы для конкретного видео переопределить шаблон по умолчанию, назначенный на уровне канала:

{% list tabs group=instructions %}

- Интерфейс Cloud Video {#console}

  1. Откройте [главную страницу](https://video.yandex.cloud/) Cloud Video.
  1. Выберите канал.
  1. На вкладке ![image](../../../_assets/console-icons/circle-play.svg) **Видео** в строке с нужным видео нажмите ![image](../../../_assets/console-icons/ellipsis.svg) и выберите **Редактировать**.
  1. В списке **Шаблон плеера** выберите нужный шаблон из доступных в канале.
  1. Нажмите **Сохранить**.

- API {#api}

  Воспользуйтесь методом REST API [update](../../api-ref/Video/update.md) для ресурса [Video](../../api-ref/Video/index.md) или вызовом gRPC API [VideoService/Update](../../api-ref/grpc/Video/update.md), передав параметр `style_preset_id`.

{% endlist %}

## Шаблон для плейлиста

Чтобы для конкретного плейлиста переопределить шаблон по умолчанию, назначенный на уровне канала:

{% list tabs group=instructions %}

- Интерфейс Cloud Video {#console}

  1. Откройте [главную страницу](https://video.yandex.cloud/) Cloud Video.
  1. Выберите канал.
  1. На вкладке ![image](../../../_assets/console-icons/bars-play.svg) **Плейлисты** в строке с нужным плейлистом нажмите ![image](../../../_assets/console-icons/ellipsis.svg) и выберите **Редактировать**.
  1. В списке **Шаблон плеера** выберите нужный шаблон из доступных в канале.
  1. Нажмите **Сохранить**.

- API {#api}

  Воспользуйтесь методом REST API [update](../../api-ref/Playlist/update.md) для ресурса [Playlist](../../api-ref/Playlist/index.md) или вызовом gRPC API [PlaylistService/Update](../../api-ref/grpc/Playlist/update.md), передав параметр `style_preset_id`.

{% endlist %}

Для всех видео в плейлисте будет действовать единый шаблон, даже если для какого-то видео был назначен другой шаблон.

#### См. также {#see-also}

* [Изменить видео](../video/update.md)
* [Создать шаблон плеера](create.md)
* [Изменить или дублировать шаблон плеера](update.md)
* [Назначить шаблон плеера по умолчанию](set-default.md)