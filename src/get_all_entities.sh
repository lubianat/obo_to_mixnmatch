
wget -nc -O data/$1.owl  http://purl.obolibrary.org/obo/$1.owl


robot export --input data/$1.owl \
  --header "ID|LABEL|IAO_0000115" \
  --export results/$1.csv

grep -v "obsolete" results/$1.csv | grep -i $1:  > results/$1_clean.csv

sed -i '1s/^/id,name,description\n /' results/$1_clean.csv

upperstr=$(echo $1 | tr '[:lower:]' '[:upper:]')

sed -i "s/$upperstr://" results/$1_clean.csv

