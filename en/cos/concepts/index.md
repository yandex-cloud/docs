# A {{ coi }}

_{{ coi }}_ is a VM [image](../../compute/concepts/image.md) optimized for running {% if lang == "ru" %}[Docker containers](https://cloud.yandex.ru/blog/posts/2022/03/docker-containers){% else %}Docker containers{% endif %}. The image includes Ubuntu LTS, Docker, and a daemon for launching Docker containers.

It's integrated with the {{ yandex-cloud }} platform, which lets you:
* Run a Docker container immediately after the VM is created from the management console or YC CLI.
* Update running Docker containers with minimum downtime.
* Access Docker container open network ports without any additional settings.

For more information about working with a {{ coi }}, see [{#T}](../tutorials/vm-create.md).