```bash
curl \
  --location \
  --request PATCH '<video_upload_link>' \
  --header 'Content-Type: application/offset+octet-stream' \
  --header 'Upload-Offset: 0' \
  --header 'Tus-Resumable: 1.0.0' \
  --data-binary '@<video_file_path>'
```

Where:
* `<video_upload_link>`: Previously saved upload link you got when creating the video.
* `<video_file_path>`: Full video file path preceded with `@`.

    E.g., `@/Users/myuser/Downloads/sample-video.MOV`.

    Do not use any shortcuts, including `~`, in the file path.