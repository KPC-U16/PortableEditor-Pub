#CHaserの行動を数字にまとめる列挙型
module CHaserActions
    
    WALK = 0
    LOOK = 1
    SEARCH = 2
    PUT = 3
    
end 


#CHaserの行動方向とその処理をまとめる列挙型
module CHaserDirections

    UP = 2
    LEFT = 4
    RIGHT = 6
    DOWN = 8
    
    def Reverse(x)
        return 10 - x
    end
    
    module_function :Reverse
end