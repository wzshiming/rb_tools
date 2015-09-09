#!/usr/bin/env ruby
#-*- coding:utf-8 -*- 
class String
  #中文数字
  @@num_cn={}
  %w{〇 一 二 三 四 五 六 七 八 九}.each_with_index do |ch,i|
    @@num_cn[ch]=i
  end
  %w{十 百 千 万}.each_with_index do |ch,i|
    @@num_cn[ch]=10**(i+1)
  end
  %w{零 壹 贰 叁 肆 伍 陆 柒 捌 玖}.each_with_index do |ch,i|
    @@num_cn[ch]=i
  end
  %w{拾 佰 仟}.each_with_index do |ch,i|
    @@num_cn[ch]=10**(i+1)
  end
  @@num_cn["两"]=2
  @@num_cn["俩"]=2
  10.times do |i|
    @@num_cn[i.to_s]=i
  end
  %w{① ② ③ ④ ⑤ ⑥ ⑦ ⑧ ⑨ ⑩ ⑪ ⑫ ⑬ ⑭ ⑮ ⑯ ⑰ ⑱ ⑲ ⑳}.each_with_index do |ch,i|
    @@num_cn[ch]=i+1
  end
  @@num_cn_index = @@num_cn.keys.join

  #中文数字字符串 to int
  def cn_to_num
    num = "#{self}"
    ret = 0
    pr = 1
    bi = 0
    i = nil
    while num.size >1 and @@num_cn[num[0]] == 0
      num=num[1..-1]
    end
    @@num_cn.each do |key, value|
      num.gsub! key, value.to_s if value < 10
    end
    return num.to_i if num.to_i.to_s == num
    num.each_char do |ch|
      i= @@num_cn[ch]
      return nil unless i
      if i >= 10
        ret += pr * i
        bi = i
        pr = 0
      elsif i == 0
        bi = 0
        pr = 0
      else
        pr = i
      end
    end
    pr *= bi / 10 if bi != 0
    ret += pr
  end
  
  #字符串 提取 中文数字
  def cn_cut_num
    self.scan Regexp.new "[#{@@num_cn_index}]+"
  end
end

if $0 == __FILE__
  {
    '三万零五' => 30005,
    '二万零壹百' => 20100,
    '七万五千六' => 75600,
    '六万' => 60000,
    '俩千' => 2000,
    '叁万5佰零五' => 30505,
    '肆万5佰五十' => 40550,
    '六' => 6,
    '零' => 0,
    '千' => 1000,
    '十' => 10,
    '万5' => 15000,
    '六七八' => 678,
    '2312' => 2312,
    '0' => 0,
    '⑪' => 11,
    '0012' => 12,
    '十一' => 11,
    '陆千八百章' => 6700,
    '一千79' => 1790,
    '俩万24十' => 20240,
  }.each do |key, value|
    i=key.cn_to_num
    puts "#{i==value}\t#{key} == #{i} == #{value}"
  end
  text ='第陆千八百章 第六节'
  puts text,text.cn_cut_num.map {|x| x.cn_to_num}
end


