---
title: Начало работы с видеотрансляциями {{ video-full-name }}
description: Чтобы запустить видеотрансляцию {{ video-name }}, создайте линию и настройте OBS.
---

# Как начать работать с видеотрансляцией в {{ video-full-name }}

Чтобы провести [трансляцию](./concepts/index.md#streams) на [канале](./concepts/index.md#channels) сервиса:
1. [Подготовьте облако к работе](#before-you-begin).
1. [Создайте канал](#create-channel).
1. [Создайте трансляцию](#create-stream).
1. [Создайте эпизод](#create-episode).
1. [Настройте OBS Studio](#configure-obs).
1. [Запустите трансляцию](#start-stream).
1. [Проверьте доступность трансляции](#test).

{% include [link-to-api-quickstart](../_includes/video/link-to-api-quickstart.md) %}

## Подготовьте облако к работе {#before-you-begin}

{% include [before-you-begin](../_includes/video/before-you-begin-variants.md) %}

## Создайте канал {#create-channel}

{% include [create-channel](../_includes/video/create-channel.md) %}

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
      
   {% include [image-characteristic](../_includes/video/image-characteristic.md) %}

1. Нажмите кнопку **{{ ui-key.yacloud_video.common.action_accept }}**.
1. В открывшемся окне трансляции скопируйте следующие данные:
    * **{{ ui-key.yacloud_video.stream-lines.label_server-address }}**;
    * **{{ ui-key.yacloud_video.stream-lines.label_stream-key }}**.

Подробнее о трансляциях в разделе [{#T}](./concepts/streams.md#streams).

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

Подробнее в разделе [{#T}](operations/streams/obs-config-help.md).

## Запустите трансляцию {#start-stream}

1. Вернитесь на вкладку ![streams](../_assets/console-icons/antenna-signal.svg) **{{ ui-key.yacloud_video.streams.title_streams }}** сервиса {{ video-name }}.
1. Выберите трансляцию, созданную ранее.
1. Включите опцию **Принимать сигнал**.
1. В OBS Studio на панели справа снизу **Управление** нажмите **Начать трансляцию**.
1. Дождитесь начала трансляции.

{% include [streams-limits-notice](../_includes/video/streams-limits-notice.md) %}

## Проверьте доступность трансляции {#test}

1. В блоке **{{ ui-key.yacloud_video.streams.title_stream-episodes }}** выберите эпизод, [созданный ранее](#create-episode).
1. Выберите вкладку `link`.
1. Нажмите кнопку ![image](../_assets/console-icons/copy.svg) **{{ ui-key.yacloud_video.streams.action_copy-code }}**.
1. Откройте новую страницу браузера и вставьте в адресной строке полученную ссылку.
1. Нажмите кнопку воспроизведения, чтобы убедиться, что трансляция доступна.

#### Полезные ссылки {#see-also}

* [{#T}](hosting.md)
* [Обзор сервиса {{ video-full-name }}](./concepts/index.md)
* [Настроить показ рекламы](operations/channels/settings.md#ad-settings)
* [{#T}](troubleshooting/index.md)
