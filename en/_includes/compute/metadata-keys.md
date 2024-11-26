{% note info %}

For users added via metadata:

* After enabling access to a VM via {{ oslogin }}, the keys specified in `user-data` and `ssh-keys` are deleted from the metadata.
* After disabling access to a VM via {{ oslogin }}, the deleted keys are recreated.

{% endnote %}
