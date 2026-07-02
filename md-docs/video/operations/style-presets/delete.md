[Документация Yandex Cloud](../../../index.md) > [Yandex Cloud Video](../../index.md) > Видеоплеер > Шаблоны плеера > Удалить шаблон

# Удалить шаблон плеера

{% note warning %}

Шаблон по умолчанию удалить нельзя. Чтобы удалить его, сначала [выберите](set-default.md) шаблоном по умолчанию другой.

{% endnote %}

{% list tabs group=instructions %}

- Интерфейс Cloud Video {#console}

  1. Откройте [главную страницу](https://video.yandex.cloud/) Cloud Video.
  1. Выберите канал.
  1. На вкладке ![image](../../../_assets/console-icons/gear-play.svg) **Шаблоны плеера** в строке с нужным шаблоном нажмите ![image](../../../_assets/console-icons/ellipsis.svg) и выберите **Удалить**.
  
     Если шаблон используется в каком-либо видео или плейлисте, появится сообщение об этом. После удаления шаблона вместо него будет применен шаблон по умолчанию.
  
  1. Подтвердите удаление.

- API {#api}

  Воспользуйтесь методом REST API [delete](../../api-ref/StylePreset/delete.md) для ресурса [StylePreset](../../api-ref/StylePreset/index.md) или вызовом gRPC API [StylePresetService/Delete](../../api-ref/grpc/StylePreset/delete.md).

   Если шаблон используется в каком-либо видео или плейлисте, то вместо него будет применен шаблон по умолчанию.

{% endlist %}

#### Полезные ссылки {#see-also}

* [Создать шаблон плеера](create.md)
* [Изменить или дублировать шаблон плеера](update.md)
* [Получить информацию о шаблоне плеера](get.md)
* [Назначить шаблон плеера по умолчанию](set-default.md)