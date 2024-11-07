#!/bin/bash
echo "Bem vindo ao programa de scan em massa do Matheus"
sleep 1
while true; do 
	clear
	echo -e "Esse é o menu principal, aqui você escolhe o que deseja fazer e daremos continuidade conforme suas escolhas\n	1-Scan para emails\n	0- Saír"
	read -p "Então, o que deseja fazer?" mn_p;
	if [ "$mn_p" -eq 1 ]; then
		clear
		echo "Ok, vamos começar"
		#Caminho para o arquivo de emails
		read -p "Escreva o nome ou caminho para o arquivo: (EX: email.txt ou /home/test/email.txt)" email_scan;

		#Verificando se o diretório existe
		while true; do
			read -p "Onde deseja salvar? (EX: /home/test/Documents )" output_scan
			if [ -d "$output_scan" ]; then
				echo "Local localizado!"
				break
			else
				while true; do
					read -p "Local não localizado, deseja criar diretório? (S/N)" output_newd
					if [ "$output_newd" == "S" ]; then
						echo "Ok, criando diretório..."
						mkdir -p "$output_scan"
						sleep 3
						if [ -d "$output_scan" ]; then
							echo "Diretório criado com sucesso!"
							break 2
						else
							echo "Houve um problema ao criar o diretório."
							sleep 1
							exit 1
						fi
					elif [ "$output_newd" == "N" ]; then
						read -p "Ok, deseja buscar outro local? (S/N)" output_notnew
						if [ "$output_notnew" == "S" ]; then
							echo "Tudo bem, então vamos lá"
							break
						elif [ "$output_notnew" == "N" ]; then
							echo "Tudo bem, o programa será encerrado"
							sleep 1
							exit 0
						else
							echo "Ação inválida. Por favor, responda com 'S' ou 'N'."
						fi
					else
						echo "Ação inválida. Por favor, responda com 'S' ou 'N'."
					fi
				done
			fi
		done
	while IFS= read -r email; do
		echo "Iniciando varredura $email_scan"
		
		python3 sfcli.py -s "$email_scan" -m Breach,Pwned,Leak -o csv > "$output_scan/result$email_scan.csv"

		echo "Scan $email_scan. Concluido"
	done
	elif [ "$mn_p" -eq 0 ]; then
		clear
		echo "Ok, espero te ver em breve"
		sleep 1 
		exit 0
	else
		echo "Essa opção não é valida, use uma das opções acima por favor"
	fi
done
	