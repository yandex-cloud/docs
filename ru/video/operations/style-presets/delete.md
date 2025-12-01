---
title: Как удалить шаблон плеера в {{ video-full-name }}
description: Следуя данной инструкции, вы сможете удалить шаблон плеера в сервисе {{ video-full-name }}.
---

# Удалить шаблон плеера

{% note warning %}

Шаблон по умолчанию удалить нельзя. Чтобы удалить его, сначала [выберите](set-default.md) шаблоном по умолчанию другой.

{% endnote %}

{% list tabs group=instructions %}

- Интерфейс {{ video-name }} {#console}

  1. Откройте [главную страницу]({{ link-video-main }}) {{ video-name }}.
  1. Выберите канал.
  1. На вкладке ![image](../../../_assets/console-icons/gear-play.svg) **{{ ui-key.yacloud_video.presets.title_presets }}** в строке с нужным шаблоном нажмите ![image](../../../_assets/console-icons/ellipsis.svg) и выберите **{{ ui-key.yacloud_video.common.action_delete }}**.
  
     Если шаблон используется в каком-либо видео или плейлисте, появится сообщение об этом. После удаления шаблона вместо него будет применен шаблон по умолчанию.
  
  1. Подтвердите удаление.

- API {#api}

  Воспользуйтесь методом REST API [delete](../../api-ref/StylePreset/delete.md) для ресурса [StylePreset](../../api-ref/StylePreset/index.md) или вызовом gRPC API [StylePresetService/Delete](../../api-ref/grpc/StylePreset/delete.md).

   Если шаблон используется в каком-либо видео или плейлисте, то вместо него будет применен шаблон по умолчанию.

{% endlist %}

#### См. также {#see-also}

* [{#T}](create.md)
* [{#T}](update.md)
* [{#T}](get.md)
* [{#T}](set-default.md)