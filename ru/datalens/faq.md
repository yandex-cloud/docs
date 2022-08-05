# FAQ

В данном разделе собраны ответы на вопросы пользователей, возникающие при работе с {{ datalens-short-name }}.

Если вы не нашли ответа на свой вопрос, обратитесь к разделу [Как сообщить о проблеме](#how-to-resolve-problem).

Разделы:

* [Права доступа](#permissions)
* [Подключения](#connections)
* [Датасеты](#datasets)
* [Чарты](#charts)
* [Вычисляемые поля](#calculated-fields)
* [Дашборды](#dashboards)
* [Другое](#other)

## Права доступа {#permissions}

### Уведомления о запросах прав доступа {#permission-request-notifications}

При запросе прав доступа на объект будет выслано уведомление на почту всем администраторам объекта, а также информация о запросе прав на связанные сущности. Запрашиваемый объект будет отображаться первым в списке ссылок. Чтобы выдать права на все сущности, перейдите по ссылке на объект и укажите права для пользователей на объект и на его связанные сущности. Или нажмите каждую из ссылок в уведомлении и подтвердите выдачу прав в диалоге **Права доступа**.

**Ограничения:**
- уведомления отправляются только сотрудникам-администраторам объектов, не группам;
- администраторам связанных сущностей уведомления не приходят;
- права на связанные сущности не будут утверждены, если подтверждающий не является администратором связанной сущности;
- датасеты/подключения для скриптов `ChartEditor` не попадают в связи.

{% include [qa-for-users.md](../_includes/datalens/qa/permission-error.md) %}

### Можно ли выдавать права на просмотр чарта всем пользователям, а не только пофамильно? {#viewing-rights-for-all-users}

Для этого нужно выдать права на группу:

1. **Яндекс** — все штатные сотрудники Яндекса.
1. **Все** — все сотрудники Яндекса, включая внештатных. Для получения доступа внештатными сотрудниками необходимо следовать [инструкции](https://wiki.yandex-team.ru/Statbox/Dostup-k-Statistike-dlja-Outstaff/).
1. Вы можете дать права какой-то конкретной группе.

{% include [copy-into-folder](../_includes/datalens/qa/copy-into-folder.md) %}

{% include [revoke-token.md](../_includes/datalens/qa/revoke-token.md) %}

## Подключения {#connections}

{% include [postgre-type.md](../_includes/datalens/qa/postgre-type.md) %}

### Что делать, если таблица из Google Sheets работает некорректно? {#google-sheets-error}

{% include [google-sheets-error](../_includes/datalens/qa/google-sheets-error.md) %}

### Проблемы с таймзонами (откуда-то сдвиг на три часа во времени) {#timezone-problems}

Приводим работу с таймзонами в порядок в рамках [тикета](https://st.yandex-team.ru/BI-1478).

{% include [csv-file-rows-display.md](../_includes/datalens/qa/csv-file-rows-display.md) %}

### Как подключиться к внешней базе данных? {#connect-external-db}

Чтобы подключить внешние БД {{ CH }}, {{ PG }}, {{ MY }}, {{ MS }} или Oracle Database к внутреннему DataLens (datalens.yandex-team.ru), откройте доступ к кластеру `_DL_INT_BACK_PROD_NETS_` в [Puncher](https://puncher.yandex-team.ru/). См. [изображение](https://jing.yandex-team.ru/files/elenbaskakova/Pravila_2019-01-22_19-48-39.png).

### Какой пароль вводить для балансера clickhouse.metrika.yandex.net? {#password-for-clickhouse-metrika}

Для получения логина и пароля воспользуйтесь [инструкцией](https://wiki.yandex-team.ru/jandexmetrika/mtmega/#2.akkauntvbazedannyx).

Задайте настройки для портов:
* `8123` — выключите опцию **HTTPS**.
* `8443` — включите опцию **HTTPS**.

## Датасеты {#datasets}

### Как создать датасет на основе динамических таблиц? {#how-to-create-dataset}

Воспользуйтесь сценарием [{#T}](tutorials/data-from-ch-over-yt.md).

Если вы получаете ошибку в DataLens при создании датасета на основе динамической таблицы следующего вида: `Dynamic store read for table <название таблицы> is disabled; in order to read dynamic stores, set attribute "enable_dynamic_store_read" to true and remount table; if you indeed want to read only static part of dynamic table, pass setting chyt.dynamic_table.enable_dynamic_store_read = 0`.

Это значит, что таблицу надо перемонтировать и выставить атрибут `enable_dynamic_store_read` в CHYT.

Чтобы перемонтировать таблицу, обратитесь к владельцу данных в YT (как это сделать см. [пост в Этушке](https://clubs.at.yandex-team.ru/yt/4033)).

{% include [incorrectly-identified-date-field](../_includes/datalens/qa/incorrectly-identified-date-field.md) %}

{% include [how-to-link-two-tables](../_includes/datalens/qa/linking-two-tables.md) %}


### Как отобразить новые данные при обновлении таблицы источника CHYT? {#new-data-in-chyt-table}

1. Нажать кнопку **Обновить поля** в датасете.
1. Если в исходных данных range и добавлены колонки только в последних, то стоит отметить, что CHYT сам берёт пересечение множеств колонок по всему range. Обсуждение в [Telegram](https://t.me/c/1068660824/45777).

### Некорректно отображаются символы кириллицы в датасете {#incorrect-cyrillic-symbols}

Если ваш датасет создан поверх подключения CHYT, убедитесь, что поле в YT имеет тип `string`. {{ datalens-short-name }} не работает со специфическими типами данных, например, с типом `any` в YT.

### Как связать два датасета через селектор? {#how-to-add-common-selector}

См. пример на [дашборде](https://datalens.yandex-team.ru/vpcr34sjm4wmp-primer-svyazi-dvuh-datasetov-cherez-selektor?state=7ae8de37186).

{% include [add-line-numeration](../_includes/datalens/qa/add-line-numeration.md) %}

{% include [unix-time](../_includes/datalens/qa/unix-time.md) %}

## Датасеты {{ datalens-short-name }} в Editor {#datalens-datasets-in-editor}

Датасеты {{ datalens-short-name }} доступны для использования в [Editor](https://charts.yandex-team.ru/editor) как [один из источников](/docs/editor/sources/dataset).


## Чарты {#charts}

{% include [show-top-100-values.md](../_includes/datalens/qa/show-top-100-values.md) %}

{% include [create-labels-in-pie-chart.md](../_includes/datalens/qa/create-labels-in-pie-chart.md) %}

{% include [hide-legend-in-chart.md](../_includes/datalens/qa/hide-legend-in-chart.md) %}

{% include [add-two-indicators.md](../_includes/datalens/qa/add-two-indicators.md) %}

{% include [create-grouped-column-chart.md](../_includes/datalens/qa/create-grouped-column-chart.md) %}

{% include [number-of-indicators-in-color-section.md](../_includes/datalens/qa/number-of-indicators-in-color-section.md) %}

{% include [creating-line-chart-with-columns.md](../_includes/datalens/qa/creating-line-chart-with-columns.md) %}

### Как посмотреть, какой запрос уходит с чарта? {#request-from-chart}

1. В правом верхнем углу чарта нажмите на три точки и выберите **Инспектор** (см. [изображение](https://jing.yandex-team.ru/files/pampiduzik/2021-02-12T07%3A23%3A58Z.56275ff.png)).
2. В разделе **Источники данных** откройте параметры второго источника: там будет отображено тело запроса, а в блоке **Дополнительная информация** — SQL-запрос (см. [изображение](https://jing.yandex-team.ru/files/pampiduzik/2021-02-12T07%3A26%3A03Z.b42e7f7.png)).

{% include [pie-chart-note](../_includes/datalens/qa/pie-chart-note.md) %}

{% include [making-logarithmic-scale](../_includes/datalens/qa/making-logarithmic-scale.md) %}

{% include [sign-last-point](../_includes/datalens/qa/sign-last-point.md) %}

{% include [sign-multiple-lines](../_includes/datalens/qa/sign-multiple-lines.md) %}

{% include [rename-column](../_includes/datalens/qa/rename-column.md) %}

{% include [cell-image](../_includes/datalens/qa/cell-image.md) %}

{% include [null-setting-in-charts.md](../_includes/datalens/qa/null-setting-in-charts.md) %}

### Как выгрузить из таблицы все значения, а не только первые 100 строк? {#pagination}

1. Перейдите в [настройки чарта](concepts/chart/settings.md#common-settings).
1. В открывшемся окне установите значение **Выкл** напротив функции **Пагинация**.

### Как добавить изображение в таблицу? {#cell-image}

Добавить изображение в ячейку таблицы можно только в [ChartEditor](https://charts.yandex-team.ru/editor). Для этого укажите ссылку на нужное изображение в свойстве [backround-image](http://htmlbook.ru/css/background-image) для [css-стиля ячейки](./editor/widgets/table/index.md#example). См. [пример](https://datalens.yandex-team.ru/editor/1penklxj2bds0-table-with-base64-image).

## Вычисляемые поля {#calculation-fields}

### Как создать вычисляемое поле (формулу) в подключении Statface Report или (App)Metrica API? {#how-to-create-calculated-fields}

Поддерживается ограниченный [перечень операторов и функций](https://cloud.yandex.ru/docs/datalens/function-ref/availability).

### Как создать агрегацию над полем в подключении Statface Report или (App)Metrica API? {#how-to-create-aggregation}

Не поддерживается. См. подробнее вопрос [Как создать вычисляемое поле (формулу) в подключении Statface Report или (App)Metrica API?](#how-to-create-calculated-fields)

{% include [how-to-calculate-cumulative-sum](../_includes/datalens/qa/calculating-cumulative-sum.md) %}

{% include [calculate-ifnull-zn-nan](../_includes/datalens/qa/calculating-ifnull-zn-nan.md) %}

## Дашборды {#dashboards}

### Можно ли сделать селектор на основе двух полей датасета (start_date и end_date), работающий следующим образом: если хотя бы один день из селектора принадлежит интервалу (start_date;end_date), то оставлять данную строку? {#selector-based-on-range}

Такое сейчас невозможно. Через больше/меньше с двумя селекторами можно будет работать после расширения операторов в селекторах (см. [тикет](https://st.yandex-team.ru/DLFR-285)).
См. более сложную конструкцию с поддержкой параметризации в [тикете](https://st.yandex-team.ru/DLFR-174).

Сейчас можно попробовать через `Editor` и ручные селекторы, но нет готовых образцов, которыми можно поделиться.

{% include [configure-link-between-selectors](../_includes/datalens/qa/configure-link-between-selectors.md) %}

{% include [unavailable-selector-values](../_includes/datalens/qa/unavailable-selector-values.md) %}

### Приходит рассылка с «Нет прав на просмотр дашборда» {#no-permissions-to-view-dashboard}

По умолчанию рассылка выполняется роботом `robot-charts-postman`. Для доступа робота права на чтение/исполнение должны быть выданы для этого робота. Чтобы рассылка была с доступами пользователя, добавьте его OAuth-токен при настройке рассылок.

### Можно ли из внутренней сети публиковать публичные дашборды? {#publishing-public-dashboards-from-internal-network}

Такой возможности нет.

{% include [apply-filter-to-two-datasets](../_includes/datalens/qa/apply-filter-to-two-datasets.md) %}

{% include [configure-selectors](../_includes/datalens/qa/configure-selectors.md) %}

### Селекторы выдают ошибку при выборе значения (подключение к Statface Report) {#error-of-value-selection}

Это происходит потому, что для данного типа подключения не работают связанные селекторы.

Чтобы исправить эту ошибку:

1. Создайте селекторы без указания значений, выбранных по умолчанию.
1. Разорвите связи между селекторами.
1. Установите в селекторах значения по умолчанию.


## Партнерская аналитика {#partner-analytics}

Партнерская аналитика — это возможность делиться с партнерами дашбордами с разграничением прав доступа через внешний облачный DataLens. Это позволяет реализовать один дашборд над одним кубом данных, при этом каждый партнер будет видеть только доступные ему данные. [Подробности на вики](https://wiki.yandex-team.ru/DataLens/Partnerskaja-analitika/).


## Другое {#other}

{% include [copy-folder](../_includes/datalens/qa/copy-folder.md) %}

### В чарте ошибка — клика CHYT недоступна. Как восстановить клику? {#clique-is-not-running}

Если вы видите ошибку типа Clique `*chyt_analytics is not running; actual state = failed`, попросите ответственного поднять клику.
Чтобы найти ответственного:
1. Откройте операцию на нужном вам кластере YT, например на [Hahn](https://yt.yandex-team.ru/hahn/operations).
1. Введите имя клики со звездочкой, например, `*chyt_analytics`.
1. Нажмите **Go to operation**.
1. Посмотрите логин ответственного в поле **User**.

### Можно ли откатить версию объекта {{ datalens-short-name }} на более раннюю? {#dl-rollback}

История изменений и возможность отката версии доступна для дашбордов и чартов в меню дашборда/чарта (см. версионирование [дашборда](concepts/dashboard.md#versioning)/[чарта](concepts/chart/index.md#versioning)). Для остальных объектов пользователь не может самостоятельно откатить версию объекта. Через жука {{ datalens-short-name }} заведите тикет. В тикете укажите объекты {{ datalens-short-name }} и версию (время), к которому требуется вернуть объект.

{% include [object-id](../_includes/datalens/qa/object-id.md) %}

## Как сообщить о проблеме {#how-to-resolve-problem}

Мы всегда поможем, если у вас возникнут трудности и проблемы.
О проблемах и ошибках оповещайте через жучка (автоматически создастся тикет в очереди [DLHELP](https://st.yandex-team.ru/createTicket?queue=DLHELP)).
При обращении желательно предоставить:
* максимально точное описание проблемы и порядок ваших действий;
* картинки, GIF или видео (совсем не обязательно, но совсем не лишнее).
Предложения и пожелания — очередь [DLFR](https://st.yandex-team.ru/createTicket?queue=DLFR).
За новостями сервиса следите в [Этушке](https://clubs.at.yandex-team.ru/statistics/) и Telegram-канале [DataLens News](https://t.me/joinchat/AAAAAEY_2U2A53YOLnT5_A).

