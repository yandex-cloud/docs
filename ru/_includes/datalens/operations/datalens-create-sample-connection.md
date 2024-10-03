
{% include [datalens-workbooks-collections-note](../../../_includes/datalens/operations/datalens-workbooks-collections-note.md) %}



1. Перейдите на [страницу подключений]({{ link-datalens-main }}/connections).
1. Нажмите кнопку **Создать подключение**.



1. Выберите подключение **ClickHouse**.

   
   1. В открывшемся окне укажите параметры подключения:

      * Подключение — тип **Указать вручную**.
      * Имя хоста — `rc1a-ckg8nrosr2lim5iz.{{ dns-zone }}`.
      * Порт HTTP-интерфейса — `8443` (по умолчанию).
      * Имя пользователя — `samples_ro`.
      * Пароль — `MsgfcjEhJk`.

    1. Активируйте опцию **Разрешить подзапросы в датасетах и запросы из чартов**.
    1. Проверьте подключение и нажмите кнопку **Создать подключение**.
    1. Введите название подключения — `Sample ClickHouse`.
    1. Нажмите кнопку **Создать**.


      ![create-connection](../../../_assets/datalens/sql-chart/create-sample-connection-sql-chart.png)



Дождитесь сохранения подключения.
