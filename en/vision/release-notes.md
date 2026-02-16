---
title: '{{ vision-full-name }} release notes'
description: This page presents the {{ vision-full-name }} release notes.
---

# {{ vision-full-name }} release notes

## Release as of 30/06/2025 {#300625}

* Updated existing models and improved recognition accuracy.
* [Added](./concepts/ocr/index.md#models) `markdown` and `math-markdown` models that return the recognized text in Markdown syntax.
* All recognized text `blocks[]` now have the `LayoutType` property.
* The API response now includes the `pictures` field with coordinates of images in the document.
* The English-Russian [language model](./concepts/ocr/supported-languages.md) is no longer supported.

## Release as of 06/02/2024 {#060224}

* Improved [table recognition](operations/ocr/text-detection-table.md) quality. Now the service should recognize all tables as tables.
* Added Turkish language support for table recognition.

## Release as of 11/01/2024 {#110124}

Updated the table recognition model.

## Release as of 07/04/2023 {#070423}

* To enable [document recognition](concepts/ocr/template-recognition.md), we added the `vehicle-registration-front` and `vehicle-registration-back` models that extract data from vehicle registration certificates.
* Improved recognition accuracy for all models.
* Significantly improved PDF file processing quality.
