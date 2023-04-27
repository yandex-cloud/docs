# Настройка эндпоинта-источника Microsoft SQL Server

При [создании](../index.md#create) или [изменении](../index.md#update) эндпоинта задайте настройки доступа к {{ MS }}.

## Настройки {#settings}

{% list tabs %}

- Консоль управления

    * **{{ ui-key.yc-data-transfer.data-transfer.endpoint.airbyte.mssql_source.endpoint.airbyte.mssql_source.MSSQLSource.host.title }}** — IP-адрес или FQDN хоста, к которому необходимо подключиться.
  
    * **{{ ui-key.yc-data-transfer.data-transfer.endpoint.airbyte.mssql_source.endpoint.airbyte.mssql_source.MSSQLSource.port.title }}** — номер порта, который сервис {{ data-transfer-name }} будет использовать для подключения к хосту. 

    * **{{ ui-key.yc-data-transfer.data-transfer.endpoint.airbyte.mssql_source.endpoint.airbyte.mssql_source.MSSQLSource.database.title }}** — имя БД для подключения.

    * **{{ ui-key.yc-data-transfer.data-transfer.endpoint.airbyte.mssql_source.endpoint.airbyte.mssql_source.MSSQLSource.username.title }}**, **{{ ui-key.yc-data-transfer.data-transfer.endpoint.airbyte.mssql_source.endpoint.airbyte.mssql_source.MSSQLSource.password.title }}** — имя и пароль пользователя БД.
  
    * **{{ ui-key.yc-data-transfer.data-transfer.endpoint.airbyte.mssql_source.endpoint.airbyte.mssql_source.MSSQLSource.replication_method.title }}** — способ репликации, используемый для извлечения данных из базы данных. Репликация типа `STANDARD` не требует настройки на стороне БД, но не сможет отображать изменения данных. Репликация типа `CDC` позволяет обнаруживать вставки, обновления и удаления.
  
    * **{{ ui-key.yc-data-transfer.data-transfer.endpoint.airbyte.mssql_source.endpoint.airbyte.mssql_source.MSSQLSource.ssl_method.title }}** — метод шифрования, который используется при обмене данными с базой данных:
      
        * `UNENCRYPTED` — сохранение пароля в открытом текстовом виде;
      
        * `ENCRYPTER (trust cert)` — использование сертификата из достоверного источника;

        * `ENCRYPTER (verify cert)` — использование самоподписанного сертификата.
    
{% endlist %}

Подробнее о настройках см. в [документации Airbyte®](https://docs.airbyte.com/integrations/sources/mssql/).

{% include [airbyte-trademark](../../../../_includes/data-transfer/airbyte-trademark.md) %}
