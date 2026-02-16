To ensure that only an {{ AF }} cluster can connect to your resources, create separate subnets for the cluster and do not host any other resources in those subnets.

Make sure your subnets meet the following requirements:

* For each subnet in the cluster network (including those not assigned to the cluster), the IP address range does not overlap with that of the {{ airflow-service-address }} auxiliary subnet.
* The IP address range of each cluster subnet includes at least `2 × N` vacant addresses, where `N` is the total number of instances of all [components](../../../managed-airflow/concepts/index.md#components): web server, scheduler, workers, and triggerer service.

For more information, see [{#T}](../../../managed-airflow/concepts/network.md#subnet-requirements).
