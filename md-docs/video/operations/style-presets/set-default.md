# Назначить шаблон плеера по умолчанию

Шаблон по умолчанию применяется ко всем видео и плейлистам канала, для которых не переопределен индивидуальный шаблон. Предустановленный шаблон `Default Style Preset` добавляется при создании канала.

{% list tabs group=instructions %}

- Интерфейс Cloud Video {#console}

  1. Откройте [главную страницу](https://video.yandex.cloud/) Cloud Video.
  1. Выберите канал.
  1. На вкладке ![image](../../../_assets/console-icons/gear-play.svg) **Шаблоны плеера** в строке с нужным шаблоном нажмите ![image](../../../_assets/console-icons/ellipsis.svg) и выберите **Выбрать шаблоном по умолчанию**.
  
- API {#api}

  Воспользуйтесь методами REST API [create](../../api-ref/Channel/create.md) или [update](../../api-ref/Channel/update.md) для ресурса [Channel](../../api-ref/Channel/index.md), вызовом gRPC API [ChannelService/Create](../../api-ref/grpc/Channel/create.md) или [ChannelService/Update](../../api-ref/grpc/Channel/update.md). Настройки задаются с помощью параметра `default_style_preset_id`.

{% endlist %}

Шаблон по умолчанию нельзя удалить.

#### См. также {#see-also}

* [Создать шаблон плеера](create.md)
* [Изменить или дублировать шаблон плеера](update.md)
* [Удалить шаблон плеера](delete.md)
* [Получить информацию о шаблоне плеера](get.md)
* [Выбрать шаблон плеера](assign-to-video.md)