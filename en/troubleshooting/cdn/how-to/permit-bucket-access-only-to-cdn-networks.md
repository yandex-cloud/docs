# How to restrict {{ objstorage-name }} bucket access to a specific {{ cdn-name }} IP address range



## Case description {#case-description}

You need to ensure that only {{ cdn-full-name }} can access the content of your static website or single-page application (SPA) hosted in {{ objstorage-full-name }}.

## Solution {#case-resolution}

Static website hosting in {{ objstorage-name }} implies that bucket contents should be available to all IP addresses and subnets requesting content from the website.

{{ cdn-name }} caches the website bucket contents on its servers. However, the management console does not yet have the option to restrict access to your bucket to CDNs only.

To implement this scenario, restrict public access to the bucket by IP address: manually allow connections only from {{ cdn-full-name }} subnets, prohibiting access to bucket contents from any other IP addresses. To do this, you need to configure a [bucket policy](../../../storage/concepts/policy.md) where you will specify the IP address ranges used by {{ cdn-name }}.

{% list tabs group=instructions %}

- {{ cdn-full-name }}

  You can view the list of the {{ cdn-full-name }} subnets [here](../../../security/ip-list.md#cloud-cdn). 
  

- EdgeCDN

  To get the list of the relevant IP addresses and subnets, see:
  
  * [List of public IP addresses of the EdgeCenter provider](https://api.edgecenter.ru/cdn/public_ips_list)
  * [List of subnets of the EdgeCenter provider (with CIDRs)](https://api.edgecenter.ru/cdn/public_net_list)
  

{% endlist %}

{% note info "Note" %}

This IP address list gets changed on a regular basis, with new IP addresses or subnets added or unused ones removed. 

You may want to regularly check the subnet list in your bucket policy against the current IP address list.

{% endnote %}

Apply the policy from the configuration below by following [this guide](../../../storage/operations/buckets/policy.md#apply-policy).
Before applying a policy based on this configuration, replace `<bucket_name>` with your bucket name in {{ objstorage-name }}.

{% list tabs group=instructions %}

- {{ cdn-full-name }}

  ```
  {
    "Version": "2012-10-17",
    "Statement": [
      {
        "Effect": "Allow",
        "Principal": "*",
        "Action": "s3:GetObject",
        "Resource": "arn:aws:s3:::<bucket_name>/*",
        "Condition": {
          "IpAddress": {
            "aws:sourceip": "188.72.103.0/24"
          }
        }
      },
      {
        "Effect": "Allow",
        "Principal": "*",
        "Action": "s3:GetObject",
        "Resource": "arn:aws:s3:::<bucket_name>/*",
        "Condition": {
          "IpAddress": {
            "aws:sourceip": "188.72.104.0/24"
          }
        }
      },
      {
        "Effect": "Allow",
        "Principal": "*",
        "Action": "s3:GetObject",
        "Resource": "arn:aws:s3:::<bucket_name>/*",
        "Condition": {
          "IpAddress": {
            "aws:sourceip": "188.72.105.0/24"
          }
        }
      },
      {
        "Effect": "Allow",
        "Principal": "*",
        "Action": "s3:GetObject",
        "Resource": "arn:aws:s3:::<bucket_name>/*",
        "Condition": {
          "IpAddress": {
            "aws:sourceip": "188.72.110.0/24"
          }
        }
      },
      {
        "Effect": "Allow",
        "Principal": "*",
        "Action": "s3:GetObject",
        "Resource": "arn:aws:s3:::<bucket_name>/*",
        "Condition": {
          "IpAddress": {
            "aws:sourceip": "188.72.111.0/24"
          }
        }
      },
      {
        "Effect": "Allow",
        "Principal": "*",
        "Action": "s3:GetObject",
        "Resource": "arn:aws:s3:::<bucket_name>/*",
        "Condition": {
          "IpAddress": {
            "aws:sourceip": "188.72.112.0/24"
          }
        }
      },
      {
        "Effect": "Allow",
        "Principal": "*",
        "Action": "s3:GetObject",
        "Resource": "arn:aws:s3:::<bucket_name>/*",
        "Condition": {
          "IpAddress": {
            "aws:sourceip": "188.72.113.0/24"
          }
        }
      },
      {
        "Effect": "Allow",
        "Principal": "",
        "Action": "s3:GetObject",
        "Resource": "arn:aws:s3:::<bucket_name>/*",
        "Condition": {
          "IpAddress": {
            "aws:sourceip": "89.223.9.0/24"
          }
        }
      }
    ]
  }
  ```

- EdgeCDN

  You can find the list of IP addresses for the EdgeCenter CDN provider [here](https://api.edgecenter.ru/cdn/public_ips_list). Since this list is very large, you way want to generate an ACL automatically, and then upload it to the bucket configuration.
  In this article, we provide a Python script as an example. Save this script to `acl_generator.py` and run it through `python3 acl_generator.py https://api.edgecenter.ru/cdn/public_ips_list my-bucket -o policy.json`, where `my-bucket` is the name of your bucket in {{ objstorage-name }}.

  {% cut "Example of Python script" %}

   ```python
    import json
    import requests
    import argparse

    def main():
      parser = argparse.ArgumentParser(description='Generate S3 Bucket ACL from IP list')
      parser.add_argument('url', help='URL of JSON file with IP addresses')
      parser.add_argument('bucket', help='S3 bucket name')
      parser.add_argument('-o', '--output', default='acl.json', help='Output filename (default: acl.json)')
      args = parser.parse_args()

      try:
          response = requests.get(args.url, timeout=10)
          response.raise_for_status()
          data = response.json()

          if 'addresses' not in data or not isinstance(data'addresses', list):
              raise ValueError("Invalid JSON structure: 'addresses' array not found")
          
          acl = {
              "Version": "2012-10-17",
              "Statement": [
                  {
                      "Effect": "Allow",
                      "Principal": "*",
                      "Action": "s3:GetObject",
                      "Resource": f"arn:aws:s3:::{args.bucket}/*",
                      "Condition": {
                          "IpAddress": {
                              "aws:sourceip": address
                          }
                      }
                  }
                  for address in data'addresses']
              ]
          }

          with open(args.output, 'w') as f:
              json.dump(acl, f, indent=4)
          
          print(f"ACL successfully generated for  IPs. Saved to ")

      except requests.exceptions.RequestException as e:
          print(f"Network error: {e}")
      except json.JSONDecodeError:
          print("Error: Invalid JSON format in response")
      except ValueError as e:
          print(e)

   if _name_ == "_main_":
      main()
  ```

  {% endcut %}


{% endlist %}


