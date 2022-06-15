The load balancer consumption is measured in _resource units_. One resource unit includes:

* 1000 requests per second (RPS).
* 4000 concurrently active connections.
* 200 new connections per second.
* 22 MB (176 Mbit) of traffic per second.

The amount of load balancer's resource units consumed per hour is calculated based on the indicator demonstrating the highest consumption rate compared to the threshold. Calculated values of resource units are rounded up to an integer.

The number of resource units is calculated separately for each availability zone. The minimum number of units per hour per zone is 2. The load balancer usage isn't charged in the availability zones where the inbound traffic is disabled.

When calculating the number of resource units, hourly maximums for indicators are used.