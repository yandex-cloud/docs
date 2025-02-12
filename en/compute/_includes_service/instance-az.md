When creating a VM, you can select a {{ yandex-cloud }} [availability zone](../../overview/concepts/geo-scope.md) to place it in.

To move a VM to a different availability zone, use a special [CLI](../../cli/cli-ref/compute/cli-ref/instance/relocate.md) command or create a VM copy in the destination availability zone and then delete the source VM.