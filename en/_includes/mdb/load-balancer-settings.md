* **Lag**: Maximum replica lag, in seconds. If this lag is exceeded, the replica will not be included in balancing.
* **Balancing policy**:
    * `Round Robin`: Selects a replica according to the [Round-Robin](https://en.wikipedia.org/wiki/Round-robin_scheduling) policy.
    * `Least connections`: Selects the replica with the fewest connections.
