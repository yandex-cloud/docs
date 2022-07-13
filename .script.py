import os


def append_operation_yaml_en():
    docs_api = "/var/lib/teamcity/BuildAgents/dataui-qyp-iva-04/work/87388b7181e237b7/docs/en/_api-ref"
    for service in ["compute", "vpc", "iam", "mdb", "loadbalancer"]:
        for folder, subfolders, files in os.walk(os.path.join(docs_api, service)):
            api_tocs = []
            if "toc.yaml" in files:
                api_toc = os.path.join(folder, "toc.yaml")
                print(api_toc)
                api_tocs.append(api_toc)
                for toc in api_tocs:
                    with open(os.path.join(toc)) as f:
                        if "  - name: Operation\n" in f:
                            print("found")
                            break
                        else:
                            with open(os.path.join(toc), "a") as f:
                                f.writelines("  - name: Operation\n")
                                f.writelines("    items:\n")
                                f.writelines("      - name: Overview\n")
                                f.writelines("        href: api-ref/Operation/index.md\n")
                                f.writelines("      - name: get\n")
                                f.writelines("        href: api-ref/Operation/get.md\n")


def remove_cancel_operation_en():
    docs_api = "/var/lib/teamcity/BuildAgents/dataui-qyp-iva-04/work/87388b7181e237b7/docs/en/_api-ref"
    for service in ["compute", "vpc", "iam", "mdb", "loadbalancer"]:
        for folder, subfolders, files in os.walk(os.path.join(docs_api, service)):
            indeces = []
            if "index.md" in files:
                index_path = os.path.join(folder, "index.md")
                indeces.append(index_path)
                for index in indeces:
                    with open(index, "r") as f:
                        lines = f.readlines()
                    with open(index, "w") as index_updated:
                        for line in lines:
                            if line.strip("\n") != "[cancel](cancel.md) | Cancels the specified operation.":
                                index_updated.write(line)


append_operation_yaml_en()
remove_cancel_operation_en()