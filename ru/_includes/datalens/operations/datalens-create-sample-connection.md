1. {% if product == "yandex-cloud" %}Перейдите на [страницу подключений]({{ link-datalens-main }}/connections).{% endif %}{% if product == "cloud-il" %}Перейдите на страницу воркбука.{% endif %}
1. {% if product == "yandex-cloud" %}Нажмите кнопку **Создать подключение**.{% endif %}{% if product == "cloud-il" %}В правом верхнем углу нажмите **Создать** → **Подключение**.{% endif %}
1. Выберите подключение **ClickHouse**.

   {% if audience == "external" %}
   
   1. В открывшемся окне укажите параметры подключения:

      {% if product == "yandex-cloud" %}* Подключение — тип **Указать вручную**.{% endif %}
      * Имя хоста —  `rc1a-ckg8nrosr2lim5iz.{{ dns-zone }}`.
      * Порт HTTP-интерфейса — `8443` (по умолчанию).
      * Имя пользователя — `samples_ro`.
      * Пароль — `MsgfcjEhJk`.

    1. Активируйте опции **HTTPS** и **Разрешить подзапросы в датасетах и запросы из чартов**.
    1. Проверьте подключение и нажмите кнопку **Создать подключение**.
    1. Введите название подключения — `Sample ClickHouse`.
    1. Нажмите кнопку **Создать**.

      ![create-connection](../../../_assets/datalens/sql-chart/create-sample-connection-sql-chart.png)

   {% else %}

   1. В открывшемся окне укажите параметры подключения:
     
      * Подключение — тип **Указать вручную**.
      * Имя хоста — `vla-wwc7qtot5u6hhcqc.db.yandex.net,sas-gvwzxfe1s83fmwex.db.yandex.net`.
      * Порт HTTP-интерфейса — `8443` (по умолчанию).
      * Имя пользователя — `samples_user`.
      * Пароль — `ilovesamplessomuch`.

   1. Активируйте опцию **Разрешить подзапросы в датасетах и запросы из чартов**.
   1. Проверьте подключение и нажмите кнопку **Cоздать подключение**.
   1. Введите название подключения — `Sample ClickHouse`.
   1. Нажмите кнопку **Создать**.

      ![create-connection](../../../_assets/datalens/sql-chart/create-sample-connection-sql-chart-internal.png)

   {% endif %}

Дождитесь сохранения подключения.
