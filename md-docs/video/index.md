# Yandex Cloud Video

Yandex Cloud Video — комплексная платформа управления видеоконтентом. Воспользуйтесь полным набором инструментов для хранения, обработки и хостинга видео, а также запуска онлайн-трансляций. Трансляции и видео воспроизводятся в интегрированном видеоплеере.

# Yandex Cloud Video

## Начало работы

 - [Обзор](quickstart-overview.md)

 - [Хостинг видео](hosting.md)

 - [Видеотрансляция](streaming.md)

## Пошаговые инструкции

 - [Все инструкции](operations/index.md)

### Каналы

 - [Создать канал](operations/channels/create.md)

 - [Изменить канал](operations/channels/update.md)

 - [Удалить канал](operations/channels/delete.md)

 - [Настроить канал и рекламу](operations/channels/settings.md)

### Видео

 - [Загрузить видео](operations/video/upload.md)

 - [Изменить видео](operations/video/update.md)

 - [Добавить таймкоды](operations/video/add-timecodes.md)

 - [Добавить обложку](operations/video/add-thumbnail.md)

 - [Управлять субтитрами](operations/video/subtitles.md)

 - [Управлять нейропереводом](operations/video/translation.md)

 - [Управлять суммаризацией](operations/video/summarization.md)

 - [Скачать видео](operations/video/download.md)

 - [Опубликовать видео](operations/video/publish.md)

 - [Снять видео с публикации](operations/video/unpublish.md)

 - [Получить код вставки или ссылку](operations/video/get-link.md)

 - [Добавить видео в плейлист](operations/video/add-to-playlist.md)

 - [Получить статистику просмотров](operations/video/get-statistics.md)

 - [Удалить видео](operations/video/delete.md)

### Трансляции

 - [Создать трансляцию](operations/streams/create.md)

 - [Изменить трансляцию](operations/streams/update.md)

 - [Добавить обложку](operations/streams/add-thumbnail.md)

 - [Получить адрес сервера и ключ трансляции](operations/streams/get-key.md)

 - [Рекомендации по настройке OBS Studio](operations/streams/obs-config-help.md)

 - [Начать трансляцию](operations/streams/start.md)

 - [Получить код вставки или ссылку](operations/streams/get-link.md)

 - [Отозвать доступ к трансляции](operations/streams/revoke-access.md)

 - [Добавить завершенную трансляцию в плейлист](operations/streams/add-to-playlist.md)

 - [Удалить трансляцию](operations/streams/delete.md)

### Плейлисты

 - [Создать плейлист](operations/playlists/create.md)

 - [Изменить плейлист](operations/playlists/update.md)

 - [Получить код вставки или ссылку](operations/playlists/get-link.md)

 - [Удалить плейлист](operations/playlists/delete.md)

 - [Добавить участника](operations/add-member.md)

## Практические руководства

 - [Готовые решения по оформлению видео в IFrame](tutorials/video-iframe.md)

## Концепции

 - [Обзор](concepts/index.md)

 - [Видео](concepts/videos.md)

 - [Трансляции](concepts/streams.md)

 - [Плейлисты](concepts/playlists.md)

 - [Шаблоны плеера](concepts/presets.md)

 - [Квоты и лимиты](concepts/limits.md)

## Видеоплеер

 - [Обзор](concepts/player.md)

 - [Управление](operations/player-control.md)

### Шаблоны плеера

 - [Создать шаблон](operations/style-presets/create.md)

 - [Изменить или дублировать шаблон](operations/style-presets/update.md)

 - [Получить информацию о шаблоне](operations/style-presets/get.md)

 - [Назначить шаблон по умолчанию](operations/style-presets/set-default.md)

 - [Выбрать шаблон](operations/style-presets/assign-to-video.md)

 - [Удалить шаблон](operations/style-presets/delete.md)

### SDK

 - [Обзор](sdk/index.md)

