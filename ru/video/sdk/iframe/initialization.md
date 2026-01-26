---
title: Параметры инициализации плеера {{ video-player-name }} в SDK для IFrame
description: На странице описаны параметры, которые можно использовать при инициализации видеоплеера {{ video-player-name }} в SDK для IFrame.
---

# Параметры инициализации плеера

При создании iframe с [видеоплеером](../../concepts/player.md) {{ video-player-name }} вы можете передать в URL исходные параметры для настройки воспроизведения и отображения плеера.

## Формат передачи параметров {#format}

Параметры передаются в URL iframe в виде query-параметров после символа `?`. Несколько параметров разделяются символом `&`:

```html
<iframe
    src="https://runtime.video.cloud.yandex.net/player/...?param1=value1&param2=value2"
></iframe>
```

## Параметры управления воспроизведением {#playback-controls}

#### autoplay {#autoplay}

Автоматически запускать видео при загрузке плеера.

Возможные значения:
* `0` — видео не запускается автоматически (значение по умолчанию).
* `1` — видео запускается автоматически.

Чтобы автозапуск видео корректно работал во всех браузерах, используйте параметр `autoplay=1` вместе с параметром `mute=1`.

Пример:

```html
<iframe src="https://runtime.video.cloud.yandex.net/player/...?autoplay=1&mute=1"></iframe>
```

#### mute {#mute}

Выключать звук при загрузке плеера.

Возможные значения:
* `false` — звук включен (значение по умолчанию).
* `true` или `1` — звук выключен.

Пример:

```html
<iframe src="https://runtime.video.cloud.yandex.net/player/...?mute=1"></iframe>
```

#### volume {#volume}

Громкость звука при загрузке плеера.

Может принимать значения от `0` (звук не слышен) до `1` (максимальная громкость) включительно, например `volume=0.5`.

Значение параметра игнорируется, если `mute=1`.

Пример:

```html
<iframe src="https://runtime.video.cloud.yandex.net/player/...?volume=0.7"></iframe>
```

#### t {#t}

Стартовое время (в секундах), с которого необходимо начинать воспроизведение.

Может принимать значения от `0` до длительности видео включительно, например `t=30` (начать воспроизведение с 30-й секунды).

Если параметр не указан, обычное видео начнется с начала, а прямая трансляция — с текущего момента.

Пример:

```html
<iframe src="https://runtime.video.cloud.yandex.net/player/...?t=30"></iframe>
```

#### loop {#loop}

Зацикливать воспроизведение видео.

Возможные значения:
* `false` — видео не зациклено (значение по умолчанию).
* `true` — видео зациклено.

Пример:

```html
<iframe src="https://runtime.video.cloud.yandex.net/player/...?loop=true"></iframe>
```

#### allow_muted {#allow-muted}

Автоматически запускать видео без звука при загрузке плеера.

Возможные значения:
* `false` — автовоспроизведение без звука запрещено.
* `true` — автовоспроизведение без звука разрешено.

Параметр `allow_muted` имеет приоритет перед `autoplay`. При использовании `allow_muted=false` автовоспроизведение произойдет только в случае, если оно возможно со звуком.

Пример:

```html
<iframe src="https://runtime.video.cloud.yandex.net/player/...?allow_muted=true"></iframe>
```

#### preload {#preload}

Предварительно загружать видео.

Возможные значения:
* `false` — видео предварительно не загружается (значение по умолчанию).
* `true` — видео предварительно загружается.

При `autoplay=1` параметр `preload` игнорируется.

Пример:

```html
<iframe src="https://runtime.video.cloud.yandex.net/player/...?preload=true"></iframe>
```

#### play_on_visible {#play-on-visible}

Останавливать воспроизведение видео при уходе из зоны видимости и начинать воспроизведение при нахождении в ней.

Параметр влияет на показ как видеоконтента, так и рекламных роликов. Он может принимать значения:

* `false` — видео воспроизводится при уходе из зоны видимости (значение по умолчанию).
* `true` — видео не воспроизводится при уходе из зоны видимости.
* доля видимости плеера, достаточная для воспроизведения; значение параметра указывается в виде десятичной дроби, разделитель — точка (`.`).

Значение по умолчанию — `false`. При значении `true` доля видимости равна `0.5`.

{% note info %}

