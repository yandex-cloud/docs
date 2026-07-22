Where:

* `--name`: Cluster name.
* `--description`: Cluster description.
* `--airflow-version`: [{{ AF }} version](../../../../managed-airflow/concepts/versions.md).
* `--python-version`: Python version.
* `--labels`: List of labels. Provide labels in `<key>=<value>` format.
* `--admin-password`: Admin user password. The password must be not less than 8 characters long and contain at least:

    * One uppercase letter.
    * One lowercase letter.
    * One number.
    * One special character.

* `--service-account-id`: Service account ID.