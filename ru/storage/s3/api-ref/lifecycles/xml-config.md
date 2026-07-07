# Конфигурация жизненных циклов объектов в бакете

{{ objstorage-name }} позволяет управлять [жизненными циклами объектов](../../../concepts/lifecycles.md) в бакете. Для загрузки конфигурации жизненных циклов в {{ objstorage-name }} необходимо сформировать XML-документ, описанный в этом разделе. При скачивании существующей конфигурации, вы получите документ такого же формата.

Общий вид конфигурации:

```xml
<LifecycleConfiguration>
    <Rule>
        <ID>Описание правила</ID>
        <Status>{Enabled|Disabled}</Status>
        <Filter>
            <And>
                <ObjectSizeGreaterThan>минимальный размер объекта</ObjectSizeGreaterThan>
                <ObjectSizeLessThan>максимальный размер объекта</ObjectSizeLessThan>
                <Prefix>префикс ключа</Prefix>
                <Tag>
                    <Key>ключ метки</Key>
                    <Value>значение метки</Value>
                </Tag>
                ...
            </And>
            <ObjectSizeGreaterThan>минимальный размер объекта</ObjectSizeGreaterThan>
            <ObjectSizeLessThan>максимальный размер объекта</ObjectSizeLessThan>
            <Prefix>префикс ключа</Prefix>
            <Tag>
                <Key>ключ метки</Key>
                <Value>значение метки</Value>
            </Tag>
        </Filter>

        <Transition>
            <StorageClass>Идентификатор класса хранилища</StorageClass>
            <!-- <Date> или <Days> -->
        </Transition>

        <Expiration>
            <!-- <Date> или <Days> -->
            <!-- <ExpiredObjectDeleteMarker> -->
        </Expiration>

        <NoncurrentVersionTransition>
            <StorageClass>Идентификатор класса хранилища</StorageClass>
            <NoncurrentDays>Перенос версий, которые старше указанного количества дней</NoncurrentDays>
        </NoncurrentVersionTransition>

        <NoncurrentVersionExpiration>
            <NoncurrentDays>Удаление версий, которые старше указанного количества дней</NoncurrentDays>
        </NoncurrentVersionExpiration>

        <AbortIncompleteMultipartUpload>
            <DaysAfterInitiation>Удаление загрузок, не завершенных за указанное количество дней</DaysAfterInitiation>
        </AbortIncompleteMultipartUpload>
        ...
    </Rule>
    <Rule>
      ...
    </Rule>
    ...
</LifecycleConfiguration>
```

Конфигурация может содержать до 1000 правил.

## Элементы {#elements}

