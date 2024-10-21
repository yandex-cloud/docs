# Работа с синтаксисом {{ yql-full-name }} в {{ yq-full-name }}

Узнайте, как работать с синтаксисом {{ yql-full-name }}, и научитесь выполнять операции с данными в {{ yq-full-name }} на примере [аналитического](#analytical-query) и [потокового](#stream-query) запросов.

Все примеры выполняются на заранее подготовленном наборе данных - поездках Нью-Йоркского такси за 2019-2021 годы. 

{% note info %}

{% include [yellow-taxi-disclaimer](../_includes/yellow-taxi-disclaimer.md) %}

{% endnote %}

## Пример аналитического запроса {#analytical-query}

Чтобы создать аналитический запрос и начать обучение:

1. В [консоли управления]({{ link-console-main }}) выберите каталог, в котором нужно создать соединение.
1. В списке сервисов выберите **{{ ui-key.yacloud.iam.folder.dashboard.label_yq_ru }}**.
1. На панели слева выберите ![study](../../_assets/console-icons/graduation-cap.svg) **{{ ui-key.yql.yq-navigation.tutorial.menu-text }}**.
1. Нажмите кнопку **{{ ui-key.yql.yq-tutorial.create-connection.button-label }}**. В блоке создания соединения все поля ввода параметров уже заполнены — введите описание (опционально) и нажмите кнопку **{{ ui-key.yql.yq-connection-form.create.button-text }}**. Вы перейдете на экран создания привязки к данным.
1. Введите описание привязки к данным (опционально) и нажмите кнопку **{{ ui-key.yql.yq-binding-form.binding-create.button-text }}**. Будут созданы нужные для обучения ресурсы.

В списке на панели слева выберите интересующий обучающий раздел:

1. [Выборка данных из всех колонок](./select-all-columns.md).
1. [Выборка данных из определенных колонок](./select-specific-columns.md).
1. [Сортировка и фильтрация](./sort-filter.md).
1. [Агрегирование данных](./basic-aggregation.md).
1. [Дополнительные условия агрегации](./conditional-values.md).
1. [JSON](./json.md).

## Пример потокового запроса {#stream-query}

Чтобы создать потоковый запрос и начать обучение:

1. В [консоли управления]({{ link-console-main }}) выберите каталог, в котором нужно создать соединение.
1. В списке сервисов выберите **{{ ui-key.yacloud.iam.folder.dashboard.label_yq_ru }}**.
1. На панели слева выберите ![study](../../_assets/console-icons/graduation-cap.svg) **{{ ui-key.yql.yq-navigation.tutorial.menu-text }}**.
1. Выберите `{{ ui-key.yql.yq-tutorial.tutorial-type-toggle.option-streaming }}`.
1. Нажмите кнопку **{{ ui-key.yql.yq-tutorial.create-connection.button-label }}**. В блоке создания соединения часть полей ввода параметров уже заполнена.
1. Выберите или создайте новую базу данных.
1. Выберите или создайте новый сервисный аккаунт.
1. Нажмите кнопку **{{ ui-key.yql.yq-connection-form.create.button-text }}**. Вы перейдете на экран создания привязки к данным.
1. Выберите или создайте новый поток данных.
1. Введите описание привязки к данным (опционально) и нажмите кнопку **{{ ui-key.yql.yq-binding-form.binding-create.button-text }}**. Будут созданы нужные для обучения ресурсы.

В списке на панели слева выберите интересующий обучающий раздел:

1. [Выполнение запроса к данным реального времени](./streaming-query.md).

#### См. также {#see-also}

[Синтаксис {{ yql-short-name }}]({{ ydb.docs }}/yql/reference/syntax/)
