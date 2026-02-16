For the {{ AF }} cluster to work correctly, your {{ lockbox-name }} secret's name must have this format: `airflow/<artifact_type>/<artifact_ID>`, where:
   * `<artifact_type>`: Decides what data will be stored in the secret. The allowed values are:
     * `connections`: Connections.
     * `variables`: Variables.
     * `config`: Configuration data.
   * `<artifact_ID>`: ID to use to access the artifact in {{ AF }}.