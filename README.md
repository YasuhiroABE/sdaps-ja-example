
# はじめに

DockerHubに登録している、``yasuhiroabe/sdaps-ja`` パッケージのテスト用シートです。

## 前提

* 質問票のLaTeXファイルは、vol.proj/ に配置している
* スキャンしたPDFファイルは、vol.proj/questionnaire.tex に配置している
* スキャンしたTIFF/PDFファイルは、vol.proj/01.pdf や vol.proj/02.tiff のように vol.proj/直下に配置している

Makefile内の変数を変更することで、これらの前提は変更可能です。

## 使い方

標準的なLinux環境でサンプルの質問票を作成し、スキャン、一連のコマンドラインは次のようになります。
WindowsやmacOSでも後述するセットアップを行なえば、同じ要領でコマンドを実行することができます。

    $ git clone https://github.com/YasuhiroABE/sdaps-ja-example.git
    $ cd sdaps-ja-example/
    $ make setup

    ## GUI環境とatrilドキュメントビューアーが利用できれば、次の要領でvol.proj/work/questionnaire.pdfの内容を確認できます。(状況によって実行できない場合は次に進んでください)
    ## If you can use the atril GUI document viewer, check the vol.proj/work/questionnaire.pdf file.
    $ make atril

    ## まずvol.proj/work/questionnaire.pdfを印刷し、回答後にスキャンしてください。
    ## Print out the vol.proj/work/questionnaire.pdf file, fill in answers, and scan it.
    ## 次に PDFもしくはTIFFファイルをvol.proj/01.pdf などの名前で配置してください。
    ## Then, put it to the appropriate filename, "*.pdf", "*.tiff", or "*.tif", such as vol.proj/01.pdf.

    ## 準備ができたら、以下の要領で認識、レポートやCSVファイルの作成を行ないます。
    $ make add
    $ make recognize
    $ make reportex
    $ make repotlab
    $ make csv

最終的に次のようなファイルが作成されます。

* vol.proj/work/report_1.pdf (レポートPDFファイル。手書き部分の内容を確認するために必要)
* vol.proj/work/data_1.csv (CSV形式の数値データ。手書き部分は入力の有無だけが判定され、文字はreport_1.pdfで確認できる)

## Windows10以降の環境で利用する場合

まず Windowsは64bit版であることが必要です。(Windows11は64bit版のみが提供されており、条件を満たすので、この確認は不要です。)

次にWSL2を有効にし、Microsoft Storeから、Canonicalが配布する"Ubuntu 20.04"を導入したら、Windows Terminalアプリなどでのシェルを開き、次のように必要なコマンドを入力します。(WSL2を有効にする方法はタイミングによって違いますが、最新の方法は https://docs.microsoft.com/ja-jp/windows/wsl/install を参照してください。)

最後に、Docker Desktop for Windowsの導入が必要です。

必要なコマンドは make, git, find, atril dockerコマンドです。
dockerコマンドはDocker Desktopを導入したタイミングで自動的に利用できるようになるはずですが、DockerのDashboardから利用しているWSL2環境で利用できるように設定しているか確認してください。
その他のコマンドが利用できない場合は、下記の要領で導入してください。

    $ sudo apt update
    $ sudo apt dist-upgrade
    $ sudo apt install make git findutils

Windows10環境では``make atril``を実行するためにはX Serverを別途実行し、適切に環境変数を設定する必要があります。

Windows11環境ではatrilコマンドの実行に特別な制約はありません。実行する場合にはatrilコマンドを追加でインストールしてください。

    $ sudo apt install atril

## macOS環境で利用する場合

Docker Desktop for Macを導入するだけで、その他に必要な作業はありません。

標準的な環境ではターミナルからGUIが利用できないので、``make atril``は実行しないでください。
macOSのPDFビューアーを利用してください。

質問票を確認する必要があれば、Finderから vol.proj/work/questionnaire.pdf ファイルを直接操作してください。

## 使用機材

* ドキュメント・スキャナ: Brother ADS-3600W
* Windows上でのマルチページTIFFファイルの閲覧・編集ソフトウェア: IrfanView v4.59 (64bit)
* Docker実行環境: VMware Workstation 17 Pro & Ubuntu 22.04 LTS

経験上はマルチページTIFF形式 300dpi程度の品質でスキャンできるドキュメント・スキャナの利用がお勧めです。

PDF出力のみのドキュメントスキャナを利用する場合、sdapsはPDF形式からのTIFF変換機能を、addコマンドの``--convert``オプションで提供しています。この他の方法でTIFFイメージに変換する場合には、マルチページ白黒イメージである必要があります。

## 考慮点

1ページの質問票をスキャンした場合に、裏面の空白ページがそのまま保存される場合があります。
そのまま処理をしても空白のページは無効なものとして扱われ ``レポート`` に影響はありませんが、``CSVファイル` には反映されます。

マルチページTIFFファイルから空白ページを削除するには、IrfanViewの ``Edit Multipage TIF (C-q)`` メニューから編集が便利だと思います。偶数ページだけ削除するなら、自動化するためのプログラムを自作しても良いかもしれませんが、適切なライブラリを見付けることが難しいかもしれません。

以上
