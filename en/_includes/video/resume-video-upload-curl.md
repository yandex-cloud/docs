1. Get the `offset` position of the interrupted upload using the previously saved video upload link:

    ```bash
    curl \
      --head '<video_upload_link>' \
      --header 'Host: tusd.video.cloud.yandex.net' \
      --header 'Tus-Resumable: 1.0.0'
    ```

    Result:

    ```text
    HTTP/1.1 200 OK
    Server: nginx/1.18.0
    Date: Mon, 16 Sep 2024 15:21:52 GMT
    Connection: keep-alive
    Cache-Control: no-cache
    Tus-Resumable: 1.0.0
    Upload-Length: 100100627
    Upload-Metadata: filename c2FtcGxlLXZpZGVv********,video_id dnBsdjVpeWh2M2F6ZnYz********
    Upload-Offset: 28231123
    X-Content-Type-Options: nosniff
    X-Request-Id: 3b775c2a********
    X-Trace-Id: 95ab2f994557ce1b1ee9dd09********
    X_h: edge-5b647c8d67-*****
    Access-Control-Allow-Origin: *
    Access-Control-Allow-Headers: *
    Access-Control-Expose-Headers: *
    Expires: Thu, 01 Jan 1970 00:00:01 GMT
    ```

    Save the `Upload-Offset` field value as you will need it to complete the video file upload.

1. Complete the file upload by running this command:

    ```bash
    curl \
      --location \
      --request PATCH '<video_upload_link>' \
      --header 'Content-Type: application/offset+octet-stream' \
      --header 'Upload-Offset: <offset_value>' \
      --header 'Tus-Resumable: 1.0.0' \
      --data-binary '@<video_file_path>'
    ```

    Where:
    * `<video_upload_link>`: Previously saved upload link you got when creating the video.
    * `<offset_value>`: Previously saved `offset` value indicating the position in the file the previous upload attempt was interrupted at.
    * `<video_file_path>`: Full video file path preceded with `@`. 
    
        E.g., `@/Users/myuser/Downloads/sample-video.MOV`.

        Do not use any shortcuts, including `~`, in the file path.