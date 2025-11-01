{% list tabs group=instructions %}

- Консоль управления {#console}

   1. [Постройте график](#add-graph).
   1. Справа вверху нажмите кнопку **{{ ui-key.yacloud_monitoring.wizard.wizard.mx.save-as }}**.
   1. Введите название графика.
   1. Выберите облако и каталог.
   1. Выберите существующий дашборд или создайте новый.
   1. Выберите один из вариантов добавления графика:
      * **{{ ui-key.yacloud_monitoring.component.add-to-dashboard-form.action.add }}** — график будет добавлен на дашборд, вы останетесь в разделе **{{ ui-key.yacloud_monitoring.aside-navigation.menu-item.explorer.title }}**.
      * **{{ ui-key.yacloud_monitoring.component.add-to-dashboard-form.action.add-and-go }}** — график будет добавлен на дашборд, вы перейдете в раздел **{{ ui-key.yacloud_monitoring.aside-navigation.menu-item.dashboards.title }}**. В разделе **{{ ui-key.yacloud_monitoring.aside-navigation.menu-item.explorer.title }}** график не сохранится.

{% endlist %}

{% note tip %}

Вы также можете [создать](../../monitoring/operations/dashboard/create.md) пустой дашборд и потом добавить на него нужные графики.

{% endnote %}


