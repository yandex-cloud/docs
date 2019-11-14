# Dictionaries

_Dictionaries_ in {{ CH }} are key-value data stores that are fully or partially loaded to the {{ CH }} server memory.
Dictionary data is accessed using a [set of functions](https://clickhouse.yandex/docs/ru/query_language/functions/ext_dict_functions/) that are faster than standard SQL queries. Access to dictionaries is read-only. You can't write data to a dictionary using {{ CH }}.

The main advantage of dictionaries is that they're faster compared to JOIN operations. Dictionaries are useful when you have to frequently access reference lists to get a set of values from a key.

As their data sources, dictionaries can use [{{ CH }} internal dictionaries](https://clickhouse.yandex/docs/ru/query_language/dicts/internal_dicts/) or [external sources](https://clickhouse.yandex/docs/ru/query_language/dicts/external_dicts/), including HTTP(s) resources or other DBMS ({{ MY }}, {{ CH }}, {{ MG }}, {{ PG }}).

## Internal dictionaries {#internal-dicts}

{{ CH }} contains an internal dictionary for working with a geobase. The dictionary lets you:

* Get the name of a region in the required language by its ID.
* Get the ID of a city, region, federal district, country, and continent by the region ID.
* Check whether one region is part of another.
* Get a chain of parent regions.

To learn more about internal dictionaries, see the [{{ CH }} documentation](https://clickhouse.ya ndex/docs/ru/query_language/dicts/internal_dicts/).

## External dictionaries {#external-dicts}

For external dictionaries, HTTP(s) resources and other DBMS ({{ MY }}, {{ CH }}, {{ MG }}, {{ PG }}) can be used as data sources.

Depending on the dictionary settings, {{ CH }} fully or partially stores dictionaries in RAM, periodically updates them, and dynamically loads the missing values.

To learn how to add and configure a dictionary using {{ mch-full-name }}, see [Adding external dictionaries](../operations/dictionaries.md).

