# Как начать работать с видеотрансляцией в {{ video-full-name }}

Чтобы провести [трансляцию](concepts/index.md#streams) на [канале](concepts/index.md#channels) сервиса:
1. [Подготовьте облако к работе](#before-you-begin).
1. [Создайте канал](#create-channel).
1. [Создайте трансляцию](#create-stream).
1. [Создайте эпизод](#create-episode).
1. [Настройте OBS Studio](#configure-obs).
1. [Запустите трансляцию](#start-stream).
1. [Проверьте доступность трансляции](#test).

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

## Создайте трансляцию {#create-stream}

1. На вкладке ![streams](../_assets/console-icons/antenna-signal.svg) **{{ ui-key.yacloud_video.streams.title_streams }}** нажмите кнопку **{{ ui-key.yacloud_video.streams.action_create-stream }}**.
1. Введите имя трансляции.
1. В поле **{{ ui-key.yacloud_video.stream-lines.label_input-stream-protocol }}** выберите `RTMP`.
1. В поле **{{ ui-key.yacloud_video.stream-lines.label_input-stream-type }}** выберите `Push`.
1. Активируйте опцию **{{ ui-key.yacloud_video.streams.label_auto-publish-streams }}**.
1. Нажмите кнопку **{{ ui-key.yacloud_video.common.action_create }}**.

## Создайте эпизод {#create-episode}

1. В блоке **{{ ui-key.yacloud_video.streams.title_stream-episodes }}** нажмите кнопку ![image](../_assets/console-icons/plus.svg) **{{ ui-key.yacloud_video.streams.action_add-stream-episode }}**.
1. В поле **{{ ui-key.yacloud_video.streams.label_episode-type }}** выберите режим **{{ ui-key.yacloud_video.streams.label_episode-type-live }}**.
1. Введите имя эпизода.
1. В списке **Доступ** выберите `Для всех пользователей`.
1. В поле **{{ ui-key.yacloud_video.thumbnails.label_thumbnail }}** нажмите кнопку ![upload](../_assets/console-icons/cloud-arrow-up-in.svg) **Выберите файл** и выберите изображение для обложки.
      
   Поддерживаются обложки в следующих форматах: [JPG](https://ru.wikipedia.org/wiki/JPEG), [PNG](https://ru.wikipedia.org/wiki/PNG) и [GIF](https://ru.wikipedia.org/wiki/GIF).

1. Нажмите кнопку **{{ ui-key.yacloud_video.common.action_accept }}**.
1. В открывшемся окне трансляции скопируйте следующие данные:
    * **{{ ui-key.yacloud_video.stream-lines.label_server-address }}**;
    * **{{ ui-key.yacloud_video.stream-lines.label_stream-key }}**.

Подробнее о трансляциях см. в разделе [{#T}](concepts/streams.md#streams).

## Настройте OBS Studio {#configure-obs}

1. Чтобы установить программу для записи видео и потокового вещания [Open Broadcaster Software](https://ru.wikipedia.org/wiki/Open_Broadcaster_Software) (OBS Studio или OBS):

    {% list tabs group=operating_system %}
    
    - Linux {#linux}
    
      Выполните команду:
    
      ```bash
      sudo add-apt-repository ppa:obsproject/obs-studio \
      sudo apt install obs-studio
      ```
    
    - Windows {#windows}
    
      [Скачайте](https://obsproject.com/ru/download) и установите OBS Studio с сайта проекта или воспользуйтесь пакетным менеджером [Chocolatey](https://chocolatey.org/install). В PowerShell выполните команду от имени администратора:
    
      ```powershell
      choco install obs-studio
      ```
    
    {% endlist %}

1. Настройте OBS Studio:

    1. На панели справа перейдите в раздел **Управление** → **Настройки** → **Трансляция**.
    1. В блоке **Назначение**:

       * В поле **Служба** выберите **Настраиваемый...**.
       * В поле **Сервер** укажите адрес сервера, [полученный](#create-episode) ранее.
       * В поле **Ключ потока** укажите ключ трансляции, полученный ранее.
    
    1. На панели слева в разделе **Вывод** → **Трансляция**:
    
       * В поле **Битрейт видео** установите значение в зависимости от разрешения экрана и скорости интернета. Измерить скорость интернета можно с помощью [Яндекс.Интернетометра](https://yandex.ru/internet). Битрейт трансляции не должен превышать значения **Исходящее соединение**.
       * В поле **Кодировщик видео** выберите формат кодирования видео.
    
    1. В блоке **Запись**:
    
       * В поле **Путь записи** укажите путь для сохранения вашей трансляции.
       * В поле **Формат записи** выберите формат видеофайла.
    
    1. Нажмите **ОК**.
    1. Чтобы добавить источник, на панели слева снизу **Источники** нажмите кнопку ![plus-sign](../_assets/console-icons/plus.svg).
    
       * В открывшемся списке выберите источник, например **Устройство захвата видео**.
       * В открывшемся окне задайте название источника и нажмите **ОК**.
       * Выберите устройство, с которого передавать видеопоток, например веб-камеру, и нажмите **ОК**.
    
    1. В центральной части окна можете настроить размер и положение транслируемого видеопотока.

Подробнее см. в разделе [{#T}](operations/streams/obs-config-help.md).

## Запустите трансляцию {#start-stream}

1. Вернитесь на вкладку ![streams](../_assets/console-icons/antenna-signal.svg) **{{ ui-key.yacloud_video.streams.title_streams }}** сервиса {{ video-name }}.
1. Выберите трансляцию, созданную ранее.
1. Включите опцию **Принимать сигнал**.
1. В OBS Studio на панели справа снизу **Управление** нажмите **Начать трансляцию**.
1. Дождитесь начала трансляции.

В сервисе действуют [ограничения](concepts/limits.md) на длительность и количество одновременных трансляций.

## Проверьте доступность трансляции {#test}

1. В блоке **{{ ui-key.yacloud_video.streams.title_stream-episodes }}** выберите эпизод, [созданный ранее](#create-episode).
1. Выберите вкладку `link`.
1. Нажмите кнопку ![image](../_assets/console-icons/copy.svg) **{{ ui-key.yacloud_video.streams.action_copy-code }}**.
1. Откройте новую страницу браузера и вставьте в адресной строке полученную ссылку.
1. Нажмите кнопку воспроизведения, чтобы убедиться, что трансляция доступна.

#### См. также {#see-also}

* [{#T}](hosting.md)
* [Обзор сервиса {{ video-full-name }}](concepts/index.md)
* [Настроить показ рекламы](operations/channels/settings.md#ad-settings)
* [{#T}](troubleshooting/index.md)