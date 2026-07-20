{% note warning %}

For the boot disk of the auxiliary VM, use an operating system image different from the one installed on the VM you are recovering. For example, if the VM you are recovering runs Ubuntu 22.04, use Ubuntu 20.04, Ubuntu 24.04 or another distribution for the auxiliary VM. Otherwise, due to matching file system UUIDs, the auxiliary VM may boot from the attached disk of the VM being recovered instead of its own one.

{% endnote %}
