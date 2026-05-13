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

  Создайте запись о субтитрах методом REST API [Create](../../api-ref/Subtitle/create.md) для ресурса [Subtitle](../../api-ref/Subtitle/index.md) или вызовом gRPC API [SubtitleService.Create](../../api-ref/grpc/Subtitle/create.md).

  Загрузите файл субтитров по URL, полученному методом REST API [GenerateUploadURL](../../api-ref/Subtitle/generateUploadURL.md) для ресурса [Subtitle](../../api-ref/Subtitle/index.md) или вызовом gRPC API [SubtitleService.GenerateUploadURL](../../api-ref/grpc/Subtitle/generateUploadURL.md).

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

  Сгенерируйте новый URL и загрузите файл субтитров методом REST API [GenerateUploadURL](../../api-ref/Subtitle/generateUploadURL.md) для ресурса [Subtitle](../../api-ref/Subtitle/index.md) или вызовом gRPC API [SubtitleService.GenerateUploadURL](../../api-ref/grpc/Subtitle/generateUploadURL.md).

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

  Для удаления субтитров воспользуйтесь методом REST API [Delete](../../api-ref/Subtitle/delete.md) для ресурса [Subtitle](../../api-ref/Subtitle/index.md) или вызовом gRPC API [SubtitleService.Delete](../../api-ref/grpc/Subtitle/delete.md).

{% endlist %}