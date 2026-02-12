---
title: Troubleshooting video upload and processing in {{ video-full-name }}
description: This article provides solutions for possible issues with uploading and processing video files in {{ video-name }}.
---

# Troubleshooting video upload and processing

This section describes possible issues with uploading and processing video files in {{ video-name }} and how to solve them.

## Video file processing error {#processing-error}

{{ video-name }} cannot properly process a file due to corrupted data in the container, video stream, or audio stream. This may be due to recording failures caused by camera or memory card issues, corruption during copying or transcoding, etc.

Note that the file might still open and play on your PC, as media players can often mask errors, skip damaged packets, or reconstruct frames using keyframes. However, {{ video-name }} will reject such a file, so repair it before uploading.

### How to check the file {#check-file}

[Re-upload](../operations/video/upload.md) the file. If the error persists, the file is likely corrupted.

You can check this by opening the file in a third-party media player (e.g., Windows Media Player, QuickTime, VLC, etc.). A corrupted file may exhibit freezing, artifacts, black screens, and other video or audio issues.

Keep in mind that issues can occur anywhere in the file: even a few corrupted frames can render your entire file invalid for processing.

### How to fix the file {#fix-file}

1. Re-export the file if created in a video editor.
1. If the original file cannot be restored, re-encode it into a recommended format using [FFmpeg](https://www.ffmpeg.org), instructing it to skip corrupted segments:

   ```bash
   ffmpeg -err_detect ignore_err \
          -i <input_file> \
          -c:v libx264 \
          -crf 23 \
          -c:a aac \
          -b:a 192k \
          -map 0 \
          <output_file>
   ```

1. Optionally, trim the corrupted segment if needed and save a new version.
1. Re-upload the repaired file to {{ video-name }}.

### When to contact support {#contact-support}

If the file plays without errors after re-encoding but processing in {{ video-name }} still fails, contact [support]({{ link-console-support }}) and provide the video's ID.
