
FILE=shakes-mapping.json
if [ ! -f "$FILE" ]; then
    echo "Baixando o schema "
    wget http://media.sundog-soft.com/es7/shakes-mapping.json
    curl -H 'Content-Type: application/json' -XPUT 'https://localhost:9200/shakespeare' --data-binary @shakes-mapping.json -ku admin:admin
fi


FILE=shakespeare_7.0.json
if [ ! -f "$FILE" ]; then
    echo "Baixando a obra de Shakespeare e Indexando no Elastic Search"
    wget http://media.sundog-soft.com/es7/shakespeare_7.0.json
    curl -H 'Content-Type: application/json' -XPOST 'https://localhost:9200/shakespeare/_bulk?pretty' --data-binary @shakespeare_7.0.json -ku admin:admin
fi
 



curl -H 'Content-Type: application/json' -XGET 'https://localhost:9200/shakespeare/_search?pretty' -d '
{
"query" : {
"match_phrase" : {
"text_entry" : "to be or not to be"
}
}
}
' -ku admin:admin
