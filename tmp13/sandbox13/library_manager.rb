# encoding: utf-8
require 'active_support/all'
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
    return nil unless issue_datetime.kind_of? DateTime
    return nil unless price.kind_of? Numeric
    zone_seconds_addon=0 #(DateTime.now.zone.to_i-issue_datetime.zone.to_i)*3600
    sec=DateTime.now.strftime('%s').to_i-issue_datetime.strftime('%s').to_i+zone_seconds_addon
    if sec<=0
        0
    else
      full_hours=(sec/3600.round(1)).floor
      (full_hours*price*0.1/100).round(0)
    end
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
    first_oldest=year_of_birth_first<=year_of_birth_second ? true : false
    if first_oldest
      year_of_death_first>=year_of_birth_second ? true : false   
    else
      year_of_death_second>=year_of_birth_first ? true : false   
    end
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
    # так как берутся проценты => при любой цене 41 дн !!!
    (1/(24*0.1/100)).ceil
  end


  # 4. Для удобства иностранных пользователей, имена авторов книг на украинском языке нужно переводить в 
  # транслит. Транслитерацию должна выполняться согласно официальным 
  # правилам http://kyivpassport.com/transliteratio/
  
  # Входящий параметр метода 
  # - имя и фамилия автора на украинском. ("Іван Франко") 
  # Возвращаемое значение 
  # - имя и фамилия автора транслитом. ("Ivan Franko")
  def author_translit ukr_name
    alet={ "а"=>"a", "б"=>"b", "в"=>"v", "г"=>"h", "ґ"=>"g", "д"=>"d", "е"=>"e", "є"=>"ie", "ж"=>"zh", 
      "з"=>"z","и"=>"y", "і"=>"i", "ї"=>"i", "й"=>"i", "к"=>"k", "л"=>"l", "м"=>"m", 
      "н"=>"n", "о"=>"o", "п"=>"p", "р"=>"r", "с"=>"s", "т"=>"t", "у"=>"u", "ф"=>"f", 
      "х"=>"kh", "ц"=>"ts", "ч"=>"ch", "ш"=>"sh", "щ"=>"shch","ю"=>"iu", "я"=>"ia",
      "А"=>"A", "Б"=>"B", "В"=>"V", "Г"=>"H", "Ґ"=>"G", "Д"=>"D", "Е"=>"E", "Є"=>"Ye", "Ж"=>"Zh", 
      "З"=>"Z","И"=>"Y", "І"=>"I", "Ї"=>"Yi", "Й"=>"Y", "К"=>"K", "Л"=>"L", "М"=>"M", 
      "Н"=>"N", "О"=>"O", "П"=>"P", "Р"=>"R", "С"=>"C", "Т"=>"T", "У"=>"U", "Ф"=>"F", 
      "Х"=>"Kh", "Ц"=>"Ts", "Ч"=>"Ch", "Ш"=>"Sh", "Щ"=>"Shch","Ю"=>"Yu", "Я"=>"Ya"}
    ukr_name.chars.map{|t| alet.has_key?(t) ? alet.fetch(t):t}.join

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
    need_hour=((pages_quantity-current_page)/reading_speed).ceil
    end_time=DateTime.now.to_time+need_hour*60*60
    zone_seconds_addon=(DateTime.now.zone.to_i-issue_datetime.zone.to_i)*3600
    sec=end_time.strftime('%s').to_i-issue_datetime.strftime('%s').to_i+zone_seconds_addon
    if sec<=0
        0
    else
      full_hours=(sec/3600.round(1)).floor
      (full_hours*price*0.1/100).round(0)
    end
  end

end
