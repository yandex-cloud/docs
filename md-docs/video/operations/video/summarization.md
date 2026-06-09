# Управлять суммаризацией

Вы можете [добавлять](#enable) и [удалять](#disable) суммаризацию во время загрузки или изменения видео. Суммаризация позволяет автоматически создавать краткое содержание видео, которое передает его основные моменты и ключевую информацию. При включении к видео автоматически добавляются таймкоды. Вы можете скорректировать предложенные таймкоды или [добавить свои вручную](add-timecodes.md).

Внешним видом суммаризации можно управлять через [шаблоны](../style-presets/create.md).

{% note info %}

[Нейросетевые функции](../../concepts/videos.md#ai-capabilities), такие как автоматическая генерация субтитров, суммаризация и нейроперевод, уже включены в стоимость других услуг работы с видео и дополнительно не тарифицируются.

{% endnote %}

## Включить суммаризацию {#enable}

{% list tabs group=instructions %}

- Интерфейс {{ video-name }} {#console}

  1. Откройте [главную страницу]({{ link-video-main }}) {{ video-name }}.
  1. Выберите канал.
  1. На вкладке ![image](../../../_assets/console-icons/circle-play.svg) **{{ ui-key.yacloud_video.videos.title_videos }}** в строке с нужным видео нажмите значок ![image](../../../_assets/console-icons/ellipsis.svg) и выберите **{{ ui-key.yacloud_video.common.action_edit }}**.

      {% note info %}

      Суммаризация недоступна, если видео находится в статусе `{{ ui-key.yacloud_video.videos.status_processing }}` или длится более 4 часов.

      {% endnote %}

  1. Включите опцию **{{ ui-key.yacloud_video.videos.field_summarization }}**.
  1. Нажмите кнопку **{{ ui-key.yacloud_video.common.action_accept }}**.

{% endlist %}


## Выключить суммаризацию {#disable}

{% list tabs group=instructions %}

- Интерфейс {{ video-name }} {#console}

  1. Откройте [главную страницу]({{ link-video-main }}) {{ video-name }}.
  1. Выберите канал.
  1. На вкладке ![image](../../../_assets/console-icons/circle-play.svg) **{{ ui-key.yacloud_video.videos.title_videos }}** в строке с нужным видео нажмите значок ![image](../../../_assets/console-icons/ellipsis.svg) и выберите **{{ ui-key.yacloud_video.common.action_edit }}**.
  1. Выключите опцию **{{ ui-key.yacloud_video.videos.field_summarization }}**.
  1. Нажмите кнопку **{{ ui-key.yacloud_video.common.action_accept }}**.

{% endlist %}