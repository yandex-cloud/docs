# How to restrict {{ objstorage-name }} bucket access to a specific {{ cdn-name }} IP address range


## Issue description {#case-description}

You need to ensure that only {{ cdn-full-name }} can access the content of your static website or single-page application (SPA) hosted in {{ objstorage-full-name }}.

## Solution {#case-resolution}

Static website hosting in {{ objstorage-name }} implies that bucket contents should be available to all IP addresses and subnets requesting content from the website.

{{ cdn-full-name }} caches the website bucket contents on its servers. However, the management console does not yet have the option to restrict access to your bucket to CDNs only. 

To implement this scenario, restrict public access to the bucket by IP address: manually allow connections only from {{ cdn-name }} subnets, prohibiting access to bucket contents from any other IP addresses. To do this, you need to configure a [bucket policy](../../../storage/concepts/policy.md) where you will specify the IP address ranges used by {{ cdn-name }}.

You can get a list of IP addresses and subnets used by {{ cdn-name }} by following these links:

* [List of public IP addresses of the EdgeCenter provider](https://api.edgecenter.ru/cdn/public_ips_list)
* [List of subnets of the EdgeCenter provider (with CIDRs)](https://api.edgecenter.ru/cdn/public_net_list)

{% note info %}

Please note that this IP address list may get updated occasionally, with new IP addresses or subnets added or unused ones removed.

We recommend that you check the subnet list in your bucket policy against the current IP address list periodically.

{% endnote %}

Our CDN partner, [EdgeCenter](https://apidocs.edgecenter.ru/cdn#tag/Networks-and-IP-addresses), provides this IP address list to the API.

Apply the policy from the configuration below by following [this guide](../../../storage/operations/buckets/policy.md#apply-policy). Before applying a policy based on this configuration, change `<bucket_name>` to your bucket name in {{ objstorage-name }}.

{% cut "Configuration example" %}

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
          "aws:SourceIp": "103.242.74.224/29"
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
          "aws:SourceIp": "185.211.231.192/29"
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
          "aws:SourceIp": "5.188.132.0/28"
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
          "aws:SourceIp": "195.34.58.164/31"
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
          "aws:SourceIp": "217.118.183.248/30"
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
          "aws:SourceIp": "178.176.145.176/28"
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
          "aws:SourceIp": "194.67.48.24/30"
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
          "aws:SourceIp": "176.56.179.176/29"
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
          "aws:SourceIp": "98.158.98.226/31"
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
          "aws:SourceIp": "87.239.191.78/31"
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
          "aws:SourceIp": "195.3.244.188/30"
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
          "aws:SourceIp": "92.223.123.96/27"
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
          "aws:SourceIp": "138.204.14.150/31"
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
          "aws:SourceIp": "81.211.44.154/31"
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
          "aws:SourceIp": "220.158.132.70/31"
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
          "aws:SourceIp": "92.223.108.0/27"
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
          "aws:SourceIp": "194.186.66.252/30"
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
          "aws:SourceIp": "5.188.121.128/25"
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
          "aws:SourceIp": "178.176.153.0/24"
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
          "aws:SourceIp": "178.176.145.96/27"
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
          "aws:SourceIp": "5.101.68.0/27"
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
          "aws:SourceIp": "91.243.83.0/26"
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
          "aws:SourceIp": "31.173.147.2/31"
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
          "aws:SourceIp": "92.223.122.160/27"
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
          "aws:SourceIp": "178.176.131.224/28"
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
          "aws:SourceIp": "195.239.135.56/30"
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
          "aws:SourceIp": "178.176.145.0/27"
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
          "aws:SourceIp": "92.223.110.0/27"
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
          "aws:SourceIp": "87.229.240.64/30"
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
          "aws:SourceIp": "5.188.7.0/26"
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
          "aws:SourceIp": "178.176.131.128/26"
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
          "aws:SourceIp": "92.50.131.190/31"
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
          "aws:SourceIp": "109.200.129.16/29"
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
          "aws:SourceIp": "194.154.79.64/30"
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
          "aws:SourceIp": "92.223.123.0/26"
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
          "aws:SourceIp": "92.223.64.0/28"
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
          "aws:SourceIp": "185.101.137.0/28"
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
          "aws:SourceIp": "92.223.114.0/26"
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
         "aws:SourceIp": "178.176.145.64/27"
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
         "aws:SourceIp": "195.239.185.56/30"
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
         "aws:SourceIp": "178.176.145.128/28"
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
         "aws:SourceIp": "178.176.145.144/28"
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
          "aws:SourceIp": "178.176.145.0/26"
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
         "aws:SourceIp": "5.8.43.0/28"
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
         "aws:SourceIp": "185.228.134.96/31"
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
        "aws:SourceIp": "5.188.121.128/26"
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
      "aws:SourceIp": "62.141.95.96/30"
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
        "aws:SourceIp": "92.223.43.0/26"
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
        "aws:SourceIp": "185.11.76.52/31"
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
           "aws:SourceIp": "178.176.131.0/26"
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
            "aws:SourceIp": "178.176.145.160/28"
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
            "aws:SourceIp": "31.173.147.0/31"
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
            "aws:SourceIp": "178.176.131.192/27"
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
            "aws:SourceIp": "178.176.131.240/28"
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
            "aws:SourceIp": "178.176.131.64/26"
        }
      }
    }
  ]
}

```
{% endcut %}