#|
|| Элемент | Описание ||
|| `LifecycleConfiguration` | Корневой элемент XML-документа.
Может содержать до 1000 элементов `Rule`.
Путь: `LifecycleConfiguration`. ||
|| `Rule` | Описание правила.
Объекты, попадающие под действие правила, задаются элементом `Filter`. Действия над объектами определяются элементами `Transition` и `Expiration`. Действий каждого типа может быть несколько.
Путь: `LifecycleConfiguration\Rule`. ||
|| `ID` | Уникальный идентификатор правила.
Произвольный текст длиной до 255 символов, например «Удалить через 20 дней». Необязательный параметр, который можно использовать для поиска правила в конфигурации.
Если идентификатор не указан, то {{ objstorage-name }} генерирует его автоматически.
Путь: `LifecycleConfiguration\Rule\ID`. ||
|| `Status` | Статус правила.
Правило можно активировать, установив `<Status>Enabled</Status>`, или отключить, установив `<Status>Disabled</Status>`.
Путь: `LifecycleConfiguration\Rule\Status`. ||
|| `Filter` | Фильтр объектов.
Содержит не более одного элемента каждого типа: `And`, `Prefix`, `ObjectSizeGreaterThan`, `ObjectSizeLessThan`, `Tag`.
Если установить пустой фильтр `<Filter></Filter>`, то правило применяется ко всем объектам в бакете.
Путь: `LifecycleConfiguration\Rule\Filter`. ||
|| `ObjectSizeGreaterThan` | Минимальный размер объекта в байтах.
Под действие правила попадают объекты, размер которых больше указанного.
Фильтр может содержать только один минимальный размер объекта.
Путь: `LifecycleConfiguration\Rule\Filter\ObjectSizeGreaterThan`. ||
|| `ObjectSizeLessThan` | Максимальный размер объекта в байтах.
Под действие правила попадают объекты, размер которых меньше указанного.
Фильтр может содержать только один максимальный размер объекта.
Путь: `LifecycleConfiguration\Rule\Filter\ObjectSizeLessThan`. ||
|| `Prefix` | Префикс ключа.
Под действие правила попадают объекты с указанным префиксом ключа.
Примеры префиксов для ключа `some/long/object/key`: `some`, `some/`, `some/lo`.
Фильтр может содержать только один префикс.
Путь: `LifecycleConfiguration\Rule\Filter\Prefix`. ||
|| `Tag` | [Метка](../../../concepts/tags.md#object-tags) объекта
Под действие правила попадают объекты, которым присвоена указанная метка.
Фильтр может содержать только одну метку объекта.
Путь: `LifecycleConfiguration\Rule\Filter\Tag`. ||
|| `And` | Логический оператор **И** (`AND`) для фильтров.
Может содержать любое сочетание следующих элементов: `Prefix`, `ObjectSizeGreaterThan`, `ObjectSizeLessThan`, `Tag`.
Путь: `LifecycleConfiguration\Rule\Filter\And`. ||
|| `Key` | Ключ метки объекта
Путь: `LifecycleConfiguration\Rule\Filter\Tag\Key`. ||
|| `Value` | Значение метки объекта
Путь: `LifecycleConfiguration\Rule\Filter\Tag\Value`. ||
|| `Transition` | Правило для изменения [класса хранилища](../../../concepts/storage-class.md) объекта.
Содержит элемент `StorageClass`, который определяет целевой класс хранилища, а также элемент `Date` или `Days`, который определяет срок исполнения действия.
Переместить объекты можно из стандартного (`STANDARD`) в холодное (`COLD`) , ледяное (`ICE`) или умное (`INTELLIGENT_TIERING`) хранилище, а также из холодного в ледяное хранилище.
Для бакетов с включенным [версионированием](../../../operations/buckets/versioning.md) действие будет применяться к текущим версиям объектов.
Путь: `LifecycleConfiguration\Rule\Transition\`. ||
|| `StorageClass` | [Класс хранилища](../../../concepts/storage-class.md) объекта. Может быть `COLD`, `STANDARD`, `ICE` или `INTELLIGENT_TIERING`.
Путь: `LifecycleConfiguration\Rule\Transition\StorageClass`. ||
|| `Expiration` | Правило для удаления объекта из {{ objstorage-name }}.
Содержит элемент `Days` или `Date`, который определяет сроки исполнения действия.<br/>Дополнительно может содержать `ExpiredObjectDeleteMarker` — маркер удаления объекта с истекшим сроком действия, который указывает, удалит ли {{ objstorage-name }} маркер удаления при отсутствии неактивных версий.
Для бакетов со включенным версионированием действие будет применяться для текущих версий объектов.
Путь: `LifecycleConfiguration\Rule\Expiration`.||
|| `Date` | Дата исполнения правила.
Формат — [ISO 8601](https://ru.wikipedia.org/wiki/ISO_8601), например, `YYYY-MM-DD`. Время — всегда 00:00 UTC.
Путь: `LifecycleConfiguration\Rule\Expiration\Date`. ||
|| `Days` | Интервал исполнения правила.
Задается количеством дней после загрузки объекта.
Минимальное значение — 1.
Путь: `LifecycleConfiguration\Rule\Expiration\Days`. ||
|| `NoncurrentVersionTransition` | Правило для изменения [класса хранилища](../../../concepts/storage-class.md) неактивных версий объекта. Это правило применяется не ко всему объекту, а только к его неактивным версиям.
Содержит элемент `StorageClass`, который определяет целевой класс хранилища, а также элемент `NoncurrentDays`, который определяет срок исполнения действия.
Переместить объекты можно из стандартного (`STANDARD`) в холодное (`COLD`) , ледяное (`ICE`) или умное (`INTELLIGENT_TIERING`) хранилище, а также из холодного в ледяное хранилище.
Путь: `LifecycleConfiguration\Rule\NoncurrentVersionTransition`. ||
|| `NoncurrentVersionExpiration` | Правило для удаления неактивных версий объекта из {{ objstorage-name }}. Это правило применяется не ко всему объекту, а только к его неактивным версиям.
Содержит элемент `NoncurrentDays`, который определяет сроки исполнения действия.
Путь: `LifecycleConfiguration\Rule\NoncurrentVersionExpiration`.
 
{% note tip %}

Чтобы удалять [неактивные маркеры удаления](*noncurrent-delete-markers), используйте параметр правила жизненного цикла `NoncurrentDeleteMarkers`. Параметр поддерживается только инструментами [{{ yandex-cloud }} CLI](../../../operations/buckets/lifecycles.md#cli_1), [{{ yandex-cloud }} REST](../../../api-ref/Bucket/update.md#yandex.cloud.storage.v1.LifecycleRule.NoncurrentDeleteMarkers) и [{{ yandex-cloud }} gRPC](../../../api-ref/grpc/Bucket/update.md#yandex.cloud.storage.v1.LifecycleRule.NoncurrentDeleteMarkers).

{% endnote %}

||
|| `AbortIncompleteMultipartUpload` | Правило для удаления загрузок, не завершенных за указанное количество дней.
Содержит элемент `DaysAfterInitiation`, который определяет срок исполнения правила.
Путь: `LifecycleConfiguration\Rule\AbortIncompleteMultipartUpload\DaysAfterInitiation`. ||
|#


## Пример {#example}

Приведенное ниже правило для всех объектов, загруженных в бакет, задает:

- Перемещение в холодное хранилище через 30 дней после загрузки в {{ objstorage-name }}.
- Удаление из {{ objstorage-name }} через 365 дней после загрузки.
- Удаление из {{ objstorage-name }} незавершенных загрузок через 5 дней после начала загрузки.

```xml
<LifecycleConfiguration>
    <Rule>
        <ID>Переместить и потом удалить</ID>
        <Status>Enabled</Status>
        <Filter>
           <Prefix></Prefix>
        </Filter>
        <Transition>
            <StorageClass>COLD</StorageClass>
            <Days>30</Days>
        </Transition>
        <Expiration>
            <Days>365</Days>
        </Expiration>
        <AbortIncompleteMultipartUpload>
            <DaysAfterInitiation>5</DaysAfterInitiation>
        </AbortIncompleteMultipartUpload>
    </Rule>
</LifecycleConfiguration>
```

#### Связанные статьи {#related-articles}

* [{#T}](../../../concepts/lifecycles.md)

{% include [the-s3-api-see-also-include](../../../../_includes/storage/the-s3-api-see-also-include.md) %}

[*noncurrent-delete-markers]: {% include notitle [popups](../../../_includes_service/popups.md#noncurrent-delete-markers) %}
