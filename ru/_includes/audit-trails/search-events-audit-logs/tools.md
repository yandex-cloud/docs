Трейл {{ at-name }} собирает аудитные логи и загружает их в один из доступных [объектов назначения](../../../audit-trails/concepts/trail.md#target). Способ поиска событий зависит от выбранного объекта.

## Бакет {{ objstorage-name }} {#tool-jq}

Каждый файл аудитного лога в бакете содержит JSON-массив событий. Для поиска событий в этих файлах используйте `jq` — утилиту для фильтрации данных в формате JSON.

[Смонтируйте бакет и установите jq](../../../audit-trails/tutorials/search-bucket.md#before-you-begin). Чтобы ограничить поиск периодом, передайте команде `find` путь к каталогу за нужный месяц или день. Затем [отфильтруйте события с помощью jq](../../../audit-trails/tutorials/search-bucket.md#search) по типу операции, ресурсу или пользователю.

## {{ monium-name }} {#tool-monium}

В {{ monium-logs-name }} аудитные логи поступают в [проект](*monium-folder-project) каталога с трейлом. Для поиска событий используйте интерфейс {{ monium-name }} и [язык запросов сервиса](../../../monium/logs/query.md).

[Откройте логи](../../../audit-trails/tutorials/search-cloud-logging.md#monium), выберите период и выполните [запрос для нужного сценария](../../../audit-trails/tutorials/search-events-audit-logs/examples.md).

Чтобы отслеживать количество отказов в доступе и изменений прав, используйте [дашборд](../../../monium/operations/dashboard/create.md) с [метриками по аудитным логам](../../../monium/logs/aggregates.md). Чтобы получать уведомления о назначении привилегированных ролей или превышении заданного числа отказов в доступе, [настройте алерты](../../../monium/operations/alert/create-alert.md) по этим метрикам.

## Поток {{ yds-name }} {#data-streams}


В [{{ yds-full-name }}](../../../data-streams/) одно сообщение может содержать несколько событий в [формате JSON Lines](../../../audit-trails/concepts/format.md#data-stream-message). Для поиска и анализа событий можно выбрать один из подходов.

* Поиск и фильтрация событий в своем приложении. Читать данные из потока можно через [API, совместимый с Amazon Kinesis Data Streams](../../../data-streams/kinesisapi/index.md), в том числе с помощью [AWS SDK](../../../data-streams/operations/aws-sdk/get-records.md). Для чтения из командной строки доступен [AWS CLI](../../../data-streams/operations/aws-cli/get-records.md).
* Передача событий в систему анализа. Например, можно [загружать аудитные логи в MaxPatrol SIEM](../../../audit-trails/tutorials/maxpatrol/index.md) и использовать ее средства поиска.

[*monium-folder-project]: {% include notitle [folder-project](../../../_popups/monium/folder-project.md) %}
