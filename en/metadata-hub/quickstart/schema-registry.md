# Getting started with {{ schema-registry-name }}

Manage schema versions with {{ schema-registry-name }}.



{% include notitle [preview](../../_includes/note-preview.md) %}




## Create a namespace {#create-namespace}

{% list tabs group=instructions %}

- Management console {#console}

  {% include [new namespace](../../_includes/metadata-hub/create-name-space.md) %}


{% endlist %}

## Upload a schema to a subject {#add-schema}

{% list tabs group=instructions %}

- Management console {#console}

  {% include [load schema](../../_includes/metadata-hub/add-subject.md) %}

- API {#api}

  
  1. Install [cURL](https://curl.haxx.se).
  1. [Log in](../api-ref/authentication.md) to perform operations in the API.
  1. [In the new namespace settings](../operations/update-name-space.md), copy its ID.
  1. Use the POST API method to upload and register the schema for a subject. Provide the following in the request: 
     
      * `schemaType`: Data format: [PROTOBUF](https://protobuf.dev/), [AVRO](https://avro.apache.org/), or [JSON](https://json-schema.org/). If `schemaType` is not specified, it defaults to `AVRO`.
      * `schema.type`: Data type, e.g., `record`.
      * `schema.name`: Name of the schema to upload to the subject.
      * `schema.fields`: Schema fields. Example: `[{\"name\": \"age\", \"type\": \"int\"}]`.
      * Namespace ID.
      * Name of the subject to upload your schema to.

      Request format:

            
      ```bash
      curl \
        --request POST \
        --header "accept: application/json" \
        --header "Authorization: <token>" \
        --header "Content-Type: application/json" \
        --data '{
           "schemaType": "<data_format>",
           "schema": '{
             \"type\": \"<data_type>\", 
             \"name\": \"<schema_name>\", 
             \"fields\":[schema_fields]}
            }' \
        https://<namespace_ID>.schema-registry.yandexcloud.net/subjects/<subject_name>/versions
      ```

      A successful request will return a unique schema ID, e.g., `{"id":1}`.

      For examples of requests, see [this Confluent article](https://docs.confluent.io/platform/current/schema-registry/develop/api.html#post--subjects-(string-%20subject)-versions).

{% endlist %}

## What's next {what-is-next}

After you create a namespace and register a schema:
1. [Connect to the namespace](../operations/connect-to-namespace.md).
1. [Add schemas to the subject](../operations/add-schema.md).
1. [Compare schema versions](../operations/compare-schemas.md).
