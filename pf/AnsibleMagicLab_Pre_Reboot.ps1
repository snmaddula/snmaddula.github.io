echo "##############################################################################################"
echo "######################## Ansible & Ansible Tower (AWX) Lab Setup #############################"
echo "##########################       PART 01 (PRE-REBOOT)      ###################################"
echo "##############################################################################################"

# Disable Hyper-V
Disable-WindowsOptionalFeature -Online -FeatureName Microsoft-Hyper-V-All -NoRestart
echo ">>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>> Disabled Hyper-V"

# Setup a Lab directory
New-Item -ItemType Directory -Path ~/__LAB__ -Force; cd ~/__LAB__

# Bypass SSL
echo ">>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>> Bypassing SSL"
[Net.ServicePointManager]::SecurityProtocol = [Net.SecurityProtocolType]::Tls12

# Grab Git, VirtualBox, & Vagrant
Invoke-WebRequest -Uri https://github.com/git-for-windows/git/releases/download/v2.20.0.windows.1/Git-2.20.0-64-bit.exe -OutFile gitbin.exe
echo ">>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>> Downloaded Git"
Invoke-WebRequest -Uri https://download.virtualbox.org/virtualbox/5.2.22/VirtualBox-5.2.22-126460-Win.exe -OutFile vbox.exe
echo ">>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>> Downloaded VirtualBox"
Invoke-WebRequest -Uri https://releases.hashicorp.com/vagrant/2.2.2/vagrant_2.2.2_x86_64.msi -OutFile vag.msi
echo ">>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>> Downloaded Vagrant"

# Setup Git + SSH Client
cmd "/C .\gitbin.exe /SP- /SILENT /NOCANCEL /NORESTART /COMPONENTS=icons,ext\reg\shellhere,assoc,assoc_sh";
$env:Path="$env:Path;C:\Program Files\Git\bin\;C:\Program Files\Git\usr\bin\;"
rm gitbin.exe -ErrorAction Ignore
echo ">>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>> Git Setup Complete!"

# Setup VirtualBox
cmd "/C .\vbox.exe -msiparams ADDLOCAL=VBoxApplication,VBoxUSB,VBoxNetwork,VBoxPython,VBoxNetworkFlt,VBoxNetworkAdp --silent";
rm vbox.exe -ErrorAction Ignore
echo ">>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>> VirtualBox Setup Complete!"

# Setup Vagrant
cmd "/C .\vag.msi"
rm vag.exe -ErrorAction Ignore
echo ">>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>> Vagrant Setup Complete!"
