# Посмотреть статистику просмотров видео

{% list tabs group=instructions %}

- Интерфейс {{ video-name }} {#console}

  1. Откройте [главную страницу]({{ link-video-main }}) {{ video-name }}.
  1. Выберите канал.
  1. На вкладке ![image](../../../_assets/console-icons/circle-play.svg) **{{ ui-key.yacloud_video.videos.title_videos }}** выберите нужное [видео](../../concepts/videos.md).
  1. На открывшейся странице перейдите на вкладку **{{ ui-key.yacloud_video.common.statistics }}**.
  1. В поле **Временной промежуток** выберите интервал времени, за который требуется показать статистику.

      Временной промежуток можно задать:
      * Указав начальные и конечные даты и время.
      * На вкладке **Основное** выбрав `Последние 5 минут`, `Последние 30 минут`, `Последний час`, `Последние 3 часа`, `Последние 6 часов`, `Последние 12 часов` или `Последний день`.
      * На вкладке **Другое** выбрав `Сегодня`, `Вчера`, `Эта неделя`, `Этот месяц`, `Этот год`, `С начала дня` или `С начала недели`.

      После выбора временного промежутка статистика обновится автоматически.

  1. В поле **Количество просмотров за** выберите уровень дискретизации графика количества просмотров: `5 минут`, `1 час` или `1 день`.

  Подробное описание отображаемых статистических данных см. в разделе [{#T}](../../concepts/videos.md#video-statistics).

{% endlist %}
