# Rundeck stack

Criamos uma stack que utiliza Terraform para criar o provisionamento de Infraestrutura e Ansible para gerência de configuração.

## Terraform

Rode o Terraform.

```
cd terraform
terraform init
terraform apply -auto-approve
```

## Ansible

Baixar a role necessária para o Rundeck.

```
docker run \
--rm \
-v $(pwd):/root \
-v /home/rafael/.ssh/id_rsa:/root/key.pem \
-w /root \
raffaeldutra/docker-ansible-2.8:1.0 \
ansible-galaxy install -r requirements.yml
```

Variável que é utilizada para guardar o IP da instância vinda do Terraofmr

```
rundeck_ip=$(terraform output -state=../terraform/terraform.tfstate nat_ip | grep [0-9] | sed 's/[", ]//g')
```

Docker fará a instalação de todo o Rundeck.

```
docker run \
--rm \
-v $(pwd):/root \
-v /home/rafael/.ssh/id_rsa:/root/key.pem \
-w /root \
raffaeldutra/docker-ansible-2.8:1.0 \
ansible-playbook -i ${rundeck_ip}, site.yml \
--extra-vars="{target: ${rundeck_ip}}" \
--extra-vars=rundeck_framework_server_hostname=${rundeck_ip} \
--extra-vars=rundeck_framework_server_name=${rundeck_ip} \
--extra-vars=rundeck_grails_serverURL="http://${rundeck_ip}:4440" \
--private-key=/root/key.pem
```