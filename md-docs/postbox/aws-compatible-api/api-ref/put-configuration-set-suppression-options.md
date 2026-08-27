[Документация Yandex Cloud](../../../index.md) > [Yandex Cloud Postbox](../../index.md) > [Справочник API](../index.md) > [REST](index.md) > Конфигурации > Метод PutConfigurationSetSuppressionOptions

# Метод PutConfigurationSetSuppressionOptions

Обновляет настройки [стоп-листа](../../concepts/suppression-list.md) для [конфигурации](../../concepts/glossary.md#configuration) в каталоге. Нужный каталог определяется по сервисному аккаунту, от имени которого выполняется запрос.

## Запрос {#request}

```http
PUT /v2/email/configuration-sets/{ConfigurationSetName}/suppression-options HTTP/2
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
   "SuppressedReasons": ["BOUNCE", "COMPLAINT"]
}
```

#|
|| **Параметр** | **Описание** ||
|| `SuppressedReasons` | **Тип**: array.

[Причины](../../concepts/suppression-list.md#reasons), по которым адрес из стоп-листа блокирует отправку письма. Допустимые значения элементов массива — `BOUNCE` и `COMPLAINT`.

Если массив содержит значение `COMPLAINT`, адреса автоматически добавляются в стоп-лист по жалобам получателей.

Если массив пустой, стоп-лист не блокирует отправку писем, а адреса не добавляются в него автоматически. ||
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
|| `403` | Недостаточно прав для выполнения запроса. ||
|| `404 NotFoundException` | Запрошенный ресурс не найден. ||
|| `429 TooManyRequestsException` | При вызове запроса превышена [квота](../../concepts/limits.md#postbox-quotas). ||
|#