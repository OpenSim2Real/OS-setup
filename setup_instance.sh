#!/bin/bash

#CHange these
USER_GITHUB_EMAIL = "horvath.dawson@gmail.com"
USER_NAME = "DAWSON HORVATH"

# Install Ignition Fortress
sudo apt-get update
sudo apt-get install lsb-release wget gnupg
sudo wget https://packages.osrfoundation.org/gazebo.gpg -O /usr/share/keyrings/pkgs-osrf-archive-keyring.gpg
echo "deb [arch=$(dpkg --print-architecture) signed-by=/usr/share/keyrings/pkgs-osrf-archive-keyring.gpg] http://packages.osrfoundation.org/gazebo/ubuntu-stable $(lsb_release -cs) main" | sudo tee /etc/apt/sources.list.d/gazebo-stable.list > /dev/null
sudo apt-get update
sudo apt-get install -Y ignition-fortress

# Set Env variable for ignition
echo 'export IGN_GAZEBO_PHYSICS_ENGINE_PATH=${IGN_GAZEBO_PHYSICS_ENGINE_PATH}:/usr/lib/x86_64-linux-gnu/ign-physics-5/engine-plugins/' >> ~/.bashrc

sudo apt install -Y python3-pip swig screen
sudo apt-get install -Y build-essential libeigen3-dev libxml2-dev coinor-libipopt-dev libassimp-dev libirrlicht-dev
pip install --upgrade pip
# Pip install gym and depends
pip install gym==v0.21.0
pip install --pre scenario gym-ignition
pip install git+https://github.com/OpenSim2Real/gym-os2r.git

# pip install torch
pip install torch torchvision torchaudio

# Pip install Wandb and log in
echo "Please copy the authorization key from wandb and paste it into your command line when asked to authorize your account."
echo ""
echo "After completing click enter to continue."

read -p "After reading instructions. Press enter to continue" yn

pip install wandb
wandb login

git config --global user.name $USER_NAME
git config --global user.email $USER_GITHUB_EMAIL


# Pip install Wandb and log in
echo "Generate SSH key for github."
echo ""
echo "In next step you can press enter three times. No need for a password unless you want one..."

read -p "After reading instructions. Press enter to continue" yn


ssh-keygen -t ed25519 -C $USER_GITHUB_EMAIL
eval "$(ssh-agent -s)"
ssh-add ~/.ssh/id_ed25519

# Pip install Wandb and log in
echo "Please copy the SSH key below and paste it into your github ssh keys."
echo ""

cat ~/.ssh/id_ed25519.pub

