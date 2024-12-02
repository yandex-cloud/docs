# Проверка превышения порогов метрик регрессий с помощью CLI

Для каждой метрики (линии) на графиках [дашбордов регрессий](./regressions.md) можно добавить пороговое значение, превышение которого нужно считать аномальным. Помимо графического отображения областей, на которых превышены пороговые значения, можно получать информацию о регрессиях с помощью [команды CLI](../../cli/cli-ref/loadtesting/cli-ref/test/check-regression.md). 

На этой странице описаны основные сценарии применения команды `yc loadtesting test check-regression` для проверки превышения пороговых значений на графиках регрессий.

## Подготовка идентификаторов тестов {#get-test-ids}

Получите список идентификаторов тестов командой `yc loadtesting test list`:

Пример ответа:

```
+----------------------+---------+--------+---------------------+----------+
|          ID          |  NAME   | LABELS |       CREATED       | FINISHED |
+----------------------+---------+--------+---------------------+----------+
| ff6mmyz7s4t2m4****** | test780 |        | 2024-09-29 09:26:56 |          |
+----------------------+---------+--------+---------------------+----------+
```

Используйте полученные идентификаторы для вызова команды проверки.

## Проверка всех графиков выбранного теста {#check-test}

Если вы выполните команду без дополнительных параметров, то она будет проверять наличие регрессии на всех графиках из вашего каталога, на которых есть указанный тест.

Выполните команду:

```
yc loadtesting test check-regression <идентификатор теста>
```

Пример выполнения команды:

```
yc loadtesting test check-regression ff6mmyz7s4t2m4******

                     Test:   autotest-pandora-line-uripost (id=ff6mmyz7s4t2m4******)

------------------------------------------------------------------------------------
   Charts checked (count):                                                         3
               Thresholds:                                           2 OK / 1 FAILED


   status   value     threshold        fn                           metric      case                                                    chart        dashboard

--------------------------------------------------------------------------------------------------------------------------------------------------------------
       OK       0    value <= 5   percent   Responses: protocol code (5xx)   overall                       all tests: less than 5% 5xx codes    test-dashboard
       OK     100   value >= 90   percent   Responses: protocol code (200)   overall                      all tests: more than 90% 200 codes    test-dashboard
   FAILED      27   value <= 20       q99                          Latency   overall              Время ответа: autotest-pandora-line-uripost         autotest
        -      18             -       q98                          Latency   overall              Время ответа: autotest-pandora-line-uripost         autotest
        -     4.3             -       q75                          Latency   overall              Время ответа: autotest-pandora-line-uripost         autotest
        -    3.39             -       q50                          Latency   overall              Время ответа: autotest-pandora-line-uripost         autotest
```

## Проверка графиков на указанном дашборде {#check-graphs-from-dashboard}

При выполнении команды с параметром `--dashboard-id` будут проверены только графики, добавленные на указанный дашборд.

Получить идентификатор дашборда можно на странице со списком дашбордов (колонка ID скрыта по умолчанию), либо взять его из URL страницы дашборда.

Выполните команду:

```
yc loadtesting test check-regression <идентификатор теста> --dashboard-id <идентификатор дашборда>
```

Пример выполнения команды:

```
yc loadtesting test check-regression ff6mmyz7s4t2m4****** --dashboard-id ff6jqg3mf5xhby******

                     Test:   autotest-pandora-line-uripost (id=ff6mmyz7s4t2m4******)

------------------------------------------------------------------------------------
   Charts checked (count):                                                         2
               Thresholds:                                           2 OK / 0 FAILED


   status   value     threshold        fn                           metric      case                                 chart        dashboard

-------------------------------------------------------------------------------------------------------------------------------------------
       OK       0    value <= 5   percent   Responses: protocol code (5xx)   overall    all tests: less than 5% 5xx codes    test-dashboard
       OK     100   value >= 90   percent   Responses: protocol code (200)   overall   all tests: more than 90% 200 codes    test-dashboard
```

## Проверка отдельного графика {#check-graph}

При выполнении команды с параметрами `--dashboard-id` и `--chart-id` пороги будут проверяться только на конкретном графике.

```
yc loadtesting test check-regression <идентификатор теста> --dashboard-id <идентификатор дашборда> --chart-id <идентификатор графика>
```

Получить идентификатор дашборда можно на странице со списком дашбордов (колонка ID скрыта по умолчанию), либо взять его из URL страницы дашборда.

Чтобы получить идентификатор графика, рядом с любым из графиков на дашборде нажмите кнопку ![image](../../_assets/console-icons/chevrons-expand-up-right.svg) — откроется отдельная страница графика. Идентификатор находится в верхней части страницы и в URL.

Пример выполнения команды:

```
yc loadtesting test check-regression ff6mmyz7s4t2m4****** --dashboard-id ff6jqg3mf5xhby****** --chart-id 57651054-35af-47ea-a5a8-6a1a8dbe4377

                     Test:   autotest-pandora-line-uripost (id=ff6mmyz7s4t2m4******)

------------------------------------------------------------------------------------
   Charts checked (count):                                                         1
               Thresholds:                                           1 OK / 0 FAILED


   status   value    threshold        fn                           metric      case                                chart        dashboard

-----------------------------------------------------------------------------------------------------------------------------------------
       OK       0   value <= 5   percent   Responses: protocol code (5xx)   overall   all tests: less than 5% 5xx codes    test-dashboard
```