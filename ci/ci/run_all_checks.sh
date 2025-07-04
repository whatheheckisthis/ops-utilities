# ci/run_all_checks.sh

bash ci/verify_environment.sh
python ci/verify_imports.py
# Add more checks here if needed
run: |
  bash ci/run_all_checks.sh
