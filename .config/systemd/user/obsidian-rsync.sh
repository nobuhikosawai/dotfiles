#!/bin/sh
rsync -avrh /home/nobuhikosawai/Obsidian/Vault/ /home/nobuhikosawai/Dropbox/App/Obsidian/Current_Vault_Backup/
rsync -avrh /home/nobuhikosawai/Obsidian/Private/ /home/nobuhikosawai/Dropbox/App/Obsidian/Current_Private_Backup/
rsync -avrh /home/nobuhikosawai/Obsidian/Imported/ /home/nobuhikosawai/Dropbox/App/Obsidian/Current_Imported_Backup/
