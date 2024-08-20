---
title: "Как добавить трансляцию в плейлист в {{ video-full-name }}"
description: "Следуя данной инструкции, вы сможете добавить трансляцию в плейлист в сервисе {{ video-name }}."
---

# Добавить завершенную трансляцию в плейлист

{% list tabs group=instructions %}

- Интерфейс {{ video-name }} {#console}

  1. Откройте [главную страницу]({{ link-video-main }}) {{ video-name }}.
  1. Выберите канал.
  1. На вкладке ![image](../../../_assets/console-icons/bars-play.svg) **Плейлисты** в строке с плейлистом, в который вы хотите добавить трансляцию, нажмите ![image](../../../_assets/console-icons/ellipsis.svg) и выберите **{{ ui-key.yacloud_video.common.action_edit }}**. 
  
     Если в списке нет нужного плейлиста, [создайте](../playlists/create.md) его.

  1. В блоке **Порядок воспроизведения** нажмите **Добавить видео**.
  1. В открывшемся окне перейдите на вкладку `Трансляции` и выберите нужные завершенные трансляции. Чтобы создать новую трансляцию, нажмите кнопку **Создать трансляцию**.
  1. Нажмите **{{ ui-key.yacloud_video.common.action_add }}**

{% endlist %}

#### См. также {#see-also}

* [Плейлисты в {{ video-name }}](../../concepts/playlists.md)
* [Трансляции в {{ video-name }}](../../concepts/streams.md)
* [{#T}](../playlists/get-link.md)