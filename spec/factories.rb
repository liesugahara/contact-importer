require 'open-uri'
require 'tempfile'

FactoryBot.define do

  factory :movie do
    name {"El hombre de acero 1"}
    description {"Mientras lucha con las repercusiones de su origen y sus habilidades extraordinarias, el joven Clark Kent debe convertirse en un héroe y salvar a las personas que ama de una grave amenaza."}
    photo_url {"https://encrypted-tbn3.gstatic.com/images?q=tbn:ANd9GcS37PwbA1qkHX8GglZqS9K-0RvuXC5Wlmn-RnH1geNR2N9uD_ei"}
    start_date{"31-03-2020"}
    end_date{"07-04-2020"}
    factory :movie2 do
      start_date{"07-04-2020"}
      end_date{"14-04-2020"}
    end
  
    factory :movie3 do
      start_date{"15-04-2020"}
      end_date{"22-04-2020"}
    end
  
    factory :movie4 do
      start_date{"23-04-2020"}
      end_date{"30-04-2020"}
    end
  
    factory :movie5 do
      start_date{"01-05-2020"}
      end_date{"08-05-2020"}
    end
  end

end