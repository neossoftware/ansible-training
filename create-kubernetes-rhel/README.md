This Guide is to setup a Kubernetes cluster in AWS based on EC2 Vms - RHEL 9

This guide is based on this 
https://kanzal.com/kubernetes-with-kubeadm-on-redhat-9/

This is another to create sample cluster based on Ubuntu server
https://milindasenaka96.medium.com/setup-your-k8s-cluster-with-aws-ec2-3768d78e7f05

1.  Create 2 VMs 
   Master / Slave1
 a) Add a Security Group on MASter 
 Inbound                    Depending on VPC
 	Custom TCP	TCP	6443	172.31.0.0/16

2. Once are created  it is required to execute:

```
sudo useradd ansible
sudo mkdir -p /home/ansible
sudo chown ansible:ansible /home/ansible 
sudo passwd ansible

sudo visudo
ansible ALL=(ALL) NOPASSWD: ALL

```

3. Add SSH public key from ansible server to 2 VMs

4. from Ansible server execute ssh ec2-master-node-DNS to test conectivity

4. from Ansible server execute ssh ec2-slave1-node-DNS to test conectivity

If conectivity is OK execute from ansible server

Install kubernates base (kernel parameters, packages, etc)
ansible-playbook -i inventory k8-kube-dependencies-rhel-allnodes.yml

Initialize Control plane
ansible-playbook -i inventory k8-kube-dependencies-rhel-master.yml

