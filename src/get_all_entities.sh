
wget -nc -O data/$1.owl  http://purl.obolibrary.org/obo/$1.owl


robot export --input data/$1.owl \
  --header "ID|LABEL|IAO_0000115|hasDbXref|subClassOf [ID]" \
  --export results/$1.csv

grep -v "obsolete" results/$1.csv | grep -v ",,"| grep -i $1:  > results/$1_clean.csv

sed -i '1s/^/id,name,description,xrefs,parents\n /' results/$1_clean.csv

upperstr=$(echo $1 | tr '[:lower:]' '[:upper:]')

if [[ $2 != "--no-change" ]]
then
  if [[ $2 == "--underscore" ]]
  then
    sed -i "s/:/_/" results/$1_clean.csv

  else
    sed -i "s/$upperstr://" results/$1_clean.csv
  fi
else
    echo "No change"
fi


