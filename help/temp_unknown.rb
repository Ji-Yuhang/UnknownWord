#!/usr/bin/env ruby
require 'active_record'
require 'sqlite3'
require 'awesome_print'
require '../ruby/spell'
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
io = File.open "unknown_word.txt","w"
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

