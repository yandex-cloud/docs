# How to set `max_execution_time`


## Case description {#case-description}

In {{ mch-short-name }}, the default `max_execution_time` value is 60. You need to change this value.

## Solution {#case-resolution}

Recreate the external table by adding to `LOCATION` (`pxf:connection_string`) `ON ALL` `&query_timeout=3600` to get `pxf:connection_string&query_timeout=3600`.
​
After that, run your query. Its execution timeout should increase.

For more information, see [this guide](https://docs.vmware.com/en/VMware-Greenplum-Platform-Extension-Framework/6.6/greenplum-platform-extension-framework/jdbc_pxf.html) on the official VMware website.