#### IFrame

 - [Начало работы](sdk/iframe/index.md)

 - [Параметры инициализации плеера](sdk/iframe/initialization.md)

 - [Методы плеера](sdk/iframe/player-methods.md)

 - [События плеера](sdk/iframe/player-events.md)

#### iOS

 - [Начало работы](sdk/ios-sdk.md)

##### CloudVideoPlayer

 - [Environment](sdk/CloudVideoPlayerSDK/Environment.md)

 - [PictureInPictureController](sdk/CloudVideoPlayerSDK/PictureInPictureController.md)

 - [VideoSurface](sdk/CloudVideoPlayerSDK/VideoSurface.md)

 - [YaPlayer](sdk/CloudVideoPlayerSDK/YaPlayer.md)

###### Structs

 - [PlayerError](sdk/CloudVideoPlayerSDK/PlayerError.md)

 - [Configuration](sdk/CloudVideoPlayerSDK/Configuration.md)

 - [ClientUserId](sdk/CloudVideoPlayerSDK/ClientUserId.md)

 - [ContentIdEndpoint](sdk/CloudVideoPlayerSDK/ContentIdEndpoint.md)

 - [From](sdk/CloudVideoPlayerSDK/From.md)

 - [PlaybackConfig](sdk/CloudVideoPlayerSDK/PlaybackConfig.md)

 - [PlaybackSpeed](sdk/CloudVideoPlayerSDK/PlaybackSpeed.md)

 - [PlayerStatus](sdk/CloudVideoPlayerSDK/PlayerStatus.md)

 - [QuasiEndpoint](sdk/CloudVideoPlayerSDK/QuasiEndpoint.md)

 - [Time](sdk/CloudVideoPlayerSDK/Time.md)

 - [VideoType](sdk/CloudVideoPlayerSDK/VideoType.md)

##### CloudVideoPlayerUI

 - [VideoView](sdk/CloudVideoPlayerSDKUI/VideoView.md)

#### JavaScript

 - [Начало работы](sdk/javascript/index.md)

 - [Параметры инициализации плеера](sdk/javascript/initialization.md)

 - [Методы плеера](sdk/javascript/player-methods.md)

 - [Состояние плеера](sdk/javascript/player-state.md)

 - [События плеера](sdk/javascript/player-events.md)

##### Справочник API

 - [Modules](api-ref/javascript/modules.md)

###### Enumerations

 - [PlayerSdkEvents](api-ref/javascript/enums/PlayerSdkEvents.md)

 - [PlayerSdkStatus](api-ref/javascript/enums/PlayerSdkStatus.md)

###### Interfaces

 - [PlayerSdkApi](api-ref/javascript/interfaces/PlayerSdkApi.md)

 - [PlayerSdkEventHandlers](api-ref/javascript/interfaces/PlayerSdkEventHandlers.md)

 - [PlayerSdkInitConfig](api-ref/javascript/interfaces/PlayerSdkInitConfig.md)

 - [PlayerSdkSourceParams](api-ref/javascript/interfaces/PlayerSdkSourceParams.md)

 - [PlayerSdkState](api-ref/javascript/interfaces/PlayerSdkState.md)

 - [Защищенный контент](troubleshooting-drm.md)

 - [Политика автозапуска браузеров](autoplay-policy.md)

 - [Управление доступом](security/index.md)

 - [Правила тарификации](pricing.md)

## Справочник API

 - [Аутентификация в API](api-ref/authentication.md)

 - [Начало работы с API](api-ref/quickstart.md)

### gRPC (англ.)

 - [Overview](api-ref/grpc/index.md)

#### Channel

 - [Overview](api-ref/grpc/Channel/index.md)

 - [Get](api-ref/grpc/Channel/get.md)

 - [List](api-ref/grpc/Channel/list.md)

 - [Create](api-ref/grpc/Channel/create.md)

 - [Update](api-ref/grpc/Channel/update.md)

 - [Delete](api-ref/grpc/Channel/delete.md)

 - [BatchDelete](api-ref/grpc/Channel/batchDelete.md)

 - [ListAccessBindings](api-ref/grpc/Channel/listAccessBindings.md)

 - [SetAccessBindings](api-ref/grpc/Channel/setAccessBindings.md)

 - [UpdateAccessBindings](api-ref/grpc/Channel/updateAccessBindings.md)

