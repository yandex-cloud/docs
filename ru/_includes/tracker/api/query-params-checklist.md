{% cut "Параметры запроса" %}

**Дополнительные параметры**

Параметр | Описание | Тип данных
-------- | -------- | ----------
notify | Уведомлять пользователей, которые указаны в полях **Автор**, **Ответственный**, **Участники**, **Заказчики** и **Наблюдатели**. Значение по умолчанию — `true`. | Логический
notifyAuthor | Уведомлять автора изменений. Значение по умолчанию — `false`. | Логический
[fields](../../../tracker/concepts/entities/about-entities.md#query-params) | Дополнительные поля сущности, которые будут включены в ответ. | Строка
expand | Дополнительная информация, которая будет включена в ответ: <ul><li>`attachments` — вложенные файлы.</li></ul> | Строка

{% endcut %}
