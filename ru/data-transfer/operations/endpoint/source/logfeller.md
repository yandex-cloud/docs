# Настройка эндпоинта-источника Logfeller

При [создании](../index.md#create) или [изменении](../index.md#update) эндпоинта задайте настройки доступа к Logfeller.

## Настройки {#settings}

{% list tabs %}

- Консоль управления

    * **Logbroker-топик** — топик, из которого будут поступать данные.
 
    * **YT delivery** — настройка [YT-поставки](https://logbroker.yandex-team.ru/docs/how_to/configuration#configuring-yt-delivery) для топика. Настройте YT-поставку для топика самостоятельно.

    * **Настройки операций YT для индексации**:

        * **Pool** — пул, в котором будут запускаться операции в YT для обработки данных лога.

        * **Specification** — [спецификации YT-операций в формате JSON](https://yt.yandex-team.ru/docs/description/mr/operations_options#obshie-opcii-dlya-vseh-tipov-operacij). Позволяет переопределять настройки.
    
    * **Настройки парсинга**:
  
        * **Правило разбиения** — правило разбиения данных на строки в чанке Logbroker. Выберите значение из списка.
  
        * **Парсер** — выберите тип парсера: **Внешний парсер** или **Встроенный парсер**.

            * **Внешний парсер** — задайте парсер из [конфига Logfeller](https://a.yandex-team.ru/arc/trunk/arcadia/logfeller/configs/parsers/parsers.auto.json).
            
            * **Встроенный парсер**:
          
                * **Базовые опции**:

                    * **Время события** — учитывается на этапе индексации для раскладки проанализированных данных в таблицы по времени. Выберите значение из списка.
                  
                    * **TimeZone-поле** — используется если часовой пояс в данных пишется отдельным полем и в формате `TZMode=PARSE`.

                    * **Формат значения поля со временем** — укажите время в секундах Unixtime или форматированною строку с указанием значения формата времени и временной зоны. 

                    * **Дополнительный формат времени** — альтернативный формат времени. Укажите время в секундах Unixtime или форматированною строку с указанием значения формата времени и временной зоны.

                    * **Включить хеширование столбца PUID** — выберите для активации хеширования столбца PUID.

                    * **Список прекомпьютеров** — [прекомпьютеры](https://a.yandex-team.ru/svn/trunk/arcadia/logfeller/lib/parsing/precompute/README.md#dostupnye-prekomptery) добавляют вычисляемые столбцы. Полный список доступных прекомпьютеров см. в [документации](https://a.yandex-team.ru/arc/trunk/arcadia/logfeller/configs/parsers/precomputers.json).

                * **Описание необработанного формата** — описание форматов JSON или TSKV до обработки:

                    * **JSON** — используйте для удаления извлеченных полей, добавления поля `_rest` для записи всех полей, не указанных в схеме, обработки целочисленных значений из строки и валидации строк UTF-8.

                    * **TSKV** — используйте опции для пропуска полей, не указанных в схеме и для запрета использования полей, не указанных в схеме.

                    * **Схема данных** — можно указать списком полей, в конфигурационном JSON-файле или использовать внешнюю схему, указав ее ID.

    * **Дополнительные ресурсы** — используйте для подключения специфических ресурсов, которые хранятся в Cypress, пользовательским парсером или прекомпьютером.

    * **Защищенные переменные окружения YT** — используйте, если в процесс парсинга нужно выставить защищенные переменные окружения: `key` - имя переменной, `value` - ID секрета в `vault-api.passport.yandex.net`.

{% endlist %}