One resource unit is designed for the following maximum indicator values:

* 1000 requests per second (RPS).
* 4000 concurrently active connections.
* 300 new connections per second.
* 22 MB (176 Mbit) of traffic per second.

A group of resource units is automatically scaled depending on the external load on the load balancer nodes. The group size is calculated so that the load per unit does not exceed the threshold values.