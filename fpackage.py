import os
import shutil
import json
import sys

from zipfile import ZipFile
from glob import glob
from pathlib import Path

mods_folder = os.path.expandvars(sys.argv[1])
cwd = os.getcwd() + "/" + sys.argv[2]

dbg = False

if dbg:
    print("Mods Folder: " + mods_folder)
    print("Working Dir: " + cwd)

mod_version = "0.0.0"
mod_name = ""

with open(cwd + "/info.json") as info:
    json_file = json.load(info)
    mod_version = json_file["version"]
    mod_name = json_file["name"]

mod_full_name = mod_name + "_" + mod_version

mod_output_path = cwd + "/" + mod_full_name + ".zip"

mod_output = os.listdir(cwd)
for mod in mod_output:
    if mod_name + "_" in mod:
        if dbg:
            print(cwd + "/" + mod)
        os.remove(cwd + "/" + mod)

if dbg:
    print("Output: " + mod_output_path)

if os.path.exists(mod_output_path):
    os.remove(mod_output_path)

with ZipFile(mod_output_path, 'w') as f:
    for root, dirs, files in os.walk(cwd):
        if Path(root).name.startswith("."):
            continue
        zip_root = mod_name + "/" + Path(root).relative_to(cwd).as_posix()
        for file_name in files:

            if not (".git" in file_name or file_name.endswith(".zip") or ".prototypes" in root or ".git" in root or file_name.endswith(".bat") or ".vscode" in root or file_name.endswith(".py") or "factorio-images" in root):
                f.write(root + "/" + file_name, zip_root + "/" + file_name)

mods = os.listdir(mods_folder)
for mod in mods:
    if mod_name + "_" in mod:
        if dbg:
            print(mods_folder + "/" + mod)
        os.remove(mods_folder + "/" + mod)

shutil.copyfile(mod_output_path, mods_folder + "/" + mod_full_name + ".zip")

print("Finished packaging mod: " + mod_full_name)