# GRPC_JSON

Type of test data for the Pandora load generator. It supports gRPC requests.

The test data type is specified when [creating a test](../../operations/create-test-bucket.md#create-test).

Data format:

```
{"tag": "/Add", "call": "api.Adder.Add", "metadata": {"Authorization": "Bearer $YC_TOKEN"}, "payload": {"x": 21, "y": 12}}
{"tag": "/Add", "call": "api.Adder.Add", "metadata": {"Authorization": "Bearer $YC_TOKEN"}, "payload": {"x": 22, "y": 13}}
{"tag": "/Add", "call": "api.Adder.Add", "metadata": {"Authorization": "Bearer $YC_TOKEN"}, "payload": {"x": 23, "y": 14}}
```
Where:
* `tag`: Request label used in the results display interface. It enables using different tags for requests to group and filter test results.
* `call`: Service and its method being called.
* `metadata`: It is used to send headers, e.g., `Authorization`.
* `payload`: Request body.


When configuring the Pandora load generator using a YAML file, specify the `grpc/json` type in the `ammo` section:

```
pandora:
  enabled: true
  config_content:
    pools:
      - id: Custom
        gun:
          type: grpc
          target: 'test.hostname:80'
        ammo:
          type: grpc/json
          file: ./ammo.json
        result:
          type: phout
          destination: ./phout.log
        rps:
          - duration: 8m
            from: 1
            to: 700
            type: line
        startup:
          - type: once
            times: 8000
    log:
      level: debug
    monitoring:
      expvar:
        enabled: true
        port: 1234
```

When uploading a file with test data via the management console, data types and paths are filled in automatically.