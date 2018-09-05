IMAGE := mathematiguy/te-wiki-o-te-reo
USER  ?= $$(id -u)
GROUP ?= $$(id -g)
RUN ?= docker run -it --rm -v $$(pwd):/work -w /work -u $(USER):$(GROUP)
RUN_IMAGE ?= $(RUN) $(IMAGE)

JUPYTER_PASSWORD ?= jupyter
JUPYTER_PORT ?= 8888
.PHONY: jupyter
jupyter: USER=root
jupyter: GROUP=root
jupyter: 
	$(RUN) \
		-p 8888:$(JUPYTER_PORT) \
		-e NB_USER=$$USER \
		-e NB_UID=$(shell id -u) \
		-e NB_GID=$(shell id -g) \
		$(IMAGE)  \
		jupyter lab \
		--allow-root \
		--NotebookApp.password=$(shell $(RUN_IMAGE) \
			python -c \
			"from IPython.lib import passwd; print(passwd('$(JUPYTER_PASSWORD)'))"\
			)

.PHONY: docker
docker:
	docker build --tag $(IMAGE):latest .

.PHONY: enter
enter: USER = root
enter: GROUP = root
enter:
	$(RUN_IMAGE) bash

inspect_variables:
	@echo IMAGE:     $(IMAGE)
	@echo USER:      $(USER)
	@echo GROUP:     $(GROUP)
	@echo RUN:       $(RUN)
	@echo RUN_IMAGE: $(RUN_IMAGE)
