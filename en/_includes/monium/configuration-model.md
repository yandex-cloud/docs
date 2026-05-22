* _Project_: Top-level logical entity. You can use projects to aggregate telemetry from associated applications and microservices and restrict data access for development teams. Some examples include an online store, billing system, or security services.

* _Cluster_: Allows you to isolate an environment or independent service installations, e.g., production and test clusters, clusters in different regions.

* _Service_: Standalone client application generating telemetry data. This may be a microservice or its component, e.g., Nginx, Envoy, or {{ compute-name }} VM instance.

* _Shard_: Container for data of a specific _service-cluster_ pair and data storage settings, e.g., [TTL](https://en.wikipedia.org/wiki/Time_to_live).

The project, cluster, and service objects define the data source, and the shard defines the storage rules.