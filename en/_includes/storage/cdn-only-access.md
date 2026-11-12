You can restrict access to objects by using a [bucket policy](../../storage/concepts/policy.md) that allows read access only from the {{ cdn-full-name }} subnets.

The list of subnets [periodically changes](../../security/ip-list.md#cloud-cdn). The script below retrieves the current list, merges adjacent ranges, and generates the policy in JSON format. All ranges are in a single `aws:SourceIp` condition and use the `OR` logic.

{% cut "Policy generation script" %}

Save the code to the `cdn-bucket-policy.py` file:

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
    raise ValueError("List of CDN subnets empty")

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

Run the script using Python 3 with the bucket name specified:


```bash
python3 cdn-bucket-policy.py --bucket <bucket_name> \
  --source https://tech.cdn.yandex.net/prefixes/yc.json > policy.json
```


Check the resulting file and [apply the policy to the bucket](../../storage/operations/buckets/policy.md#apply-policy). The script only creates a JSON file without changing the bucket settings.

The policy allows read-only access to objects from the CDN networks. Other operations, including [access via the management console](../../storage/concepts/policy.md#console-access), require separate rules. If the bucket already has a policy, consider its rules when making your changes: other allow rules may open read access to addresses outside the CDN networks as well.

Rerun the script from time to time and update the bucket policy to accommodate the changes made to the list of subnets.
