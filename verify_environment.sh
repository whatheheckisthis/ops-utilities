# Rename the file
mv ci/init_environment.sh ci/verify_environment.sh

# Then update your GitHub Actions workflow
- name: Environment readiness verification
  shell: bash -l {0}
  run: |
    bash ci/verify_environment.sh
