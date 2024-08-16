# В датасетах {{ metrika }} отображаются не все поля


## Описание проблемы {#issue-description}

В датасетах {{ metrika }} отображаются не все поля.

## Решение {#issue-resolution}

Посмотреть, какие именно поля выгружаются, можно на [демонстрационном дашборде Metrica Live](https://yandex.cloud/ru/marketplace/products/yandex/metrica-live-demo). После подключения демонстрационного дашборда в меню **{{ ui-key.datalens.component.aside-header.view.switch_datasets }}** появятся два новых датасета:

* `Метрика Визиты`, *** полей;
* `Метрика Просмотры`, *** полей.

## Если проблема осталась {#if-issue-still-persists}

Если среди этих полей нет тех, которые нужны для вашего сценария, то  для полноценной работы с данными рекомендуем делать экспорт данных из [Logs API {{ metrika }}](https://yandex.ru/dev/metrika/doc/api2/logs/intro.html) в [облачный {{ CH }}](../../../managed-clickhouse/) и подключать {{ datalens-name }} уже к этой базе данных.
