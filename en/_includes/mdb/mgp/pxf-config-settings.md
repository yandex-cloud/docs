* `connection_timeout`: Timeout for connection to the Apache Tomcat® server when making read requests, in seconds. The values may range from `5` to `600`.
* `upload_timeout`: Timeout for connection to the Apache Tomcat® server when making write requests, in seconds. The values may range from `5` to `600`.
* `max_threads`: Maximum number of the Apache Tomcat® threads. The values may range from `1` to `1024`.

   To prevent situations when requests get stuck or fail due to running out of memory or malfunctioning of the Java garbage collector, specify the number of the Apache Tomcat® threads. See more information on how to adjust the number of threads in the [VMware {{ GP }} Platform Extension Framework]({{ gp.docs.vmware }}-Platform-Extension-Framework/6.9/greenplum-platform-extension-framework/cfg_mem.html) documentation.

* `pool_allow_core_thread_timeout`: Determines whether a timeout for core streaming threads is permitted or not. The default value is `false`.
* `pool_core_size`: Number of core streaming threads per pool. The parameter takes positive integer values.
* `pool_queue_capacity`: Maximum number of requests you can add to a pool queue for core streaming threads. The values may range from zero upward. If `0`, no pool queue is generated.
* `pool_max_size`: Maximum allowed number of core streaming threads. The values may range from `1` to `1024`.
* `xmx`: Initial size of the JVM heap for the PXF daemon. The values may range from `64` to `16384`.
* `xms`: Maximum size of the JVM heap for the PXF daemon. The values may range from `64` to `16384`.