При `play_on_visible=true` параметр `autoplay` игнорируется. Параметр работает только в браузерах, в которых можно определить точную видимость плеера.

{% endnote %}

Пример:

```html
<iframe src="https://runtime.video.cloud.yandex.net/player/...?play_on_visible=0.7"></iframe>
```

## Параметры отображения интерфейса {#ui-controls}

#### hidden {#hidden}

С помощью параметра можно скрыть элементы интерфейса плеера. По умолчанию отображаются все элементы.

Возможные значения:

* `*` — все элементы интерфейса.
* `*,!<элемент-исключение>` — все элементы интерфейса, кроме исключенного. Например, `*,!play` — скрыть все элементы интерфейса, кроме кнопки воспроизведения.
* `contextMenu` — контекстное меню.
* `fullscreen` — кнопка перевода в полноэкранный режим.
* `live` — кнопка **Вернуться в эфир**.
* `mobileSeekButtons` — кнопки перемотки в мобильном интерфейсе.
* `play` — элемент интерфейса, в котором отображаются кнопки **Воспроизвести**, **Пауза**, **Повторить**. Отключает воспроизведение или паузу при нажатии на плеер.
* `playbackRate` — скорость воспроизведения.
* `poster` — постер.
* `preloader` — индикатор загрузки.
* `settings` — кнопка настроек.
* `startScreen` — стартовый экран.
* `startScreenPlay` — кнопка воспроизведения на стартовом экране.
* `subtitlesToggle` — кнопка включения и выключения субтитров.
* `timeline` — временная шкала. Отключает перемотку с клавиатуры или при нажатии на сенсорный экран.
* `timelinePreview` — превью на временной шкале.
* `time` — текущее время воспроизведения.
* `title` — название видео.
* `sound` — кнопка отключения звука.
* `volumeSlider` — ползунок громкости.

Чтобы скрыть несколько элементов интерфейса, передайте строку со значениями через запятую, например `hidden=startScreenPlay,play`.

{% note info %}

Не рекомендуется использовать вместе `autoplay=0` и `hidden=*`, с такими параметрами видео нельзя запустить.

{% endnote %}

Пример:

```html
<iframe src="https://runtime.video.cloud.yandex.net/player/...?hidden=title,settings"></iframe>
```

#### lang {#lang}

Язык, на котором будет отображаться интерфейс плеера.

Возможные значения:

* `ru` — русский.
* `en` — английский.
* `be` — белорусский.
* `id` — индонезийский.
* `kk` — казахский.
* `tr` — турецкий.
* `tt` — татарский.
* `uk` — украинский.
* `uz` — узбекский.

Если параметр не указан или передано неподдерживаемое значение, язык интерфейса плеера будет определяться на основании данных пользователя.

Пример:

```html
<iframe src="https://runtime.video.cloud.yandex.net/player/...?lang=en"></iframe>
```

#### object_fit {#object-fit}

Масштабировать обложку по размеру экрана при загрузке видео.

Возможные значения:

* `contain` — сохранить исходные пропорции обложки, не обрезать.
* `cover` — заполнить все доступное пространство обложкой, допустимо изменять пропорции или обрезать (значение по умолчанию).

Пример:

```html
<iframe src="https://runtime.video.cloud.yandex.net/player/...?object_fit=contain"></iframe>
```

## Параметры стилизации {#styling}

#### background_color {#background-color}

Цвет фона плеера и виджетов.

