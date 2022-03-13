
## If you need root previledge, then change the following line to "sudo docker" instead of the "docker" command.
DOCKER_CMD = docker 

TEXFILE = questionnaire.tex
WORKDIR = vol.proj

DOCKER_IMAGE_NAME = yasuhiroabe/sdaps-ja:ub2004-5
DOCKER_RUNTIME_NAME = sdaps-ja
SHEETFILE_REGEX = "sheet*.tiff"

.PHONY: init add recognize reportex csv clean evince

init:
	sudo rm -rf $(WORKDIR)/work
	$(DOCKER_CMD) run --rm -v `pwd`/$(WORKDIR):/proj \
		--name $(DOCKER_RUNTIME_NAME) \
		 $(DOCKER_IMAGE_NAME) \
		 setup --add translator-sdaps-dictionary-English.dict \
		 work/ $(TEXFILE)

TIFF_IMAGES := $(subst ./$(WORKDIR)/,,$(shell find . -name $(SHEETFILE_REGEX) ))
add:
	$(DOCKER_CMD) run --rm -v `pwd`/$(WORKDIR):/proj \
		--name $(DOCKER_RUNTIME_NAME) \
		 $(DOCKER_IMAGE_NAME) \
		 add work/ $(TIFF_IMAGES)

recognize:
	$(DOCKER_CMD) run --rm -v `pwd`/$(WORKDIR):/proj \
		--name $(DOCKER_RUNTIME_NAME) \
		 $(DOCKER_IMAGE_NAME) \
		 recognize work/

reportex:
	$(DOCKER_CMD) run --rm -v `pwd`/$(WORKDIR):/proj \
		--name $(DOCKER_RUNTIME_NAME) \
		 $(DOCKER_IMAGE_NAME) \
		 report_tex work/

csv:
	$(DOCKER_CMD) run --rm -v `pwd`/$(WORKDIR):/proj \
		--name $(DOCKER_RUNTIME_NAME) \
		 $(DOCKER_IMAGE_NAME) \
		 csv export work/

clean:
	find . -type f -name '*~' -exec rm {} \; -print

atril:
	atril $(WORKDIR)/work/questionnaire.pdf
