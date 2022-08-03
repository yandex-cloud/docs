# Change data capture

CDC ([change data capture](https://en.wikipedia.org/wiki/Change_data_capture)) is a process of tracking changes in a database and delivering them to consumers in near real-time. CDC can be used to:

* Create applications that respond to data changes in real time.
* Deliver data from a centralized storage to microservices.
* Collect and deliver data from a production environment to internal data storages for processing and analysis.

In {{ yandex-cloud }}, one way CDC can be implemented is with a transfer from the database to the message broker. All database updates are tracked by the transfer and sent to the message broker, and consumers are connected to the broker and read the incoming messages.

{{ data-transfer-name }} supports CDC for transfers from {{ PG }}, {{ MG }}, and {{ MY }} databases to {{ KF }} and {{ yds-full-name }}^1^. Data is sent to the target in [Debezium](https://debezium.io/) format.

![image](../../_assets/data-transfer/concepts/cdc-flow.png)

{% include [greenplum-trademark](../../_includes/mdb/mgp/trademark.md) %}

^1^ This feature is in the Preview stage.
