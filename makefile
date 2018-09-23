IMAGE := mathematiguy/te-wiki-o-te-reo
UID ?= $$(id -u)
GID ?= $$(id -g)
TAG ?= latest
RUN ?= docker run -it --rm $(PORT) -v $$(pwd):/work -w /work -u $(UID):$(GID)
RUN_IMAGE ?= $(RUN) $(IMAGE):$(TAG)
PORT ?=

web_server: PORT=-p 8000:8000
web_server:
	(cd D3 && $(RUN_IMAGE) python3 -m http.server)

JUPYTER_PASSWORD ?= jupyter
JUPYTER_PORT ?= 8888
.PHONY: jupyter
jupyter: UID=root
jupyter: GID=root
jupyter: 
	$(RUN) \
		-p $(JUPYTER_PORT):$(JUPYTER_PORT) \
		-e NB_UID=$$UID \
		-e NB_UID=$(shell id -u) \
		-e NB_GID=$(shell id -g) \
		$(IMAGE)  \
		jupyter lab \
		--allow-root \
		--port $(JUPYTER_PORT) \
		--NotebookApp.password=$(shell $(RUN_IMAGE) \
			python -c \
			"from IPython.lib import passwd; print(passwd('$(JUPYTER_PASSWORD)'))"\
			)

.PHONY: docker
docker:
	docker build --tag $(IMAGE):latest .

.PHONY: enter
enter: UID = root
enter: GID = root
enter:
	$(RUN_IMAGE) bash

inspect_variables:
	@echo IMAGE:     $(IMAGE)
	@echo UID:       $(UID)
	@echo GID:       $(GID)
	@echo RUN:       $(RUN)
	@echo RUN_IMAGE: $(RUN_IMAGE)
