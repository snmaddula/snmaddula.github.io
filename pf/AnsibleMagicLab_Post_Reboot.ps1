echo "##############################################################################################"
echo "######################## Ansible & Ansible Tower (AWX) Lab Setup #############################"
echo "##########################       PART 02 (POST-REBOOT)      ##################################"
echo "##############################################################################################"
# Switch to Lab directory
cd ~/__LAB__
# Clone ansible magic repo
cmd "/C git clone -b box https://github.com/snmaddula/ansible-magic-lab.git"; cd ansible-magic-lab
# Spin up Lab
cmd "/c vagrant up"

# Fetch AWX IP
vagrant ssh -c "hostname -I | cut -d ' ' -f2"


echo "Congratulations! You're all set now!"
echo "Use the above IP address in your browser to access Ansible Tower (AWX)"
echo "CREDENTIALS:
echo "            username : admin"
echo "            password : password"
