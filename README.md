
# はじめに



## 前提

* Makefileの先頭にある変数(WORKDIR, TEXFILE, DOCKER_IMAGE_NAME, DOCKER_RUNTIME_NAME)を適切に変更すること
* 質問票のLaTeXファイルは、$(WORKDIR)/$(TEXFILE) に配置すること
* スキャンしたTIFFファイルは、$(WORKDIR)(デフォルト:vol.proj)直下に配置すること
* スキャンしたTIFFファイルは、``sheet*.tiff`` のネーミングルールに従うこと
