На панели слева выберите ![seal-check](../../_assets/console-icons/seal-check.svg) **{{ ui-key.yacloud_org.security-center.label_comp }}**.

В открывшемся окне отобразится список с информацией о наборах требований безопасности, на соответствие которым в текущий момент проверяется инфраструктура в выбранном окружении. Список содержит следующие сведения:

* **{{ ui-key.yacloud_org.security.comp.SetsTable.field_set_title }}** — имя отраслевого стандарта безопасности или нормативного акта, которому соответствует набор требований.
* **{{ ui-key.yacloud_org.security.comp.SetsTable.field_count_rules }}** — количество правил контроля, входящих в набор требований.
* **{{ ui-key.yacloud_org.security.comp.SetsTable.field_execution }}** — процентное соотношение выполненных правил к общему количеству правил в наборе требований. Значение `100%` означает полное выполнение требований соответствующего стандарта безопасности или нормативного акта. 

    Если проверка ресурсов окружения на соответствие набору требований отключена, поле содержит значение `{{ ui-key.yacloud_org.security.comp.SetsTable.not_verified }}`.

    {% include [rule-set-enable-disable-notice](./rule-set-enable-disable-notice.md) %}