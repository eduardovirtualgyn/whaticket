#######################################
# installs node
# Arguments:
#   None
#######################################
system_node_install() {
  print_banner
  printf "${WHITE} 💻 Instalando o Node.js...${GRAY_LIGHT}"
  printf "\n\n"

  sleep 2

  sudo su - root <<EOF
  # Instala Node.js 18.x (LTS mais recente)
  curl -fsSL https://deb.nodesource.com/setup_18.x | sudo -E bash -
  apt-get install -y nodejs
  npm install -g npm@latest

  # Instala PostgreSQL
  sudo sh -c 'echo "deb http://apt.postgresql.org/pub/repos/apt $(lsb_release -cs)-pgdg main" > /etc/apt/sources.list.d/pgdg.list'
  wget --quiet -O - https://www.postgresql.org/media/keys/ACCC4CF8.asc | sudo apt-key add -
  sudo apt-get update -y && sudo apt-get -y install postgresql

  # Configura timezone e banco de dados
  sudo timedatectl set-timezone America/Sao_Paulo
  sudo -u postgres psql -c "ALTER USER postgres PASSWORD '2000@23';"
  sudo -u postgres psql -c "CREATE DATABASE whaticketautomatizaai;"
EOF

  sleep 2
}

#######################################
# installs docker
# Arguments:
#   None
#######################################
system_docker_install() {
  print_banner
  printf "${WHITE} 💻 Instalando docker...${GRAY_LIGHT}"
  printf "\n\n"

  sleep 2

  sudo su - root <<EOF
  # Remove versões antigas do Docker
  apt remove -y docker docker-engine docker.io containerd runc

  # Instala dependências
  apt update
  apt install -y apt-transport-https ca-certificates curl gnupg lsb-release

  # Adiciona a chave GPG oficial do Docker
  mkdir -p /etc/apt/keyrings
  curl -fsSL https://download.docker.com/linux/ubuntu/gpg | sudo gpg --dearmor -o /etc/apt/keyrings/docker.gpg

  # Configura o repositório do Docker
  echo "deb [arch=$(dpkg --print-architecture) signed-by=/etc/apt/keyrings/docker.gpg] https://download.docker.com/linux/ubuntu $(lsb_release -cs) stable" | sudo tee /etc/apt/sources.list.d/docker.list > /dev/null

  # Instala o Docker
  apt update
  apt install -y docker-ce docker-ce-cli containerd.io docker-compose-plugin

  # Adiciona o usuário ao grupo Docker
  usermod -aG docker deployautomatizaai
EOF

  sleep 2
}