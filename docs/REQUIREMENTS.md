# Requirements

## Azure

Sculk was built for Azure, although the Ansible can be used on any cloud technically.

You can sign up for a free Azure account here: https://azure.microsoft.com/

### Cost

This Terraform uses a Standard B1 instance by default, which will cost approximately $7 a month to run.

### For Students

If you're a student, you can sign up for $100 of free promotional credit for Azure per year.  No credit card required.  There's also some other benefits as well to take advantage of.  

See here: https://azure.microsoft.com/en-us/free/students/

<small>Note: I wish I used this more when I was a student.</small>

## DuckDNS

This project uses DuckDNS for free DNS and to get Let's Encrypt certificates.

Sign up for free here using GitHub: https://www.duckdns.org/

## WireGuard

A WireGuard client is required to access sculk after it is fully setup.

Install the client for your OS here: https://www.wireguard.com/install/

## VS Code+Docker

This repository is equipped with a VS Code dev container that contains all of the necessary dependencies.  To take advantage of this, simply install Docker and VS Code, and open this repository in VS Code.  It should prompt you to re-open in a dev container, and once you do it will build the container and open VS Code from within the container.

## Git

You will need a git client to clone this repository.  Either install git in WSL or install [Git for Windows](https://git-scm.com/download/win).

## GitHub (optional)

If you have a GitHub account, you can fork this repository and commit any of your changes to your own repository to continue building on top of the project.

## Terraform Cloud (optional)

Terraform Cloud allows you to store the Terraform state remotely.  This helps in case something happens to the local copy of your Terraform state.

Sign up for free here (5 projects for free): https://cloud.hashicorp.com/products/terraform

Create a new organization and workspace, and [set the workspace to local execution.](https://developer.hashicorp.com/terraform/cloud-docs/workspaces/settings#execution-mode)

# Next

Next continue to [setup](./SETUP.md)