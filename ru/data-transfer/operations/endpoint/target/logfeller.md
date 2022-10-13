# Настройка эндпоинта-приемника Logfeller

При [создании](../index.md#create) или [изменении](../index.md#update) эндпоинта задайте настройки доступа к Logfeller.

## Настройки {#settings}

{% list tabs %}

- Консоль управления

    * **Имя лога** — готовые таблицы будут публиковаться в YT по пути `//logs/log_name`. Можно использовать `/` в имени лога, тогда будет создана иерархия директорий. Например, если задать имя лога `myservice/access-log`, тогда данные будут находиться в `//logs/myservice/access-log`.
 
    * **YT-кластер** — выберите YT-кластер для хранения таблиц.

    * **YT-аккаунт** — выберите YT-аккаунт для хранения таблиц. В этом аккаунте должны храниться только логи.

    * **Настройки операций YT для индексации**:

        * **Pool** — пул, в котором будут запускаться операции в YT для обработки данных лога.

        * **Specification** — [спецификации YT операций в формате JSON](https://yt.yandex-team.ru/docs/description/mr/operations_options#obshie-opcii-dlya-vseh-tipov-operacij). Позволяет переопределять настройки.
    
    * **Суточные таблицы**, **Часовые таблицы**, **Получасовые таблицы**, **Ультрафаст таблицы**: — таблицы логов, для определенных интервалов времени.
  
        * **Время жизни таблиц** — определяет срок хранения логов в таблице. Для задания временного интервала укажите значение и литеру времени, например, `12h`, `7d`, `365d`.
  
        * **Отложенная сборка** — настраивает задержку сборки таблиц. Это может быть полезно, если необработанные данные загружаются в Logbroker с постоянным отставанием. Для задания временного интервала укажите значение и литеру времени, например, `12h`, `7d`, `365d`.

        * **Опции сборки**: 

            * **Опции сборки** — сортировка данных по колонкам. Можно указывать только те колонки, которые есть в схеме таблицы. Данные будут отсортированы в указанном порядке.

            * **Кодек сжатия** — выберите один из [алгоритмов сжатия](https://yt.yandex-team.ru/docs/description/common/compression#compression_codecs).
          
            * **Erasure-кодек** — выберите один из [алгоритмов erasure](https://yt.yandex-team.ru/docs/description/common/replication#erasure).
          
            * **Настройки операций YT** — позволяет переопределить или дополнить настройки **Pool** и **Specification**, заданные выше на уровне общих настроек лога.
      
        * **Опции доливок**:

            * **Количество дней ожидания** — если источник пришлет данные старше указанного периода, то они будут проигнорированы и не попадут в уже опубликованную таблицу.

            * **Период запуска доливок** — для задания временного интервала укажите значение и литеру времени, например, `12h`, `7d`, `365d`. По умолчанию процесс запускается каждые три часа. Если настроен чувствительный порог доливок (100%) и источник регулярно присылает данные за историю, лучше запускать два раза в сутки (12h) или один раз в сутки (24h), чтобы сократить использование вычислительных ресурсов.

            * **Порог доливок** — порог <q>опоздавших</q> данных. Задается в процентах от `0.00` до `100.00`. Если указать 100%, любая опоздавшая строка превысит порог. Если задано значение 99.8%, число опоздавших строк больше чем 0.2% превысит порог. При превышении указанного порога данные дольются в опубликованную таблицу, и в Reactor будет отправлено новое событие об изменении таблицы.

            * **Настройки операций YT** — позволяет переопределить или дополнить настройки **Pool** и **Specification**, заданные на уровне выше, в общих настройках лога.

        * **Опции архивации**:

            * **Включено** — активация архивации.

            * **Отложенная архивация** — для задания временного интервала укажите значение и литеру времени, например, `12h`, `7d`, `365d`. Изначально таблицы записываются с кодеками. После архивации читать таблицы будет сложнее. Настройте отложенный запуск архивации, если для вас критичен быстрый доступ к данным.

            * **Кодек сжатия** — выберите один из [алгоритмов сжатия](https://yt.yandex-team.ru/docs/description/common/compression#compression_codecs).

            * **Erasure-кодек** — выберите один из [алгоритмов erasure](https://yt.yandex-team.ru/docs/description/common/replication#erasure).

            * **Настройки операций YT** — позволяет переопределить или дополнить настройки **Pool** и **Specification**, заданные выше на уровне общих настроек лога.

    * **Расширенные настройки**: 

        * **Чувствительные данные** — определяет, что делать с чувствительными данными. Выберите одну из предложенных стратегий.

        * **Имя отдельной очереди в Nirvactorе** — по умолчанию логи запускаются из общей очереди (для этого имя нужно оставить пустым). Если количество логов превышает 30, и есть выделенный вычислительный пул, то рекомендуется использовать отдельную очередь.

{% endlist %}