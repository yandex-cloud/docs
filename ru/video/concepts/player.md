# Видеоплеер

[Трансляции](./streams.md) и [видео](./videos.md) в сервисе {{ video-name }} воспроизводятся с помощью интегрированного _видеоплеера_.

Для размещения видеоплеера на HTML-странице реализована поддержка [Cloud Video Player SDK для IFrame](../iframe-sdk.md). В будущем будут добавлены SDK для iOS, Android и JavaScript.

## Пример размещения видеоплеера на странице {#example}

<iframe
    frameborder="0"
    scrolling="no"
    allowfullscreen
    allow="autoplay; fullscreen; encrypted-media; accelerometer; gyroscope; picture-in-picture; clipboard-write; web-share"
    src="https://runtime.video.cloud.yandex.net/player/video/vplvmyqsxi7dlwndvb4y?autoplay=1&mute=true"
></iframe>

## См. также {#see-also}
* [{#T}](../operations/video/get-link.md)
* [{#T}](../operations/streams/get-link.md)
* [{#T}](../operations/player-control.md)