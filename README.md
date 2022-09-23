
    # Using Terraform to Create an Environment

    ## Overview

    Using Provisioner uses [terraform] to create an apache virtual
    machines on [AWS Cloud]. The [terraform] job expects
    variables set as environment variables or in a `terraform.tfvars` file.


    **NOTE**: [Terraform][tfhome] must be version 0.12 or greater.

    ## Getting Started

    ### How Terraform Stores Current State

    [Terraform][tfhome] stores cluster state data in
    `.terraform/terraform.tfstate` by default. Configuring the `prefix` and
    `bucket` variables will enable storage in a remote bucket instead and is
    useful for sharing state among multiple administrators. The following
    resources provide some useful background information.

    ---
    ## Guides
    - [Learn Ubuntu Apache2](https://www.howtoforge.com/how-to-configure-apache-virtual-hosts-on-ubuntu-using-terraform/)
    - [Learn Ubuntu Apache2](https://www.digitalocean.com/community/tutorials/how-to-install-the-apache-web-server-on-ubuntu-22-04)
    - [Learn HTML Setup](https://opensource.com/article/18/2/apache-web-server-configuration)
    - [Learn Ceate new infrastructer in existing](https://stackoverflow.com/questions/47665428/how-to-launch-ecs-in-an-existing-vpc-using-terraform)
    ---

    ### Running Terraform

    Run the following to ensure ***terraform*** will only perform the expected
    actions:

    ```sh
    terraform plan
    ```

    Run the following to apply the configuration to the target AWS
    environment:

    ```sh
    terraform apply
    ```
    ### Tearing Down the Terraformed Cluster

    Run the following to verify that ***terraform*** will only impact the expected
    nodes and then tear down the cluster.

    ```sh
    terraform plan
    terraform destroy
    ```


   [tfhome]: https://www.terraform.io
    [tfgoogle]: https://registry.terraform.io/providers/hashicorp/aws/latest/docs
