# Получить информацию о шаблоне плеера

{% list tabs group=instructions %}

- Интерфейс Cloud Video {#console}

  1. Откройте [главную страницу](https://video.yandex.cloud/) Cloud Video.
  1. Выберите канал.
  1. Перейдите на вкладку ![image](../../../_assets/console-icons/gear-play.svg) **Шаблоны плеера**.
  1. В списке шаблонов найдите нужный шаблон. Информация о шаблоне отображается в таблице, где:
     * `Имя` — название шаблона.
     * `Идентификатор` — уникальный идентификатор шаблона.
     * `Обновлено` — дата и время последнего изменения.
     * `Шаблон по умолчанию` — статус.
  1. Чтобы посмотреть подробную информацию, нажмите на нужный шаблон.

- API {#api}

  Чтобы получить список шаблонов плеера, воспользуйтесь методом REST API [list](../../api-ref/StylePreset/list.md) для ресурса [StylePreset](../../api-ref/StylePreset/index.md) или вызовом gRPC API [StylePresetService/List](../../api-ref/grpc/StylePreset/list.md).

  Чтобы получить информацию о шаблоне плеера, воспользуйтесь методом REST API [get](../../api-ref/StylePreset/get.md) для ресурса [StylePreset](../../api-ref/StylePreset/index.md) или вызовом gRPC API [StylePresetService/Get](../../api-ref/grpc/StylePreset/get.md).

{% endlist %}

#### См. также {#see-also}

* [Создать шаблон плеера](create.md)
* [Изменить или дублировать шаблон плеера](update.md)
* [Удалить шаблон плеера](delete.md)
* [Назначить шаблон плеера по умолчанию](set-default.md)