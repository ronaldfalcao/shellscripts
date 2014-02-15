#!/bin/bash

  #
  # Script Para Alteração Senha Mysql
  # Por: Régio Pires - Analista de Infraestrututura
  # Em: Fevereiro de 2014
  #

  #Titulo
  echo ""
  echo "Script Para Alteração Senha do Mysql"
  echo "Por Régio Pires - Analista Infraestrutura"
  echo ""

  #Solicitação Senha
  echo -n "Nova Senha: " $senha1
  read -s senha1

  echo ""

  echo -n "Redigite a Senha: " $senha2
  read -s senha2

  echo ""

  # Verificação da Senha
  if [ $senha1 = $senha2 ]
     then
                 echo ""
                 NOVASENHA=$senha1
                 echo "Alterando..."
                 echo ""
         else
                 echo ""
                 echo "Ops! Senha não conferem! Tente novamente. :("
                 echo ""
                 exit
  fi

  #Parando Banco
  service mysqld stop > /dev/null

  #Iniciando Banco em Modo Administrativo
  `mysqld_safe --skip-grant-tables > /dev/null` &
  sleep 5

  #Acessando Banco sem senha
  echo "UPDATE user SET PASSWORD = password('$NOVASENHA') WHERE user = 'root' LIMIT 1;" | mysql mysql -u root
  echo "FLUSH PRIVILEGES;" | mysql mysql -u root

  #Reiniciando o Banco
  service mysqld restart > /dev/null

  echo "Senha alterada com sucesso!"
