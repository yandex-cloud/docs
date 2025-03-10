{% note info %}

If you use the Finder context menu to create a ZIP archive on macOS, a service directory titled `__MACOSX` is automatically added to the archive. This directory may cause errors when you build functions. To delete this directory from your ZIP archive, use the command line to navigate to the folder containing the archive and run this command:

```bash
zip -d <archive_name>.zip "__MACOSX/*"
```

{% endnote %}