class BlogPost < ApplicationRecord

  has_many :comments, as: :commentable
  # Таким образом обозначаем что BlogPost является комментируемым

end
