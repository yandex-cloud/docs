# Как начать работать с хостингом видео в {{ video-full-name }}

Чтобы загрузить [видео](concepts/index.md#videos) на [канал](concepts/index.md#channels) сервиса:
1. [Подготовьте облако к работе](#before-you-begin).
1. [Создайте канал](#create-channel).
1. [Загрузите видео](#upload-video).
1. [Опубликуйте видео](#publish-video).
1. [Проверьте доступность видео](#test).

О том, как работать с сервисом с помощью API, см. на странице [{#T}](api-ref/quickstart.md).

## Подготовьте облако к работе {#before-you-begin}

Чтобы начать работать с {{ video-name }}:

{% list tabs group=cloud_user %}

- Новый пользователь {#new}

  1. [Войдите]({{ link-passport-login }}) в ваш аккаунт на Яндексе. Если у вас еще нет аккаунта, [создайте](https://yandex.ru/support/passport/authorization/registration.html) его.
  1. Откройте [главную страницу]({{ link-video-main }}) {{ video-name }}.
  1. На главной странице сервиса подтвердите, что ознакомились с [Условиями использования](https://yandex.ru/legal/cloud_termsofuse/?lang=ru) и принимаете их и нажмите кнопку **Войти**.
  1. Создайте [платежный аккаунт](../billing/operations/create-new-account.md).

- Уже использую {{ yandex-cloud }} {#already}

  1. [Войдите]({{ link-passport-login }}) в ваш аккаунт на Яндексе.
  1. Откройте [главную страницу]({{ link-video-main }}) {{ video-name }}.
  1. Выберите один из вариантов:

     * Если у вас уже есть организация, выберите ее в выпадающем меню и нажмите **{{ ui-key.yacloud_video.organization.action_open-cloud-video }}**.

       {% note info %}

       Для активации экземпляра {{ video-name }} нужна роль `admin` или `owner`. Подробнее про роли см. в разделе [{#T}](../organization/security/index.md).

       {% endnote %}

     * Если у вас есть облако, но нет организации, нажмите **Открыть Cloud Center**. В открывшемся окне введите название и описание организации и нажмите **Создать организацию и Cloud Video**. Подробнее о работе с организациями см. в разделе [Начало работы с организациями](../organization/quickstart.md).
   1. Убедитесь, что у вас есть _минимальная_ [роль](security/index.md#video-editor) `video.editor` в организации для работы с {{ video-name }}.

{% endlist %}

Если у вас возник технический вопрос по работе сервиса, обратитесь в [службу поддержки]({{ link-console-support }}) {{ yandex-cloud }}.

## Создайте канал {#create-channel}

1. Откройте [главную страницу]({{ link-video-main }}) {{ video-name }}.
1. Нажмите кнопку ![plus-sign](../_assets/console-icons/plus.svg) **{{ ui-key.yacloud_video.channels.action_create-channel }}**.
1. На странице создания канала введите:
    * **{{ ui-key.yacloud_video.channels.label_title }}**.
    * (Опционально) **{{ ui-key.yacloud_video.channels.label_description }}**.
1. Нажмите кнопку **{{ ui-key.yacloud_video.common.action_create }}**.

После создания канала вы окажетесь внутри этого канала во вкладке ![image](../_assets/console-icons/circle-play.svg) **{{ ui-key.yacloud_video.videos.title_videos }}**.

* Подробнее о каналах см. в разделе [{#T}](concepts/index.md#channels).
* Подробнее о том, как настроить показ рекламы, см. в разделе [{#T}](operations/channels/settings.md#ad-settings).

## Загрузите видео {#upload-video}

1. На вкладке ![video](../_assets/console-icons/circle-play.svg) **{{ ui-key.yacloud_video.videos.title_videos }}** нажмите кнопку **{{ ui-key.yacloud_video.videos.action_create-video }}**.
1. На странице загрузки нажмите кнопку **Выбрать файл** и выберите видео, которое вы хотите загрузить.

    Поддерживается загрузка видео в различных форматах, например: [MP4](https://ru.wikipedia.org/wiki/MPEG-4_Part_14), [AVI](https://ru.wikipedia.org/wiki/Audio_Video_Interleave), [MKV](https://ru.wikipedia.org/wiki/Matroska), [FLV](https://ru.wikipedia.org/wiki/Flash_Video), [MOV](https://en.wikipedia.org/wiki/QuickTime_File_Format), [WebM](https://ru.wikipedia.org/wiki/WebM) и других. Вы можете [загружать](operations/video/upload.md) видео как по одному файлу, так и по несколько файлов сразу.

    В сервисе действуют [ограничения](concepts/limits.md) на разрешение публикуемых видео.

1. Введите **{{ ui-key.yacloud_video.videos.label_title }}** видео. Название будет отображаться на всех ресурсах, где будет размещено видео.
1. (Опционально) В поле **{{ ui-key.yacloud_video.videos.label_description }}** укажите таймкоды к видео в формате:
   
    ```
    00:00:00 Название главы 1
    hh:mm:ss Название главы 2
     ...
    ```
    
    {% note info %}
    
    Таймкоды должны начинаться с `00:00` или `00:00:00`. Время от названия главы отделяется пробелом. Каждый таймкод начинается с новой строки.
    
    {% endnote %}

1. В списке **{{ ui-key.yacloud_video.videos.label_accessRights }}** выберите тип доступа к видео:

    * **{{ ui-key.yacloud_video.videos.label_access_rights-sign-url-access }}** — видео будет доступно по специальной ссылке.
          
        Видео по временной ссылке доступно не более 12 часов.

    * **{{ ui-key.yacloud_video.videos.label_access_rights-public }}** — видео будет доступно неограниченное время и всем, у кого есть ссылка на видео.

1. (Опционально) Чтобы добавить обложку для видео, в поле **{{ ui-key.yacloud_video.thumbnails.label_thumbnail }}** нажмите кнопку ![upload](../_assets/console-icons/cloud-arrow-up-in.svg) **Выберите файл** и выберите изображение для обложки.

    Поддерживаются обложки в следующих форматах: [JPG](https://ru.wikipedia.org/wiki/JPEG), [PNG](https://ru.wikipedia.org/wiki/PNG) и [GIF](https://ru.wikipedia.org/wiki/GIF).

1. В списке **{{ ui-key.yacloud_video.presets.label_style-preset }}** выберите [шаблон](concepts/presets.md) оформления плеера из доступных в канале или создайте новый.

     Если шаблон не выбран, к видео будут применен шаблон по умолчанию, который добавляется при создании канала.

1. (Опционально) Чтобы добавить [суммаризацию](concepts/videos.md#summarization), включите опцию **{{ ui-key.yacloud_video.videos.field_summarization }}**.
1. (Опционально) Включите опцию **{{ ui-key.yacloud_video.videos.field_enable-decode-errors-tolerance }}**, если ваш файл поврежден или возникли [ошибки обработки](troubleshooting/video-processing.md).
1. (Опционально) Чтобы добавить [субтитры](concepts/videos.md#subtitles) для видео, в поле **{{ ui-key.yacloud_video.videos.label_subtitles }}** нажмите кнопку **{{ ui-key.yacloud_video.common.action_add }}**:
   
   1. В открывшемся окне выберите язык субтитров.
   1. Нажмите кнопку **Выбрать файл** и выберите файл субтитров.
   1. Нажмите кнопку **{{ ui-key.yacloud_video.common.action_create }}**.
   
       Дождитесь загрузки файла.
1. (Опционально) Чтобы добавить [нейроперевод](concepts/videos.md#translation) для видео, в блоке **{{ ui-key.yacloud_video.videos.label_neuro-translation }}** нажмите кнопку **{{ ui-key.yacloud_video.common.action_add }}**:
   
   1. В открывшемся окне выберите язык видео.
   1. Выберите языки для перевода.
   1. Нажмите **{{ ui-key.yacloud_video.common.action_create }}**.
1. Нажмите кнопку **{{ ui-key.yacloud_video.common.action_accept }}**.

Подробнее о видео см. в разделе [{#T}](concepts/videos.md).

## Опубликуйте видео {#publish-video}

В открывшемся окне с параметрами видео дождитесь, пока видео полностью загрузится, обработается и перейдет в статус `{{ ui-key.yacloud_video.videos.status_ready }}`. Значение поля `{{ ui-key.yacloud_video.videos.label_visibility-status }}` изменится на `{{ ui-key.yacloud_video.videos.status_published }}`.

По умолчанию все видео после загрузки опубликовываются — переходят в состояние `{{ ui-key.yacloud_video.videos.status_published }}`.

Если вы хотите [снять видео с публикации](operations/video/unpublish.md), выключите опцию **{{ ui-key.yacloud_video.videos.label_allow-access }}**. Значение поля `{{ ui-key.yacloud_video.videos.label_visibility-status }}` изменится на `{{ ui-key.yacloud_video.videos.status_unpublished }}`, а видео станет недоступно по [ссылкам](operations/video/get-link.md).

## Проверьте доступность видео {#test}

1. На странице с параметрами видео, в блоке **{{ ui-key.yacloud_video.videos.title_past-code }}**, выберите вкладку `link`.
1. Нажмите кнопку ![copy](../_assets/console-icons/copy.svg) **{{ ui-key.yacloud_video.streams.action_copy-code }}**.

    С помощью [{{ video-player-name }} SDK для IFrame](sdk/iframe/index.md) вы можете задать дополнительные настройки управления видеоплеером и параметры воспроизведения видео на HTML-странице, такие как размер и зацикливание видео, уровень звука и др.

1. Откройте новую страницу браузера и вставьте в адресной строке полученную ссылку.
1. Нажмите кнопку воспроизведения.

### См. также {#see-also}

* [{#T}](streaming.md)
* [Обзор сервиса {{ video-full-name }}](concepts/index.md)
* [Загрузить видео](operations/video/upload.md)
* [Настроить шаблон плеера](operations/style-presets/update.md)
* [Настроить показ рекламы](operations/channels/settings.md#ad-settings)
* [{#T}](troubleshooting/index.md)