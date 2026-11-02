* `security_group_ids`: List of [security group](../../../../managed-airflow/concepts/network.md#security-groups) IDs.
* `webserver`, `scheduler`, `worker`, `triggerer`, `dag_processor`: {{ maf-name }} [component](../../../../managed-airflow/concepts/index.md#components) configuration:

    * `count`: Number of instances in the cluster for the web server, scheduler, DAG processor, and Triggerer.
    * `min_count`, `max_count`: Minimum and maximum number of instances in the cluster for the worker.
    * `resource_preset_id`: ID of the computing resources of the web server, scheduler, DAG processor, worker, and Triggerer. Its possible values are:

        * `c1-m2`: 1 vCPU, 2 GB RAM
        * `c1-m4`: 1 vCPU, 4 GB RAM
        * `c2-m4`: 2 vCPUs, 4 GB RAM
        * `c2-m8`: 2 vCPUs, 8 GB RAM
        * `c4-m8`: 4 vCPUs, 8 GB RAM
        * `c4-m16`: 4 vCPUs, 16 GB RAM
        * `c8-m16`: 8 vCPUs, 16 GB RAM
        * `c8-m32`: 8 vCPUs, 32 GB RAM
    
    {% include notitle [dag-processor](../dag-processor.md) %}

* `deb_packages`, `pip_packages`: Lists of deb and pip packages enabling you to install additional libraries and applications in the cluster for running DAG files:

    You can set version restrictions for the installed packages, e.g.:

    ```hcl
    pip_packages = ["pandas==2.0.2","scikit-learn>=1.0.0","clickhouse-driver~=0.2.0"]
    ```

    The package name format and version are defined by the install command: `pip install` for pip packages and `apt install` for deb packages.

* `code_sync`: Type and properties of the DAG file [source](../../../../managed-airflow/concepts/dag-sources.md).

  * `s3.bucket`: Bucket name.

  * `git_sync`: Git repository connection settings. General settings for both authentication methods:

    * `branch`: Repository branch name, e.g., `main`.
    * `sub_path`: Path to the directory with DAG files relative to the repository, in `/<path-to-DAG-files>` format.

    Other settings depend on the authentication method. Select one of the connection methods:

    {% list tabs %}

    - SSH key

        To connect over SSH, specify:

        * `repo`: Repository address in `git@<host>:<path_to_repository>.git` format.
        * `ssh_key`: Private SSH repository access key, single-line with new line characters `\n`, or the key file contents retrieved using the `file()` function.

        For example, to connect using a key from a file, specify the following:

        ```hcl
        code_sync = {
          git_sync = {
            repo     = "git@github.com:<username>/<repository_name>.git"
            branch   = "main"
            sub_path = "/dags"
            ssh_key  = file("<path_to_key_file>")
          }
        }
        ```

        {% include [git-sync-ssh](../note-git-sync-ssh.md) %}

    - Login and password

        To connect over HTTP(S), specify:

        * `repo`: Repository address in `https://<host>/<path_to_repository>.git` or `http://<host>/<path_to_repository>.git` format.
        * `username`: Username. When using a token, the value depends on the [service and the token type](../../../../managed-airflow/concepts/dag-sources.md#git-token).
        * `password`: Password or access token.

        For example, to connect over HTTPS using a token from a file, specify the following:

        ```hcl
        code_sync = {
          git_sync = {
            repo     = "https://github.com/<username>/<repository_name>.git"
            branch   = "main"
            sub_path = "/dags"
            username = "<username>"
            password = file("<path_to_token_file>")
          }
        }
        ```

    {% endlist %}

    {% include [warn-git](../note-git-sync-network.md) %}

  Specify either `s3` or `git_sync`.

* `maintenance_window`: [Maintenance window](../../../../managed-airflow/concepts/maintenance.md) settings, including for stopped clusters:

    * `type`: Maintenance type. The possible values include:
        * `ANYTIME`: Any time.
        * `WEEKLY`: On a schedule.
    * `day`: Day of week for the `WEEKLY` type, i.e., `MON`, `TUE`, `WED`, `THU`, `FRI`, `SAT`, or `SUN`.
    * `hour`: UTC hour interval for the `WEEKLY` type, from `1` to `24`.

      > For example, `1` stands for the interval from `00:00` to `01:00`, and `5`, from `04:00` to `05:00`.

* `deletion_protection`: Enables cluster protection against accidental deletion. The possible values are `true` or `false`.

    Even with deletion protection on, one can still connect to the cluster manually and delete it.

* `lockbox_secrets_backend.enabled`: Enables using secrets in [{{ lockbox-full-name }}](../../../../lockbox/concepts/index.md) to [store {{ AF }} configuration data, variables, and connection parameters](../../../../managed-airflow/concepts/impersonation.md#lockbox-integration). The possible values are `true` or `false`.
* `airflow_config`: [{{ AF }}](https://airflow.apache.org/docs/apache-airflow/2.2.4/configurations-ref.html) additional properties, e.g., `core` for configuration section, `load_examples` for key, and `False` for value.
* `logging`: Logging parameters:

    * `enabled`: Enables logging. Logs generated by {{ AF }} components will be sent to {{ cloud-logging-full-name }}. The possible values are `true` or `false`.
    * `folder_id`: Folder ID. Logs will be written to the default [log group](../../../../logging/concepts/log-group.md) for this folder.
    * `log_group_id`: Custom log group ID. Logs will be written to this group.

      Specify one of the two parameters: `folder_id` or `log_group_id`.

    * `min_level`: Minimum logging level. Possible values: `TRACE`, `DEBUG`, `INFO` (default), `WARN`, `ERROR`, and `FATAL`.
