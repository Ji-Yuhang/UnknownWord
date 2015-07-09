#!/usr/bin/env ruby
require 'active_record'
require 'sqlite3'
require 'awesome_print'
require '../ruby/spell'
ActiveRecord::Base.establish_connection :adapter => "sqlite3",
    :database => "../db/jiyuhang.db"

class Word < ActiveRecord::Base
end
class Unknownword < ActiveRecord::Base
end
spell = Spell.instance
io = File.open "unknown_word.txt"
io.each_line do |line|
    line.chomp!
    if spell.check? line
        word = spell.remove_plural line
        num = word.to_i
        if num != 0
            next
        end
    
        #ap word
        wordinfos = Word.where word: word
        if wordinfos.empty?
            wordinfo = Word.new
            wordinfo.word = word
            #wordinfo.save
            ap wordinfo
        else 
            wordinfo = wordinfos.first
            id = wordinfo.word_id
            ap id
            un = Unknownword.new
            un.word_id = id
            un.familiarity = 1 # 1 for known, 0 for unknown
            un.save
            
        end
        
    end
end
=begin
Unknownword.all().each do |un|
    word_id = un.word_id
    if un.familiarity == 1
        #ap un.content

        begin
            word = Wordlist.find word_id
            ap word.content
            io.puts word.content
        rescue ActiveRecord::RecordNotFound
            un.destroy
            un.save!
            ap "not found"
            next
        end

    end
end
=end
