## Getting an OAuth token {#get-oauth}

If you don't have an OAuth token, get one by following this [link](https://oauth.yandex-team.ru/authorize?response_type=token&client_id=09cea1cc285845b7b4dc3f409fcacad9).

Add the received token to the `CHARTS_OAUTH_TOKEN` variable:

```bash
export CHARTS_OAUTH_TOKEN=AQAD-qKSJyAIABAKs8yk1fuH1kIdr1H5k_ccXDX
```

Use the created variable in the request header:

```bash
-H "Authorization: OAuth $CHARTS_OAUTH_TOKEN"
```
