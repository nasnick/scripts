#!/usr/bin/env ruby

class TextCompressor
attr_reader :unique, :index

def initialize( text )
  @unique = []
  @index = []
  add_text( text )
end

def add_text( text )
#get the words from text that is referenced by new object? compressor
  words = text.split
  puts words
#call the word_add method passing each word from the array 'words'
  words.each { |word| add_word( word ) }
end

def add_word( word )
#if the lookup of the word in @unique is true then that is added to @index otherwise add it to @unique. 
#Words that don't match the first part of the 'or' clause are passed to add_unique_word method.
  i = unique_index_of( word ) || add_unique_word( word )
  @index << i
puts i
end

def unique_index_of( word )
#Looks up the word and if the word is present in the unique array then it is true and returns the
#index of that word which is passed into the index array.
  @unique.index( word ) 
end

def add_unique_word( word )
#This function returns the size of the unique array and this is fed into @index in the add_word function.
#The 'i = ..' statement will first search the unique array. If it finds the word then it is added to the
#index array otherwise, the size of the array is returned in this function minus one because the first word
#is indexed as '0' but unique.size returns the number of words.
  @unique << word
  unique.size - 1
end
end

text = "hello there there my sweetness hello"
compressor = TextCompressor.new( text )

unque_word_array = compressor.unique
word_index = compressor.index

telnet 209.20.94.91 5001 ; telnet 209.20.94.91 8098 ; telnet 209.20.94.91 9231
