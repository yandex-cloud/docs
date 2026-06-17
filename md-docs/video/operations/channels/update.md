# Изменить канал

{% list tabs group=instructions %}

- Интерфейс Cloud Video {#console}

  1. Откройте [главную страницу](https://video.yandex.cloud/) Cloud Video.
  1. В строке нужного канала нажмите значок ![image](../../../_assets/console-icons/ellipsis.svg) и выберите **Редактировать**.
  1. Измените имя и описание канала.
  1. Нажмите кнопку **Сохранить**.

- API {#api}

  Воспользуйтесь методом REST API [update](../../api-ref/Channel/update.md) для ресурса [Channel](../../api-ref/Channel/index.md) или вызовом gRPC API [ChannelService/Update](../../api-ref/grpc/Channel/update.md).

{% endlist %}

#### Полезные ссылки {#see-also}

[Загрузить видео](../video/upload.md)