#### Episode

 - [Overview](api-ref/grpc/Episode/index.md)

 - [Get](api-ref/grpc/Episode/get.md)

 - [List](api-ref/grpc/Episode/list.md)

 - [BatchGet](api-ref/grpc/Episode/batchGet.md)

 - [Create](api-ref/grpc/Episode/create.md)

 - [Update](api-ref/grpc/Episode/update.md)

 - [Delete](api-ref/grpc/Episode/delete.md)

 - [BatchDelete](api-ref/grpc/Episode/batchDelete.md)

 - [PerformAction](api-ref/grpc/Episode/performAction.md)

 - [GetPlayerURL](api-ref/grpc/Episode/getPlayerURL.md)

 - [GetManifests](api-ref/grpc/Episode/getManifests.md)

#### Operation

 - [Overview](api-ref/grpc/Operation/index.md)

 - [Get](api-ref/grpc/Operation/get.md)

 - [Cancel](api-ref/grpc/Operation/cancel.md)

#### Playlist

 - [Overview](api-ref/grpc/Playlist/index.md)

 - [Get](api-ref/grpc/Playlist/get.md)

 - [List](api-ref/grpc/Playlist/list.md)

 - [Create](api-ref/grpc/Playlist/create.md)

 - [Update](api-ref/grpc/Playlist/update.md)

 - [Delete](api-ref/grpc/Playlist/delete.md)

 - [BatchDelete](api-ref/grpc/Playlist/batchDelete.md)

 - [GetPlayerURL](api-ref/grpc/Playlist/getPlayerURL.md)

#### StreamLine

 - [Overview](api-ref/grpc/StreamLine/index.md)

 - [Get](api-ref/grpc/StreamLine/get.md)

 - [List](api-ref/grpc/StreamLine/list.md)

 - [BatchGet](api-ref/grpc/StreamLine/batchGet.md)

 - [Create](api-ref/grpc/StreamLine/create.md)

 - [Update](api-ref/grpc/StreamLine/update.md)

 - [Delete](api-ref/grpc/StreamLine/delete.md)

 - [BatchDelete](api-ref/grpc/StreamLine/batchDelete.md)

 - [PerformAction](api-ref/grpc/StreamLine/performAction.md)

 - [GetStreamKey](api-ref/grpc/StreamLine/getStreamKey.md)

 - [UpdateStreamKey](api-ref/grpc/StreamLine/updateStreamKey.md)

#### Stream

 - [Overview](api-ref/grpc/Stream/index.md)

 - [Get](api-ref/grpc/Stream/get.md)

 - [List](api-ref/grpc/Stream/list.md)

 - [BatchGet](api-ref/grpc/Stream/batchGet.md)

 - [Create](api-ref/grpc/Stream/create.md)

 - [Update](api-ref/grpc/Stream/update.md)

 - [Delete](api-ref/grpc/Stream/delete.md)

 - [BatchDelete](api-ref/grpc/Stream/batchDelete.md)

 - [PerformAction](api-ref/grpc/Stream/performAction.md)

#### StylePreset

 - [Overview](api-ref/grpc/StylePreset/index.md)

 - [Get](api-ref/grpc/StylePreset/get.md)

 - [List](api-ref/grpc/StylePreset/list.md)

 - [Create](api-ref/grpc/StylePreset/create.md)

 - [Update](api-ref/grpc/StylePreset/update.md)

 - [Delete](api-ref/grpc/StylePreset/delete.md)

