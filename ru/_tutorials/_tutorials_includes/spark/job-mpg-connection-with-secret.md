```python
import json
import os
import urllib.request
from pyspark.sql import SparkSession

def get_secret(secret_id: str) -> dict:
    """Получение секрета из {{ lockbox-name }}."""
    # Получение IAM-токена через metadata service
    metadata_host = os.environ.get("YC_METADATA_ADDR", "169.254.169.254")
    token_url = f"http://{metadata_host}/computeMetadata/v1/instance/service-accounts/default/token"

    req = urllib.request.Request(token_url)
    req.add_header("Metadata-Flavor", "Google")
    with urllib.request.urlopen(req, timeout=10) as resp:
        token = json.loads(resp.read())["access_token"]

    # Получение секрета {{ lockbox-name }}
    secret_url = f"https://payload.lockbox.api.cloud.yandex.net/lockbox/v1/secrets/{secret_id}/payload"
    req = urllib.request.Request(secret_url)
    req.add_header("Authorization", f"Bearer {token}")
    with urllib.request.urlopen(req, timeout=30) as resp:
        payload = json.loads(resp.read())
        return {e["key"]: e["textValue"] for e in payload["entries"]}


# Использование функции получения секрета
secrets = get_secret("<идентификатор_секрета>")

# Инициализация Spark сессии
spark = SparkSession.builder.appName("db-reader").getOrCreate()

# Подключение к кластеру {{ mpg-name }}
df = spark.read \
    .format("jdbc") \
    .option("url", f"jdbc:postgresql://<FQDN_хоста>:{{ port-mpg }}/<имя_БД>") \
    .option("driver", "org.postgresql.Driver") \
    .option("user", "<имя_пользователя>") \
    .option("password", secrets["postgresql_password"]) \
    .option("dbtable", "<имя_таблицы>") \
    .load()

# Вывод первых 20 строк таблицы
df.show()
```