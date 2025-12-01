---
title: Как получить информацию о шаблоне плеера в {{ video-full-name }}
description: Следуя данной инструкции, вы сможете получить информацию о шаблоне плеера в сервисе {{ video-full-name }}.
---

# Получить информацию о шаблоне плеера

{% list tabs group=instructions %}

- Интерфейс {{ video-name }} {#console}

  1. Откройте [главную страницу]({{ link-video-main }}) {{ video-name }}.
  1. Выберите канал.
  1. Перейдите на вкладку ![image](../../../_assets/console-icons/gear-play.svg) **{{ ui-key.yacloud_video.presets.title_presets }}**.
  1. В списке шаблонов найдите нужный шаблон. Информация о шаблоне отображается в таблице, где:
     * `Имя` — название шаблона.
     * `Идентификатор` — уникальный идентификатор шаблона.
     * `Обновлено` — дата и время последнего изменения.
     * `Шаблон по умолчанию` — статус.
  1. Чтобы посмотреть подробную информацию, нажмите на нужный шаблон.

- API {#api}

  Чтобы получить список шаблонов плеера, воспользуйтесь методом REST API [list](../../api-ref/StylePreset/list.md) для ресурса [StylePreset](../../api-ref/StylePreset/index.md) или вызовом gRPC API [StylePresetService/List](../../api-ref/grpc/StylePreset/list.md).

  Чтобы получить информацию о шаблоне плеера, воспользуйтесь методом REST API [get](../../api-ref/StylePreset/get.md) для ресурса [StylePreset](../../api-ref/StylePreset/index.md) или вызовом gRPC API [StylePresetService/Get](../../api-ref/grpc/StylePreset/get.md).

{% endlist %}

#### См. также {#see-also}

* [{#T}](create.md)
* [{#T}](update.md)
* [{#T}](delete.md)
* [{#T}](set-default.md)