#### Subtitle

 - [Overview](api-ref/grpc/Subtitle/index.md)

 - [Get](api-ref/grpc/Subtitle/get.md)

 - [List](api-ref/grpc/Subtitle/list.md)

 - [Create](api-ref/grpc/Subtitle/create.md)

 - [GenerateUploadURL](api-ref/grpc/Subtitle/generateUploadURL.md)

 - [Delete](api-ref/grpc/Subtitle/delete.md)

#### Thumbnail

 - [Overview](api-ref/grpc/Thumbnail/index.md)

 - [Get](api-ref/grpc/Thumbnail/get.md)

 - [List](api-ref/grpc/Thumbnail/list.md)

 - [Create](api-ref/grpc/Thumbnail/create.md)

 - [BatchGenerateDownloadURLs](api-ref/grpc/Thumbnail/batchGenerateDownloadURLs.md)

 - [GenerateUploadURL](api-ref/grpc/Thumbnail/generateUploadURL.md)

 - [Delete](api-ref/grpc/Thumbnail/delete.md)

#### Video

 - [Overview](api-ref/grpc/Video/index.md)

 - [Get](api-ref/grpc/Video/get.md)

 - [List](api-ref/grpc/Video/list.md)

 - [BatchGet](api-ref/grpc/Video/batchGet.md)

 - [Create](api-ref/grpc/Video/create.md)

 - [Update](api-ref/grpc/Video/update.md)

 - [Transcode](api-ref/grpc/Video/transcode.md)

 - [Delete](api-ref/grpc/Video/delete.md)

 - [BatchDelete](api-ref/grpc/Video/batchDelete.md)

 - [PerformAction](api-ref/grpc/Video/performAction.md)

 - [GetPlayerURL](api-ref/grpc/Video/getPlayerURL.md)

 - [BatchGetPlayerURLs](api-ref/grpc/Video/batchGetPlayerURLs.md)

 - [GetManifests](api-ref/grpc/Video/getManifests.md)

 - [GenerateDownloadURL](api-ref/grpc/Video/generateDownloadURL.md)

 - [GetScreenshots](api-ref/grpc/Video/getScreenshots.md)

 - [BatchGetScreenshots](api-ref/grpc/Video/batchGetScreenshots.md)

### REST (англ.)

 - [Overview](api-ref/index.md)

#### Channel

 - [Overview](api-ref/Channel/index.md)

 - [Get](api-ref/Channel/get.md)

 - [List](api-ref/Channel/list.md)

 - [Create](api-ref/Channel/create.md)

 - [Update](api-ref/Channel/update.md)

 - [Delete](api-ref/Channel/delete.md)

 - [BatchDelete](api-ref/Channel/batchDelete.md)

 - [ListAccessBindings](api-ref/Channel/listAccessBindings.md)

 - [SetAccessBindings](api-ref/Channel/setAccessBindings.md)

 - [UpdateAccessBindings](api-ref/Channel/updateAccessBindings.md)

#### Episode

 - [Overview](api-ref/Episode/index.md)

 - [Get](api-ref/Episode/get.md)

 - [List](api-ref/Episode/list.md)

 - [BatchGet](api-ref/Episode/batchGet.md)

 - [Create](api-ref/Episode/create.md)

 - [Update](api-ref/Episode/update.md)

 - [Delete](api-ref/Episode/delete.md)

 - [PerformAction](api-ref/Episode/performAction.md)

 - [GetPlayerURL](api-ref/Episode/getPlayerURL.md)

 - [GetManifests](api-ref/Episode/getManifests.md)

#### Operation

 - [Overview](api-ref/Operation/index.md)

 - [Get](api-ref/Operation/get.md)

 - [Cancel](api-ref/Operation/cancel.md)

#### Playlist

 - [Overview](api-ref/Playlist/index.md)

 - [Get](api-ref/Playlist/get.md)

 - [List](api-ref/Playlist/list.md)

 - [Create](api-ref/Playlist/create.md)

 - [Update](api-ref/Playlist/update.md)

 - [Delete](api-ref/Playlist/delete.md)

 - [BatchDelete](api-ref/Playlist/batchDelete.md)

 - [GetPlayerURL](api-ref/Playlist/getPlayerURL.md)

