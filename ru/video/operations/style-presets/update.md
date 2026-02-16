---
title: Как изменить или дублировать шаблон плеера в {{ video-full-name }}
description: Следуя данной инструкции, вы сможете изменить или дублировать шаблон плеера в сервисе {{ video-full-name }}.
---

# Изменить или дублировать шаблон плеера

## Изменить шаблон плеера {#update}

Вы можете изменить предустановленные шаблоны плеера `Default Style Preset` и `Summarization Style Preset` или [создать](create.md) свой.

{% list tabs group=instructions %}

- Интерфейс {{ video-name }} {#console}

  1. Откройте [главную страницу]({{ link-video-main }}) {{ video-name }}.
  1. Выберите канал.
  1. На вкладке ![image](../../../_assets/console-icons/gear-play.svg) **{{ ui-key.yacloud_video.presets.title_presets }}** выберите нужный шаблон.
  1. Измените название шаблона в поле **{{ ui-key.yacloud_video.presets.label_title }}**.
  1. В блоке **{{ ui-key.yacloud_video.presets.section_wigets-settings }}**:
     * Включите или выключите нужные виджеты.
     * Измените их расположение в интерфейсе плеера.
  1. В блоке **{{ ui-key.yacloud_video.presets.section_styles-settings }}**:
     * Измените цветовую схему.
     * Настройте размеры элементов.
     * Задайте другие визуальные параметры.
  1. (Опционально) Чтобы посмотреть, как будут выглядеть видео и плейлисты с выбранным шаблоном в отдельном окне, нажмите **{{ ui-key.yacloud_video.presets.button_open-preset-template-dialog }}**.
  1. Нажмите **{{ ui-key.yacloud_video.common.action_accept }}**.

- API {#api}

  Воспользуйтесь методом REST API [update](../../api-ref/StylePreset/update.md) для ресурса [StylePreset](../../api-ref/StylePreset/index.md) или вызовом gRPC API [StylePresetService/Update](../../api-ref/grpc/StylePreset/update.md).

{% endlist %}

## Дублировать шаблон плеера {#duplicate}

{% list tabs group=instructions %}

- Интерфейс {{ video-name }} {#console}

  1. Откройте [главную страницу]({{ link-video-main }}) {{ video-name }}.
  1. Выберите канал.
  1. На вкладке ![image](../../../_assets/console-icons/gear-play.svg) **{{ ui-key.yacloud_video.presets.title_presets }}** в строке с нужным шаблоном нажмите ![image](../../../_assets/console-icons/ellipsis.svg) и выберите **{{ ui-key.datalens.component.plugin-with-menu.view.button_duplicate }}**.
  1. В списке шаблонов появится дубликат. При необходимости измените настройки виджетов и стилей.
  
- API {#api}

  Для дублирования шаблона:
  
  1. Получите информацию о существующем шаблоне с помощью метода REST API [get](../../api-ref/StylePreset/get.md) для ресурса [StylePreset](../../api-ref/StylePreset/index.md) или вызова gRPC API [StylePresetService/Get](../../api-ref/grpc/StylePreset/get.md).
  1. Создайте новый шаблон с теми же параметрами, используя метод REST API [create](../../api-ref/StylePreset/create.md) для ресурса [StylePreset](../../api-ref/StylePreset/index.md) или вызов gRPC API [StylePresetService/Create](../../api-ref/grpc/StylePreset/create.md).

{% endlist %}

#### См. также {#see-also}

* [{#T}](create.md)
* [{#T}](delete.md)
* [{#T}](get.md)
* [{#T}](set-default.md)