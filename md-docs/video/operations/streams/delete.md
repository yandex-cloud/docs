[Документация Yandex Cloud](../../../index.md) > [Yandex Cloud Video](../../index.md) > [Пошаговые инструкции](../index.md) > Трансляции > Удалить трансляцию

# Удалить трансляцию

{% list tabs group=instructions %}

- Интерфейс Cloud Video {#console}

  1. Откройте [главную страницу](https://video.yandex.cloud/) Cloud Video.
  1. Выберите канал.
  1. На вкладке ![image](../../../_assets/console-icons/antenna-signal.svg) **Трансляции** в строке с нужной трансляцией нажмите значок ![image](../../../_assets/console-icons/ellipsis.svg) и выберите ![image](../../../_assets/console-icons/trash-bin.svg) **Удалить**.
  1. Нажмите кнопку **Удалить**.

- API {#api}

  Воспользуйтесь методом REST API [delete](../../api-ref/Stream/delete.md) для ресурса [Stream](../../api-ref/Stream/index.md) или вызовом gRPC API [StreamService/Delete](../../api-ref/grpc/Stream/delete.md).

{% endlist %}