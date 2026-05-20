* **Cluster**: Traffic is routed to different {{ k8s }} nodes (default). As a result, traffic is distributed evenly; however, there are certain drawbacks:

   * The packet may come to one node's proxy and get rerouted to another node leading to delays in performing operations and sending packets.
   * The pod that receives the packet sees the IP address of the proxying node rather than the one of the client. As a result, the client IP address is not preserved.

* **Local**: Traffic is proxied and distributed across pods on the same node. The traffic is routed to the node via the port specified in the service of the [LoadBalancer or NodePort type](https://kubernetes.io/docs/concepts/services-networking/service/#publishing-services-service-types).

   The traffic comes to a specific node, so it is distributed unevenly across nodes; however, the client IP address is preserved.

For more information about policies for external traffic management, see [this {{ k8s }} guide](https://kubernetes.io/docs/reference/networking/virtual-ips/#external-traffic-policy).
