### Ошибка при переносе коллекций timeseries {#timeseries}

Тексты ошибок:

```text
Unable to find any tables
```

```text
Cannot execute mongo activate hook: 
Failed in accordance with configuration: 
some tables from include list are missing in the source database: [<имя_коллекции>]
```

Сервис не поддерживает перенос [коллекций Time Series]({{ mg.docs.comd }}/core/timeseries-collections/).

**Решение:** [исключите](../../../../data-transfer/operations/endpoint/source/mongodb.md#additional-settings) из трансфера коллекции Time Series, после чего [активируйте](../../../../data-transfer/operations/transfer.md#activate) трансфер повторно.
