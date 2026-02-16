# How to determine the speed of data upload and download



## Case description {#case-description}

You need to know the data upload and download speed, as well as the service limitations.

## Solution {#case-resolution}

{{ objstorage-name }} has internal Service Level Agreements (*SLAs*) that guarantee a specific speed of sending data to the customer, which, among other things, depend on the storage class.

{{ objstorage-name }} response time depends on the following factors:

* Client-side performance: network speed, CPU load, or disk subsystem load.
* Speed of trunks, data center interconnects, or client-server connections.
* Service performance.

To learn more, see [this guide](../../../storage/qa.md#qa-timings).

Data storages vary in prices on storage duration and operations. For more information about the pricing, see [this article](../../../storage/pricing.md).