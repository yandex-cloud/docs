---
title: "Как управлять субтитрами в {{ video-full-name }}"
description: "Следуя данной инструкции, вы сможете управлять субтитрами в сервисе {{ video-full-name }}."
---

# Управлять субтитрами

Вы можете [добавлять](#add) и [удалять](#delete) субтитры во время загрузки или изменения видео. После загрузки видео вы также сможете [скачать](#download) файлы [субтитров](../../concepts/videos.md#subtitles).


## Добавить субтитры {#add}

{% list tabs group=instructions %}

- Интерфейс {{ video-name }} {#console}

  1. Откройте [главную страницу]({{ link-video-main }}) {{ video-name }}.
  1. Выберите канал.
  1. На вкладке ![image](../../../_assets/console-icons/circle-play.svg) **{{ ui-key.yacloud_video.videos.title_videos }}** в строке с нужным видео нажмите значок ![image](../../../_assets/console-icons/ellipsis.svg) и выберите **{{ ui-key.yacloud_video.common.action_edit }}**.
  1. В поле **{{ ui-key.yacloud_video.videos.label_subtitles }}** нажмите кнопку **{{ ui-key.yacloud_video.common.action_add }}**.
  1. В открывшемся окне выберите язык субтитров.
  1. Нажмите кнопку **Выбрать файл** и выберите файл субтитров.
  1. Нажмите кнопку **{{ ui-key.yacloud_video.common.action_create }}**.

     Дождитесь загрузки файла.

  1. Нажмите кнопку **{{ ui-key.yacloud_video.common.action_accept }}**.

{% endlist %}


## Изменить субтитры {#update}

{% list tabs group=instructions %}

- Интерфейс {{ video-name }} {#console}

  1. Откройте [главную страницу]({{ link-video-main }}) {{ video-name }}.
  1. Выберите канал.
  1. На вкладке ![image](../../../_assets/console-icons/circle-play.svg) **{{ ui-key.yacloud_video.videos.title_videos }}** в строке с нужным видео нажмите значок ![image](../../../_assets/console-icons/ellipsis.svg) и выберите **{{ ui-key.yacloud_video.common.action_edit }}**.
  1. Нажмите значок ![image](../../../_assets/console-icons/xmark.svg) справа от названия файла субтитров, который нужно заменить.
  1. В поле **{{ ui-key.yacloud_video.videos.label_subtitles }}** нажмите кнопку **{{ ui-key.yacloud_video.common.action_add }}**.
  1. В открывшемся окне выберите язык субтитров.
  1. Нажмите кнопку **Выбрать файл** и выберите файл субтитров.
  1. Нажмите кнопку **{{ ui-key.yacloud_video.common.action_create }}**.

     Дождитесь загрузки файла.

  1. Нажмите кнопку **{{ ui-key.yacloud_video.common.action_accept }}**.

{% endlist %}


## Скачать субтитры {#download}

{% list tabs group=instructions %}

- Интерфейс {{ video-name }} {#console}

  1. Откройте [главную страницу]({{ link-video-main }}) {{ video-name }}.
  1. Выберите канал.
  1. На вкладке ![video](../../../_assets/console-icons/circle-play.svg) **{{ ui-key.yacloud_video.videos.title_videos }}** выберите видео.
  1. В блоке **{{ ui-key.yacloud_video.videos.label_subtitles }}** нажмите значок ![image](../../../_assets/console-icons/arrow-down-to-line.svg) справа от названия файла субтитров, который нужно скачать.

{% endlist %}


## Удалить субтитры {#delete}

{% list tabs group=instructions %}

- Интерфейс {{ video-name }} {#console}

  1. Откройте [главную страницу]({{ link-video-main }}) {{ video-name }}.
  1. Выберите канал.
  1. На вкладке ![image](../../../_assets/console-icons/circle-play.svg) **{{ ui-key.yacloud_video.videos.title_videos }}** в строке с нужным видео нажмите значок ![image](../../../_assets/console-icons/ellipsis.svg) и выберите **{{ ui-key.yacloud_video.common.action_edit }}**.
  1. Нажмите значок ![image](../../../_assets/console-icons/xmark.svg) справа от названия файла субтитров, который нужно удалить.
  1. Нажмите кнопку **{{ ui-key.yacloud_video.common.action_accept }}**.

{% endlist %}