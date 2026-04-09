Использование пулов резервов ВМ _не поддерживается_ для групп узлов со следующими параметрами:
* с [автоматическим масштабированием](../../managed-kubernetes/concepts/node-group/cluster-autoscaler.md);
* c [уровнем производительности vCPU](../../compute/concepts/performance-levels.md) менее 100%;
* c [прерываемыми ВМ](../../compute/concepts/preemptible-vm.md);
* с использованием [групп размещения ВМ](../../compute/concepts/placement-groups.md).