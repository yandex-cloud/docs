# CLI troubleshooting

If an error occurs during the operation, the CLI displays the corresponding message.

### Sample error message {#sample}

```
yc compute instance create --name my-inst3 --metadata user-data="#ps1\nnet user Administrator Passw0rd" --zone {{ region-id }}-a --public-ip --create-boot-disk image-folder-id=standard-images,image-name=windows-2016-gvlk-153
7967224
ERROR: rpc error: code = ResourceExhausted desc = The limit on maximum number of instances has exceeded.


server-request-id: 9d42710c-4a14-4561-a491-1f3bf76dbaaa
client-request-id: e69f4463-b9de-45bc-89b3-4db6e4d1bae6
client-trace-id: ddd8c763-81a3-4c58-9a7d-445257b59aee

Use server-request-id, client-request-id, client-trace-id for investigation of issues in cloud support
If you are going to ask for help of cloud support, please send the following trace file: C:\Users\username\yandex-cloud\logs\yc_compute_instance_create-2019-02-18T12-26-39.897.txt
```

### What should I do? {#what-to-do}

To help our support team solve your problem faster, use the error message to:

1. Copy all available **IDs**. In the given example, these are `server-request-id`, `client-request-id`, and `client-trace-id`.
1. Copy the **trace file** that was saved to your PC. See the path to the trace file at the end of the error message.
   In the given example, it is:
   ```
   C:\Users\username\yandex-cloud\logs\yc_compute_instance_create-2019-02-18T12-26-39.897.txt
   ```
1. Provide this information to the [technical support team]({{ link-console-support }}).

