# Agent

An _agent_ is a VM that provides computing resources to generate load on the target application. This load comes as preset test data, such as requests, parameters, or scripts.

Note that, during load generation, you need to monitor the agent system resources, such as vCPUs, memory, disks, and network. If you run out of any resource, you will not be able to generate load and measure responses in an appropriate way. 

{% note info %}

Agents automatically clean up disk space. By default, an agent cleans up 2 GB of space. You can use the [Resource Check plugin's](resource-check.md) `disk_limit` parameter to manage the amount of cleaned up space.

{% endnote %}

All agents have a load testing tool on board; they also have a connector that enables this tool to work with {{ load-testing-name }}.

## Agent performance {#benchmark}

{{ load-testing-name }} supports three types of agents:

* **Small: 2 vCPUs, 2GB RAM, 15GB HDD**: In simple use cases, such an agent allows you to generate a load of more than 10,000 requests per second with both Phantom and Pandora. This type of agent is suitable for most load tests. If you do not need to emulate a very large request flow or special conditions (such as creating a large number of concurrent connections), you are unlikely to look any further.
* **Medium: 4 vCPUs, 4GB RAM, 30GB HDD**: Allows you to establish a larger number of concurrent connections and generate a load of more than 20,000 requests per second. This type is suitable for more complex tests. You may want to choose it if the **small** type is not enough. With a larger storage capacity, a **medium** agent allows you to establish more connections or run longer tests. 
* **Large: 8 vCPUs, 8GB RAM, 60GB HDD**: Generates up to 40,000 requests per second. Use **large** agents for long tests with a large number of concurrent connections.

Specific load metrics highly depend on the test configuration. For example, you can generate more requests with the `Connection: Keep-Alive` header than with `Connection: Close`, long responses reduce the maximum possible number of requests per second, etc.

If the **large** agent type is not powerful enough to meet your needs, contact [support](../../support/overview.md).

