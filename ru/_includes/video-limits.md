#### Квоты {#quotas}

#|
|| Вид ограничения | Значение ||
|| Максимальное количество [каналов](../video/concepts/index.md#channels) в одной [организации](../organization/quickstart.md)
`video.channels.count` | 25 ||
|| Общее количество [видео](../video/concepts/videos.md) во всех каналах
`video.videos.count` | 5000 ||
|| Количество [плейлистов](../video/concepts/playlists.md) во всех каналах
`video.playlists.count` | 500 ||
|| Количество одновременных процессов по транскодированию видео с нейросетевыми функциями: [суммаризация](../video/concepts/videos.md#summarization), [нейроперевод](../video/concepts/videos.md#stranslation) и [генерация субтитров](../video/concepts/videos.md#subtitles)
`video.transcodingsWithNeuroFeatures.rate` | 1 ||
|| Количество [линий](../video/concepts/streams.md#lines) потоковой передачи в одной организации
`video.streamLines.count` | 50 ||
|| Количество [трансляций](../video/concepts/streams.md) в одной организации
`video.streams.count` | 500 ||
|| Количество одновременных трансляций в одной организации
`video.parallelStreams.count` | 1 ||
|| Количество [эпизодов](../video/concepts/streams.md#episodes) во всех трансляциях
`video.episodes.count` | 500 ||
|#

#### Лимиты {#limits}

**Вид ограничения** | **Значение**
----- | -----
Максимальное разрешение видео и трансляций | [1080p](https://en.wikipedia.org/wiki/1080p)
Максимальная длительность трансляции | 24 часа
Максимальная длительность видео для включения суммаризации, нейроперевода и генерации субтитров | 4 часа