---
title: "How to set up a notebook template in {{ ml-platform-full-name }}"
description: "Follow this guide to beging using the {{ jlab }}Lab-templates extension."
---

# Setting up template-based {{ jlab }}Lab notebook creation

To create {{ jlab }}Lab notebooks based on a template, activate the {{ jlab }}Lab-templates extension in {{ dd }} mode. To do this:

1. Create a `datasphere-templates` folder in the root directory of your project.
1. In `datasphere-templates`, create a nested folder with any name, e.g., `template-group-1`. In this folder, create a template notebook with any name, e.g., `template_notebook1.ipynb`.
1. You can create multiple templates for different use cases and group them in different folders.

   Sample structure of the `datasphere-templates` folder used to store {{ jlab }}Lab templates:

   ```text
   datasphere-templates/
                        |
                        |_ template-group-1/
                        |                   |
                        |                   |_ template_notebook1.ipynb
                        |                   |_ template_notebook2.ipynb
                        |
                        |_ template-group-2/
                                            |
                                            |_ template_notebook3.ipynb
                                            |_ template_notebook4.ipynb
   ```

1. Refresh the page in your browser.
1. You will see the **Template** button in the **Notebook** section on the {{ jlab }}Lab home page. Click it and select the folder and notebook you need.
