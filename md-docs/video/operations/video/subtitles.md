# Управлять субтитрами

Вы можете [добавлять](#add) и [удалять](#delete) субтитры во время загрузки или изменения видео. После загрузки видео вы также сможете [скачать](#download) файлы [субтитров](../../concepts/videos.md#subtitles).

{% note info %}

[Нейросетевые функции](../../concepts/videos.md#ai-capabilities), такие как автоматическая генерация субтитров, суммаризация и нейроперевод, уже включены в стоимость других услуг работы с видео и дополнительно не тарифицируются.

{% endnote %}

## Добавить субтитры {#add}

{% list tabs group=instructions %}

- Интерфейс Cloud Video {#console}

  1. Откройте [главную страницу](https://video.yandex.cloud/) Cloud Video.
  1. Выберите канал.
  1. На вкладке ![image](../../../_assets/console-icons/circle-play.svg) **Видео** в строке с нужным видео нажмите ![image](../../../_assets/console-icons/ellipsis.svg) и выберите ![image](../../../_assets/console-icons/pencil-to-square.svg) **Редактировать**.
  1. В блоке **Субтитры** нажмите ![image](../../../_assets/console-icons/plus.svg) **Добавить**.
  1. Выберите способ добавления субтитров:

     * ![image](../../../_assets/console-icons/magic-wand.svg) **Сгенерировать** — чтобы автоматически сгенерировать субтитры на основе анализа видео. В открывшемся окне укажите исходный язык видео и языки, для которых нужно создать субтитры, и нажмите **Сгенерировать**.

     * ![image](../../../_assets/console-icons/arrow-up-from-line.svg) **Загрузить** — чтобы загрузить субтитры из файла. В открывшемся окне укажите язык субтитров, выберите файл с субтитрами и дождитесь его загрузки. Нажмите **Создать**.

        {% note info %}
        
        Максимальная длительность видео для генерации субтитров — 4 часа.
        
        {% endnote %}
     
  1. Нажмите **Сохранить**.

- API {#api}

  1. Создайте запись о субтитрах методом REST API [Create](../../api-ref/Subtitle/create.md) для ресурса [Subtitle](../../api-ref/Subtitle/index.md) или вызовом gRPC API [SubtitleService.Create](../../api-ref/grpc/Subtitle/create.md).

  1. Загрузите файл субтитров по URL, полученному методом REST API [GenerateUploadURL](../../api-ref/Subtitle/generateUploadURL.md) для ресурса [Subtitle](../../api-ref/Subtitle/index.md) или вызовом gRPC API [SubtitleService.GenerateUploadURL](../../api-ref/grpc/Subtitle/generateUploadURL.md).

  1. Чтобы субтитры появились в интерфейсе [Cloud Video](https://video.yandex.cloud/) и в [плеере](../../concepts/player.md), после загрузки файла субтитров запустите перекодировку видео. Воспользуйтесь методом REST API [Transcode](../../api-ref/Video/transcode.md) для ресурса [Video](../../api-ref/Video/index.md) или вызовом gRPC API [VideoService.Transcode](../../api-ref/grpc/Video/transcode.md) и передайте в запросе:
      
       * Идентификаторы субтитров в параметре `subtitleIds` для REST API или `subtitle_ids` для gRPC API.
       * Имя обновляемого поля `subtitleIds` в параметре `fieldMask` для REST API или `subtitle_ids` в параметре `field_mask` для gRPC API.

{% endlist %}


## Изменить субтитры {#update}

{% list tabs group=instructions %}

- Интерфейс Cloud Video {#console}

  1. Откройте [главную страницу](https://video.yandex.cloud/) Cloud Video.
  1. Выберите канал.
  1. На вкладке ![image](../../../_assets/console-icons/circle-play.svg) **Видео** в строке с нужным видео нажмите ![image](../../../_assets/console-icons/ellipsis.svg) и выберите ![image](../../../_assets/console-icons/pencil-to-square.svg) **Редактировать**.
  1. В блоке **Субтитры** выберите способ изменения:

     * Чтобы изменить субтитры, загруженные из файла, справа от названия нажмите ![image](../../../_assets/console-icons/ellipsis.svg) и выберите ![image](../../../_assets/console-icons/arrows-rotate-right.svg) **Загрузить заново**. В открывшемся окне укажите язык субтитров, выберите файл с субтитрами и дождитесь его загрузки. Нажмите **Создать**.

     * Чтобы изменить сгенерированные субтитры, нажмите ![image](../../../_assets/console-icons/plus.svg) **Добавить** и выберите ![image](../../../_assets/console-icons/magic-wand.svg) **Сгенерировать**. В открывшемся окне укажите языки, для которых нужно изменить субтитры, и нажмите **Сгенерировать**.

        {% note info %}
        
        Максимальная длительность видео для генерации субтитров — 4 часа.
        
        {% endnote %}

  1. Нажмите **Сохранить**.

- API {#api}

  1. Сгенерируйте новый URL и загрузите файл субтитров методом REST API [GenerateUploadURL](../../api-ref/Subtitle/generateUploadURL.md) для ресурса [Subtitle](../../api-ref/Subtitle/index.md) или вызовом gRPC API [SubtitleService.GenerateUploadURL](../../api-ref/grpc/Subtitle/generateUploadURL.md).

  1. Чтобы субтитры появились в интерфейсе [Cloud Video](https://video.yandex.cloud/) и в [плеере](../../concepts/player.md), после загрузки файла субтитров запустите перекодировку видео. Воспользуйтесь методом REST API [Transcode](../../api-ref/Video/transcode.md) для ресурса [Video](../../api-ref/Video/index.md) или вызовом gRPC API [VideoService.Transcode](../../api-ref/grpc/Video/transcode.md) и передайте в запросе:
      
       * Идентификаторы субтитров в параметре `subtitleIds` для REST API или `subtitle_ids` для gRPC API.
       * Имя обновляемого поля `subtitleIds` в параметре `fieldMask` для REST API или `subtitle_ids` в параметре `field_mask` для gRPC API.

{% endlist %}


## Скачать субтитры {#download}

{% list tabs group=instructions %}

- Интерфейс Cloud Video {#console}

  1. Откройте [главную страницу](https://video.yandex.cloud/) Cloud Video.
  1. Выберите канал.
  1. На вкладке ![video](../../../_assets/console-icons/circle-play.svg) **Видео** выберите видео.
  1. В блоке **Субтитры** нажмите ![image](../../../_assets/console-icons/arrow-down-to-line.svg) справа от названия файла субтитров, который нужно скачать.

{% endlist %}


## Удалить субтитры {#delete}

{% list tabs group=instructions %}

- Интерфейс Cloud Video {#console}

  1. Откройте [главную страницу](https://video.yandex.cloud/) Cloud Video.
  1. Выберите канал.
  1. На вкладке ![image](../../../_assets/console-icons/circle-play.svg) **Видео** в строке с нужным видео нажмите ![image](../../../_assets/console-icons/ellipsis.svg) и выберите ![image](../../../_assets/console-icons/pencil-to-square.svg) **Редактировать**.
  1. В блоке **Субтитры** справа от названия нужного файла субтитров нажмите ![image](../../../_assets/console-icons/ellipsis.svg) и выберите ![image](../../../_assets/console-icons/trash-bin.svg) **Удалить**.
  1. Нажмите **Сохранить**.

- API {#api}

  1. Для удаления субтитров воспользуйтесь методом REST API [Delete](../../api-ref/Subtitle/delete.md) для ресурса [Subtitle](../../api-ref/Subtitle/index.md) или вызовом gRPC API [SubtitleService.Delete](../../api-ref/grpc/Subtitle/delete.md).
  1. После удаления субтитров запустите перекодировку видео. Воспользуйтесь методом REST API [Transcode](../../api-ref/Video/transcode.md) для ресурса [Video](../../api-ref/Video/index.md) или вызовом gRPC API [VideoService.Transcode](../../api-ref/grpc/Video/transcode.md) и передайте в запросе:

     * Идентификаторы субтитров, которые должны остаться в видео, в параметре `subtitleIds` для REST API или `subtitle_ids` для gRPC API. Чтобы удалить все субтитры, передайте пустой массив.
     * Имя обновляемого поля `subtitleIds` в параметре `fieldMask` для REST API или `subtitle_ids` в параметре `field_mask` для gRPC API.

{% endlist %}