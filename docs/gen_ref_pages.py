"""Generate the code reference pages."""

from pathlib import Path
import socialgene
import mkdocs_gen_files

nav = mkdocs_gen_files.Nav()
src_dir = Path(socialgene.__file__).parent

for path in sorted(src_dir.rglob("*.py")):  #
    module_path = path.relative_to(src_dir.parent).with_suffix("")  #
    doc_path = path.relative_to(src_dir).with_suffix(".md")  #
    full_doc_path = Path("reference", doc_path)  #
    parts = list(module_path.parts)
    if parts[-1] == "__init__":  #
        continue
    elif parts[-1] == "__main__":
        continue
    elif parts[-1] == "config":
        continue
    if path.parent.name in ["schema", "search"] and path.parent.parent.name == "neo4j":
        continue
    nav[parts] = doc_path.as_posix()  #
    with mkdocs_gen_files.open(full_doc_path, "w") as fd:  #
        identifier = ".".join(parts)  #
        print("::: " + identifier, file=fd)  #
    mkdocs_gen_files.set_edit_path(full_doc_path, path)  #

with mkdocs_gen_files.open("reference/SUMMARY.md", "w") as nav_file:
    nav_file.writelines(nav.build_literate_nav())