#### StreamLine

 - [Overview](api-ref/StreamLine/index.md)

 - [Get](api-ref/StreamLine/get.md)

 - [List](api-ref/StreamLine/list.md)

 - [BatchGet](api-ref/StreamLine/batchGet.md)

 - [Create](api-ref/StreamLine/create.md)

 - [Update](api-ref/StreamLine/update.md)

 - [Delete](api-ref/StreamLine/delete.md)

 - [BatchDelete](api-ref/StreamLine/batchDelete.md)

 - [PerformAction](api-ref/StreamLine/performAction.md)

 - [GetStreamKey](api-ref/StreamLine/getStreamKey.md)

 - [UpdateStreamKey](api-ref/StreamLine/updateStreamKey.md)

#### Stream

 - [Overview](api-ref/Stream/index.md)

 - [Get](api-ref/Stream/get.md)

 - [List](api-ref/Stream/list.md)

 - [BatchGet](api-ref/Stream/batchGet.md)

 - [Create](api-ref/Stream/create.md)

 - [Update](api-ref/Stream/update.md)

 - [Delete](api-ref/Stream/delete.md)

 - [BatchDelete](api-ref/Stream/batchDelete.md)

 - [PerformAction](api-ref/Stream/performAction.md)

#### StylePreset

 - [Overview](api-ref/StylePreset/index.md)

 - [Get](api-ref/StylePreset/get.md)

 - [List](api-ref/StylePreset/list.md)

 - [Create](api-ref/StylePreset/create.md)

 - [Update](api-ref/StylePreset/update.md)

 - [Delete](api-ref/StylePreset/delete.md)

#### Subtitle

 - [Overview](api-ref/Subtitle/index.md)

 - [Get](api-ref/Subtitle/get.md)

 - [List](api-ref/Subtitle/list.md)

 - [Create](api-ref/Subtitle/create.md)

 - [GenerateUploadURL](api-ref/Subtitle/generateUploadURL.md)

 - [Delete](api-ref/Subtitle/delete.md)

#### Thumbnail

 - [Overview](api-ref/Thumbnail/index.md)

 - [Get](api-ref/Thumbnail/get.md)

 - [List](api-ref/Thumbnail/list.md)

 - [Create](api-ref/Thumbnail/create.md)

 - [BatchGenerateDownloadURLs](api-ref/Thumbnail/batchGenerateDownloadURLs.md)

 - [GenerateUploadURL](api-ref/Thumbnail/generateUploadURL.md)

 - [Delete](api-ref/Thumbnail/delete.md)

#### Video

 - [Overview](api-ref/Video/index.md)

 - [Get](api-ref/Video/get.md)

 - [List](api-ref/Video/list.md)

 - [BatchGet](api-ref/Video/batchGet.md)

 - [Create](api-ref/Video/create.md)

 - [Update](api-ref/Video/update.md)

 - [Transcode](api-ref/Video/transcode.md)

 - [Delete](api-ref/Video/delete.md)

 - [BatchDelete](api-ref/Video/batchDelete.md)

 - [PerformAction](api-ref/Video/performAction.md)

 - [GetPlayerURL](api-ref/Video/getPlayerURL.md)

 - [BatchGetPlayerURLs](api-ref/Video/batchGetPlayerURLs.md)

 - [GetManifests](api-ref/Video/getManifests.md)

 - [GenerateDownloadURL](api-ref/Video/generateDownloadURL.md)

 - [GetScreenshots](api-ref/Video/getScreenshots.md)

 - [BatchGetScreenshots](api-ref/Video/batchGetScreenshots.md)

 - [Аудитные логи {{ at-name }}](at-ref.md)

 - [История изменений](release-notes.md)

## Решение проблем

 - [Обзор](troubleshooting/index.md)

 - [Видеоплеер](troubleshooting/player.md)

 - [Загрузка и обработка видео](troubleshooting/video-processing.md)