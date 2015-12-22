#FROM mrlesmithjr/ansible:ubuntu-12.04
#FROM mrlesmithjr/ansible:ubuntu-14.04
FROM mrlesmithjr/ansible

MAINTAINER mrlesmithjr@gmail.com

#Installs git
RUN apt-get update && apt-get install -y \
  git \
  && apt-get clean \
  && rm -rf /var/lib/apt/lists/* /tmp/* /var/tmp/*

#Clean up Ansible playbooks
#RUN rm -rf /opt/ansible-playbooks

#Clone docker ansible playbooks from GitHub
#RUN git clone https://github.com/mrlesmithjr/docker-ansible-playbooks.git /opt/ansible-playbooks/

#Create Ansible Folder
RUN mkdir -p /opt/ansible-playbooks/roles

#Clone GitHub Repo
RUN git clone https://github.com/mrlesmithjr/ansible-elk-kibana.git /opt/ansible-playbooks/roles/ansible-elk-kibana && \
  cd /opt/ansible-playbooks/roles/ansible-elk-kibana && \
  git checkout 4.1.4

#Copy Ansible requirements
#COPY requirements.yml /opt/ansible-playbooks/

#Install Ansible role requirements
#RUN ansible-galaxy install -r /opt/ansible-playbooks/elk-kibana/requirements.yml
#RUN ansible-galaxy install -r /opt/ansible-playbooks/requirements.yml

#Copy Ansible playbooks
COPY playbook.yml /opt/ansible-playbooks/

#Run Ansible playbook to install ELK-Kibana
#RUN ansible-playbook -i "localhost," -c local /opt/ansible-playbooks/elk-kibana/playbook.yml
RUN ansible-playbook -i "localhost," -c local /opt/ansible-playbooks/playbook.yml

#Remove Ansible roles
#RUN ansible-galaxy remove /etc/ansible/roles/*

#Clean up Ansible Playbooks
#RUN rm -rf /opt/ansible-playbooks

#Clean up APT
RUN apt-get clean

#Expose Ports
EXPOSE 5601

CMD ["/opt/kibana.sh"]
