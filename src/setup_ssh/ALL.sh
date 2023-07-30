echo "Allowing auto accepting new ssh keys systemwide"
echo "    StrictHostKeyChecking accept-new" | sudo tee -a /etc/ssh/ssh_config >/dev/null #skip yes/no prompt when connecting to new ssh host
echo ""

echo "Activating SSH Server for SSH login"
sudo systemctl enable ssh
sudo systemctl start ssh
echo ""

echo "Generating SSH Key"
ssh-keygen -t rsa -N "" -f ~/.ssh/id_rsa #options are preventing prompts
echo ""
