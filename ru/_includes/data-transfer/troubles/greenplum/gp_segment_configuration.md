### Как узнать количество сегментов в кластере? {#gp_segment_configuration}

Вы можете узнать количество сегментов:

* В [консоли управления]({{ link-console-main }}). Для этого откройте нужный кластер и перейдите на вкладку ![hosts.svg](../../../../_assets/console-icons/cube.svg) **{{ ui-key.yacloud.mdb.cluster.hosts.label_title }}**.

* При помощи SQL-запроса:

  ```pgsql
  SELECT COUNT(*) FROM gp_segment_configuration WHERE role='p' AND content >= 0;
  ```