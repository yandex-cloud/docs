# Computing resource configurations

[In {{ ds }} mode](project.md#serverless), once you create a project, it runs with the minimum resource configuration: <q>c1.4</q> (4 vCPUs). You can [modify the configuration](../operations/projects/control-compute-resources.md) while using a notebook. In this case, the state of the interpreter is saved: no variables or computation results are lost.

[In {{ dd }} mode](project.md#dedicated), you can select a configuration from the list of options [allowed in the community](../operations/community/manage-community-config.md).


{% include [configurations](../../_includes/datasphere/migration/configurations.md) %}

#### See also

* [{#T}](../operations/projects/control-compute-resources.md)
* [{#T}](../../compute/concepts/performance-levels.md)
* [{#T}](../../compute/concepts/gpus.md)