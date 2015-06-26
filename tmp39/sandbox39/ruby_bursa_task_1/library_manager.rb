require 'date'
require 'pry'

class LibraryManager

  # 1. Бибилиотека в один момент решила ввести жесткую систему штрафов (прямо как на rubybursa :D).
  # За каждый час опоздания со здачей книги читатель вынужден заплатить пеню 0,1% от стоимости.  
  # Необходимо реализовать метод, который будет считать эту сумму в зависимости от даты выдачи и 
  # текущего времени. По работе с датой-временем информацию можно посмотреть 
  # тут http://ruby-doc.org/stdlib-2.2.2/libdoc/date/rdoc/DateTime.html
  # 
  # Входящие параметры метода 
  # - стоимость книги в центах, 
  # - дата и время возврата (момент, когда книга должна была быть сдана, в формате DateTime)
  # Возвращаемое значение 
  # - пеня в центах
  def penalty price, issue_datetime
    # решение пишем тут
    late_hours = (DateTime.now.new_offset(0).to_time - issue_datetime.to_time) / 60 / 60
    return 0 if late_hours <= 0 || price <= 0
    (0.001 * price * late_hours).round
  end

  # 2. Известны годы жизни двух писателей. Год рождения, год смерти. Посчитать, могли ли они чисто 
  # теоретически встретиться. Даже если один из писателей был в роддоме - это все равно считается встречей. 
  # Помните, что некоторые писатели родились и умерли до нашей эры - в таком случае годы жизни будут просто 
  # приходить со знаком минус.
  # 
  # Входящие параметры метода 
  # - год рождения первого писателя, 
  # - год смерти первого писателя, 
  # - год рождения второго писателя, 
  # - год смерти второго писателя.
  # Возвращаемое значение 
  # - true или false
  def could_meet_each_other? year_of_birth_first, year_of_death_first, year_of_birth_second, year_of_death_second
    # решение пишем тут
    # binding.pry
    return false unless year_of_birth_first <= year_of_death_first and year_of_birth_second <= year_of_death_second
    year_of_birth_second <= year_of_death_first and year_of_birth_first <= year_of_death_second
  end

  # 3. Исходя из жесткой системы штрафов за опоздания со cдачей книг, читатели начали задумываться - а 
  # не дешевле ли будет просто купить такую же книгу...  Необходимо помочь читателям это выяснить. За каждый 
  # час опоздания со здачей книги читатель вынужден заплатить пеню 0,1% от стоимости.
  # 
  # Входящий параметр метода 
  # - стоимость книги в центах 
  # Возвращаемое значение 
  # - число полных дней, нак которые необходимо опоздать со здачей, чтобы пеня была равна стоимости книги.
  def days_to_buy price
    # решение пишем тут
    return 0 if price <= 0
    days = 1000.0 / 24
    rand < 0.5 ? days.ceil : days.floor
  end


  # 4. Для удобства иностранных пользователей, имена авторов книг на украинском языке нужно переводить в 
  # транслит. Транслитерацию должна выполняться согласно официальным 
  # правилам http://kyivpassport.com/transliteratio/
  
  # Входящий параметр метода 
  # - имя и фамилия автора на украинском. ("Іван Франко") 
  # Возвращаемое значение 
  # - имя и фамилия автора транслитом. ("Ivan Franko")
  def author_translit ukr_name
    # решение пишем тут
    replacement_dict = {'А' => 'A', 'а' => 'a',
                        'Б' => 'B', 'б' => 'b',
                        'В' => 'V', 'в' => 'v',
                        'Г' => 'H', 'г' => 'h',
                        'Ґ' => 'G', 'ґ' => 'g',
                        'Д' => 'D', 'д' => 'd',
                        'Е' => 'E', 'е' => 'e',
                        'З' => 'Z', 'з' => 'z',
                        'И' => 'Y', 'и' => 'y',
                        'І' => 'I', 'і' => 'i',
                        'К' => 'K', 'к' => 'k',
                        'Л' => 'L', 'л' => 'l',
                        'М' => 'M', 'м' => 'm',
                        'Н' => 'N', 'н' => 'n',
                        'О' => 'O', 'о' => 'o',
                        'П' => 'P', 'п' => 'p',
                        'Р' => 'R', 'р' => 'r',
                        'С' => 'S', 'с' => 's',
                        'Т' => 'T', 'т' => 't',
                        'У' => 'U', 'у' => 'u',
                        'Ф' => 'F', 'ф' => 'f',

                        'Ж(?=\p{Lu})' => 'ZH',   'Ж(?=(\b|\p{Ll}))' => 'Zh',   'ж' => 'zh',
                        'Х(?=\p{Lu})' => 'KH',   'Х(?=(\b|\p{Ll}))' => 'Kh',   'х' => 'kh',
                        'Ц(?=\p{Lu})' => 'TS',   'Ц(?=(\b|\p{Ll}))' => 'Ts',   'ц' => 'ts',
                        'Ч(?=\p{Lu})' => 'CH',   'Ч(?=(\b|\p{Ll}))' => 'Ch',   'ч' => 'ch',
                        'Ш(?=\p{Lu})' => 'SH',   'Ш(?=(\b|\p{Ll}))' => 'Sh',   'ш' => 'sh',
                        'Щ(?=\p{Lu})' => 'SHCH', 'Щ(?=(\b|\p{Ll}))' => 'Shch', 'щ' => 'shch',

                        '\bЄ(?=\p{Lu})' => 'YE', '\bЄ(?=(\b|\p{Ll}))' => 'Ye', '\bє' => 'ye',
                        '\BЄ(?=\p{Lu})' => 'IE', '\BЄ(?=(\b|\p{Ll}))' => 'Ie', '\Bє' => 'ie',

                        '\bЇ(?=\p{Lu})' => 'YI', '\bЇ(?=(\b|\p{Ll}))' => 'Yi', '\bї' => 'yi', 
                        '\BЇ' => 'I', '\Bї' => 'i',

                        '\bЙ' => 'Y', '\bй' => 'y', 
                        '\BЙ' => 'I', '\Bй' => 'i',

                        '\bЮ(?=\p{Lu})' => 'YU', '\bЮ(?=(\b|\p{Ll}))' => 'Yu', '\bю' => 'yu',
                        '\BЮ(?=\p{Lu})' => 'IU', '\BЮ(?=(\b|\p{Ll}))' => 'Iu', '\Bю' => 'iu',

                        '\bЯ(?=\p{Lu})' => 'YA', '\bЯ(?=(\b|\p{Ll}))' => 'Ya', '\bя' => 'ya',
                        '\BЯ(?=\p{Lu})' => 'IA', '\BЯ(?=(\b|\p{Ll}))' => 'Ia', '\Bя' => 'ia'}

    # binding.pry
    without_apostrophe = ukr_name.gsub(/(?:(?<=\p{L})[’'](?=\p{L})|ь)/i, '')
    replacement_dict.each {|key, value| without_apostrophe.gsub!(/#{key}/, "#{value}")}
    without_apostrophe
  end

  #5. Читатели любят дочитывать книги во что-бы то ни стало. Необходимо помочь им просчитать сумму штрафа, 
  # который придеться заплатить чтобы дочитать книгу, исходя из количества страниц, текущей страницы и 
  # скорости чтения за час.
  # 
  # Входящий параметр метода 
  # - Стоимость книги в центах
  # - DateTime сдачи книги (может быть как в прошлом, так и в будущем)
  # - Количество страниц в книге
  # - Текущая страница
  # - Скорость чтения - целое количество страниц в час.
  # Возвращаемое значение 
  # - Пеня в центах или 0 при условии что читатель укладывается в срок здачи.
  def penalty_to_finish price, issue_datetime, pages_quantity, current_page, reading_speed
    # решение пишем тут
    diff_hours = (DateTime.now.new_offset(0).to_f - issue_datetime.to_f) / 60 / 60
    pages_to_read = pages_quantity - current_page
    hours_to_read = pages_to_read.to_f / reading_speed
    late_hours = diff_hours + hours_to_read
    # binding.pry
    return 0 if price <= 0 or 
                not (0 <= current_page and current_page <= pages_quantity) or
                late_hours <= 0
    (0.001 * price * late_hours).round
  end

end