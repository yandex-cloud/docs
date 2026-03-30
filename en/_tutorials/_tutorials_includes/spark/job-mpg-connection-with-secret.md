```python
import json
import os
import urllib.request
from pyspark.sql import SparkSession

def get_secret(secret_id: str) -> dict:
    """Getting a secret from {{ lockbox-name }}."""
    # Getting an IAM token via metadata service
    metadata_host = os.environ.get("YC_METADATA_ADDR", "169.254.169.254")
    token_url = f"http://{metadata_host}/computeMetadata/v1/instance/service-accounts/default/token"

    req = urllib.request.Request(token_url)
    req.add_header("Metadata-Flavor", "Google")
    with urllib.request.urlopen(req, timeout=10) as resp:
        token = json.loads(resp.read())["access_token"]

    # Getting a {{ lockbox-name }} secret
    secret_url = f"https://payload.lockbox.api.cloud.yandex.net/lockbox/v1/secrets/{secret_id}/payload"
    req = urllib.request.Request(secret_url)
    req.add_header("Authorization", f"Bearer {token}")
    with urllib.request.urlopen(req, timeout=30) as resp:
        payload = json.loads(resp.read())
        return {e["key"]: e["textValue"] for e in payload["entries"]}


# Using the secret retrieval function
secrets = get_secret("<secret_ID>")

# Initializing a Spark session
spark = SparkSession.builder.appName("db-reader").getOrCreate()

# Connecting to a {{ mpg-name }} cluster
df = spark.read \
    .format("jdbc") \
    .option("url", f"jdbc:postgresql://<host_FQDN>:{{ port-mpg }}/<DB_name>") \
    .option("driver", "org.postgresql.Driver") \
    .option("user", "<username>") \
    .option("password", secrets["postgresql_password"]) \
    .option("dbtable", "<table_name>") \
    .load()

# Showing the first 20 rows of the table
df.show()
```