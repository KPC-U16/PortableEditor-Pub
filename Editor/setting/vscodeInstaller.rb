require 'rbconfig'
require 'open-uri'
require 'zip'  # gem install rubyzip
require "fileutils"


def os(dir)

  host_os = RbConfig::CONFIG['host_os']
  case host_os
  when /mswin|msys|mingw|cygwin|bccwin|wince|emc/
    puts "OS:Windows"
    VscodeInstall("win32-x64-archive",dir)
  
  when /darwin|mac os/
    puts "Macには対応していません。"
=begin
    puts "OSType:Mac"
    VscodeInstall("darwin-universal",dir)
=end
  
  else
    puts "このOSはサポートしていません。"
  end
end


def VscodeInstall(osType,dir)
  url = "https://code.visualstudio.com/sha/download?build=stable&os="+osType
  name = "vscode.zip"
  
  puts "vscodeのダウンロードを開始します。"
  puts url
  sleep 1

  puts "ダウンロード中"
  URI.open(url) do |file|
    IO.copy_stream(file, "tmp.zip")
  end
  
  puts "ZIPファイルを展開中"
  sleep 0.5
  
  Zip::File.open("tmp.zip") do |file|
    file.each do |entry|
      p dir+"/vscode/"+ entry.name
      file.extract(entry, dir+"/vscode/"+ entry.name) { true }
      end
    end
  
  #dataフォルダ作っておくとportableモードで稼働してくれて、設定情報とかここに置いてくれます。
  FileUtils.mkdir_p(dir+"/vscode/data")
  File.delete("tmp.zip")

  VscodeExtensionsInstall(osType,dir)
  end


def VscodeExtensionsInstall(osType,dir)
  puts "続けて、拡張機能をインストールします。"

  result = dir+"/vscode/"
  opt = ["--install-extension MS-CEINTL.vscode-language-pack-ja","--install-extension rebornix.Ruby","--install-extension MS-vsliveshare.vsliveshare-pack"]

  if osType == "win32-x64-archive"
    result += "bin/code --force #{opt.join(' ')}"
      IO.popen(result).each do |line|
      puts '===> ' + line
      end

    #HotFix-#3
    #公式が対応するまで暫定措置
    extJsonPath = dir+"/vscode/data/extensions/wingrunr21.vscode-ruby-0.28.0/package.json"
    fixJsonPath = dir+"/setting/package.json"

    FileUtils.cp(fixJsonPath,extJsonPath)
    #HotFix-#3 END
  
  # ファイルの存在は確認してるけどストレートにいけるか不明
  elsif osType == "darwin-universal"
    result += "Visual Studio Code.app/Contents/Resources/app/bin/code --force #{opt.join(' ')}"
      IO.popen(result).each do |line|
      puts '===> ' + line
      end
    end

  puts "vscodeを再起動します。"
  
  #バッチファイルへvscodeの立ち上げとtaskkill書いてます。再読み込みしないと一部の拡張機能ちゃんと読んでくれないので
  end

puts "開発環境の構築を開始します。"
puts "次回以降はvscodeフォルダ内のCode.exeを直接実行して構いません。"
sleep 3
os(ARGV[0])


=begin

  本プログラムはU-16 釧路CHaser講習会 参加者に対して簡単に環境構築を行えるように向けて開発されたプログラムです。
  2021.09現在 釧路ではRubyをメインの開発言語として採用しているためこちらも合わせた形です。
  もし後任の方へ引き継がれた時のメモ書きです。
  汚いのは許して
  
  - 搭載したい機能 -
  Proxy(検出)機能 :串を挟んだ通信は対応してないので対応したいですね。ユーザーに認証情報etcを求めるのもいいけれど、WPAD（Web Proxy Auto-Discovery）とかで自動化できたら楽だなぁ
                    code側へは code --proxy-server="http=http://ProxyユーザID:Proxyパスワード@proxyサーバ名:Proxyポート" で通せると思います。
  他OSへの対応    :同梱している AsahikawaProcon-Server はWindowsだけなのでとりあえず窓だけ書いてます。(ちょっとMac用も残ってるけど) 鯖自体はMac対応なので優先度は高め

=end