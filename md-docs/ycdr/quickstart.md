# Как начать работать с расследованиями

{% note info %}

Функциональность находится на стадии [Preview](../overview/concepts/launch-stages.md). Чтобы получить доступ, обратитесь в [техническую поддержку]({{ link-console-support }}) или к вашему аккаунт-менеджеру.

{% endnote %}

В этом руководстве вы создадите расследование и выполните первый запрос на языке [KQL (Kusto Query Language)](kql-reference.md).

## Перед началом работы {#before-you-begin}

Раздел {{ ycdr-name }} появится в интерфейсе {{ sd-name }} после одобрения заявки на доступ.

Для работы с расследованиями вам потребуется [роль](../iam/roles-reference.md#ycdr-admin) `ycdr.admin`.

## Создайте расследование {#create-investigation}

1. Перейдите в сервис [{{ sd-name }}]({{ link-sd-main }}).
1. На панели слева выберите **{{ ycdr-name }}**.
1. Перейдите на вкладку **{{ ui-key.yacloud_org.security.ycdr.YcdrPageLayout.investigations_wYxSe }}**.
1. Нажмите **{{ ui-key.yacloud_org.security.siem.InvestigationsPage.create-investigation_iCPUP }}**.
1. Введите название расследования, например: `Анализ неудачных входов`.
1. В поле **{{ ui-key.yacloud_org.security.siem.InvestigationPageLayout.fieldDescription_wiAxw }}** добавьте описание: `Поиск неудачных попыток входа в консоль за последние 30 минут`.

## Создайте запрос {#create-query}

1. В редакторе запросов введите следующий KQL-запрос:

   ```kql
   Events
   | project event_class, ['time']
   | limit 1
   ```

   Этот запрос:
   * выбирает события из таблицы `Events`;
   * отображает поля `event_class` и `time`;
   * ограничивает результат одной записью.

1. Выберите временной период **{{ ui-key.yacloud_org.security.ycdr.preset_last_30_minutes_s5Gq5 }}**.
1. Нажмите кнопку запуска запроса.

## Проанализируйте результаты {#analyze-results}

После выполнения запроса результаты отображаются в таблице с полями:

* `event_class` — класс события;
* `time` — время события.

{% note info %}

Максимальное количество строк в результатах расследования — 1 000 000.

{% endnote %}

Это простой пример запроса для проверки работоспособности сервиса. Для более сложного анализа используйте другие запросы и фильтры.


## Что дальше {#whats-next}

* Узнайте больше о [расследованиях](concepts/investigations.md) и [запросах](concepts/queries.md).
* Научитесь [управлять расследованиями](operations/investigations/manage-investigations.md).
* Изучите [работу с запросами](operations/queries/index.md).
* Изучите [справочник KQL](kql-reference.md).