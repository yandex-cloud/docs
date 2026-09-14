{% note alert %}

If a bucket is registered in an {{ OS }} cluster as a snapshot repository, do not edit the bucket contents manually as this will disrupt the {{ OS }} snapshot mechanism.

{% endnote %}

1. [Connect](../../managed-opensearch/operations/connect/index.md) to the cluster.
1. Register the bucket as a snapshot repository using the public [{{ OS }} API]({{ os.docs }}/opensearch/snapshot-restore/#register-repository):

    ```http
    PUT --cacert ~/.opensearch/root.crt https://admin:<password>@<ID_of_{{ OS }}_host_with_DATA_role>.{{ dns-zone }}:{{ port-mos }}/_snapshot/<repository_name>
    ```

    In the request parameters, specify the bucket associated with the cluster service account:

    ```bash
    curl --request PUT \
         "https://admin:<password>@<ID_of_{{ OS }}_host_with_DATA_role>.{{ dns-zone }}:{{ port-mos }}/_snapshot/<repository_name>" \
         --cacert ~/.opensearch/root.crt \
         --header "Content-Type: application/json" \
         --data '{
           "type": "s3",
           "settings": {
             "endpoint": "{{ s3-storage-host }}",
             "bucket": "<bucket_name>"
           }
         }'
    ```
