# Устранение ошибки ERR.DS_API.SOURCE_CONFIG.TABLE_NOT_CONFIGURED в DataLens

## Описание проблемы {#issue-description}
После загрузки таблицы из Google Sheets или CSV-файла, в предпросмотре датасета отображается ошибка:
```
        "code": "ERR.DS_API.SOURCE_CONFIG.TABLE_NOT_CONFIGURED",
        "message": "Table is not ready yet",
        "level": "error"
```

## Решение {#issue-resolution}
Эта ошибка означает, что у датасета только что была изменена схема. Дождитесь пересоздания таблицы предпросмотра (ожидание может составить несколько минут).

## Если проблема осталась {#if-issue-still-persists}
Если вышеописанные действия не помогли решить проблему, [создайте запрос в техническую поддержку](https://console.cloud.yandex.ru/support?section=contact).
В запросе укажите следующую информацию:
1. Полный текст сообщения об ошибке с Request ID;
2. [HAR-файл](../../../support/create-har.md) с сохраненными результатами взаимодействия браузера и серверов DataLens.
