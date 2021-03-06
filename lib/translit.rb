# coding: utf-8

module Translit
  def self.english
    { "a"=>["А","а"], "b"=>["Б","б"], "v"=>["В","в"], "g"=>["Г","г"], "d"=>["Д","д"], "e"=>["Е","е"], "jo"=>["Ё","ё"], "yo"=>["Ё","ё"], "ö"=>["Ё","ё"], "zh"=>["Ж","ж"],
      "z"=>["З","з"], "i"=>["И","и"], "j"=>["Й","й"], "k"=>["К","к"], "l"=>["Л","л"], "m"=>["М","м"], "n"=>["Н","н"], "o"=>["О","о"], "p"=>["П","п"], "r"=>["Р","р"],
      "s"=>["С","с"], "t"=>["Т","т"], "u"=>["У","у"], "f"=>["Ф","ф"], "h"=>["Х","х"], "x"=>["Х","х"], "c"=>["Ц","ц"], "ch"=>["Ч","ч"], "sh"=>["Ш","ш"], "w"=>["Щ","щ"],
      "shh"=>["Щ","щ"], "sch"=>["Щ","щ"], "#"=>["Ъ","ъ"], "y"=>["Ы","ы"], "'"=>["Ь","ь"], "je"=>["Э","э"], "ä"=>["Э","э"], "ju"=>["Ю","ю"], "yu"=>["Ю","ю"],
      "ü"=>["Ю","ю"], "ya"=>["Я","я"], "ja"=>["Я","я"], "q"=>["Я","я"]}
  end

  def self.russian
    @russian ||= create_russian_map
  end

  def self.convert(text)
    lang = detect_input_language(text.split(/\s+/).first)
    map = self.send(lang.to_s).sort_by {|k,v| v.length <=>  k.length}
    map.each do |translit_key, translit_value|
      text.gsub!(translit_key.capitalize, translit_value.first)
      text.gsub!(translit_key, translit_value.last)
    end
    text
  end

private
  def self.create_russian_map
    self.english.inject({}) do |acc, tuple|
      rus_up, rus_low = tuple.last
      eng_value       = tuple.first
      acc[rus_up]  ? acc[rus_up]  << eng_value.capitalize : acc[rus_up]  = [eng_value.capitalize]
      acc[rus_low] ? acc[rus_low] << eng_value            : acc[rus_low] = [eng_value]
      acc
    end
  end

  def self.detect_input_language(text)
    text.scan(/\w+/).empty? ? :russian : :english
  end
end