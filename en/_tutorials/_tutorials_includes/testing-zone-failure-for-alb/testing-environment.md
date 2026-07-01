1. Alignment with production environment:

    {% note warning %}

    We do not recommend using your production environment for testing; do a test environment exercise first.

    {% endnote %}

    * We recommend making your test environment closely similar to the production environment in terms of configuration.
    * The test load should resemble the production workload. Use an appropriate load testing tool to simulate the production load.
    * We recommend using [Infrastructure as Code](https://yandex.cloud/ru/blog/cloud-control-tools#iac) to automate the setup of test environments.

1. Follow these best practices to optimize costs when deploying resources in the test environment:
    * Use NRD disks instead of [SSD-IO](../../../compute/concepts/disk.md#disks-types).
    * Use [preemptible VMs](../../../compute/concepts/preemptible-vm.md).
    * Create your resources dynamically only for the duration of the test.
    * Free up resources automatically after the tests are over.
    * Use components without SLA to reduce costs.
