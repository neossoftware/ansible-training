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

Once it is completed the scripts login on master node 

and execute 

   mkdir -p $HOME/.kube
  sudo cp -i /etc/kubernetes/admin.conf $HOME/.kube/config
  sudo chown $(id -u):$(id -g) $HOME/.kube/config

  then validate cluster using

  kubectl get nodes 

  ansible@ip-172-31-45-169 ~]$ kubectl get nodes
NAME                            STATUS   ROLES           AGE    VERSION
ip-172-31-45-169.ec2.internal   Ready    control-plane   4m8s   v1.28.3

On master execute this command to get the token to add each worker node in the cluster
 sudo kubeadm token create --print-join-command
 p.e 

Login on each node an execute the output of previous command

sudo kubeadm join 172.31.45.169:6443 --token ufwkdj.zepxe1hiokhozlxu --discovery-token-ca-cert-hash sha256:951b6eb0253170fb099815cb0e2c732702631056c525d279d76961569d513228