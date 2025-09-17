## Ansible Role: task

This role installs the [Task](https://taskfile.dev/) command-line tool on your server, which is used to run tasks defined in `Taskfile.yaml`.

**How it works:**
- Checks if `/usr/local/bin/task` exists (idempotent install).
- If not present, downloads and installs the latest Task binary using the official install script.
- Uses `become: true` to ensure proper permissions for installation.

**Usage:**
This role is included in the main Ansible playbook and will ensure Task is available for subsequent automation steps.

**Example playbook snippet:**
```yaml
roles:
   - task
```

# Application Documentation

## Tools Used

1. **Docker**: Containerization platform used for packaging applications and their dependencies.
2. **AWS and AWS CLI**: Cloud computing platform and its command-line interface used for managing AWS services.
3. **Git**: Version control system used for tracking changes in the application codebase.
4. **Ansible**: Configuration management tool used for automating the deployment and configuration of infrastructure.
5. **Terraform**: Infrastructure as Code (IaC) tool used for provisioning and managing AWS infrastructure.
6. **SSM Parameter**: AWS Systems Manager Parameter Store used for storing Doppler token.
7. **Doppler**: Secret and configuration management tool used for managing application secrets and environment variables.

## Infrastructure Diagram

![Untitled Diagram drawio (1)](https://github.com/anshultaak/demo-app/assets/76546821/c1d36988-76b6-4cd5-9ead-628fc41753f7)

## Infrastructure Setup

1. **Terraform Setup**:
   - Infrastructures have been set up by Terraform.
   - Make sure Terraform is installed on your local machine. You can follow the installation steps [here](https://developer.hashicorp.com/terraform/tutorials/aws-get-started/install-cli).
   - Change directory to `cd terraform/dev`.
   - Ensure AWS CLI has been configured and update the profile name in `main.tf`.
   - Run `terraform init` command to initialize Terraform configurations.
   - Run `terraform plan` command to see plan
   - RUN `terraform apply` command to Deploy the Infrastructure
     
   ### Explanation of Module Parameters

| Parameter             | Description                                  | Value                      |
|-----------------------|----------------------------------------------|----------------------------|
| `source`              | Path to the module source                    | `../../modules/`           |
| `env`                 | Environment name                             | `test`                     |
| `project`             | Project name                                 | `demo`                     |
| `key_name`            | Key pair name used for the instances         | `demo-test`                |
| `vpc_id`              | ID of the VPC where resources will be deployed | `vpc-784fcc02`             |
| `subnet_id`           | ID of the subnet where instances will be launched | `subnet-a53c418b`          |
| `length`              | Number of instances to launch                | `1`                        |
| `instance_type`       | Type of instance                             | `t3.medium`                |
| `ami`                 | AMI ID for the instance                      | `ami-0e001c9271cf7f3b9`    |
| `volume_size`         | Size of the EBS volume                       | `50`                       |
| `volume_type`         | Type of the EBS volume                       | `gp3`                      |
| `encrypted`           | Whether the EBS volume is encrypted          | `true`                     |
| `delete_on_termination`| Whether to delete the volume on termination of the instance | `false`                    |
| `eip`                 | Whether to allocate an Elastic IP to the instance | `true`                     |
| `load_balancer`       | Whether to use a load balancer               | `false`                    |
| `ssh_ports`           | Ports to open for SSH access                 | `[22]`                     |
| `ssh_cidr_block`      | CIDR block allowed to access the instance via SSH | `["0.0.0.0/0"]`           |
| `web_ports`           | Ports to open for web access                 | `[80, 443]`                |
| `web_cidr_blocks`     | CIDR blocks allowed to access the instance via web ports | `["0.0.0.0/0"]`           |
| `iam_role`            | IAM role assigned to the instance            | `ssm_parameter`            |

2. **Ansible Setup**:
   - Install required packages on the server using Ansible. 
   - Make sure Ansible is installed on your system. You can follow the installation steps [here](https://docs.ansible.com/ansible/latest/installation_guide/intro_installation.html).
   - Change directory to `cd ansible`.
   - Run the Ansible playbook using the following command:
     ```
     ansible-playbook -i dev main.yaml -u ubuntu --private-key $PRIVATE_KEY_PATH
     ```
   - Ansible will install AWS CLI, Docker, Git, Zip, Task, and Doppler packages on the server.

## Deploy the Application

1. **Clone Repository and Deploy**:
   - SSH into the server: `ssh ubuntu@IP -i $PRIVATE_KEY_PATH`.
   - Clone the repository: `git clone https://github.com/anshultaak/demo-app.git`.
   - Run the `taskfile.yaml` to deploy the application.
     - Use `task deploy_app` command to deploy the application.
     - Use `task clean` command to clean the running Docker containers.

## Taskfile.yaml Explanation

1. **Environment Configuration**:
   - Define environment variables in the YAML file:
     - `container_name`: Name of the application container.
     - `hadolint_config`: Path to the Hadolint YAML file.
     - `hadolint_image`: Name of the Hadolint Docker image.
     - `local_port`: Local server port to access the application.
     - `container_port`: Port inside the Docker container.

2. **Tasks**:
   - **build**: Docker image build command.
   - **lint**: Review Dockerfile using Hadolint for code quality.
   - **deploy**: Deploy the application without Doppler environment.
   - **deploywithdoppler**: Deploy the application using Doppler environment.
   - **test**: Run `test.sh` script to check application functionality.
   - **clean**: Clean the running application Docker containers.
   - **deploy_app**: Run multiple tasks together: clean, build, lint, deploywithdoppler, and test.
   - **force_clean**: Clean the all Docker containers.
   - **images_clean**: Clean the all Docker images.

## Hadolint Explanation

1. **Purpose**:
   - Hadolint is used to lint your Dockerfile, ensuring it follows best practices and coding standards.

2. **Configuration**:
   - Configuration for Hadolint is defined in the `hadolint.yaml` file.
   - Key configuration options include:
     - **failure-threshold**: Specifies the threshold level for reporting issues (e.g., `error`, `warning`, `info`, `style`, `ignore`, `none`).
     - **trustedRegistries**: Defines trusted URLs that can be used in the Dockerfile.
     - **ignored**: Specifies which errors should be ignored during linting.

3. **Documentation**:
   - For more detailed information and additional configuration options, refer to the [Hadolint documentation](https://github.com/hadolint/hadolint).
