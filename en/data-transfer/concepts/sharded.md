# Sharded copy

{{ data-transfer-name }} can use more than a single execution thread for a transfer. The sharded copy functionality helps significantly increase transfer throughput by using more resources for the transfer.

Scaling capabilities are limited by the nature of the source database and the data being transferred. Some sources do not support sharded copy. The algorithm for distributing data across several execution threads (sharding algorithm) depends on the source. That is why we recommend selecting sharding settings individually for each transfer.

## Settings {#settings}

By default, sharded copy is disabled. To enable sharded copy, you need to specify proper transfer settings.

{% list tabs %}

- Management console

{% if audience != "internal" %}

  * **Runtime environment**

    * **Processes count**: Number of {{ compute-name }} virtual machines involved in a sharded copy. Each virtual machine has dedicated CPU and RAM resources and a dedicated network connection.

    * **Threads count**: Maximum number of execution threads launched in each virtual machine.

{% else %}

  * **Runtime environment**

    * **Processes count**: Number of YT jobs involved in a sharded copy. Each YT job has dedicated CPU and RAM resources and a dedicated network connection.

    * **Threads count**: Maximum number of execution threads launched in each YT job.

{% endif %}

{% endlist %}
