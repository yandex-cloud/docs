[Документация Yandex Cloud](../index.md) > [Yandex Object Storage](index.md) > Аудитные логи Audit Trails

# Справочник аудитных логов Yandex Audit Trails

В Audit Trails для Yandex Object Storage поддерживается отслеживание [событий уровня конфигурации](../audit-trails/concepts/format.md) (Control Plane) и [событий уровня сервисов](../audit-trails/concepts/format-data-plane.md) (Data Plane).

Общий вид значения поля `event_type` (_тип события_):

```text
yandex.cloud.audit.storage.<имя_события>
```

## Справочник событий уровня конфигурации {#control-plane-events}

Имя события | Описание
--- | ---
`BucketAccessBindingsUpdate` | Изменение механизма привязки доступа к бакету
`BucketAclUpdate` | Изменение ACL бакета
`BucketCorsUpdate` | Изменение конфигурации CORS бакета
`BucketCreate` | Создание бакета
`BucketDelete` | Удаление бакета
`BucketEncryptionUpdate` | Обновление настроек шифрования бакета
`BucketVersioningUpdate` | Обновление настроек версионирования бакета
`BucketHttpsUpdate` | Изменение HTTPS-конфигурации для бакета
`BucketLifecycleUpdate` | Изменение жизненного цикла объекта в бакете
`BucketLoggingUpdate` | Изменение механизма логирования действий с бакетом
`BucketObjectLockUpdate` | Изменение настроек блокировки версии объекта в бакете
`BucketPolicyUpdate` | Изменение политик доступа бакета
`BucketTagsUpdate` | Изменение тегов бакета
`BucketUpdate` | Изменение бакета
`BucketWebsiteUpdate` | Изменение конфигурации сайта

## Справочник событий уровня сервисов {#data-plane-events}

Имя события | Описание
--- | ---
`ObjectAclUpdate` | Изменение ACL объекта в бакете
`ObjectCreate` | Создание объекта в бакете
`ObjectDelete` | Удаление объекта из бакета
`ObjectGetByPresignURL` | Получение объекта из бакета по [подписанному URL](security/overview.md#pre-signed)
`ObjectTagsDelete` | Удаление тегов объекта в бакете
`ObjectTagsUpdate` | Изменение тегов объекта в бакете
`ObjectUpdate` | Изменение объекта в бакете
`PresignURLCreate` | Создание подписанной ссылки