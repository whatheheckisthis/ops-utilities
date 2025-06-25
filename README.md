



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

## Directory Structure

```bash
.
├── generate.sh            # Encrypts input files
├── read.sh                # Decrypts input files
├── cleanup_logs.sh        # Deletes stale logs
├── check_venv.sh          # Checks Python venv state
├── backup_repo.sh         # GitHub repo mirroring
├── timestamp_tail.sh      # Adds timestamps to live logs
├── md_to_html.sh          # Converts markdown to HTML
├── init_environment.sh    # Environment readiness check
├── files/                 # Stores encrypted files
└── README.md              # This file
```

---

## License

This repo is licensed under the MIT License.




Decrypt a File
Interactive Mode
bash
Copy
Edit
./read.sh ./files/filename.dat
You’ll be prompted to enter the decryption passphrase:

text
Copy
Edit
Input passphrase to read the content: ******
Inline Passphrase (not recommended for sensitive use)
bash
Copy
Edit
./read.sh ./files/filename.dat yourpassphrase
Output to File
bash
Copy
Edit
./read.sh ./files/filename.dat > output.txt
Use Cases
Secure backups of SSH keys or API secrets

Encrypted config file storage in CI/CD pipelines

Support desk use for quick data protection/decryption workflows

