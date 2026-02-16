### Server-side copy {#server-side-copy}

For details on [server-side copy](../../storage/operations/objects/copy.md) in buckets with access restricted to {{ vpc-short-name }} service connections, refer to this table:

Source bucket | Target bucket | Condition to initiate server-side copying^1^
--- | --- | ---
Access restricted to {{ vpc-short-name }} service connections | Access restricted to {{ vpc-short-name }} service connections | Request from a service connection listed as allowed for both buckets
Access restricted to {{ vpc-short-name }} service connections | Access from a public network | Request from a service connection listed as allowed for the source bucket
Access from a public network | Access restricted to {{ vpc-short-name }} service connections | Request from a service connection listed as allowed for the target bucket
Access from a public network | Access from a public network | Request from a public network or service connection

^1^ If the client has permissions to read from the source bucket and write to the target bucket.