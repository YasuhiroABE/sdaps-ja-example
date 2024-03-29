
## If you need root previledge, please change the following line to "sudo docker" instead of the "docker" command.
DOCKER_CMD = docker 

TEXFILE = questionnaire.tex
WORKDIR = vol.proj

DOCKER_IMAGE_NAME = yasuhiroabe/sdaps-ja:ub2204-20231004
DOCKER_RUNTIME_NAME = sdaps-ja
SCANNEDFILE_REGEX = ".*(pdf|tiff|tif)"

.PHONY: setup
setup:
	chmod a+rwx,g+s $(WORKDIR)
	rm -rf $(WORKDIR)/work
	$(DOCKER_CMD) run --rm -v `pwd`/$(WORKDIR):/proj \
		--name $(DOCKER_RUNTIME_NAME) \
		 $(DOCKER_IMAGE_NAME) \
		 setup tex --add translator-sdaps-dictionary-English.dict \
		 work $(TEXFILE)

.PHONY: add
TIFF_IMAGES := $(subst ./$(WORKDIR)/,,$(shell find . -mindepth 2 -maxdepth 2 -type f -regextype posix-egrep -regex $(SCANNEDFILE_REGEX) ))
add:
	$(DOCKER_CMD) run --rm -v `pwd`/$(WORKDIR):/proj \
		--name $(DOCKER_RUNTIME_NAME) \
		 $(DOCKER_IMAGE_NAME) \
		 add --convert work/ $(TIFF_IMAGES)

.PHONY: recognize
recognize:
	$(DOCKER_CMD) run --rm -v `pwd`/$(WORKDIR):/proj \
		--name $(DOCKER_RUNTIME_NAME) \
		 $(DOCKER_IMAGE_NAME) \
		 recognize work/

.PHONY: reporttex
reporttex:
	$(DOCKER_CMD) run --rm -v `pwd`/$(WORKDIR):/proj \
		--name $(DOCKER_RUNTIME_NAME) \
		 $(DOCKER_IMAGE_NAME) \
		 report tex work/

.PHONY: reportlab
reportlab:
	$(DOCKER_CMD) run --rm -v `pwd`/$(WORKDIR):/proj \
		--name $(DOCKER_RUNTIME_NAME) \
		 $(DOCKER_IMAGE_NAME) \
		 report reportlab work/

.PHONY: csv
csv:
	$(DOCKER_CMD) run --rm -v `pwd`/$(WORKDIR):/proj \
		--name $(DOCKER_RUNTIME_NAME) \
		 $(DOCKER_IMAGE_NAME) \
		 export csv work/

.PHONY: reset
reset:
	$(DOCKER_CMD) run --rm -v `pwd`/$(WORKDIR):/proj \
		--name $(DOCKER_RUNTIME_NAME) \
		 $(DOCKER_IMAGE_NAME) \
		 reset work/

.PHONY: clean
clean:
	find . -type f -name '*~' -exec rm {} \; -print

.PHONY: atril
atril:
	atril $(WORKDIR)/work/questionnaire.pdf

