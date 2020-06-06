#Creating ssh keys
ssh-keygen -t rsa -b 4096 -C "vaithy31@gmail.com"

#Creating/Changing Passphrase
ssh-keygen -p

#Start ssh-agent
eval $(ssh-agent) #Not in background
eval $(ssh-agent -s) #In the background

#Add the key to the agent
ssh-add /e/Actionable/GitControlledPrograms/ssh_keys/vaithyanathan_ramanathan_rsa

#Testing connection to Github
ssh -T git@github.com

#Check keys of Github and Local is same
ssh-add -l -E md5 e:/Actionable/GitControlledPrograms/ssh_keys/vaithyanathan_ramanathan_rsa.pub
