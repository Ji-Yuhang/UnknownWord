#!/usr/bin/env ruby
require 'active_record'
require 'sqlite3'
require 'awesome_print'
require './spell'
#ActiveRecord::Base.establish_connection :adapter => "sqlite3",
    #:database => "nce.db"

ActiveRecord::Base.establish_connection :adapter => "mysql",
    :host => "rds1m2iqskhitpx6nmx7u.mysql.rds.aliyuncs.com",
    :database => "english",
    :username => "jiyuhang",
    :password => "jiyuhang8757871"
class Wordlist < ActiveRecord::Base
end
class Unknownword < ActiveRecord::Base
end
Wordlist.all().each do |s|
    word = s.content
    spell = Spell.instance
    if !spell.check?(word)
        ap s
        s.delete
        s.save!
        next
    end
    stemword = spell.remove_plural word
    if stemword != word
        s.content = stemword
        s.save!
    end
end

=begin
Unknownword.all().each do |un|
    word_id = un.word_id
    begin
    word = Wordlist.find word_id
    rescue ActiveRecord::RecordNotFound
        un.destroy
        un.save!
        ap "not found"
        next
    end
end
=end

#s = Wordlist.first
#ap s
=begin
s.id=99991
s.sentence = "Nothing"
s.article="article"
s.addtime=123456778
s.updatetime=123456778
s.status=123456778

s.save!
=end
