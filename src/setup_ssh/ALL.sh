echo "Allowing auto accepting new ssh keys systemwide"
echo "    StrictHostKeyChecking accept-new" | sudo tee -a /etc/ssh/ssh_config >/dev/null #skip yes/no prompt when connecting to new ssh host
echo ""

echo "Activating SSH Server for SSH login"
sudo -i mkdir /run/sshd
sudo systemctl enable ssh
sudo systemctl start ssh
echo ""

echo "Generating SSH Key"
if [ -f ~/.ssh/id_rsa ]; then
    echo "SSH Key already present, not overwriting"
else
    ssh-keygen -t rsa -N "" -f ~/.ssh/id_rsa #options are preventing prompts
fi
echo ""

echo "Copying SSH Key to Gutruhn (My NAS)"
sudo apt install sshpass -y #can put ssh passwords in automatically (stdin doesnt work because of openssh design choices)

sshpass -p "$PASSWORD" ssh-copy-id Aki@toasteruwu.com #this is my NAS, which i connect to via sshfs (SFTP with Fuse)
echo ""
