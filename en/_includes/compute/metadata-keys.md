For users added via metadata:

* After enabling access to a VM via {{ oslogin }}, the keys specified in `user-data` and `ssh-keys` are removed from the metadata.
* After disabling access to a VM via {{ oslogin }}, the removed keys are recreated.