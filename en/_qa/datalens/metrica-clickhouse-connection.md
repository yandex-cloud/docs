### How do I connect to Yandex Metrica from {{ datalens-short-name }}? {#metrica-clickhouse-connection}

{{ datalens-short-name }} can connect to Yandex Metrica directly (see [Web analytics with a connection to Yandex Metrica](../../datalens/tutorials/data-from-metrica-visualization.md)). In this case, you won't have access to some analytical functions for data (the data is accessed over an API with limited functionality). It is likely that the API will slowly respond to queries involving large amounts of data. If you are using the API very actively, you may exceed the API limits.

You can use scripts to set up export of the metric to your database and connect to this database using {{ datalens-short-name }}.

{% include [datalens-metrica-note](../../_includes/datalens/datalens-metrica-note.md) %}