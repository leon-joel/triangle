


class Triangle

  # 引数
  #  各辺の長さの配列
  #  ※to_iで数値化出来るならstringを含んでいても可
  #  ※小数は不可
  # 戻り値
  #  -1 : 引数エラー
  #   0 : 三角形ではない（『辺の長さが負』はここ。『to_iで数値化出来ない文字列を含んでいる場合』、『小数を含んでいる場合』もここ）
  #   1 : 不等辺三角形（なんでもない三角形）
  #   2 : 二等辺三角形
  #   3 : 正三角形
  def self.is_valid(sizes)
    return -1 if sizes.nil? || sizes.size != 3

    ###
    # 三角形の成立条件  ※参考: http://ameblo.jp/toyokunbenkyou/entry-10307543297.html
    # aが最大辺の時、a < b + c
    ###

    s = sizes.map(&:to_i).sort
    # puts "最大辺:#{s[-1]}  その他の2辺:#{s[0]}, #{s[1]}"

    # 成立条件を満たさない ⇒ 三角形ではない
    return 0 unless s[-1] < s[0] + s[1]

    # すべての辺が同じ長さ ⇒ 正三角形
    return 3 if s[0] == s[-1]   # ※あらかじめsortしているので、ここでは先頭と末尾だけを比較すればOK

    # 短い方2辺もしくは長い方2辺が同じ長さ ⇒ 二等辺三角形
    return 2 if s[0] == s[1] || s[1] == s[-1]

    # 残りはただの三角形
    1
  end
end


####################################################################
###
### Main
###

if $0 == __FILE__
  # p ARGV
  # p ARGV.size
  #
  # if ARGV.size != 3
  #   puts "Wrong number of arguments."
  #   exit
  # end

  ret = Triangle.is_valid(ARGV)

  str = case ret
          when -1 then "引数エラー"
          when  0 then "三角形じゃないです＞＜"
          when  1 then "不等辺三角形ですね！"
          when  2 then "二等辺三角形ですね！"
          when  3 then "正三角形ですね！"
          else "不正な戻り値です(-_-)"
        end
  puts str
end