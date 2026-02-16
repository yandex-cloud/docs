---
title: Как назначить шаблон плеера по умолчанию в {{ video-full-name }}
description: Следуя данной инструкции, вы сможете выбрать шаблон плеера по умолчанию в сервисе {{ video-full-name }}.
---

# Назначить шаблон плеера по умолчанию

Шаблон по умолчанию применяется ко всем видео и плейлистам канала, для которых не переопределен индивидуальный шаблон. Предустановленный шаблон `Default Style Preset` добавляется при создании канала.

{% list tabs group=instructions %}

- Интерфейс {{ video-name }} {#console}

  1. Откройте [главную страницу]({{ link-video-main }}) {{ video-name }}.
  1. Выберите канал.
  1. На вкладке ![image](../../../_assets/console-icons/gear-play.svg) **{{ ui-key.yacloud_video.presets.title_presets }}** в строке с нужным шаблоном нажмите ![image](../../../_assets/console-icons/ellipsis.svg) и выберите **{{ ui-key.yacloud_video.presets.action_set-as-default }}**.
  
- API {#api}

  Воспользуйтесь методами REST API [create](../../api-ref/Channel/create.md) или [update](../../api-ref/Channel/update.md) для ресурса [Channel](../../api-ref/Channel/index.md), вызовом gRPC API [ChannelService/Create](../../api-ref/grpc/Channel/create.md) или [ChannelService/Update](../../api-ref/grpc/Channel/update.md). Настройки задаются с помощью параметра `default_style_preset_id`.

{% endlist %}

Шаблон по умолчанию нельзя удалить.

#### См. также {#see-also}

* [{#T}](create.md)
* [{#T}](update.md)
* [{#T}](delete.md)
* [{#T}](get.md)
* [{#T}](assign-to-video.md)