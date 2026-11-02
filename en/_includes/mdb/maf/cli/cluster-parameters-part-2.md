* `--security-group-ids`: List of [security group](../../../../managed-airflow/concepts/network.md#security-groups) IDs.
* `--webserver`, `--scheduler`, `--worker`, `--triggerer`, `--dag-processor`: {{ maf-name }} [component](../../../../managed-airflow/concepts/index.md#components) configuration:

    * `count`: Number of instances in the cluster for the web server, scheduler, DAG processor, and Triggerer.
    * `min-count`, `max-count`: Minimum and maximum number of instances in the cluster for the worker.
    * `resource-preset-id`: [ID of the computing resources](../../../../managed-airflow/concepts/instance-types.md) of the web server, scheduler, DAG processor, worker, and Triggerer. Its possible values are:

        * `c1-m2`: 1 vCPU, 2 GB RAM
        * `c1-m4`: 1 vCPU, 4 GB RAM
        * `c2-m4`: 2 vCPUs, 4 GB RAM
        * `c2-m8`: 2 vCPUs, 8 GB RAM
        * `c4-m8`: 4 vCPUs, 8 GB RAM
        * `c4-m16`: 4 vCPUs, 16 GB RAM
        * `c8-m16`: 8 vCPUs, 16 GB RAM
        * `c8-m32`: 8 vCPUs, 32 GB RAM

    {% include notitle [dag-processor](../dag-processor.md) %}

* `--deb-packages`, `--pip-packages`: Lists of deb and pip packages enabling you to install additional libraries and applications in the cluster for running DAG files:

    You can set version restrictions for the installed packages, e.g.:

    ```hcl
    --pip-packages "pandas==2.0.2,scikit-learn>=1.0.0,clickhouse-driver~=0.2.0"
    ```

    The package name format and version are defined by the install command: `pip install` for pip packages and `apt install` for deb packages.

* DAG file [source](../../../../managed-airflow/concepts/dag-sources.md) type and parameters:

    * `--dags-bucket`: Bucket name.

    * `--gitsync`: Git repository connection parameters. General parameters for both authentication methods:

      * `branch`: Repository branch name, e.g., `main`.
      * `subpath`: Path to the directory with DAG files relative to the repository, in `/<path-to-DAG-files>` format.

      Other settings depend on the authentication method. Select one of the connection methods:

      {% list tabs %}

      - SSH key

          To connect over SSH, specify:

          * `repo`: Repository address in `git@<host>:<path_to_repository>.git` format.
          * One of the parameters with a private SSH key:

              * `ssh-key`: Key content in a single line with newline characters `\n`.
              * `ssh-key-path`: Path to the key file.

          For example, to connect using a key from a file, provide the following:

          ```bash
          --gitsync repo=git@github.com:<username>/<repository_name>.git,`
                    `branch=main,`
                    `subpath=/dags,`
                    `ssh-key-path=<path_to_key_file>
          ```

          {% include [git-sync-ssh](../note-git-sync-ssh.md) %}

      - Username and password

          To connect over HTTP(S), specify:

          * `repo`: Repository address in `https://<host>/<path_to_repository>.git` or `http://<host>/<path_to_repository>.git` format.
          * `username`: Username. When using a token, the value depends on the [service and the token type](../../../../managed-airflow/concepts/dag-sources.md#git-token).
          * One of the parameters with a password or access token:

              * `password`: Password or token.
              * `password-path`: Path to the file containing the password or token. Use this parameter if the password or token contains the `,`, `{`, `}`, `[`, or `]` characters.

          For example, to connect over HTTPS using a token from a file, provide the following:

          ```bash
          --gitsync repo=https://github.com/<username>/<repository_name>.git,`
                    `branch=main,`
                    `subpath=/dags,`
                    `username=<username>,`
                    `password-path=<path_to_token_file>
          ```

      {% endlist %}

      {% include [warn-git](../note-git-sync-network.md) %}

    Specify either `--dags-bucket` or `--gitsync`.

* `--maintenance-window`: [Maintenance window](../../../../managed-airflow/concepts/maintenance.md) settings that apply to both running and stopped clusters. The `type` setting defines the maintenance type:

    {% include [maintenance-window](../../../../_includes/mdb/cli/maintenance-window-description.md) %}

* `--deletion-protection`: Enables cluster protection against accidental deletion.

    Even with deletion protection on, one can still connect to the cluster manually and delete it.

* `--lockbox-secrets-backend`: Enables using secrets in [{{ lockbox-full-name }}](../../../../lockbox/concepts/index.md) to [store {{ AF }} configuration data, variables, and connection parameters](../../../../managed-airflow/concepts/impersonation.md#lockbox-integration).
* `--airflow-config`: [{{ AF }}](https://airflow.apache.org/docs/apache-airflow/2.2.4/configurations-ref.html) additional properties. Provide them in `<configuration_section>.<key>=<value>` format, such as the following:

    ```bash
    --airflow-config core.load_examples=False
    ```

* Logging parameters:

    * `--log-enabled`: Enables logging. Logs generated by {{ AF }} components will be sent to {{ cloud-logging-full-name }}.
    * `--log-folder-id`: Folder ID. Logs will be written to the default [log group](../../../../logging/concepts/log-group.md) for this folder.
    * `--log-group-id`: Custom log group ID. Logs will be written to this group.

        Specify one of the two parameters: `--log-folder-id` or `--log-group-id`.

    * `--log-min-level`: Minimum logging level. Possible values: `TRACE`, `DEBUG`, `INFO` (default), `WARN`, `ERROR`, and `FATAL`.
