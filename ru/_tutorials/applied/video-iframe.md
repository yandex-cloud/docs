# Готовые решения по оформлению видео в IFrame

Руководство содержит готовые примеры для оформления [видеоплеера](../../video/concepts/player.md) в зависимости от назначения видео. Выберите один из вариантов и при необходимости доработайте его под ваши задачи.

Чтобы воспользоваться примерами для оформления видео в IFrame:

1. Загрузите видео в [{{ video-full-name }}](../../video/hosting).
1. Сохраните ссылку на видео.
1. Добавьте в код вашей HTML-страницы [код вставки iframe](../../video/iframe-sdk.md).
1. Скопируйте код вставки iframe из примера, указав в нем ссылку на ваше видео.

Если требуется передать видео в виде URL — скопируйте из примера из поля `src` параметры видео после знака `?`.

Некоторые из параметров видеоплеера можно настроить в интерфейсе {{ video-name }}:

{% list tabs group=instructions %}

- Интерфейс {{ video-name }} {#console}

  1. Откройте [главную страницу]({{ link-video-main }}) {{ video-name }}.
  1. Выберите канал.
  1. На вкладке ![image](../../_assets/console-icons/circle-play.svg) **{{ ui-key.yacloud_video.videos.title_videos }}** выберите видео.
  1. Задайте [настройки видео](../../video/operations/video/update.md).
  1. В разделе **{{ ui-key.yacloud_video.videos.title_past-code }}** на вкладке **html** скопируйте код вставки iframe.
  1. Добавьте в код вашей HTML-страницы скопированный код вставки iframe.
  1. Чтобы передать видео в виде URL, на вкладке **link** скопируйте содержимое ссылки с настройками.

{% endlist %}

## Автоматически воспроизводить видео без звука {#mute}

{% note info %}

Автоматическое воспроизведение видео может быть ограничено политикой браузеров. Подробнее см. в [{#T}](../../video/autoplay-policy.md)

{% endnote %}

```html
<iframe
    frameborder="0"
    scrolling="no"
    allowfullscreen
    allow="autoplay; fullscreen; encrypted-media; accelerometer; gyroscope; picture-in-picture; clipboard-write; web-share; screen-wake-lock"
    src="<ссылка>?autoplay=1&mute=true">
</iframe>
```

Где:
* `<ссылка>` — ссылка на воспроизводимый контент, например `https://runtime.video.cloud.yandex.net/player/video/vplvmyqsxi7dlwndvb4y`.
* `autoplay=1` — автоматически запускает видео при загрузке плеера.
* `mute=true` — выключает звук.

{% cut "Пример" %}

<iframe
    frameborder="0"
    scrolling="no"
    allowfullscreen
    allow="autoplay; fullscreen; encrypted-media; accelerometer; gyroscope; picture-in-picture; clipboard-write; web-share; screen-wake-lock"
    src="https://runtime.video.cloud.yandex.net/player/video/vplvmyqsxi7dlwndvb4y?autoplay=1&mute=true">
</iframe>

{% endcut %}


## Автоматически воспроизводить зацикленное видео {#automatically-loop}

```html
<iframe
    frameborder="0"
    scrolling="no"
    allowfullscreen
    allow="autoplay; fullscreen; encrypted-media; gyroscope; picture-in-picture;"
    src="<ссылка>?autoplay=1&loop=true">
</iframe>
```

Где:
* `<ссылка>` — ссылка на воспроизводимый контент, например `https://runtime.video.cloud.yandex.net/player/video/vplvmyqsxi7dlwndvb4y`.
* `autoplay=1` — автоматически запускает видео при загрузке плеера.
* `loop=true` — зацикливает воспроизведение видео.

{% cut "Пример" %}

<iframe
    frameborder="0"
    scrolling="no"
    allowfullscreen
    allow="autoplay; fullscreen; encrypted-media; gyroscope; picture-in-picture;"
    src="https://runtime.video.cloud.yandex.net/player/video/vplvmyqsxi7dlwndvb4y?autoplay=1&loop=true">
</iframe>

{% endcut %}


## Автоматически воспроизводить видео со скрытыми элементами {#autoplay-hidden-elements}

```html
<iframe
    frameborder="0"
    scrolling="no"
    allowfullscreen
    allow="autoplay; fullscreen; encrypted-media; gyroscope; picture-in-picture;"
    src="<ссылка>?autoplay=1&hidden=*,!time,!sound">
</iframe>
```

Где:
* `<ссылка>` — ссылка на воспроизводимый контент, например `https://runtime.video.cloud.yandex.net/player/video/vplvmyqsxi7dlwndvb4y`.
* `autoplay=1` — автоматически запускает видео при загрузке плеера.
* `hidden=*,!time,!sound` — скрывает все элементы интерфейса плеера, кроме текущего времени и кнопки включения/отключения звука.

{% cut "Пример" %}

<iframe
    frameborder="0"
    scrolling="no"
    allowfullscreen
    allow="autoplay; fullscreen; encrypted-media; gyroscope; picture-in-picture;"
    src="https://runtime.video.cloud.yandex.net/player/video/vplvmyqsxi7dlwndvb4y?autoplay=1&hidden=*,!time,!sound"
</iframe>

{% endcut %}


## Запретить перемотку видео {#prohibit-rewinding}

```html
<iframe
    frameborder="0"
    scrolling="no"
    allowfullscreen
    allow="autoplay; fullscreen; encrypted-media; gyroscope; picture-in-picture;"
    src="<ссылка>?autoplay=1&hidden=timeline,mobileSeekButtons,timelinePreview">
</iframe>
```

Где:
* `<ссылка>` — ссылка на воспроизводимый контент, например `https://runtime.video.cloud.yandex.net/player/video/vplvmyqsxi7dlwndvb4y`.
* `autoplay=1` — автоматически запускает видео при загрузке плеера.
* `hidden=timeline,mobileSeekButtons,timelinePreview` — скрывает временную шкалу, превью на ней и кнопки перемотки в мобильном интерфейсе. 

{% note info %}

Из-за особенностей платформы iPhone в полноэкранном режиме перемотка будет доступна. Чтобы полностью запретить перемотку на iPhone, необходимо также скрыть кнопку полноэкранного режима (`fullscreen`) и запретить режим «Картинка в картинке» (PiP), убрав `picture-in-picture` из атрибута `allow`.

{% endnote %}

{% cut "Пример" %}

<iframe
    frameborder="0"
    scrolling="no"
    allowfullscreen
    allow="autoplay; fullscreen; encrypted-media; gyroscope; picture-in-picture;"
    src="https://runtime.video.cloud.yandex.net/player/video/vplvmyqsxi7dlwndvb4y?autoplay=1&hidden=timeline,mobileSeekButtons,timelinePreview">
</iframe>

{% endcut %}


## Настроить виджеты плеера {#widgets}

```html
<iframe
    width="560" height="315"
    frameborder="0"
    scrolling="no"
    allowfullscreen
    allow="autoplay; fullscreen; encrypted-media; gyroscope; picture-in-picture;"
    src="<ссылка>?player_color=yellow&autoplay=0&player_border_radius=10">
</iframe>
```

Где:
* `width` — ширина блока плеера.
* `height` — высота блока плеера.
* `<ссылка>` — ссылка на воспроизводимый контент, например `https://runtime.video.cloud.yandex.net/player/video/vplvmyqsxi7dlwndvb4y`.
* `player_color` — устанавливает цвет элементов интерфейса плеера.
* `player_border_radius` — скругляет углы блока плеера.

{% cut "Пример" %}

<iframe
    width="560" height="315"
    frameborder="0"
    scrolling="no"
    allowfullscreen
    allow="autoplay; fullscreen; encrypted-media; gyroscope; picture-in-picture;"
    src="https://runtime.video.cloud.yandex.net/player/video/vplvmyqsxi7dlwndvb4y?player_color=yellow&autoplay=0&player_border_radius=10">
</iframe>

{% endcut %}


## Оформить видео для карточки товара {#product_card}

Чтобы оформить видео для карточки товара, потребуется настроить автоматическое воспроизведение видео в зоне видимости, без звука и без элементов управления.

```html
<iframe
    frameborder="10"
    scrolling="no"
    allowfullscreen
    allow="autoplay; fullscreen; encrypted-media; gyroscope; picture-in-picture;"
    src="<ссылка>?loop=true&allow_muted=true&play_on_visible=true&hidden=*">
</iframe>
```

Где:
* `frameborder` — ширина рамки блока плеера.
* `<ссылка>` — ссылка на воспроизводимый контент, например `https://runtime.video.cloud.yandex.net/player/video/vplvmyqsxi7dlwndvb4y`.
* `loop=true` — зацикливает воспроизведение видео.
* `allow_muted=true` — автоматически запускает видео без звука.
* `play_on_visible=true` — видео воспроизводится только в зоне видимости.
* `hidden=*` — скрывает все элементы интерфейса плеера.

{% cut "Пример" %}

<iframe
    frameborder="10"
    scrolling="no"
    allowfullscreen
    allow="autoplay; fullscreen; encrypted-media; gyroscope; picture-in-picture;"
    src="https://runtime.video.cloud.yandex.net/player/video/vplvmyqsxi7dlwndvb4y?loop=true&allow_muted=true&play_on_visible=true&hidden=*">
</iframe>

{% endcut %}

## Рекомендовать к просмотру другие видео {#playlist_settings}

Чтобы после просмотра видео предложить пользователю другие видео по теме, воспользуйтесь [плейлистом](../../video/concepts/playlists.md):

1. Загрузите несколько видео в [{{ video-full-name }}](../../video/hosting).
1. [Создайте плейлист](../../video/operations/playlists/create.md) и добавьте в него загруженные видео.
1. Сохраните ссылку на плейлист.
1. Добавьте в код вашей HTML-страницы [код вставки iframe](../../video/iframe-sdk.md).
1. Скопируйте код вставки iframe из примера, указав в нем ссылку на ваш плейлист.

{% note info %}

Размеры блока плеера должны быть достаточными для отображения плейлиста.

{% endnote %}

```html
<iframe
    frameborder="0"
    width="300" height="400"
    scrolling="no"
    allow="autoplay; fullscreen; encrypted-media; gyroscope; picture-in-picture;"
    src="<ссылка_на_плейлист>?autoplay=0&mute=0&background_color=ffeaea&widget_text_color_primary=841327&playlist_selected_item_background_color=FF8EA2&player_border_radius=10&playlist_item_border_radius=5">
</iframe>
```

Где:
* `frameborder` — ширина рамки блока плеера.
* `width` — ширина блока плеера.
* `height` — высота блока плеера.
* `<ссылка_на_плейлист>` — ссылка на воспроизводимый плейлист, например `https://runtime.strm.yandex.ru/player/playlist/vplqibh5xiq5c45ij777`.
* `autoplay=0` — видео не запускается автоматически.
* `mute=0` — звук включен.
* Параметры стилизации:
  * `background_color=ffeaea` — цвет фона плеера и виджетов.
  * `widget_text_color_primary=841327` — цвет основного текста виджетов.
  * `playlist_selected_item_background_color=FF8EA2` — цвет фона активного элемента плейлиста.
  * `player_border_radius=10` — скругление углов блока плеера.
  * `playlist_item_border_radius=5` — скругление углов элементов плейлиста.

Подробнее о параметрах стилизации см. в разделе [{#T}](../../video/iframe-sdk.md#parameters).

{% cut "Пример" %}

<iframe
    frameborder="0"
    width="300" height="400"
    scrolling="no"
    allow="autoplay; fullscreen; encrypted-media; gyroscope; picture-in-picture;"
    src="https://runtime.strm.yandex.ru/player/playlist/vplqibh5xiq5c45ij777?autoplay=0&mute=0&background_color=ffeaea&widget_text_color_primary=841327&playlist_selected_item_background_color=FF8EA2&player_border_radius=10&playlist_item_border_radius=5">
</iframe>

{% endcut %}