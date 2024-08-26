---
editable: false
---

# Метод write

Записывает использование образа продукта. Для аутентификации используется сервисный аккаунт пользователя.

## HTTP-запрос {#https-request}

```http
POST https://marketplace.{{ api-host }}/marketplace/v1/metering/imageProductUsage/write
```

## Параметры запроса {#body_params}
 
```json 
{
  "validateOnly": true,
  "productId": "string",
  "usageRecords": [
    {
      "uuid": "string",
      "skuId": "string",
      "quantity": "string",
      "timestamp": "string"
    }
  ]
}
```

Поле | Описание
--- | ---
validateOnly | **boolean** (boolean)<br><p>Сообщение с параметром `validateOnly: true` проверяет, возможна ли отправка метрик использования.</p> 
productId | **string**<br><p>Обязательное поле. ID продукта Marketplace.</p> <p>Максимальная длина строки — 50 символов.</p> 
usageRecords[] | **object**<br><p>Обязательное поле. Список записей об использовании продукта (до 25 записей в запросе).</p> <p>Номера элементов списка должны быть в диапазоне от 1 до 25.</p> 
usageRecords[].<br>uuid | **string**<br><p>Обязательное поле. Уникальный идентификатор записи об использовании в формате UUID.</p> <p>Максимальная длина строки — 36 символов.</p> 
usageRecords[].<br>skuId | **string**<br><p>Обязательное поле. Marketplace SKU ID потребления, связанный с `UsageRecord.product_id`.</p> <p>Максимальная длина строки — 50 символов.</p> 
usageRecords[].<br>quantity | **string** (int64)<br><p>Количество потребленных SKU в юнитах потребления `sku.usage_unit` (например, байтах).</p> <p>Значение должно быть больше 0.</p> 
usageRecords[].<br>timestamp | **string** (date-time)<br><p>Обязательное поле. UTC Timestamp отчетного периода.</p> <p>Строка в текстовом формате <a href="https://www.ietf.org/rfc/rfc3339.txt">RFC3339</a>.</p> 
 
## Ответ {#responses}

**HTTP Code: 200 — OK**

```json 
{
  "accepted": [
    {
      "uuid": "string"
    }
  ],
  "rejected": [
    {
      "uuid": "string",
      "reason": "string"
    }
  ]
}
```

 
Поле | Описание
--- | ---
accepted[] | **object**<br><p>Список принятых записей о потреблении продукта.</p> 
accepted[].<br>uuid | **string**<br><p>Уникальный идентификатор записи о потреблении в формате UUID.</p> 
rejected[] | **object**<br><p>Список отклоненных записей о потреблении продукта с указанием причины.</p> 
rejected[].<br>uuid | **string**<br><p>Уникальный идентификатор записи о потреблении в формате UUID.</p> 
rejected[].<br>reason | **string**<br><p>Причина отклонения записи.</p> 