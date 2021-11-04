export ZSH="$HOME/.oh-my-zsh"
ZSH_THEME="robbyrussell"

DISABLE_UPDATE_PROMPT="true"
ENABLE_CORRECTION="true"
COMPLETION_WAITING_DOTS="true"
DISABLE_UNTRACKED_FILES_DIRTY="true"

# zsh completions
# fpath=(/usr/local/share/zsh-completions $fpath)
if type brew &>/dev/null; then
	FPATH=$(brew --prefix)/share/zsh-completions:$FPATH

	autoload -Uz compinit
	compinit
fi

# plugins=(
#   docker
#   docker-compose
#   git
#   kubectl
#   nvm
#   osx
#   postgres
#   pyenv
#   python
#   virtualenv
#   yarn
# )
plugins=(
  git
	kubectl
)

source $ZSH/oh-my-zsh.sh

export VOLTA_HOME="$HOME/.volta"
export PATH="$VOLTA_HOME/bin:$PATH"

test -e "${HOME}/.iterm2_shell_integration.zsh" && source "${HOME}/.iterm2_shell_integration.zsh"

# Poetry
export PATH="$HOME/.poetry/bin:$PATH"

# PyEnv and Pyenv Virtualenv
if command -v pyenv 1>/dev/null 2>&1; then
  eval "$(pyenv init -)"
  eval "$(pyenv virtualenv-init -)"
fi

# VIM
export EDITOR=/usr/bin/vim
export VISUAL=/usr/bin/vim

# GPG
export GPG_TTY=$(tty)

# Testing alias
alias test-vars="set -a && . ./variables-test.env && set +a"

# iTerm2 Shell Integration
test -e "${HOME}/.iterm2_shell_integration.zsh" && source "${HOME}/.iterm2_shell_integration.zsh"

qsi-db() (
  set -euo pipefail

  kubectl run -it psql-`whoami` --image=dencold/pgcli  --restart=Never --overrides='{
    "spec": {
      "containers": [{
        "name": "psql",
        "command": ["bash", "-c", "pgcli $bespin"],
        "image": "dencold/pgcli",
        "tty": true,
        "stdin": true,
        "envFrom": [
          {"secretRef": {"name": "databases"}}
        ]
      }]
    }
  }' --rm
)

ecr-login () {
	account_id=`aws sts get-caller-identity | jq .Account -r`
	region=`aws configure get region`
	aws ecr get-login-password | docker login --username AWS --password-stdin $account_id.dkr.ecr.$region.amazonaws.com/
}

qsi-push-dev () {
	(
		set -euo pipefail
		cur_ctx=`kubectl config current-context`
		if [[ $cur_ctx != "dev"* ]]
		then
			echo "you can use only this command on the dev cluster!"
			exit 1
		fi
		BUILD=`date +'%Y-%m-%dT%H-%M-%S'`
		IMAGE=`cat .circleci/config.yml | tr '\n' ' ' | sed 's/.*IMAGE: \([^ ]*\).*/\1/'`
		TAG=300212233050.dkr.ecr.us-east-1.amazonaws.com/$IMAGE:$BUILD
		docker build $@ -t $TAG .
		ecr-login
		docker push $TAG
		python3 .k8s/deploy.py $BUILD
	)
}
