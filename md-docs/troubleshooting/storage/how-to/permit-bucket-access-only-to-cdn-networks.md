[Документация Yandex Cloud](../../../index.md) > [Все решения](../../index.md) > [Object Storage](../index.md) > Как ограничить доступ к бакету Object Storage диапазоном IP-адресов, принадлежащих Cloud CDN

# Как ограничить доступ к бакету Object Storage диапазоном IP-адресов, принадлежащих Cloud CDN


Доступ к объектам можно ограничить с помощью [политики доступа](../../../storage/concepts/policy.md), которая разрешает чтение только из подсетей Yandex Cloud CDN.

Список подсетей [периодически меняется](../../../security/ip-list.md#cloud-cdn). Скрипт ниже получает актуальный список, объединяет смежные диапазоны и формирует политику в формате JSON. Все диапазоны находятся в одном условии `aws:SourceIp` и применяются с логикой `ИЛИ`.

{% cut "Скрипт генерации политики" %}

Сохраните код в файл `cdn-bucket-policy.py`:

```python
import argparse
import ipaddress
import json
import urllib.request

parser = argparse.ArgumentParser()
parser.add_argument("--bucket", required=True)
parser.add_argument("--source", required=True)
args = parser.parse_args()

with urllib.request.urlopen(args.source, timeout=30) as response:
    prefixes = json.load(response)["prefixes"]

if not prefixes:
    raise ValueError("Список подсетей CDN пуст")

networks = [ipaddress.ip_network(prefix) for prefix in prefixes]
cidrs = []
for version in (4, 6):
    cidrs.extend(
        str(network)
        for network in ipaddress.collapse_addresses(
            network for network in networks if network.version == version
        )
    )

policy = {
    "Version": "2012-10-17",
    "Statement": [{
        "Sid": "AllowCloudCDNOnly",
        "Effect": "Allow",
        "Principal": "*",
        "Action": "s3:GetObject",
        "Resource": f"arn:aws:s3:::{args.bucket}/*",
        "Condition": {"IpAddress": {"aws:SourceIp": cidrs}},
    }],
}
print(json.dumps(policy, indent=2, ensure_ascii=False))
```

{% endcut %}

Запустите скрипт с помощью Python 3, указав имя бакета:


```bash
python3 cdn-bucket-policy.py --bucket <имя_бакета> \
  --source https://tech.cdn.yandex.net/prefixes/yc.json > policy.json
```


Проверьте полученный файл и [примените политику к бакету](../../../storage/operations/buckets/policy.md#apply-policy). Скрипт только создает JSON-файл и не меняет настройки бакета.

Политика разрешает только чтение объектов из сетей CDN. Для других операций, в том числе [доступа через консоль управления](../../../storage/concepts/policy.md#console-access), нужны отдельные правила. Если в бакете уже есть политика, учитывайте ее правила при внесении изменений: другие разрешающие правила могут открыть чтение и для адресов вне сетей CDN.

Периодически запускайте скрипт повторно и обновляйте политику, чтобы учитывать изменения списка подсетей.