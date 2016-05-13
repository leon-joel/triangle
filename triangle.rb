# coding: utf-8

require 'bigdecimal'
require 'bigdecimal/util'

class Triangle

  # 各辺の長さを表す文字列配列（ARGVを想定）を
  # 数値（Rational）の配列に変換
  # @raise  ArgumentError Rationalに変換できない要素が含まれていた
  def self.argv_to_num_array(argv)
    # ARGVをスペース区切りで1つの文字列に
    # スペースもしくはカンマで分割
    # 空文字列は除外
    # Rationalに変換
    argv.join(" ")
        .split(/[\s,]+/)
        .reject(&:empty?)
        .map { |a| Rational(a) }
  end

  # 引数
  #   argv: 各辺の長さの配列 ※起動時引数ARGV（Stringの配列）を渡されることを想定
  # 戻り値
  #   -1 : 引数エラー
  #   0 : 三角形ではない
  #   1 : 不等辺三角形（なんでもない三角形）
  #   2 : 二等辺三角形
  #   3 : 正三角形
  def self.triangle_type_from_array(argv)
    sizes = argv_to_num_array(argv)
    return -1 if sizes.size != 3

    triangle_type(*sizes)
  rescue TypeError, ArgumentError => e
    # 変換エラー
    -1
  end



  # 引数には数値が格納されていることを前提とする
  def self.triangle_type(a, b, c)
    # puts "#{a} #{b} #{c}"
    sizes = [a, b, c]

    ###
    # 三角形の成立条件  ※参考: http://ameblo.jp/toyokunbenkyou/entry-10307543297.html
    # aが最大辺の時、a < b + c
    ###

    s = sizes.sort
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

  ret = Triangle.triangle_type_from_array(ARGV)

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
