Go to the folder hosting the {{ yandex-cloud }} API repository, create a folder named `upload_data`, and generate the client interface code in it. Then open the `upload_data` folder:

{% list tabs group=programming_language %}

- Bash {#bash}

   ```bash
   cd <path_to_cloudapi_directory> && \
   mkdir upload_data && \
   python3 -m grpc_tools.protoc -I . -I third_party/googleapis \
        --python_out=./upload_data/ \
        --grpc_python_out=./upload_data/ \
        google/api/http.proto \
        google/api/annotations.proto \
        yandex/cloud/api/operation.proto \
        google/rpc/status.proto \
        yandex/cloud/operation/operation.proto \
        yandex/cloud/validation.proto \
        yandex/cloud/speechsense/v1/*.proto \
        yandex/cloud/speechsense/v1/*/*.proto
   cd upload_data
   ```

{% endlist %}
