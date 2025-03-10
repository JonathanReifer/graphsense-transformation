#!/bin/bash

function insert_data () {
    echo "Insert test data from file $1 into Cassandra table $2..."
    while IFS= read -r line
    do
        cqlsh localhost -e "INSERT INTO $2 JSON '$line';"
        echo "Inserted test data record"
    done <"$1"
}

echo "Creating raw keyspace in Cassandra"
cqlsh localhost -f ./scripts/schema_raw.cql

echo "Ingesting test blocks..."

insert_data "./src/test/resources/cassandra/test_blocks.json" "btc_raw.block"
insert_data "./src/test/resources/cassandra/test_txs.json" "btc_raw.transaction"
insert_data "./src/test/resources/cassandra/test_block_txs.json" "btc_raw.block_transactions"
insert_data "./src/test/resources/cassandra/test_exchange_rates.json" "btc_raw.exchange_rates"
insert_data "./src/test/resources/cassandra/test_tags.json" "tagpacks.tag_by_address"
