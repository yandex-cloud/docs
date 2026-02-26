You can add connection parameters to the command, if required, for example:
* `tls`: Enables TLS encryption for the connection (`true` or `false`). Encryption is enabled by default.
* `tlsCAFile`: Path to the `.pem` file with root certificates from the CA.
* `readPreference`: Hosts to read from:
  * `primary`: Only the primary replica (master).
  * `primaryPreferred`: Master or secondary replicas if the master is unavailable.
  * `secondary`: Only secondary replicas.
  * `secondaryPreferred`: Secondary replicas or the master if there are no secondary replicas.
  * `nearest`: Least lagging host.
* `authSource`: Name of the database storing the user credentials. By default, it is the same as `<DB_name>`.
* `appName`: App name to display in logs.

For more information about available connection parameters, see [this reference](https://mongodb.prakticum-team.ru/docs/manual/reference/connection-string-options/).

The parameter string begins with the `?` character, and `&` is the separator.
