# Agent

An _agent_ is a VM that provides computing resources to generate load on the target application. Preset test data, such as a set of requests, parameters, or scripts, is used as the payload.

Please note that, during load generation, you need to monitor an agent's system resources: vCPU, memory, disks, and network usage. Correct load generation and accurate response measurements are impossible if you run out of any resource.

A load testing tool and a connector that enables interactions between it and {{ load-testing-name }} are installed on agents.

## Agent performance {#benchmark}

The service supports three types of agents:

* **small: 2 vCPUs, 2GB RAM, 15GB HDD**: In simple use cases, this type lets you generate a load of more than 10000 requests per second with both Phantom and Pandora. This type of agent is suitable for most load tests. If you don't need to emulate a very large request flow or special conditions (such as creating a large number of concurrent connections), choose this type.
* **medium: 4 vCPUs, 4GB RAM, 30GB HDD**: Lets you establish a larger number of concurrent connections and generate a load of more than 20000 requests per second. Suitable for more complex tests. Choose this type of agent if the **small** type is not enough: thanks to its larger storage capacity, a **medium** agent lets you establish more connections or conduct longer tests.
* **large: 8 vCPUs, 8GB RAM, 60GB HDD**: Generates up to 40000 requests per second. Use **large** agents for long tests with a large number of concurrent connections.

Specific load indicators strongly depend on the test configuration. For example, you can generate more requests with the `Connection: Keep-Alive` header than `Connection: Close`. Long responses reduce the maximum possible number of requests per second and so on.

If the **large** agent type is not powerful enough for your tasks, contact [support](../../support/overview.md).

