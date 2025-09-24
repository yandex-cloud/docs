### How do I find out the number of segments in a cluster? {#gp_segment_configuration}

You can find out the number of segments:

* In the [management console]({{ link-console-main }}). To do this, open the cluster you need and go to the ![hosts.svg](../../../../_assets/console-icons/cube.svg) **{{ ui-key.yacloud.mdb.cluster.hosts.label_title }}** tab.

* Using this SQL query:

  ```pgsql
  SELECT COUNT(*) FROM gp_segment_configuration WHERE role='p' AND content >= 0;
  ```