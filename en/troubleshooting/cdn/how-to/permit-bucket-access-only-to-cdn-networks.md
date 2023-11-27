# Restricting access to an Object Storage bucket using an IP range from Cloud CDN

## Issue description {#case-description}
You need to ensure that your static site content (or single-page application, SPA) hosted in Yandex Object Storage is only available to Yandex Cloud CDN.

## Solution {#case-solution}
By the logic of static site hosting in Object Storage, bucket contents should be available to all IP addresses and subnets that request content from the site.
The Yandex Cloud CDN caches the content from site buckets on its servers. However, you cannot use the management console to make your bucket accessible only from Yandex Cloud CDN networks.

To implement this scenario, restrict public access to the bucket from IP addresses. For this, manually allow connections only from Yandex Cloud CDN subnets, prohibiting access to bucket contents from all the other IP addresses.
In this case, you need to create a [bucket access policy](../../../storage/concepts/policy.md) to specify IP ranges used by Yandex Cloud CDN.

You can get a list of IPs and subnets used by the service at the links:
- [List of public IP addresses of the Edge Center provider](https://api.edgecenter.ru/cdn/public-ip-list)
- [List of IP subnets of the Edge Center provider (with CIDRs)](https://api.edgecenter.ru/cdn/public-net-list).

{% note info %}

Keep in mind that this IP list may get updated occasionally, with new IPs/subnets added or unused IPs/subnets removed.
Make sure to check the subnet list in your Object Storage against the current IP list from time to time.

{% endnote %}

Our CDN partner, [EDGECenter](https://apidocs.edgecenter.ru/cdn#tag/IP-Addresses-List), provides this IP list to our API.


Apply the policy from the sample configuration below by following [this guide](../../../storage/operations/buckets/policy.md#apply-policy).
Before applying a policy based on this sample configuration, change `<bucket_name>` to your bucket name in Object Storage.

{% cut "Sample configuration" %}

```
{
  "Version": "2012-10-17",
  "Statement": [
    {
      "Effect": "Allow",
      "Principal": "*",
      "Action": "s3:GetObject",
      "Resource": "arn:aws:s3:::<bucket name>/*",
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
      "Resource": "arn:aws:s3:::<bucket name>/*",
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
      "Resource": "arn:aws:s3:::<bucket name>/*",
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
      "Resource": "arn:aws:s3:::<bucket name>/*",
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
      "Resource": "arn:aws:s3:::<bucket name>/*",
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
      "Resource": "arn:aws:s3:::<bucket name>/*",
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
      "Resource": "arn:aws:s3:::<bucket name>/*",
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
      "Resource": "arn:aws:s3:::<bucket name>/*",
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
      "Resource": "arn:aws:s3:::<bucket name>/*",
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
      "Resource": "arn:aws:s3:::<bucket name>/*",
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
      "Resource": "arn:aws:s3:::<bucket name>/*",
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
      "Resource": "arn:aws:s3:::<bucket name>/*",
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
      "Resource": "arn:aws:s3:::<bucket name>/*",
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
      "Resource": "arn:aws:s3:::<bucket name>/*",
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
      "Resource": "arn:aws:s3:::<bucket name>/*",
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
      "Resource": "arn:aws:s3:::<bucket name>/*",
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
      "Resource": "arn:aws:s3:::<bucket name>/*",
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
      "Resource": "arn:aws:s3:::<bucket name>/*",
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
      "Resource": "arn:aws:s3:::<bucket name>/*",
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
      "Resource": "arn:aws:s3:::<bucket name>/*",
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
      "Resource": "arn:aws:s3:::<bucket name>/*",
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
      "Resource": "arn:aws:s3:::<bucket name>/*",
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
      "Resource": "arn:aws:s3:::<bucket name>/*",
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
      "Resource": "arn:aws:s3:::<bucket name>/*",
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
      "Resource": "arn:aws:s3:::<bucket name>/*",
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
      "Resource": "arn:aws:s3:::<bucket name>/*",
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
      "Resource": "arn:aws:s3:::<bucket name>/*",
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
      "Resource": "arn:aws:s3:::<bucket name>/*",
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
      "Resource": "arn:aws:s3:::<bucket name>/*",
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
      "Resource": "arn:aws:s3:::<bucket name>/*",
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
      "Resource": "arn:aws:s3:::<bucket name>/*",
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
      "Resource": "arn:aws:s3:::<bucket name>/*",
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
      "Resource": "arn:aws:s3:::<bucket name>/*",
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
      "Resource": "arn:aws:s3:::<bucket name>/*",
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
      "Resource": "arn:aws:s3:::<bucket name>/*",
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
      "Resource": "arn:aws:s3:::<bucket name>/*",
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
      "Resource": "arn:aws:s3:::<bucket name>/*",
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
      "Resource": "arn:aws:s3:::<bucket name>/*",
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
      "Resource": "arn:aws:s3:::<bucket name>/*",
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
      "Resource": "arn:aws:s3:::<bucket name>/*",
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
      "Resource": "arn:aws:s3:::<bucket name>/*",
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
      "Resource": "arn:aws:s3:::<bucket name>/*",
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
      "Resource": "arn:aws:s3:::<bucket name>/*",
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
      "Resource": "arn:aws:s3:::<bucket name>/*",
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
      "Resource": "arn:aws:s3:::<bucket name>/*",
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
      "Resource": "arn:aws:s3:::<bucket name>/*",
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
      "Resource": "arn:aws:s3:::<bucket name>/*",
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
      "Resource": "arn:aws:s3:::<bucket name>/*",
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
      "Resource": "arn:aws:s3:::<bucket name>/*",
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
      "Resource": "arn:aws:s3:::<bucket name>/*",
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
      "Resource": "arn:aws:s3:::<bucket name>/*",
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
      "Resource": "arn:aws:s3:::<bucket name>/*",
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
      "Resource": "arn:aws:s3:::<bucket name>/*",
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
      "Resource": "arn:aws:s3:::<bucket name>/*",
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
      "Resource": "arn:aws:s3:::<bucket name>/*",
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