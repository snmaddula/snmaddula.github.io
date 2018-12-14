echo "##############################################################################################"
echo "######################## Ansible & Ansible Tower (AWX) Lab Setup #############################"
echo "##########################       PART 01 (PRE-REBOOT)      ###################################"
echo "##############################################################################################"

# Disable Hyper-V
$hyperv = Get-WindowsOptionalFeature -FeatureName Microsoft-Hyper-V-All -Online
if($hyperv.State = "Disabled") {
    echo ">>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>> Hyper-V is already disabled."
} else {
    Disable-WindowsOptionalFeature -Online -FeatureName Microsoft-Hyper-V-All -NoRestart
    echo ">>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>> Disabled Hyper-V"
}

# Setup a Lab directory
New-Item -ItemType Directory -Path ~/__LAB__ -Force; cd ~/__LAB__

# Bypass SSL
echo ">>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>> Bypassing SSL"
[Net.ServicePointManager]::SecurityProtocol = [Net.SecurityProtocolType]::Tls12


$UninstallPath = (Get-ItemProperty HKLM:\Software\Microsoft\Windows\CurrentVersion\Uninstall\*)
$UninstallPath = $UninstallPath + (Get-ItemProperty HKLM:\Software\Wow6432Node\Microsoft\Windows\CurrentVersion\Uninstall\*)

$isGitInstalled = $UninstallPath | Where-Object { $null -ne $_.DisplayName -and $_.Displayname.Contains('Git') }
$isOVBInstalled = $UninstallPath | Where-Object { $null -ne $_.DisplayName -and $_.Displayname.Contains('Oracle VM VirtualBox') }
$isVagInstalled = $UninstallPath | Where-Object { $null -ne $_.DisplayName -and $_.Displayname.Contains('Vagrant') }

if($isGitInstalled) {
    echo ">>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>> Git is already Installed!"
} else {
    # Download Git
    $gitExists = Test-Path gitbin.exe -PathType Leaf
    if($gitExists) {
        echo ">>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>> Git binary already exists! Download Skipped!"
    } else {
        echo ">>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>> Git binary does not exist! Downloading Git!"
        Invoke-WebRequest -Uri https://github.com/git-for-windows/git/releases/download/v2.20.0.windows.1/Git-2.20.0-64-bit.exe -OutFile gitbin.exe
        echo ">>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>> Downloaded Git"
    }
    # Setup Git + SSH Client
    cmd "/C .\gitbin.exe /SP- /SILENT /NOCANCEL /NORESTART /COMPONENTS=icons,ext\reg\shellhere,assoc,assoc_sh";
    $env:Path="$env:Path;C:\Program Files\Git\bin\;C:\Program Files\Git\usr\bin\;"
    echo ">>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>> Git Setup Complete!"
}

if($isOVBInstalled) {
    echo ">>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>> VirtualBox is already Installed!"
} else {
    # Download VirtualBox
    $vboxExists = Test-Path vbox.exe -PathType Leaf
    if($vboxExists) {
        echo ">>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>> VirtualBox already exists! Download Skipped!"
    } else {
        echo ">>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>> VirtualBox does not exist! Downloading VirtualBox!"
        Invoke-WebRequest -Uri https://download.virtualbox.org/virtualbox/5.2.22/VirtualBox-5.2.22-126460-Win.exe -OutFile vbox.exe
        echo ">>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>> Downloaded VirtualBox"
    }

    # Setup VirtualBox
    cmd "/C .\vbox.exe -msiparams ADDLOCAL=VBoxApplication,VBoxUSB,VBoxNetwork,VBoxPython,VBoxNetworkFlt,VBoxNetworkAdp --silent";
    echo ">>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>> VirtualBox Setup Complete!"
}

if($isVagInstalled) {
    echo ">>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>> Vagrant is already Installed!"
} else {
    # Download Vagrant
    $vagExists = Test-Path vag.msi -PathType Leaf
    if($vagExists) {
        echo ">>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>> Vagrant already exists! Download Skipped!"
    } else {
        echo ">>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>> Vagrant does not exist! Downloading Vagrant!"
        Invoke-WebRequest -Uri https://releases.hashicorp.com/vagrant/2.2.2/vagrant_2.2.2_x86_64.msi -OutFile vag.msi
        echo ">>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>> Downloaded Vagrant"
    }

    # Setup Vagrant
    cmd "/C .\vag.msi"
    echo ">>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>> Vagrant Setup Complete!"
}
