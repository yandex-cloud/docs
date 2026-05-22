Get a list of API keys for a specific service account by entering the service account name:

```bash
yc iam api-key list \
  --service-account-name <service_account_name>
```

Result:

```text
+----------------------+---------------------+--------------+--------------------------------+--------------------------------+------------+------------+
|          ID          |     CREATED AT      | LAST USED AT |             SCOPE              |             SCOPES             | EXPIRES AT | MASKED KEY |
+----------------------+---------------------+--------------+--------------------------------+--------------------------------+------------+------------+
| aje5qvnhl67v******** | 2025-09-16 16:56:01 |              | yc.ai.foundationModels.execute | yc.ai.foundationModels.execute |            | ****rCG02w |
| aje8be90datc******** | 2025-08-21 19:33:45 |              | yc.ai.foundationModels.execute | yc.ai.foundationModels.execute |            | ****u9hGKi |
| aje1lmv2ipu3******** | 2025-09-16 16:56:25 |              | yc.ai.imageGeneration.execute  | yc.ai.imageGeneration.execute  |            | ****S5ejQ8 |
+----------------------+---------------------+--------------+--------------------------------+--------------------------------+------------+------------+
```

The `MASKED KEY` field shows the last six characters of the key’s secret part to help you [identify the key](../../iam/concepts/authorization/api-key.md#identify-key).

The folder specified in the CLI profile is used by default to search for the service account. You can specify a different folder using the `--folder-name` or `--folder-id` parameter.