
# Bash Utilities for Secure Operations and Daily Workflow Automation

Encryption, decryption, secure file handling, and daily support-ready Bash tools designed for technical support, DevOps, and service workflows.



## 1. Symmetric File Encryption Using OpenSSL

This utility provides a fast, repeatable method to encrypt and decrypt files using symmetric AES-256 encryption via OpenSSL. All logic is encapsulated in Bash scripts and does not require additional tools beyond a Unix-based shell.



### Encrypt a File

```bash
./generate.sh path/to/your_file.txt
```

* Prompts for a passphrase.
* Encrypted output is saved to the `./files` directory with a `.dat` extension.

---

### Decrypt (interactive mode)

```bash
./read.sh ./files/your_file.txt.dat
```

* Prompts for the passphrase.
* Decrypted content is printed directly to the terminal.

---

### Decrypt (with inline passphrase)

```bash
./read.sh ./files/your_file.txt.dat yourpassphrase
```

* Avoids interactive input.
* Outputs content to terminal.

---

### Decrypt and Save Output to File

```bash
./read.sh ./files/your_file.txt.dat > output.txt
```

* Allows storing decrypted content for pipeline use.

---

## 2. Environment Bootstrapping Script

Run this script to set up a local working directory and ensure dependencies like OpenSSL, Git, and Docker are installed.

```bash
bash ./init_environment.sh
```

Creates:

* `files/` directory (if not present)
* Checks for OpenSSL installation
* Checks Docker installation
* Grants execution permission to scripts

---

## 3. Daily Bash Tools for Ops & Support Teams

### Clean Logs Older Than 7 Days

```bash
bash ./cleanup_logs.sh /var/log
```

* Automatically deletes files older than 7 days in the specified directory.

---

### Check for Active Python Virtual Environment

```bash
bash ./check_venv.sh
```

* Returns environment status and exits with code `1` if inactive.

---

### Local GitHub Repo Backup (No API)

```bash
bash ./backup_repo.sh https://github.com/whatheheckisthis/Crypto-Detector
```

* Creates a compressed `.tar.gz` mirror backup of the given repo.

---

### Tail Log With Timestamps

```bash
bash ./timestamp_tail.sh mylog.log
```

* Prepends ISO 8601 timestamp to every line from a live `tail -f`.

---

### Convert Markdown to HTML

```bash
bash ./md_to_html.sh file.md
```

* Converts `.md` files to `.html` using Pandoc (requires Pandoc to be pre-installed).

---

## 4. How to Use in a Workflow

These scripts can be integrated with:

* Pre-commit Git hooks for secret scanning
* Release log documentation
* Secure file exchanges between service desks
* Intern operational readiness in secure environments
* Edge-to-cloud file pipelines for encrypted telemetry (e.g., as implemented in CARLA lane detection)

---

## 5. Setup Notes

Ensure the following permissions are applied:

```bash
chmod +x *.sh
```

Run the full environment init with:

```bash
./init_environment.sh
```

---


### File Tree:

```
├── generate.sh             # Encrypts input files with OpenSSL
├── read.sh                 # Decrypts encrypted files
├── cleanup_logs.sh         # Deletes stale `.log` files
├── check_venv.sh           # Checks if Python venv is active
├── backup_repo.sh          # Mirrors GitHub repo to backup folder
├── timestamp_tail.sh       # Adds timestamp to live `tail -f` output
├── md_to_html.sh           # Converts Markdown files to HTML
├── init_environment.sh     # Bootstraps VCS/venv/changelog check
├── generate_auto_changelog.sh  # Generates CHANGELOG from Git
├── cleanup_changelog.sh        # Cleans blank/duplicate entries
└── files/                  # Folder to store encrypted files
```

---

###  `generate.sh`

```bash
#!/bin/bash
# Encrypts a file using OpenSSL with AES-256 encryption

INPUT=$1
OUTDIR="files"
mkdir -p $OUTDIR

echo -n "Enter passphrase for encryption: "
read -s PASSPHRASE
echo

openssl enc -aes-256-cbc -salt -in "$INPUT" -out "$OUTDIR/$(basename "$INPUT").enc" -pass pass:$PASSPHRASE
echo "[✓] Encrypted file saved to $OUTDIR/$(basename "$INPUT").enc"
```

---

###  `read.sh`

```bash
#!/bin/bash
# Decrypts an encrypted file using OpenSSL

INPUT=$1

echo -n "Enter passphrase to decrypt: "
read -s PASSPHRASE
echo

openssl enc -d -aes-256-cbc -in "$INPUT" -pass pass:$PASSPHRASE
```

---

### `cleanup_logs.sh`

```bash
#!/bin/bash
# Deletes .log files older than 7 days from current directory

find . -type f -name "*.log" -mtime +7 -exec rm -v {} \;
echo "[✓] Old logs cleaned up"
```

---

###  `check_venv.sh`

```bash
#!/bin/bash
# Checks whether a Python virtual environment is active

if [[ "$VIRTUAL_ENV" != "" ]]; then
  echo "[✓] Virtual environment is active: $VIRTUAL_ENV"
else
  echo "[✗] No virtual environment detected"
fi
```

---

###  `backup_repo.sh`

```bash
#!/bin/bash
# Mirrors a GitHub repository to a local backup folder

REPO_DIR=$1
BACKUP_DIR="repo_backup_$(date +%F_%T)"
mkdir "$BACKUP_DIR"
cp -r "$REPO_DIR" "$BACKUP_DIR"
echo "[✓] Repository backed up to $BACKUP_DIR"
```

---

### `timestamp_tail.sh`

```bash
#!/bin/bash
# Adds timestamps to the output of tail -f

FILE=$1
tail -f "$FILE" | while read line; do
  echo "[$(date +%F_%T)] $line"
done
```

---

###  `md_to_html.sh`

```bash
#!/bin/bash
# Converts a Markdown file to HTML using pandoc

INPUT=$1
OUTPUT="${INPUT%.md}.html"

pandoc "$INPUT" -o "$OUTPUT"
echo "[✓] Converted $INPUT to $OUTPUT"
```

---

### `init_environment.sh`

```bash
#!/bin/bash
# Preps environment by checking VCS, venv, and updating changelog

./check_venv.sh
./generate_auto_changelog.sh
echo "[✓] Environment ready"
```

---

### `generate_auto_changelog.sh`

```bash
#!/bin/bash
# Generates a changelog from Git history into AUTO_CHANGELOG.md

OUTFILE="AUTO_CHANGELOG.md"
echo "# Auto-generated Changelog" > $OUTFILE
echo "" >> $OUTFILE
git log --pretty=format:'- %ad: %s' --date=short >> $OUTFILE
echo "[✓] Changelog written to $OUTFILE"
```

---

### `cleanup_changelog.sh`

```bash
#!/bin/bash
# Cleans up AUTO_CHANGELOG.md by removing blank lines and duplicate entries

FILE="AUTO_CHANGELOG.md"
if [[ -f "$FILE" ]]; then
  awk '!seen[$0]++' "$FILE" | sed '/^$/d' > tmp && mv tmp "$FILE"
  echo "[✓] Cleaned $FILE"
else
  echo "[✗] $FILE not found"
fi
```

---



## License

This repo is licensed under the MIT License.


