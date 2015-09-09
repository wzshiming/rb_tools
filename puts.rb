#!/usr/bin/env ruby 
#-*- coding:utf-8 -*- 
module Kernel
  alias :puts0 :puts 
  def _puts data , size = 0, space = ' '
    tabs = space * size
    case data
    when Array, Enumerator
      data.map do |value|
        "#{tabs+space}#{_puts value, size+1, space}"
      end.inject("[\n", :+) + "#{tabs}]"
    when Hash
      data.map do |key,value| 
        "#{tabs+space}#{key}: #{"\n#{tabs+space}" if Array === value or Hash === value}#{_puts value, size + 1, space}"
      end.inject("{\n", :+) + "#{tabs}}"
    when nil then "nil"
    else data.to_s
    end + "\n"
  end
  
  def puts *argv
    argv.each do |arg|
      puts0 _puts arg
    end
  end
end

if $0 == __FILE__
  require 'set'
  a={}
  5.times do |i|
    a[i.to_s]=i+12**2
    a[i.to_s+'a']=[rand(3),rand(4)]
  end
  a['asd']=[[nil],[33,[42,[],true,{hehe:"hehe",hehe2:/asdasd/,nn: [123,123]}]]]
  puts a,[23],2
  puts [1,2,3,4,455].map
  puts Set.new([1,2,3,4])
  puts
end