# Подключения

В качестве источника данных вы можете использовать подключения {{ datalens-short-name }}. Поддерживается работа со следующими типами подключений:

* {{ CH }} over YT
* {{ CH }} over YDB
* {{ CH }}
* {{ GP }}
* {{ MS }}
* {{ MY }}
* Oracle Database
* {{ PG }} 
* {{ ydb-full-name }}

Чтобы использовать подключение в качестве источника:

1. [Создайте](../../operations/index.md#creating-connection) или выберите подключение к источнику данных. Id существующего подключения указан в URL-адресе (см. [раздел](../../faq.md#how-to-find-object-id)).
1. Убедитесь, что в подключении активирована настройка **Уровень доступа SQL-запросов** → **Разрешить подзапросы в датасетах и запросы из чартов**.
1. В ChartEditor на вкладке [Urls](../architecture.md#urls) укажите идентификатор подключения, созданного в {{ datalens-short-name }}, и напишите SQL-запрос для получения данных из подключения. Например:

   ```js
   const {buildSource} = require('libs/sql/v1');

   module.exports = {
     sql: buildSource({
         // указываем нужный id подключения
         id: '0sa8m0z2vqgqz',
         
         // пишем запрос получения данных из подключения (использовать надо синтаксис той БД, подключение к которой используется)
         query: `
             select Category, sum(Profit)
             from samples.SampleLite
             group by Category
             order by Category
         `,
     })
   };
   ```

1. На вкладке [JavaScript](../architecture.md#js) используйте один из методов модуля `libs/sql/v1` для работы с данными:

   * getRows — получение значений из `query`;
   * getColumns — получение названий колонок (полей из `query`);
   * getMetadata — получение метаданных (значения из `query`, названия полей из `query`, типов данных).



