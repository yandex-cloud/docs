[Документация Yandex Cloud](../../../index.md) > [Yandex Cloud Video](../../index.md) > [Пошаговые инструкции](../index.md) > Видео > Опубликовать видео

# Опубликовать видео

Вы можете опубликовать видео и проверить его доступность.

## Опубликуйте видео {#publish-video}

{% list tabs group=instructions %}

- Интерфейс Cloud Video {#console}

  1. [Загрузите](upload.md) видео.
  1. Дождитесь, пока видео полностью загрузится, обработается и перейдет в статус `Ready`.

  По умолчанию все видео после загрузки опубликовываются — переходят в состояние `Published`.
  
  Если вы хотите [снять видео с публикации](unpublish.md), выключите опцию **Разрешить доступ**. Значение поля `Публичный доступ` изменится на `Unpublished`, а видео станет недоступно по [ссылкам](get-link.md).

- API {#api}

  Воспользуйтесь методом REST API [performAction](../../api-ref/Video/create.md) для ресурса [Video](../../api-ref/Video/index.md) или вызовом gRPC API [VideoService/PerformAction](../../api-ref/grpc/Video/performAction.md).

{% endlist %}

## Проверьте доступность видео {#test}

{% list tabs group=instructions %}

- Интерфейс Cloud Video {#console}

  1. Откройте [главную страницу](https://video.yandex.cloud/) Cloud Video.
  1. Выберите канал.
  1. На вкладке ![image](../../../_assets/console-icons/circle-play.svg) **Видео** выберите нужное видео.
  1. На открывшейся странице с параметрами видео в блоке **Код вставки** выберите вкладку `link`.
  1. Нажмите кнопку ![copy](../../../_assets/console-icons/copy.svg) **Скопировать**.
  1. Откройте новую страницу браузера и вставьте в адресной строке полученную ссылку.
  1. Нажмите кнопку воспроизведения.

- API {#api}

  Воспользуйтесь методом REST API [getPlayerURL](../../api-ref/Video/getPlayerURL.md) для ресурса [Video](../../api-ref/Video/index.md) или вызовом gRPC API [VideoService/GetPlayerURL](../../api-ref/grpc/Video/getPlayerURL.md).

{% endlist %}

#### Полезные ссылки {#see-also}

* [Получить код вставки или ссылку на видео](get-link.md)
* [Скачать видео](download.md)