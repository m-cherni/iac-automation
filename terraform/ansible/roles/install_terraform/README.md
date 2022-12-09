# Role Name

This role "install_terraform" installs terraform on linux machines

## Requirements

- ansibe
- molecule
- molecule-docker
- yamllint
- ansible-lint
- docker
- python

For a complete list, please refer to the file requirements.txt

## Role Variables

- manual_installation: A boolean variable that indicates if the installation will be manual by downloading terraform or by using package manager. Default to false.
- terraform_install_directory: A string variable that indicates the location where to install terraform; Defaults to /usr/local/bin.
- system_version: A string variable that indicates the system type. Default to "linux_amd64".
- terraform_version: A string variable that indicates the tarreform version. Default to 1.1.3
- terraform_download_url: A string variable that define the url from where we can download terraform in case of manual installation.

## Dependencies

No dependencies for this role.

## Example Playbook

Including an example of how to use your role (for instance, with variables passed in as parameters) is always nice for users too:

```
- hosts: terraform
  become: true
  roles:
    - install-terraform
```

## Test Playbook

Run the command below to execute the tests.

```
# Linting
molecule lint

# Testing playbook
molecule converge

# Verification
molecule verify

# Idempotency
molecule idempotency

# To destroy resources
molecule destroy

```
