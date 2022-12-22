
# Yandex Vault (YAV)

ChartEditor enables you to work with secrets from [Yandex Vault](https://yav.yandex-team.ru/).

## How to link a secret to the chart {#how-to-link-secret}

- In the control panel, click the ![keychain](../../_assets/datalens/internal/editor/secret-keys.png) icon
- Under "Secrects", click  "Add secret"
- You'll see a list of secrets available in [Yandex Vault](https://yav.yandex-team.ru/)
- Select a secret
- Add the secret key and alias

[From your code,](#access-to-secrets) you'll access secrets by aliases: be sure that the alias has a unique name.

All the secrets that you add are taken from the latest secret version in [Yandex Vault](https://yav.yandex-team.ru/).

## Access rights for a chart with secrets in the context of security {#permissions}

For security reasons, you can run scripts in ChartEditor if you have the "Edit" access or higher.
This rule doesn't apply to a chart in a dashboard or other places because they use a published chart.

If you grant the "Edit" access or higher to your users, you actually disclose your secrets to them.

Trying to output the secret data to `console.log` results in a random string `sec-fe523b7330-ret`. This is to avoid writing secrets to the chart logs accidentally. 

## Accessing secrets from code {#access-to-secrets}

To get secrets from the code, use the method `ChartEditor.getSecrets()`. It returns an object with secrets, where the object's keys are the aliases that you added and values are the actual secret values.

Imagine that you added a secret with the `clickhouse` alias.

```js
const secrets = ChartEditor.getSecrets();
const clickhouseSecret = secrets['clickhouse'];
```


