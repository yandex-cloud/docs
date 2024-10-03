# How to determine the speed of data upload and download


## Scenario description {#case-description}

You need to know the data upload and download speed, as well as the service limitations.

## Solution {#case-resolution}

{{ objstorage-full-name }} has internal SLAs and SLOs for speed of data delivery to the client, which also depend on the storage class.

{{ objstorage-full-name }} response time depends on the following factors:

- Client-side performance (network speed, CPU, or disk subsystem load).
- Speed of backbone connections, connections between data centers, or between the client and server.
- Service performance.

For more details, see the [documentation](../../../storage/qa#qa-timings).

Data storages vary in prices on storage time and operations. For more information about the pricing, see the [documentation](../../../storage/pricing).

