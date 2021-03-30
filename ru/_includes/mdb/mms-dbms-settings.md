* **Audit level**{#audti-level} {{ tag-con }} {{ tag-api }}

  Настройки аудита входа, необходимого для мониторинга активности подключения к компоненту SQL Server Database Engine.

  Возможные значения:

  - `0` — не регистрировать попытки входа в систему (по умолчанию);
  - `1` — регистрировать только неудачные попытки входа в систему;
  - `2` — регистрировать только успешные попытки входа в систему (не рекомендуется);
  - `3` — регистрировать все попытки входа в систему (не рекомендуется).
  
  Подробнее см. [в документации {{ MS }}](https://docs.microsoft.com/ru-ru/sql/ssms/configure-login-auditing-sql-server-management-studio?view=sql-server-2016).
  
* **Cost threshold for parallelism**{#setting-cost-threshold} {{ tag-con }} {{ tag-api }}

  Задает пороговое значение, при котором {{ MS }} создает и выполняет параллельные планы для запросов. Этот процесс запускается только в том случае, если расчетная стоимость выполнения последовательного плана для того же запроса превышает значение этого параметра.

  Допустимые значения — от `0` до `32767` включительно. Значение по умолчанию — `5`.

  Подробнее см. [в документации {{ MS }}](https://docs.microsoft.com/ru-ru/sql/database-engine/configure-windows/configure-the-cost-threshold-for-parallelism-server-configuration-option?view=sql-server-2016).

* **Fill factor percent**{#setting-fill-factor} {{ tag-con }} {{ tag-api }}

  Задает [коэффициент заполнения для индекса](https://docs.microsoft.com/ru-ru/sql/relational-databases/indexes/specify-fill-factor-for-an-index?view=sql-server-2016). Этот коэффициент определяет процент заполнения пространства каждой страницы конечного уровня, когда индекс создается или перестраивается. Оставшееся пространство при этом резервируется как свободное.
  
  Допустимые значения — от `0` до `100` включительно. Значение по умолчанию — `0`.

  Значения `0` и `100` означают полное заполнение страницы (свободное место не резервируется).

  Подробнее см. [в документации {{ MS }}](https://docs.microsoft.com/ru-ru/sql/database-engine/configure-windows/configure-the-fill-factor-server-configuration-option?view=sql-server-2016).

* **Max degree of parallelism**{#setting-mark-cache-size} {{ tag-con }} {{ tag-api }}

  Ограничивает число процессоров, задействованных для параллельного построения плана при выполнении запроса.
  
  Допустимые значения — от `0` до `32767` включительно. Значение по умолчанию — `0` (используются все доступные процессоры).

  Подробнее см. [в документации {{ MS }}](https://docs.microsoft.com/ru-ru/sql/database-engine/configure-windows/configure-the-max-degree-of-parallelism-server-configuration-option?view=sql-server-2016).
  
* **Optimize for ad hoc workloads**{#setting-ad-hoc-workloads} {{ tag-con }} {{ tag-api }}

  Включает кеширование планов запросов только после второго выполнения. Позволяет избежать раздувания кеша SQL из-за одноразовых планов.
  
  По умолчанию настройка выключена.

  Подробнее см. [в документации {{ MS }}](https://docs.microsoft.com/ru-ru/sql/database-engine/configure-windows/optimize-for-ad-hoc-workloads-server-configuration-option?view=sql-server-2016).
