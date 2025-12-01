---
title: Как создать шаблон плеера в {{ video-full-name }}
description: Следуя данной инструкции, вы сможете создать шаблон плеера в сервисе {{ video-full-name }}.
---

# Создать шаблон плеера

{% list tabs group=instructions %}

- Интерфейс {{ video-name }} {#console}

  1. Откройте [главную страницу]({{ link-video-main }}) {{ video-name }}.
  1. Выберите канал.
  1. На вкладке ![image](../../../_assets/console-icons/gear-play.svg) **{{ ui-key.yacloud_video.presets.title_presets }}** нажмите **{{ ui-key.yacloud_video.presets.action_create-preset }}**.
  1. В поле **{{ ui-key.yacloud_video.presets.label_title }}** укажите название шаблона.
  1. В блоке **{{ ui-key.yacloud_video.presets.section_wigets-settings }}**:
     * Включите или выключите нужные виджеты.
     * Задайте их расположение в интерфейсе плеера.

  1. В блоке **{{ ui-key.yacloud_video.presets.section_styles-settings }}**:
     * Выберите цветовую схему.
     * Настройте размеры элементов.
     * Задайте другие визуальные параметры.
  1. (Опционально) Чтобы посмотреть, как будут выглядеть видео и плейлисты с выбранным шаблоном в отдельном окне, нажмите **{{ ui-key.yacloud_video.presets.button_open-preset-template-dialog }}**.
  1. Нажмите **{{ ui-key.yacloud_video.common.action_create }}**.

- API {#api}

  Воспользуйтесь методом REST API [create](../../api-ref/StylePreset/create.md) для ресурса [StylePreset](../../api-ref/StylePreset/index.md) или вызовом gRPC API [StylePresetService/Create](../../api-ref/grpc/StylePreset/create.md).

{% endlist %}

#### См. также {#see-also}

* [{#T}](update.md)
* [{#T}](delete.md)
* [{#T}](get.md)