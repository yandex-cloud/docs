1. В [консоли управления]({{ link-console-main }}) откройте страницу кластера.
1. В поле **{{ ui-key.yacloud.airflow.cluster.overview.title_resource-webserver }}** нажмите **{{ ui-key.yacloud.mdb.cluster.overview.label_web-server-url }}** ![start](../../../_assets/console-icons/arrow-up-right-from-square.svg).
1. В открывшемся веб-интерфейсе [веб-сервера {{ maf-name }}](../../../managed-airflow/concepts/index.md#components) введите данные для аутентификации:

   * Логин — `admin`.
   * Пароль — пароль пользователя `admin`, который вы указали при создании кластера.

Подробнее о работе в веб-интерфейсе см. [документацию {{ AF }}](https://airflow.apache.org/docs/apache-airflow/stable/ui.html).
