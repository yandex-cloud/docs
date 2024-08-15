Перейдите в папку с репозиторием API {{ yandex-cloud }}, создайте папку `upload_data`, сгенерируйте в ней код интерфейса клиента и перейдите в папку `upload_data`:

{% list tabs group=programming_language %}

- Bash {#bash}

   ```bash
   cd <путь_к_папке_cloudapi> && \
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
