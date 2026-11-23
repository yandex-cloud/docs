CDC ([change data capture](https://en.wikipedia.org/wiki/Change_data_capture)) is a process of tracking changes in a database and delivering them to consumers in near real-time. A CDC use case is where minimal time latency and data freshness are critical, and also when it is essential to obtain a list of all changes within a data source.

One way CDC can be implemented is with a delivery from the database to the message broker. All database updates are tracked and sent to the message broker, and consumers are connected to the broker and read the incoming messages. Then, changes from the message broker are propagated to the REST catalog.

 
