# SDK видеоплеера для IFrame

Вы можете разместить [видеоплеер](./concepts/player.md) с контентом из {{ video-name }} на HTML-странице с помощью SDK видеоплеера для IFrame.

Добавьте в код страницы [iframe](https://en.wikipedia.org/wiki/HTML_element#Frames)-контейнер:

```html
<iframe
    frameborder="0"
    scrolling="no"
    allowfullscreen
    allow="autoplay; fullscreen; encrypted-media; accelerometer; gyroscope; picture-in-picture; clipboard-write; web-share; screen-wake-lock"
    src="https://runtime.video.cloud.yandex.net/player/...?autoplay=1&mute=1"
></iframe>
```

{% include [video-content-id-desc](../_includes/video/video-content-id-desc.md) %}

Код вставки содержит iframe-контейнер, в котором отображается плеер с указанным видео.

Вы также можете настроить [размер видео](#size) и [параметры запуска плеера](#parameters).

## Настроить размер видео {#size}

Чтобы указать размер видео, задайте в теге `iframe` параметры: `height` — высота и `width` — ширина. 

Пример:

```html
<iframe width="560" height="315" 
  frameborder="0"
    scrolling="no"
    allowfullscreen
    allow="autoplay; fullscreen; encrypted-media; accelerometer; gyroscope; picture-in-picture; clipboard-write; web-share; screen-wake-lock"
    src="https://runtime.video.cloud.yandex.net/player/..."
></iframe>
```

Чтобы подстроить видео под ширину контейнера, измените код вставки так:

```html
<div style="min-width: 100%">
  <div style="position: relative; padding-bottom: 56.25%; height: 0;">
    <iframe style="position: absolute; top: 0; left: 0; width: 100%; height: 100%;"
        frameborder="0"
        scrolling="no"
        allowfullscreen
        allow="autoplay; fullscreen; encrypted-media; accelerometer; gyroscope; picture-in-picture; clipboard-write; web-share; screen-wake-lock"
        src="https://runtime.video.cloud.yandex.net/player/...?autoplay=1&mute=true"
    ></iframe>
  </div>
</div>
```

## Настроить параметры запуска плеера {#parameters}

Вы можете настроить отображение плеера и воспроизведение видео с помощью специальных параметров. 

К URL кода вставки после символа `?` добавьте пары `параметр=значение`, разделяя их символом `&`:

```http
https://runtime.video.cloud.yandex.net/player/...?{param1=value1}&...&{paramN=valueN}
```

Список параметров и их значений приведен в таблице ниже. Если параметры не указаны, плеер загрузится с параметрами по умолчанию.

#|

|| **Параметр:** | **Описание:** ||
|| `allow_muted`  |
Автоматически запускать видео без звука при загрузке плеера:

* `false` — автовоспроизведение без звука запрещено.
* `true` — автовоспроизведение без звука разрешено.

Параметр `allow_muted` имеет приоритет перед `autoplay`. При использовании `allow_muted=false` автовоспроизведение произойдет только в случае, если оно возможно со звуком.
||
|| `autoplay` |
Автоматически запускать видео при загрузке плеера:

* `0` — видео не запускается автоматически.
* `1` — видео запускается автоматически.

Значение по умолчанию — `0`.

Чтобы автозапуск видео корректно работал во всех браузерах, используйте параметр `autoplay=1` вместе с параметром `mute=1`.
||
|| `t` |
Стартовое время (в секундах), с которого необходимо начинать воспроизведение.

Может принимать значения от `0` до длительности видео включительно, например `t=30` (начать воспроизведение с 30-й секунды).

Если параметр не указан, обычное видео начнется с начала, а прямая трансляция — с текущего момента.
||
|| `hidden` |
С помощью параметра можно скрыть элементы интерфейса плеера. По умолчанию отображаются все.

{% cut "Список элементов интерфейса" %}

* `*` — все элементы интерфейса.
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

{% endcut %}

Чтобы скрыть несколько элементов интерфейса, передайте строку со значениями через запятую, например `hidden=startScreenPlay,play`.
||
|| `lang` |
Язык, на котором будет отображаться интерфейс плеера.

{% cut "Список языков" %}

* `ru` — русский.
* `en` — английский.
* `be` — белорусский.
* `id` — индонезийский.
* `kk` — казахский.
* `tr` — турецкий.
* `tt` — татарский.
* `uk` — украинский.
* `uz` — узбекский.

{% endcut %}

Если параметр не указан или передано неподдерживаемое значение, язык интерфейса плеера будет определяться на основании данных пользователя.
||
|| `loop` |
Зацикливать воспроизведение видео:

* `false` — видео не зациклено.
* `true` — видео зациклено.

Значение по умолчанию — `false`. 
||
|| `mute` |
Выключать звук при загрузке плеера:

* `false` — звук включен.
* `true` — звук выключен.

Значение по умолчанию — `false`.
||
|| `object_fit` |
Масштабировать обложку по размеру экрана при загрузке видео:

* `contain` — сохранить исходные пропорции обложки, не обрезать.
* `cover` — заполнить все доступное пространство обложкой, допустимо изменять пропорции или обрезать.

Значение по умолчанию — `cover`.
||
||  `play_on_visible` |
Останавливать воспроизведение видео при уходе из зоны видимости и начинать воспроизведение при нахождении в ней. Параметр влияет на показ как видеоконтента, так и рекламных роликов. Он может принимать значения:

* `false` — видео воспроизводится при уходе из зоны видимости.
* `true` — видео не воспроизводится при уходе из зоны видимости.
* доля видимости плеера, достаточная для воспроизведения; значение параметра указывается в виде десятичной дроби, разделитель — точка (`.`).

Значение по умолчанию — `false`. При значении `true` доля видимости равна `0.5`.

{% note info %}

При `play_on_visible=true` параметр `autoplay` игнорируется. Параметр работает только в браузерах, в которых можно определить точную видимость плеера.

{% endnote %}
||
||  `preload` |
Предварительно загружать видео:

* `false` — видео предварительно не загружается.
* `true` — видео предварительно загружается.

Значение по умолчанию — `false`.

При `autoplay=1` параметр `preload` игнорируется.
||
||  `volume`  |
Громкость звука при загрузке плеера.

Может принимать значения от `0` до `1` включительно, например `volume=0.5`.

Значение параметра игнорируется, если `mute=1`.
||
|#

### Пример {#example}

В примере видео будет запущено автоматически, но без звука:

```html
<iframe
    frameborder="0"
    scrolling="no"
    allowfullscreen
    allow="autoplay; fullscreen; encrypted-media; accelerometer; gyroscope; picture-in-picture; clipboard-write; web-share; screen-wake-lock"
    src="https://runtime.video.cloud.yandex.net/player/video/vplvmyqsxi7dlwndvb4y?autoplay=1&mute=true"
></iframe>
```

<iframe
    frameborder="0"
    width="320"
    height="180"
    scrolling="no"
    allowfullscreen
    allow="autoplay; fullscreen; encrypted-media; accelerometer; gyroscope; picture-in-picture; clipboard-write; web-share; screen-wake-lock"
    src="https://runtime.video.cloud.yandex.net/player/video/vplvmyqsxi7dlwndvb4y?autoplay=1&mute=true"
></iframe>
