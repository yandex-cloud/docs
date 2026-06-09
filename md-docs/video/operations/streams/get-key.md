# Получить адрес сервера и ключ трансляции

{% list tabs group=instructions %}

- Интерфейс Cloud Video {#console}

  1. Откройте [главную страницу](https://video.yandex.cloud/) Cloud Video.
  1. Выберите канал.
  1. На вкладке ![image](../../../_assets/console-icons/antenna-signal.svg) **Трансляции** выберите нужную трансляцию.
  1. В открывшемся окне с параметрами трансляции скопируйте значения следующих полей:

      * **Адрес сервера**;
      * **Ключ трансляции**.

- API {#api}

  Чтобы получить адрес сервера, воспользуйтесь методом REST API [get](../../api-ref/StreamLine/get.md) для ресурса [StreamLine](../../api-ref/StreamLine/index.md) или вызовом gRPC API [StreamLineService/Get](../../api-ref/grpc/StreamLine/get.md).

  Чтобы получить ключ трансляции, воспользуйтесь методом REST API [getStreamKey](../../api-ref/StreamLine/getStreamKey.md) для ресурса [StreamLine](../../api-ref/StreamLine/index.md) или вызовом gRPC API [StreamLineService/GetStreamKey](../../api-ref/grpc/StreamLine/getStreamKey.md).

{% endlist %}