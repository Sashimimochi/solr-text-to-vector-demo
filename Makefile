DOC_DIR=./mysql/data/
LOG_DIR=./solr/logs/
INDEX_DIR=./solr/data/
BATCH_PYCACHE_DIR=./batch/__pycache__/
COLLECTION=idcc

tsv:
	bash ./scripts/make_data.sh
log:
	mkdir -p $(LOG_DIR)
	sudo chmod 777 $(LOG_DIR)
docker-launch:
	sudo docker-compose --profile basic up -d
upload-configset:
	bash ./scripts/upload_configset.sh ${COLLECTION}
create-collection:
	sudo chmod -R 777 $(INDEX_DIR)
	bash ./scripts/create_collection.sh ${COLLECTION}
	sudo chmod -R 777 $(INDEX_DIR)
make-collection:
	@make upload-configset
	@make create-collection
delete-collection:
	bash ./scripts/delete_collection.sh ${COLLECTION}
add-index:
	sudo docker-compose exec batch python index_pipeline.py
model-update:
	curl -XDELETE 'http://localhost:8983/solr/${COLLECTION}/schema/text-to-vector-model-store/mymodel'
	curl -XPUT 'http://localhost:8983/solr/${COLLECTION}/schema/text-to-vector-model-store' --data-binary "@./solr/myModel.json" -H 'Content-type:application/json'
launch:
	@make docker-launch
	@make upload-configset
	@make make-collection
all:
	@make tsv
	@make log
	@make docker-launch
	@make upload-configset
	@make create-collection
	@make add-index
	@make model-update
data-clean:
	rm -rf $(DOC_DIR)
	rm -rf $(INDEX_DIR)
docker-clean:
	sudo docker-compose down
	sudo docker volume prune
	rm -rf $(LOG_DIR)
	sudo rm -rf $(BATCH_PYCACHE_DIR)
clean:
	@make docker-clean
	@make data-clean
