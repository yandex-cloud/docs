If necessary, make your VM [preemptible](../../compute/concepts/preemptible-vm.md).

When creating a preemptible instance group, keep in mind that the virtual machines will terminate after 24 hours of continuous operation or earlier. It's possible that {{ ig-name }} won't be able to restart them immediately due to insufficient resources. This may occur in the event of a drastic increase of the computing resource utilization in {{ yandex-cloud }}.

