#!/usr/bin/env ruby
#require 'epub/parser'
require 'active_record'
require 'sqlite3'
require 'awesome_print'
require './article'

module Willpower
    ActiveRecord::Base.establish_connection :adapter => "sqlite3",
        :database => "../db/the_will_power_instinct.db"

    class Articles < ActiveRecord::Base
    end

    class Sentences < ActiveRecord::Base
    end

    class Words < ActiveRecord::Base
    end

    def get_sentence word
        info = Words.where word: word

        ap info.word
        senidlist = info.sentence_id_list
        senids = senidlist.split ","
        senids.each do |senid|
            seninfo = Sentences.find senid
            sen = seninfo.sentence
            articleid = seninfo.article_id
            ap sen

        end

    end

    module_function :get_sentence
end

module NCE3
    ActiveRecord::Base.establish_connection :adapter => "sqlite3",
        :database => "../db/nce3.db"

    class Articles < ActiveRecord::Base
    end

    class Sentences < ActiveRecord::Base
    end

    class Words < ActiveRecord::Base
    end

    def get_sentence word
        infos = Words.where word: word
        info = infos.first
        #ap info.first
        #ap info

        #ap info.word
        senidlist = info.sentence_id_list
        senids = senidlist.split ","
        senids.each do |senid|
            seninfo = Sentences.find senid
            sen = seninfo.sentence
            articleid = seninfo.article_id
            ap sen

        end

    end

    module_function :get_sentence

end
module Jiyuhang
    ActiveRecord::Base.establish_connection :adapter => "sqlite3",
        :database => "../db/jiyuhang.db"

    class Words < ActiveRecord::Base
    end
    class Unknownwords < ActiveRecord::Base
    end
    
    def familiarity word
        words = Words.where word: word
        if words.empty?
        else
            word = words.first
            word_id = word.word_id
            uns = Unknownwords.where word_id: word_id
            if uns.empty?
            else
                un = uns.first
                fami = un.familiarity
                return fami
            end
        end
        return nil
    end
    module_function :familiarity
end
