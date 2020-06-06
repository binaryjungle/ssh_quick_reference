#Creating ssh keys
ssh-keygen -t rsa -b 4096 -C "vaithy31@gmail.com"

#Creating/Changing Passphrase
ssh-keygen -p

####### Manual addition of ssh-key to agent ###############

#Start ssh-agent
eval $(ssh-agent) #Not in background
eval $(ssh-agent -s) #In the background

#Add the key to the agent
ssh-add /e/Actionable/GitControlledPrograms/ssh_keys/vaithyanathan_ramanathan_rsa

###########################################################

#Testing connection to Github
ssh -T git@github.com

#Check keys of Github and Local is same
ssh-add -l -E md5 e:/Actionable/GitControlledPrograms/ssh_keys/vaithyanathan_ramanathan_rsa.pub

#### Auto-launch Authentication Agent (bash_profile) ######

env=~/.ssh/agent.env

agent_load_env () { test -f "$env" && . "$env" >| /dev/null ; }

agent_start () {
    (umask 077; ssh-agent >| "$env")
    . "$env" >| /dev/null ; }

agent_load_env

# agent_run_state: 0=agent running w/ key; 1=agent w/o key; 2= agent not running
agent_run_state=$(ssh-add -l >| /dev/null 2>&1; echo $?)

if [ ! "$SSH_AUTH_SOCK" ] || [ $agent_run_state = 2 ]; then
    agent_start
    ssh-add e:/Actionable/GitControlledPrograms/ssh_keys/vaithyanathan_ramanathan_rsa
	echo "Agent not running. Agent running and Key Added now"
elif [ "$SSH_AUTH_SOCK" ] && [ $agent_run_state = 1 ]; then
    ssh-add e:/Actionable/GitControlledPrograms/ssh_keys/vaithyanathan_ramanathan_rsa
	echo "Agent running without key. Key Added now"
fi

unset env

###########################################################