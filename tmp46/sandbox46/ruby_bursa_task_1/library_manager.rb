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
	now_date = DateTime.now.new_offset(0)
	difference_in_time = (now_date.to_time - issue_datetime.to_time).to_i/3600
	return 0 if difference_in_time < 0 || price < 0
	(price * difference_in_time * 0.001).round
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
	a=year_of_birth_first
	b=year_of_death_first
	c=year_of_birth_second
	d=year_of_death_second
	((a<b)&&(c<d))&&((c<=b)&&(a<=d))
		
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
		 return 0 if price <=0
	((price / (price * 0.001))/24).round
	

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
		h =  (pages_quantity - current_page) / reading_speed
		now_date = DateTime.now.new_offset(0)
		difference_in_time = ((now_date.to_time + h*3600)-issue_datetime.to_time).to_i/3600
if difference_in_time <= 0 
 return 0
 else 
  return (difference_in_time*0.001*price).round
  end
	  end
end