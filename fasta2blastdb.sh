#!/bin/bash

# Cria o banco de dados BLAST a partir de arquivos .fasta para busca
# Autor: Luciano Kalabric Silva
# Data: 24/03/2023
# Última atualização: 24/03/2023
# Referencia: https://www.ncbi.nlm.nih.gov/books/NBK569841/

# Sintáxe
./fasta2blastdb.sh <REFSEQDIR> <BLASTDBDIR> 

# Diretórios dos dados (Subjects)
# Salvar os arquivos contendo as sequencias referências no formato Fasta (obtidos do Genbank) 
# individualmente ou formato multiseq Fasta neste diretório ou em sub-diretórios. Os arquivos
# são contatenados em um único arquivo refseq.fasta para montagem do banco de dados
REFSEQDIR=${HOME}/data/REFSEQ/HEV   # Para análise do genoma do HEV apenas

# Remove o arquivo contendo as sequencias referência, se houver, antes de criar um novo
[[ -r ${REFSEQDIR}/refseq.fasta ]] && rm ${REFSEQDIR}/refseq.fasta

# Diretório onde será criado o novo banco de dados refseq
BLASTDBDIR=${HOME}/data/HEV_DB      # Para análise do genoma do HEV apenas

# Reseta o diretório antes de criar um novo banco de dados
[[ -d ${BLASTDBDIR} ]] && rm -r ${BLASTDBDIR}
[ ! -d ${BLASTDBDIR} ] && mkdir -vp ${BLASTDBDIR}

# Concatena todos os arquivos .fasta em refseq.fasta, exceto o arquivo refgen.fasta que é gerado pelo make_refgen.sh
echo "Concatenando as sequencias referência em refseq.fasta..."
if [[ ! -f ${REFSEQDIR}/refseq.fasta ]]
then
	find ${REFSEQDIR} -type f -iname '*.fasta' -not -name 'refgen.fasta' -print0 | sort -z | xargs -0 cat > "${REFSEQDIR}/refseq.fasta"
fi

# Processa a linha de descrição das sequencias referências para conter apenas o número de acesso sem espaços
# echo "Processando os labels do arquivo refseq.fasta..."
# mv ${REFSEQDIR}/${REFSEQFILENAME} ${REFSEQDIR}/refseq.old
# while read -r line; do
# 	if echo "$line" | grep ">";
#   then
#    	echo "$line" | cut -d "." -f 1 >>${REFSEQDIR}/refseq.fasta
#	else
#		echo "$line" >>${REFSEQDIR}/refseq.fasta
#	fi
# done < "${REFSEQDIR}/refseq.old"

# Cria a lista de números de acc Genbank a partir do arquivo .fasta
# echo "Criando o arquivo refseq.acc..."
# [[ -f ${REFSEQDIR}/refseq.acc ]] && rm  ${REFSEQDIR}/refseq.acc
# grep ">" ${REFSEQDIR}/refseq.fasta | sed 's/>//' | cut -d " " -f 1 > ${REFSEQDIR}/refseq.acc

# Cria a lista de taxid a partir nos números de acc Genbank
# [[ -f ${REFSEQDIR}/refseq.map ]] && rm  ${REFSEQDIR}/refseq.map
# Retrive Taxid
# echo "Criando o arquivo refseq.map..."
# while read -r line; do
# 	echo "$line "$(efetch -db nuccore -id "$line" -format docsum | xtract -pattern DocumentSummary -element TaxId) >>${REFSEQDIR}/refseq.map
# done < ${REFSEQDIR}/refseq.acc

# Cria o banco de dados refseq para busca pelos programas Blast a partir de um arquivo .fasta
echo "Criando o banco de dados BLAST_DB/refseq..."
makeblastdb -in ${REFSEQDIR}/refseq.fasta -parse_seqids -blastdb_version 5 -dbtype nucl -out ${BLASTDBDIR}/refseq
echo "Banco de dados criado com sucesso!"

# Faz o donwload do taxdb
# wget ftp://ftp.ncbi.nlm.nih.gov/blast/db/taxdb.tar.gz -P ${BLASTDBDIR}

# IMPORTATE: Após incluir uma nova sequencia no diretório REFSEQ e executar uma nova análise, é importante
# atualizar os arquivos WIMP para sumarizar o relatório da busca pelo Blast. Abaixo seguem alguns reports
# para conferência
# echo "Conferir o arquivo refseq.fasta e os arquivos .wimp..."
# echo "Total de taxons encontrados no arquivo refseq.fasta atual: $(grep -c ">" ${REFSEQDIR}/refseq.fasta)"
# echo "Total de números de acesso (refseq.acc): $(wc -l ${REFSEQDIR}/refseq.acc)"
# echo "Total de números de acesso com taxid (refseq.map): $(wc -l ${REFSEQDIR}/refseq.map)"
# echo -e "Total de números de acesso em cada arquivo .wimp:\n $(wc -l ${HOME}/data/WIMP/*.wimp)"
# echo "IMPORTANTE: Atualizar os arquivos .wimp para uma relatoria correta!"
