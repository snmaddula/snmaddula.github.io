echo "##############################################################################################"
echo "######################## Ansible & Ansible Tower (AWX) Lab Setup #############################"
echo "##########################       PART 02 (POST-REBOOT)      ##################################"
echo "##############################################################################################"

# Switch / Setup a Lab directory
New-Item -ItemType Directory -Path ~\__LAB__ -Force; cd ~\__LAB__

# Clone ansible magic repo
#Remove-Item -Path ~/__LAB__\ansible-magic-lab -Recurse -ErrorAction Ignore
Remove-Item .\ansible-magic-lab -Force  -Recurse -ErrorAction SilentlyContinue
cmd "/C git clone -b box https://github.com/snmaddula/ansible-magic-lab.git"; cd ansible-magic-lab

# Spin up Lab
cmd "/C vagrant destroy"
#cmd "/C vagrant box remove snmaddula/ubuntu"
cmd "/c vagrant up"

# Fetch AWX IP
vagrant ssh -c "hostname -I | cut -d ' ' -f2"


echo "Congratulations! You're all set now!"
echo "Use the above IP address in your browser to access Ansible Tower (AWX)"
echo "CREDENTIALS:"
echo "            username : admin"
echo "            password : password"