Поддерживаются цвета в формате [HEX](https://developer.mozilla.org/en-US/docs/Web/CSS/hex-color) из трех и шести символов, а также стандартные для HTML [названия цветов](https://www.w3.org/wiki/CSS/Properties/color/keywords).

Пример:

```html
<iframe src="https://runtime.video.cloud.yandex.net/player/...?background_color=000000"></iframe>
```

#### player_color {#player-color}

Цвет элементов интерфейса плеера: индикатора загрузки, временной шкалы и кнопки воспроизведения на стартовом экране при `autoplay=0`.

Поддерживаются цвета в формате [HEX](https://developer.mozilla.org/en-US/docs/Web/CSS/hex-color) из трех и шести символов, а также стандартные для HTML [названия цветов](https://www.w3.org/wiki/CSS/Properties/color/keywords).

Пример:

```html
<iframe src="https://runtime.video.cloud.yandex.net/player/...?player_color=FF0000"></iframe>
```

#### widget_text_color_primary {#widget-text-color-primary}

Цвет основного текста виджетов.

Поддерживаются цвета в формате [HEX](https://developer.mozilla.org/en-US/docs/Web/CSS/hex-color) из трех и шести символов, а также стандартные для HTML [названия цветов](https://www.w3.org/wiki/CSS/Properties/color/keywords).

Пример:

```html
<iframe src="https://runtime.video.cloud.yandex.net/player/...?widget_text_color_primary=FFFFFF"></iframe>
```

#### widget_text_color_secondary {#widget-text-color-secondary}

Цвет вторичного текста виджетов.

Поддерживаются цвета в формате [HEX](https://developer.mozilla.org/en-US/docs/Web/CSS/hex-color) из трех и шести символов, а также стандартные для HTML [названия цветов](https://www.w3.org/wiki/CSS/Properties/color/keywords).

Пример:

```html
<iframe src="https://runtime.video.cloud.yandex.net/player/...?widget_text_color_secondary=CCCCCC"></iframe>
```

#### widget_accent_color {#widget-accent-color}

Акцентный цвет текста виджетов.

Поддерживаются цвета в формате [HEX](https://developer.mozilla.org/en-US/docs/Web/CSS/hex-color) из трех и шести символов, а также стандартные для HTML [названия цветов](https://www.w3.org/wiki/CSS/Properties/color/keywords).

Пример:

```html
<iframe src="https://runtime.video.cloud.yandex.net/player/...?widget_accent_color=00FF00"></iframe>
```

#### playlist_selected_item_background_color {#playlist-selected-item-background-color}

Цвет фона активного элемента плейлиста.

Поддерживаются цвета в формате [HEX](https://developer.mozilla.org/en-US/docs/Web/CSS/hex-color) из трех и шести символов, а также стандартные для HTML [названия цветов](https://www.w3.org/wiki/CSS/Properties/color/keywords).

Пример:

```html
<iframe src="https://runtime.video.cloud.yandex.net/player/...?playlist_selected_item_background_color=333333"></iframe>
```

#### widget_block_separator_color {#widget-block-separator-color}

Цвет разделителей блоков виджетов.

Поддерживаются цвета в формате [HEX](https://developer.mozilla.org/en-US/docs/Web/CSS/hex-color) из трех и шести символов, а также стандартные для HTML [названия цветов](https://www.w3.org/wiki/CSS/Properties/color/keywords).

Пример:

```html
<iframe src="https://runtime.video.cloud.yandex.net/player/...?widget_block_separator_color=444444"></iframe>
```

#### player_border_radius {#player-border-radius}

Скругление углов блока плеера.

Значение по умолчанию — `3`.

Пример:

```html
<iframe src="https://runtime.video.cloud.yandex.net/player/...?player_border_radius=10"></iframe>
```

#### playlist_item_border_radius {#playlist-item-border-radius}

Скругление углов элементов плейлиста.

Значение по умолчанию — `3`.

Пример:

```html
<iframe src="https://runtime.video.cloud.yandex.net/player/...?playlist_item_border_radius=5"></iframe>
```

#### widget_block_gap {#widget-block-gap}

Отступ плеера от блока плейлиста.

Значение по умолчанию — `0`.

Пример:

```html
<iframe src="https://runtime.video.cloud.yandex.net/player/...?widget_block_gap=20"></iframe>
```

#### playlist_item_gap {#playlist-item-gap}

Отступ между элементами плейлиста.

Значение по умолчанию — `10`.

Пример:

```html
<iframe src="https://runtime.video.cloud.yandex.net/player/...?playlist_item_gap=15"></iframe>
```

## Пример использования {#example}

Пример iframe с несколькими параметрами:

```html
<iframe
    width="640"
    height="360"
    frameborder="0"
    scrolling="no"
    allowfullscreen
    allow="autoplay; fullscreen; encrypted-media; accelerometer; gyroscope; picture-in-picture; clipboard-write; web-share; screen-wake-lock"
    src="https://runtime.video.cloud.yandex.net/player/...?autoplay=1&mute=1&t=10&lang=ru&player_color=FF0000"
></iframe>
```

#### См. также {#see-also}

* [{#T}](./index.md)
* [{#T}](./player-methods.md)
* [{#T}](./player-events.md)