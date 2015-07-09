#!/usr/bin/env ruby
require 'awesome_print'
require './db'
require './shanbay'

NCE3::Articles.all().each do |article|
    content = article.content
    words = Article.get_words content
    words.each do |word|
        ap word
        fami =  Jiyuhang.familiarity word
        if !fami.nil? and fami == 1
            next
        end
        puts word
        yes = gets
        yes.chomp!
        if yes == "n"
            Shanbay.shanbayword word
            NCE3.get_sentence word
        end
    end
    
end
