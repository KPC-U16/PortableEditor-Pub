# -*- coding: utf-8 -*-
require  'CHaserConnect.rb' #呼び出すおまじない

# 書き換えない
target = CHaserConnect.new("prac") # ()の中好きな名前
values = Array.new(10)
random = Random.new # 乱数生成

#--------ここから--------
loop do # ここからループ

#---------ここから---------
  values = target.getReady

  if values[0] == 0
    break
  end
#-----ここまで書き換えない-----

#ここに処理を書く

#---------ここから---------
  if values[0] == 0
    break
  end

end # ループここまで
target.close
#-----ここまで書き換えない-----