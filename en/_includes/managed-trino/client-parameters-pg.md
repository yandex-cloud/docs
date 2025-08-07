{% cut "Available parameters" %}

* `ApplicationName`: Name of the application using the connection.
* `defaultRowFetchSize`: Number of rows fetched in `ResultSet` per database query. The default value is `0` (all rows are fetched at once). Limit the number of rows to avoid unnecessary memory usage.
* `hostRecheckSeconds`: Time in seconds before rechecking the host status. The default value is `10`.
* `loadBalanceHosts`: Defines how the hosts are connected. The possible values are:

    * `false` (default): Connect hosts in the specified order.
    * `true`: Randomly select hosts from a pool of suitable candidates.

* `maxResultBuffer`: Result buffer size not to exceed when reading the results. You can set the value in one of the two ways:

    * In bytes, e.g., `100`, `200M`, or `2G`.
    * As a percentage of the maximum heap memory, e.g., `10p`, `20pct`, or `50percent`. The value cannot exceed 90% of the maximum heap memory. All larger values will be reduced to this limit.

    By default, `maxResultBuffer` is set to `null`, i.e., there are no limits on reading results.

* `maxSendBufferSize`: Maximum number of bytes to buffer before sending to the server side. The `pgjdbc` driver uses the `least(maxSendBufferSize, greatest(8192, SO_SNDBUF))` function to determine the buffer size.
* `readOnly`: Switches the connection to read-only mode. The default value is `false`.
* `readOnlyMode`: Manages the connection behavior in read-only mode, i.e., if `readOnly = true`. The possible values are:

    * `ignore`: Ignores the `readOnly` parameter.
    * `transaction` (default): If autocommit is `false`, the driver will set the transaction to read only by sending `BEGIN READ ONLY`.
    * `always`: If autocommit is `true`, the session will be set to read only. If autocommit is `false`, the driver will set the transaction to read only by sending `BEGIN READ ONLY`.

* `receiveBufferSize`: Socket read buffer size (`SO_RCVBUF`) in bytes. The default value is `-1`, unlimited.
* `sendBufferSize`: Socket write buffer size (`SO_SNDBUF`) in bytes. The default value is `-1`, unlimited.
* `targetServerType`: Defines which server type to connect to. The possible values are `any` (default), `master`, `primary`, `slave`, `secondary`, `preferSlave`, `preferSecondary`, and `preferPrimary`. We do not recommend using the `master`, `slave`, and `preferSlave` values, as they have been deprecated and replaced with `primary`, `secondary`, and `preferSecondary`, respectively.

{% endcut %}
