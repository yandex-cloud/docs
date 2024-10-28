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
  1. [In the settings of the created namespace](../operations/update-name-space.md) copy its ID.
  1. Use the POST API method to upload and register the schema for a subject. Provide the following in the request: 
     
      * `subject`: Subject name for uploading schemas.
      * `subject`: Name of the schema you want to upload to the specified subject.
      * `schemaType`: Schema type: [Avro](https://avro.apache.org/), [JSON Schema](https://json-schema.org/), or [Protobuf](https://protobuf.dev/).

      
     ```bash
      curl \
        --request POST "https://<namespace_ID>.schema-registry.yandexcloud.net/v1/namespace"\
        --header "accept: application/json" \
        --header "Authorization: <token>" \
        --header "Content-Type: application/json" \
        --data "{
         \ "schema": "{
             \"type": <type>, 
             \"name": "<schema_name>, 
             \"fields":[schema_fields]}
            }' \
        $<namespace_ID>/subjects/<subject_name>/versions
        {"id":1}
      ```
{% endlist %}

## What's next {what-is-next}

After you create a namespace and register a schema:
1. [Add schemas to the subject](../operations/add-schema.md).
1. [Compare schema versions](../operations/compare-schemas.md).
