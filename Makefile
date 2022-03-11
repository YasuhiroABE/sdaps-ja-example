
TEXFILE = questionnaire.tex
WORKDIR = vol.proj

DOCKER_IMAGE_NAME = yasuhiroabe/sdaps-ja:ub2004-3
DOCKER_RUNTIME_NAME = sdaps-ja
SHEETFILE_REGEX = "sheet*.tiff"

.PHONY: init add recognize reportex csv clean evince

init:
	sudo rm -rf $(WORKDIR)/work
	sudo docker run --rm -v `pwd`/$(WORKDIR):/proj \
		--name $(DOCKER_RUNTIME_NAME) \
		 $(DOCKER_IMAGE_NAME) \
		 setup --add translator-sdaps-dictionary-English.dict \
		 work/ $(TEXFILE)

stamp:
	sudo docker run --rm -v `pwd`/$(WORKDIR):/proj \
		--name $(DOCKER_RUNTIME_NAME) \
		 $(DOCKER_IMAGE_NAME) \
		 stamp work/ -f id.txt

TIFF_IMAGES := $(subst ./$(WORKDIR)/,,$(shell find . -name $(SHEETFILE_REGEX) ))
add:
	sudo docker run --rm -v `pwd`/$(WORKDIR):/proj \
		--name $(DOCKER_RUNTIME_NAME) \
		 $(DOCKER_IMAGE_NAME) \
		 add work/ $(TIFF_IMAGES)

recognize:
	sudo docker run --rm -v `pwd`/$(WORKDIR):/proj \
		--name $(DOCKER_RUNTIME_NAME) \
		 $(DOCKER_IMAGE_NAME) \
		 recognize work/

reorder:
	sudo docker run --rm -v `pwd`/$(WORKDIR):/proj \
		--name $(DOCKER_RUNTIME_NAME) \
		 $(DOCKER_IMAGE_NAME) \
		 reorder work/

reportex:
	sudo docker run --rm -v `pwd`/$(WORKDIR):/proj \
		--name $(DOCKER_RUNTIME_NAME) \
		 $(DOCKER_IMAGE_NAME) \
		 report_tex work/

csv:
	sudo docker run --rm -v `pwd`/$(WORKDIR):/proj \
		--name $(DOCKER_RUNTIME_NAME) \
		 $(DOCKER_IMAGE_NAME) \
		 csv export work/

clean:
	find . -type f -name '*~' -exec rm {} \; -print

atril:
	atril $(WORKDIR)/work/questionnaire.pdf
