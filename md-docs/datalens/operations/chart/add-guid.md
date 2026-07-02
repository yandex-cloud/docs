[Документация Yandex Cloud](../../../index.md) > [Yandex DataLens](../../index.md) > Чарты > Параметры в чартах > Добавление ID в качестве параметра

# Добавление ID в качестве параметра в Yandex DataLens

Чтобы передать фильтр в чарт в виде параметра:


{% note warning %}

Если вы работаете с новой объектной моделью DataLens, включающей [воркбуки и коллекции](../../workbooks-collections/index.md):

1. На панели слева выберите ![collections](../../../_assets/console-icons/rectangles-4.svg) **Коллекции и воркбуки**.
1. Откройте нужный воркбук и выберите объект.

Продолжайте инструкцию с шага 2.

{% endnote %}


1. На панели слева нажмите ![image](../../../_assets/console-icons/circles-intersection.svg) **Датасеты** и выберите нужный датасет. Если у вас нет датасета, [создайте его](../../dataset/create-dataset.md#create).
1. В левом верхнем углу переключитесь на вкладку **Поля**.
1. В правой части строки с нужным полем нажмите значок ![image](../../../_assets/console-icons/ellipsis.svg) и выберите **Скопировать ID**.
1. Откройте чарт, в который нужно добавить параметр, и вверху нажмите значок ![image](../../../_assets/console-icons/ellipsis.svg) → **Копировать ссылку**. Вы также можете скопировать URL чарта из адресной строки браузера.
1. Добавьте ID поля к URL чарта в качестве параметра запроса. Должна получиться ссылка вида `https://datalens.ru/wizard/yfn1k6yxud7yr-example-chart?17ecb9a1-c8a5-4811-b53e-c8229f88fcba=<значение>`, где:

   * `https://datalens.ru/wizard/yfn1k6yxud7yr-example-chart` — URL чарта;
   * `17ecb9a1-c8a5-4811-b53e-c8229f88fcba` — ID поля;
   * `<значение>` — одно из значений поля, по которому происходит фильтрация.

   При переходе по такой ссылке чарт откроется с примененным фильтром по указанному полю.

{% cut "Чарт без параметра" %}

![image](../../../_assets/datalens/parameters/chart.svg)

{% endcut %}

{% cut "Чарт с параметром" %}

Для фильтрации данных в чарте сформирована ссылка:

`https://datalens.ru/wizard/3v7xz********-temperatura?season_xw29=spring`, где:

   * `https://datalens.ru/wizard/3v7xz********-temperatura` — URL чарта;
   * `season_xw29` — ID поля;
   * `spring` — значение поля, по которому происходит фильтрация.

![image](../../../_assets/datalens/parameters/chart-with-parameter.svg)

{% endcut %}