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
  
  1. В блоке **{{ ui-key.yacloud_video.presets.section_logo-settings }}**:
     1. Включите опцию **{{ ui-key.yacloud_video.presets.field_logo-enabled }}**, чтобы отображать ваш логотип поверх видео.
     1. Загрузите изображение с логотипом не более 2 МБ в формате JPG, PNG или GIF.
     1. Включите опцию **{{ ui-key.yacloud_video.presets.field_logo-show-with-controls }}**, чтобы логотип исчезал вместе с элементами управления плеера, когда пользователь не взаимодействует с видео.
     1. В поле **{{ ui-key.yacloud_video.presets.field_logo-redirect-on-click-url }}** добавьте URL, который будет открываться при нажатии на логотип.
  
  1. (Опционально) Чтобы посмотреть, как будут выглядеть видео и плейлисты с выбранным шаблоном в отдельном окне, нажмите **{{ ui-key.yacloud_video.presets.button_open-preset-template-dialog }}**.
  1. Нажмите **{{ ui-key.yacloud_video.common.action_create }}**.

- API {#api}

  Воспользуйтесь методом REST API [create](../../api-ref/StylePreset/create.md) для ресурса [StylePreset](../../api-ref/StylePreset/index.md) или вызовом gRPC API [StylePresetService/Create](../../api-ref/grpc/StylePreset/create.md).

{% endlist %}

#### См. также {#see-also}

* [{#T}](update.md)
* [{#T}](delete.md)
* [{#T}](get.md)