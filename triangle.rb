class Triangle

  # 引数
  #   a, b, c: 各辺の長さ
  #            ※to_iで整数化出来るならstringでも可（よって、*ARGVを渡せる。引数の数があっていない場合は落ちるが…）
  #            ※辺の長さが『nil,0以下』『to_iで正しく数値化出来ない』の場合、0 を返す。
  #            ※小数が渡された場合、to_iで小数部が切り捨てられるので、正しい結果が返らない。
  # 戻り値
  #   0 : 三角形ではない
  #   1 : 不等辺三角形（なんでもない三角形）
  #   2 : 二等辺三角形
  #   3 : 正三角形
  def self.triangle_type(a, b, c)
    # puts "#{a} #{b} #{c}"
    sizes = [a, b, c]

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

  ret = Triangle.triangle_type(*ARGV)

  str = case ret
          when  0 then "三角形じゃないです＞＜"
          when  1 then "不等辺三角形ですね！"
          when  2 then "二等辺三角形ですね！"
          when  3 then "正三角形ですね！"
          else "不正な戻り値です(-_-)"
        end
  puts str
end
