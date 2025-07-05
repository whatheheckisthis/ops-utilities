# ops-utilities

**Bash Utilities for Secure Operations and Workflow Automation**

This repository provides a growing collection of secure, modular, and reusable shell scripts designed to support:

- CI/CD pipeline validation
- Environment bootstrapping
- Code linting and testing
- Log cleanup and operational hygiene
- System readiness and runtime import checks

Originally developed to support robust Conda-based validation and GitHub Actions workflows, this repo is evolving into a structured toolbox for managing operational scripts in a clean, testable, and reusable way.

---

## 📁 Directory Structure

```bash
.
├── ci/             # CI and workflow-specific scripts (import tests, env checks)
├── scripts/        # General-purpose automation and cleanup tools
├── config/         # Static configuration files (.flake8, environment.yml, etc.)
├── tests/          # Test coverage for critical CI and utility functions
├── docs/           # Internal documentation, contributing notes, and CI overview
├── bin/legacy/     # Archived scripts (retained for reference, not active)
├── .github/        # GitHub Actions workflows
└── README.md       # Project overview and usage


---

### 🔧 Legacy Utilities (Click to expand)

<details>
<summary><strong>Bash Utilities for Secure Operations and Daily Workflow Automation</strong></summary>

<br>

Encryption, decryption, secure file handling, and daily support-ready Bash tools designed for technical support, DevOps, and service workflows.

---

#### 1. Symmetric File Encryption Using OpenSSL

Encrypt a file:

```bash
./generate.sh path/to/your_file.txt
```

Decrypt (interactive mode):

```bash
./read.sh ./files/your_file.txt.dat
```

Decrypt (with inline passphrase):

```bash
./read.sh ./files/your_file.txt.dat yourpassphrase
```

Decrypt and save to file:

```bash
./read.sh ./files/your_file.txt.dat > output.txt
```

---

#### 2. Environment Bootstrapping

```bash
bash ./init_environment.sh
```

Creates:

* `files/` directory
* Checks for OpenSSL, Git, Docker
* Makes scripts executable

---

#### 3. Daily Bash Tools for Ops & Support

Clean logs older than 7 days:

```bash
bash ./cleanup_logs.sh /var/log
```

Check Python virtual environment:

```bash
bash ./check_venv.sh
```

Local GitHub repo backup:

```bash
bash ./backup_repo.sh https://github.com/whatheheckisthis/Crypto-Detector
```

Tail log with timestamps:

```bash
bash ./timestamp_tail.sh mylog.log
```

Convert Markdown to HTML:

```bash
bash ./md_to_html.sh file.md
```

---

#### 4. Use Cases

These scripts support:

* Pre-commit Git hooks
* Secure ops desk file handling
* Encrypted data telemetry pipelines
* Intern workflow bootstraps

---

#### 5. Setup Notes

Make sure scripts are executable:

```bash
chmod +x *.sh
```

Run full setup:

```bash
./init_environment.sh
```

---

#### File Tree

```
├── generate.sh
├── read.sh
├── cleanup_logs.sh
├── check_venv.sh
├── backup_repo.sh
├── timestamp_tail.sh
├── md_to_html.sh
├── init_environment.sh
├── generate_auto_changelog.sh
├── cleanup_changelog.sh
└── files/
```

---

#### Example Scripts

<details>
<summary><code>generate.sh</code> – Encrypt a file</summary>

```bash
#!/bin/bash
INPUT=$1
OUTDIR="files"
mkdir -p $OUTDIR

echo -n "Enter passphrase for encryption: "
read -s PASSPHRASE
echo

openssl enc -aes-256-cbc -salt -in "$INPUT" -out "$OUTDIR/$(basename "$INPUT").enc" -pass pass:$PASSPHRASE
echo "[✓] Encrypted file saved to $OUTDIR/$(basename "$INPUT").enc"
```

</details>

<details>
<summary><code>read.sh</code> – Decrypt a file</summary>

```bash
#!/bin/bash
INPUT=$1

echo -n "Enter passphrase to decrypt: "
read -s PASSPHRASE
echo

openssl enc -d -aes-256-cbc -in "$INPUT" -pass pass:$PASSPHRASE
```

</details>

<details>
<summary><code>cleanup_logs.sh</code> – Clean old log files</summary>

```bash
#!/bin/bash
find . -type f -name "*.log" -mtime +7 -exec rm -v {} \;
echo "[✓] Old logs cleaned up"
```

</details>

<details>
<summary><code>check_venv.sh</code> – Check virtual environment</summary>

```bash
#!/bin/bash
if [[ "$VIRTUAL_ENV" != "" ]]; then
  echo "[✓] Virtual environment is active: $VIRTUAL_ENV"
else
  echo "[✗] No virtual environment detected"
fi
```

</details>

<details>
<summary><code>backup_repo.sh</code> – Backup GitHub repo</summary>

```bash
#!/bin/bash
REPO_DIR=$1
BACKUP_DIR="repo_backup_$(date +%F_%T)"
mkdir "$BACKUP_DIR"
cp -r "$REPO_DIR" "$BACKUP_DIR"
echo "[✓] Repository backed up to $BACKUP_DIR"
```

</details>

<details>
<summary><code>timestamp_tail.sh</code> – Add timestamps to log tail</summary>

```bash
#!/bin/bash
FILE=$1
tail -f "$FILE" | while read line; do
  echo "[$(date +%F_%T)] $line"
done
```

</details>

<details>
<summary><code>md_to_html.sh</code> – Convert Markdown to HTML</summary>

```bash
#!/bin/bash
INPUT=$1
OUTPUT="${INPUT%.md}.html"
pandoc "$INPUT" -o "$OUTPUT"
echo "[✓] Converted $INPUT to $OUTPUT"
```

</details>

<details>
<summary><code>init_environment.sh</code> – Environment bootstrap</summary>

```bash
#!/bin/bash
./check_venv.sh
./generate_auto_changelog.sh
echo "[✓] Environment ready"
```

</details>

<details>
<summary><code>generate_auto_changelog.sh</code> – Git changelog</summary>

```bash
#!/bin/bash
OUTFILE="AUTO_CHANGELOG.md"
echo "# Auto-generated Changelog" > $OUTFILE
echo "" >> $OUTFILE
git log --pretty=format:'- %ad: %s' --date=short >> $OUTFILE
echo "[✓] Changelog written to $OUTFILE"
```

</details>

<details>
<summary><code>cleanup_changelog.sh</code> – Clean changelog</summary>

```bash
#!/bin/bash
FILE="AUTO_CHANGELOG.md"
if [[ -f "$FILE" ]]; then
  awk '!seen[$0]++' "$FILE" | sed '/^$/d' > tmp && mv tmp "$FILE"
  echo "[✓] Cleaned $FILE"
else
  echo "[✗] $FILE not found"
fi
```

</details>

---

</details>  
<!-- End legacy block -->
---

Let me know if you’d like to auto-link these scripts to their future `bin/legacy/` paths or include CI shields.




