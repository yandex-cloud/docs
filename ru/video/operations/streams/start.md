---
title: Как начать трансляцию в {{ video-full-name }}
description: Следуя данной инструкции, вы сможете начать трансляцию {{ video-full-name }}.
---

# Начать трансляцию

Чтобы начать трансляцию:
1. [Получите адрес сервера и ключ трансляции](#get-key).
1. [Настройте программу для трансляции](#configure-soft).
1. [Запустите трансляцию](#start-stream).
1. [Проверьте доступность трансляции](#test).

## Получите адрес сервера и ключ трансляции {#get-key}

{% include [get-key](../../../_includes/video/get-key.md) %}

## Настройте программу для трансляции {#configure-soft}

Вам потребуется программа для записи видео и потокового вещания, например [Open Broadcaster Software (OBS)](https://obsproject.com).

В программе укажите {{ ui-key.yacloud_video.stream-lines.label_stream-key }} и {{ ui-key.yacloud_video.stream-lines.label_server-address }}, полученные ранее, и запустите трансляцию.

### Пример настройки OBS {#configure-obs}

1. На панели справа перейдите в раздел **Управление** → **Настройки** → **Трансляция**.
1. В блоке **Назначение**:

     * В поле **Служба** выберите **Настраиваемый...**.
     * В поле **Сервер** укажите адрес сервера, полученный ранее.
     * В поле **Ключ потока** укажите ключ трансляции, полученный ранее.
    
1. На панели слева в разделе **Вывод** → **Трансляция**:
    
     * В поле **Битрейт видео** установите значение в зависимости от разрешения экрана и скорости интернета. Измерить скорость интернета можно с помощью [Яндекс.Интернетометра](https://yandex.ru/internet). Битрейт трансляции не должен превышать значения **Исходящее соединение**.
     * В поле **Кодировщик видео** выберите формат кодирования видео.
    
1. В блоке **Запись**:
    
     * В поле **Путь записи** укажите путь для сохранения вашей трансляции.
     * В поле **Формат записи** выберите формат видеофайла.
    
1. Нажмите **ОК**.
1. Чтобы добавить источник, на панели слева снизу **Источники** нажмите кнопку ![plus-sign](../../../_assets/console-icons/plus.svg).
    
     * В открывшемся списке выберите источник, например **Устройство захвата видео**.
     * В открывшемся окне задайте название источника и нажмите **ОК**.
     * Выберите устройство, с которого передавать видеопоток, например веб-камеру, и нажмите **ОК**.
    
1. В центральной части окна можете настроить размер и положение транслируемого видеопотока.

Подробнее в разделе [{#T}](../../operations/streams/obs-config-help.md).

## Запустите трансляцию {#start-stream}

{% list tabs group=instructions %}

- Интерфейс {{ video-name }} {#console}

  1. Вернитесь на вкладку ![streams](../../../_assets/console-icons/antenna-signal.svg) **{{ ui-key.yacloud_video.streams.title_streams }}** сервиса {{ video-name }}.
  1. Выберите трансляцию, созданную ранее.
  1. Включите опцию **Принимать сигнал**.
  1. В OBS Studio на панели справа снизу **Управление** нажмите **Начать трансляцию**.
  1. В поле **{{ ui-key.yacloud_video.streams.label_start-broadcast }}** дождитесь, когда кнопка ![play](../../../_assets/console-icons/circle-play.svg) **{{ ui-key.yacloud_video.streams.label_start-broadcast }}** станет активной и нажмите на нее. Если значение поля `{{ ui-key.yacloud_video.streams.label_start-broadcast-auto }}`, дополнительных действий не требуется.
   
- API {#api}

  Воспользуйтесь методом REST API [performAction](../../api-ref/Stream/performAction.md) для ресурса [Stream](../../api-ref/Stream/index.md) или вызовом gRPC API [StreamService/PerformAction](../../api-ref/grpc/Stream/performAction.md).

{% endlist %}

{% include [streams-limits-notice](../../../_includes/video/streams-limits-notice.md) %}

## Проверьте доступность трансляции {#test}

{% list tabs group=instructions %}

- Интерфейс {{ video-name }} {#console}

  1. В блоке **{{ ui-key.yacloud_video.streams.title_stream-episodes }}** выберите эпизод трансляции со статусом `On air`.
  1. На странице эпизода выберите вкладку `link`.
  1. Нажмите кнопку ![image](../../../_assets/console-icons/copy.svg) **{{ ui-key.yacloud_video.streams.action_copy-code }}**.
  1. Откройте новую страницу браузера и вставьте в адресной строке полученную ссылку.
  1. Нажмите кнопку воспроизведения, чтобы убедиться, что трансляция доступна.

- API {#api}

  Воспользуйтесь методом REST API [getPlayerURL](../../api-ref/Episode/getPlayerURL.md) для ресурса [Episode](../../api-ref/Episode/index.md) или вызовом gRPC API [EpisodeService/GetPlayerURL](../../api-ref/grpc/Episode/getPlayerURL.md).

{% endlist %}