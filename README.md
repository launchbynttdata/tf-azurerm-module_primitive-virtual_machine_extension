# tf-azurerm-module_primitive-virtual_machine_extension

[![License](https://img.shields.io/badge/License-Apache_2.0-blue.svg)](https://opensource.org/licenses/Apache-2.0)
[![License: CC BY-NC-ND 4.0](https://img.shields.io/badge/License-CC_BY--NC--ND_4.0-lightgrey.svg)](https://creativecommons.org/licenses/by-nc-nd/4.0/)

## Overview

What does this module do?

## Usage

See [examples/complete](examples/complete) for a full working example.

## Module Development

### Pre-Requisites

The following commands should be available on your system:

- `asdf` or `mise`
- `make`
- `python3` (for pre-commit)

Additionally, your `git` user and email must be configured. Run the `make configure` command from the root of the repository to ensure that you meet these requirements.

### Pre-Commit hooks

The [.pre-commit-config.yaml](.pre-commit-config.yaml) file defines `pre-commit` hooks for Terraform formatting, validation, documentation generation, and detect-secrets. Hooks are installed when you run `make configure`. Go linting runs via `make lint` in local development and CI, not via pre-commit.

### Terratest examples

Post-deploy tests in `tests/post_deploy_functional/` and `tests/post_deploy_functional_readonly/` target `examples/complete` via an explicit folder constant in each `main_test.go`. Adding another example (for example `examples/minimal`) requires a new test entry point or updating that constant; it is not picked up automatically.

### Local Validation

You should validate the changes you make to any module locally, prior to pushing your changes in a branch to GitHub.

1. Ensure that you have run `make configure` successfully.
2. Ensure you are signed into the appropriate cloud provider (e.g. Azure) for the module under test in your current console session.
3. Run the Terraform and Golang linters:

```
make lint
```

4. Once linters pass, run integration tests (apply, test, destroy):

```
make test
```

The pre-commit validations, as well as the `make lint` and `make test` targets, are performed in CI. Running them locally before opening a PR helps ensure a smooth review.

### Review & Merge Process

Open a Pull Request to the default (`main`) branch. The PR title must follow [Conventional Commits](https://www.conventionalcommits.org/en/v1.0.0/#specification) format to merge and to drive semantic versioning.

Ensure CI workflows pass, address review feedback, and obtain approvals required by `CODEOWNERS`.

### Automatic Updates

Shared configuration and workflow files are largely managed through [launch-terraform-skeleton](https://github.com/launchbynttdata/launch-terraform-skeleton). Avoid one-off edits to copied skeleton files in this repository unless necessary (for example `.gitignore` entries for generated artifacts). Use `copier check-update` / `copier update` when refreshing from the skeleton.

<!-- BEGIN_TF_DOCS -->
## Requirements

| Name | Version |
|------|---------|
| <a name="requirement_terraform"></a> [terraform](#requirement\_terraform) | >= 1.5.0, < 2.0 |
| <a name="requirement_azurerm"></a> [azurerm](#requirement\_azurerm) | =3.77.0 |

## Modules

No modules.

## Resources

| Name | Type |
|------|------|
| [azurerm_virtual_machine_extension.virtual_machine_extension](https://registry.terraform.io/providers/hashicorp/azurerm/3.77.0/docs/resources/virtual_machine_extension) | resource |

## Inputs

| Name | Description | Type | Default | Required |
|------|-------------|------|---------|:--------:|
| <a name="input_auto_upgrade_minor_version"></a> [auto\_upgrade\_minor\_version](#input\_auto\_upgrade\_minor\_version) | (Optional) Specifies if the platform deploys the latest minor version update to the type\_handler\_version specified. | `bool` | `false` | no |
| <a name="input_automatic_upgrade_enabled"></a> [automatic\_upgrade\_enabled](#input\_automatic\_upgrade\_enabled) | (Optional) Should the Extension be automatically updated whenever the Publisher releases a new version of this VM Extension? | `bool` | `false` | no |
| <a name="input_failure_suppression_enabled"></a> [failure\_suppression\_enabled](#input\_failure\_suppression\_enabled) | (Optional) Should failures from the extension be suppressed? Possible values are true or false. | `bool` | `false` | no |
| <a name="input_name"></a> [name](#input\_name) | (Required) The name of the virtual machine extension peering. Changing this forces a new resource to be created. | `string` | n/a | yes |
| <a name="input_protected_settings"></a> [protected\_settings](#input\_protected\_settings) | (Optional) The protected\_settings passed to the extension, like settings, these are specified as a JSON object in a string. | `string` | `null` | no |
| <a name="input_protected_settings_from_key_vault"></a> [protected\_settings\_from\_key\_vault](#input\_protected\_settings\_from\_key\_vault) | (Optional) Map of protected settings from Key Vault. Can not be used with protected\_settings | <pre>object({<br/>    secret_url      = string<br/>    source_vault_id = string<br/>  })</pre> | `null` | no |
| <a name="input_publisher"></a> [publisher](#input\_publisher) | (Required) The publisher of the extension, available publishers can be found by using the Azure CLI. Changing this forces a new resource to be created. | `string` | n/a | yes |
| <a name="input_settings"></a> [settings](#input\_settings) | (Optional) The settings passed to the extension, these are specified as a JSON object in a string. Changing this forces a new resource to be created. | `string` | n/a | yes |
| <a name="input_tags"></a> [tags](#input\_tags) | (Optional) A mapping of tags to assign to the resource. | `map(string)` | `{}` | no |
| <a name="input_type"></a> [type](#input\_type) | (Required) The type of extension, available types for a publisher can be found using the Azure CLI. | `string` | n/a | yes |
| <a name="input_type_handler_version"></a> [type\_handler\_version](#input\_type\_handler\_version) | (Required) Specifies the version of the extension to use, available versions can be found using the Azure CLI. | `string` | n/a | yes |
| <a name="input_virtual_machine_id"></a> [virtual\_machine\_id](#input\_virtual\_machine\_id) | (Required) The ID of the Virtual Machine. Changing this forces a new resource to be created | `string` | n/a | yes |

## Outputs

| Name | Description |
|------|-------------|
| <a name="output_id"></a> [id](#output\_id) | The ID of the Virtual Machine Extension. |
<!-- END_TF_DOCS -->
