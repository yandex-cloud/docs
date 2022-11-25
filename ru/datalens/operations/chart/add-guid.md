# Добавление ID в качестве параметра

Чтобы передать фильтр в чарт в виде параметра:

1. Откройте датасет. Если у вас нет датасета, [создайте его](../dataset/create.md).
1. В левом верхнем углу переключитесь на вкладку **Поля**.
1. В правой части строки с нужным полем нажмите значок ![image](../../../_assets/datalens/horizontal-ellipsis.svg) и выберите **Скопировать ID**.
1. Вставьте ID в URL чарта в качестве параметра запроса. Должна получиться ссылка вида {% if product == "yandex-cloud" %}`https://datalens.yandex.ru/wizard/yfn1k6yxud7yr-example-chart?17ecb9a1-c8a5-4811-b53e-c8229f88fcba=<значение>`{% endif %}{% if product == "cloud-il" %}`https://datalens.cloudil.co.il/wizard/yfn1k6yxud7yr-example-chart?17ecb9a1-c8a5-4811-b53e-c8229f88fcba=<значение>`{% endif %}, где:

   * `17ecb9a1-c8a5-4811-b53e-c8229f88fcba` — ID поля;
   * `<значение>` — одно из значений поля, по которому происходит фильтрация.
