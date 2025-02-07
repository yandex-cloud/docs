# Resource Check

_Resource Check_ is a plugin you configure when creating a test. It monitors if the test agent has free system resources.

Resource Check controls the amount of available RAM and disk space before and during testing. If there is not enough RAM or disk space to run a new test, it will not start.

`rcheck` section format in the `yaml` test configuration file:

```yaml
rcheck:
  enabled: true
  package: yandextank.plugins.ResourceCheck
  disk_limit: 2048
  interval: 10s
  mem_limit: 512
```

Where:
* `disk_limit`: Minimum amount of free disk space, MB. The default value is 2 GB.
* `interval`: Resource check interval. The default value is ten seconds.
* `mem_limit`: Minimum amount of free RAM, MB. The default value is 512 MB.

{% note info %}

The `disk_limit` parameter also sets the amount of disk space to free up during the automatic cleanup. The auto cleanup is performed before starting a test. It removes temporary files, downloaded data cache, and old tests.

{% endnote %}