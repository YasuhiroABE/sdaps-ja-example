
# はじめに

DockerHubに登録している、``yasuhiroabe/sdaps-ja`` パッケージのテスト用シートです。

## 前提

* Intel系CPUを搭載したコンピュータで作業し、Dockerの実行環境(dockerコマンド)が準備できていること(※)
* Makefileの先頭にある変数を適切に変更するか、これに合わせてファイルの配置などをすること
* 質問票のLaTeXファイルは、$(WORKDIR)/$(TEXFILE) に配置すること
* スキャンしたTIFFファイルは、$(WORKDIR)(デフォルト:vol.proj)直下に配置すること
* スキャンしたTIFFファイルは、``sheet*.tiff`` のネーミングルールに従うこと

(※: ``yasuhiroabe/sdaps-ja:ub2004-5`` では、M1 macOSなどARM系CPU(ARM64, arm/v7)に対応しています)

## 使い方

一連のコマンドラインは次のようになります。

	$ git clone https://github.com/YasuhiroABE/sdaps-ja-example.git
	$ cd sdaps-ja-example/
    $ make init
	$ make atril  ## check the vol.proj/work/questionnaire.pdf by the atril pdf viewer.
    ## Print out the questionnaire.pdf file, fill in answers, and scan it, then placed it by the appropriate format, such as vol.proj/sheet01.tiff.
	$ make recognize
	$ make reportex
	$ make report
	$ make csv

``make init`` によって、questionnaire.tex が questionnaire.pdf に変換されます。

これを印刷し、回答を記入し、ドキュメントスキャナーなどで、マルチページTIFF形式のファイルに保存し、sheet01.tiffのような形式で配置します。

次に、``make recognize``などの一連のタスクを実行することで、``vol.proj/work/``ディレクトリ以下にレポート、CSVデータファイルなどが出力されます。

## 使用機材

* ドキュメント・スキャナ: Brother ADS-3600W
* Windows上でのマルチページTIFFファイルの閲覧・編集ソフトウェア: IrfanView v4.58 (64bit)
* Docker実行環境: VMware Workstation 16 Pro & Ubuntu 20.04 LTS

経験上はマルチページTIFF形式 300dpi程度の品質でスキャンできるドキュメント・スキャナの利用がお勧めです。

PDF出力のみのドキュメントスキャナを利用する場合、sdapsはPDF形式からのTIFF変換機能を、addコマンドの``--convert``オプションで提供しています。この他の方法でTIFFイメージに変換する場合には、マルチページ白黒イメージである必要があります。

## 考慮点

1ページの質問票をスキャンした場合に、裏面の空白ページがそのまま保存される場合があります。
そのまま処理をしても空白のページは無効なものとして扱われ ``レポート`` に影響はありませんが、``CSVファイル` には反映されます。

マルチページTIFFファイルから空白ページを削除するには、IrfanViewの ``Edit Multipage TIF (C-q)`` メニューから編集が便利だと思います。偶数ページだけ削除するなら、自動化するためのプログラムを自作しても良いかもしれませんが、適切なライブラリを見付けることが難しいかもしれません。

以上
