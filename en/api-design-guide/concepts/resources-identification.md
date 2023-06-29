# Resource identification

Each resource in the {{ yandex-cloud }} APIs has its own unique ID. IDs are generated on the service side. An ID is a string consisting of Latin letters and numbers.

IDs should be passed in API requests when accessing resources.

Sample gRPC description of the [Get](https://github.com/yandex-cloud/cloudapi/blob/master/yandex/cloud/compute/v1/disk_service.proto) method used to get a disk:

```protobuf
 rpc Get (GetDiskRequest) returns (Disk) {
   option (google.api.http) = {
     get: "/compute/v1/disks/{disk_id}"
   };
 }

 message GetDiskRequest {
   // ID of the requested disk.
   string disk_id = 1;
 }
```

In the REST API, each resource has its own unique URL generated according to the pattern:

```http
https://<domain>/<service>/<API version>/<resource category>/<resource identifier>
```

Sample REST request for a disk:
```
 GET https://compute.{{ api-host }}/compute/v1/disks/e0m97h0gbq0foeuis03
```

As you can see from the example, a resource URL is identified by the <q>resource category and resource ID</q> bundle.

The resource category determines the type of resource. For example, `disks` is a category of disks; `instances` is a category of VMs; and `images` is a category of images.

{% note info %}

A resource category should not be confused with the concept of collection in the REST API. Categories are not independent resources and you cannot manage them (create, change them, or request information). Categories are for service use, i.e., they are used in resource URLs for routing requests on the service side.

{% endnote %}


## Nested resource IDs {#nested-resources-identification}

Some resources in APIs are nested, that is, created in the context of other resources. For example, databases are created in clusters. When accessing such resources, always specify the following two parameters:

- ID of the parent resource. In the example with DBs, the parent resource is a cluster.
- Nested resource name. In our example, the nested resource is a database.

The name of a nested resource is specified by the user and must be unique within the parent resource. For example, you cannot create two DBs with the same names in the same cluster.

Sample gRPC description of the [Get](https://github.com/yandex-cloud/cloudapi/blob/master/yandex/cloud/mdb/postgresql/v1/database_service.proto) method used to get a DB resource:
```protobuf
 rpc Get (GetDatabaseRequest) returns (Database) {
   option (google.api.http) = {
     get: "/managed-postgresql/v1/clusters/{cluster_id}/databases/{database_name}"
   };
 }
 message GetDatabaseRequest {
   // ID of the cluster the DB belongs to.
   // Required field.
   string cluster_id = 1;

   // DB name.
   // Required field.
   string database_name = 2;
 }
```

{% include notitle [database_name](../_includes/database_name.md) %}

In the REST API, the unique URI of a nested resource has a hierarchical structure:
```
/<parent resource category>/<parent resource ID>/<nested resource category>/<nested resource ID>
```
Sample REST request for getting a DB:
```
 GET https://mdb.{{ api-host }}/managed-postgresql/v1/clusters/24f17h0gfqf7oeuis2f/databases/db-testing
```
Where:
- `clusters`: Category of the parent resource.
- `24f17h0gfqf7oeuis2f`: ID of the parent resource.
- `databases`: Category of the nested resource.
- `db-testing`: ID of the nested resource.


#### See also {#see-also}
- [{{ yandex-cloud }} API repository](https://github.com/yandex-cloud/cloudapi): Link to the .proto specifications of the API.
- [{{ resmgr-full-name }}Documentation](../../resource-manager/concepts/resources-hierarchy.md): Link to the <q>Hierarchy of {{ yandex-cloud }}resources</q> section.

