# Resolving the error of access to S3 buckets from a DataProc 1.4 cluster


## Issue description {#issue-description}

When attempting to access S3 buckets from a DataProc 1.4 cluster, you see this error:
```
ls: doesBucketExist on yc-mdb-examples: com.amazonaws.AmazonClientException:
No AWS Credentials provided by ComputeMetadataCredentialsProvider : com.amazonaws.AmazonServiceException: Bad Request (Service: null; Status Code: 400; Error Code: null; Request ID: null)
```
Meanwhile, the cluster hosts have network access to S3.

## Solution {#issue-resolution}

Create a new cluster with DataProc version 2.0 or higher: the specified error does not occur there, and the connection to the bucket is valid.

{% note info %}

To establish a connection, use the `ubuntu` login rather than `root`.

{% endnote %}
