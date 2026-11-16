[Документация Yandex Cloud](../../../index.md) > [Yandex Cloud Postbox](../../index.md) > [Справочник API](../index.md) > [REST](index.md) > Конфигурации > Метод PutConfigurationSetVdmOptions

# Метод PutConfigurationSetVdmOptions

Обновляет настройки сбора статистики для [конфигурации](../../concepts/glossary.md#configuration) в каталоге. Нужный каталог определяется по сервисному аккаунту, от имени которого выполняется запрос.

Из настроек VDM (Virtual Deliverability Manager) Amazon SES Yandex Cloud Postbox поддерживает только параметр `DashboardOptions.EngagementMetrics`.

## Запрос {#request}

```http
PUT /v2/email/configuration-sets/{ConfigurationSetName}/vdm-options HTTP/2
```

### Path-параметры {#path-parameters}

#|
|| **Параметр** | **Описание** ||
|| `ConfigurationSetName` | **Тип**: string.

Название конфигурации, которая будет изменена. ||
|#

### Заголовки запроса {#request-headers}

Используйте в запросе [общие заголовки](request-headers.md).

### Тело запроса {#request-body}

```json
{
  "VdmOptions": {
    "DashboardOptions": {
      "EngagementMetrics": "ENABLED|DISABLED"
    }
  }
}
```

#|
|| **Параметр** | **Описание** ||
|| `VdmOptions` | **Тип**: object.

Настройки сбора статистики. Содержит объект `DashboardOptions`.

Если объект `VdmOptions` или вложенный объект `DashboardOptions` не передан, метод возвращает `200 OK` и не изменяет настройки конфигурации. ||
|| `DashboardOptions` | **Тип**: object.

Объект, который содержит параметр `EngagementMetrics`. ||
|| `EngagementMetrics` | **Тип**: string.

Отслеживание [открытия писем](../../concepts/mail-opened.md) и [переходов по ссылкам](../../concepts/click-tracking.md) для сбора [метрик](../../concepts/statistics.md#metrics) `Открытия` и `Переходы`. Возможные значения: `ENABLED` — отслеживание включено, `DISABLED` — выключено.

Параметр соответствует опции **Статистика вовлечённости** в консоли управления. Уведомления в поток данных Data Streams при этом не отправляются. Чтобы получать уведомления об открытиях и переходах, создайте [подписку](../../concepts/glossary.md#subscription) с типами событий `OPEN` и `CLICK`. ||
|#

## Ответы {#responses}

### 200 OK {#200}

Ответ `200 OK` возвращается в случае успешного выполнения запроса.

### Ошибки {#errors}

Для всех ошибок тело ответа представлено в одинаковом формате:

```json
{
   "Code": "<название_ошибки>",
   "message": "<пояснение_к_ошибке>"
}
```

Название ошибки заимствуется из ее кода, например `BadRequestException`.

Возможные ошибки:

#|
|| **Код ошибки** | **Описание** ||
|| `400 BadRequestException` | В запросе неправильно указаны заголовки или параметры. ||
|| `404 NotFoundException` | Конфигурация не найдена. ||
|| `429 TooManyRequestsException` | При вызове запроса превышена [квота](../../concepts/limits.md#postbox-quotas). ||
|#