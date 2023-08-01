# Создание подключения к Snowflake

Чтобы создать подключение к Snowflake:

1. Перейдите на [страницу подключений](https://datalens.yandex.ru/connections).
1. Нажмите кнопку **Создать подключение**.
1. Выберите подключение **Snowflake**.
1. Заполните поля в блоке **Аутентификация**:

   {% note info %}
   
   Для получения токена рекомендуется завести на Snowflake пользователя с ограниченными правами доступа.

   {% endnote %}

   1. Если это первое подключение к Snowflake в {{ datalens-short-name }}, настройте [интеграцию OAuth](https://docs.snowflake.com/en/user-guide/oauth-custom#integration-example):

      1. В поле **Интеграция OAuth** введите произвольное название для объекта интеграции на латинице и нажмите кнопку **Получить сниппет**.
      1. Создайте интеграцию: в среде Snowflake запустите скопированный в буфер сниппет. Код сниппета должен выполняться от имени пользователя, у которого есть соответствующие права. В ответе на запрос вы получите значения для вставки в {{ datalens-name }}.
      
         {% note info %}

         Полученные параметры можно использовать также для других подключений к Snowflake с этим же аккаунтом.
         
         {% endnote %}

   1. Заполните параметры, которые вы получили после исполнения кода сниппета в среде Snowflake:

      * **ACCOUNT_NAME** — [имя аккаунта](https://docs.snowflake.com/en/user-guide/client-redirect#snowsight-the-snowflake-web-interface) в среде Snowflake. 
      * **CLIENT_ID** — [идентификатор клиента](https://docs.snowflake.com/en/sql-reference/functions/system_show_oauth_client_secrets#system-show-oauth-client-secrets) для созданного объекта интеграции.
      * **CLIENT_SECRET** — [секрет клиента](https://docs.snowflake.com/en/sql-reference/functions/system_show_oauth_client_secrets#system-show-oauth-client-secrets).

   1. Нажмите **Получить токен** рядом с полем [**Refresh-токен**](https://docs.snowflake.com/en/user-guide/oauth-intro#refresh-token). Откроется страница Snowflake, на которой необходимо подтвердить доступ. Убедитесь, что вы вошли в аккаунт пользователя Snowflake с ограниченными правами доступа.

1. Укажите параметры подключения в блоке **Сведения о базе данных**:

   * **User name** — [имя пользователя](https://docs.snowflake.com/en/sql-reference/sql/create-user#create-user), который подтверждал права доступа к Snowflake.
   * **Database name** — [имя](https://docs.snowflake.com/en/sql-reference/sql/create-database#create-database) подключаемой базы данных.
   * **Database schema** — [схема](https://docs.snowflake.com/en/sql-reference/sql/create-schema#create-schema) базы данных.
   * **Warehouse** — [хранилище](https://docs.snowflake.com/en/sql-reference/sql/create-warehouse#create-warehouse) базы данных.
   * **User role** — [роль пользователя](https://docs.snowflake.com/en/sql-reference/sql/create-role#create-role) с правом доступа к подключаемой базе данных.

1. Проверьте подключение и нажмите кнопку **Создать подключение**.
1. Укажите название подключения и нажмите кнопку **Создать**.
