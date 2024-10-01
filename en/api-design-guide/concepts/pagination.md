# Pagination

Some API methods support _pagination_. Pagination is when a server returns results in parts, page by page, and not all of them at once. Pagination is generally used for the `List*` method that returns a list.

To get the desired page with results, pass the following parameters in a request:

- `page_token`: Result page token. You can get the next page token from the `next_page_token` field when retrieving a list of resources (see the example below).

- `page_size`: Number of results per page. Possible values: from 0 to 1000. The default value is: 100.

## Examples {#examples}

### gRPC

gRPC description of the [List](https://github.com/yandex-cloud/cloudapi/blob/master/yandex/cloud/compute/v1/disk_service.proto) method used for disks:
```protobuf
 // The method returns a list of disks in the specified folder.
 rpc List (ListDisksRequest) returns (ListDisksResponse) {
   option (google.api.http) = { get: "/compute/v1/disks" };
 }
 message ListDisksRequest {
   // Folder ID.
   // Required field.
   string folder_id = 1;

   // Maximum number of results per page.
   int64 page_size = 2;

   // Token of the requested result page.
   string page_token = 3;
 }

 message ListDisksResponse {
   // List of disks.
   repeated Disk disks = 1;

   // Token of the next page.
   string next_page_token = 2;
 }
```

### REST

Sample REST request used to get a list of disks in the folder:

```http
GET https://compute.{{ api-host }}/compute/v1/disks?folderId=a3s17h9sbq5asdgss12&pageToken=1acdeb26078146e6
```

Response:

```json
{
  "disks": [
    {
      "folderId": "de0m97h0gbq0foeuis03",
      "createdAt": "2018-08-09T12:54:53+00:00",
      "id": "de019dv504rmhoinn3nk",
      "name": "development",
      "zoneId" : "{{ region-id }}-a",
      "typeId" : "network-nvme",
      "size" : 5368709120 
    },
    ...
  ],
  "nextPageToken": "ae08rgjd5smu4bq5n1o4"
}
```
