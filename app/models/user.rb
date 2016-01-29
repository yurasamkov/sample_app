class User < ActiveRecord::Base
	before_save { self.email = email.downcase } # перед зберіганням мила 
	                                            # в бд переводить мило в нижній регістр
	validates :name, presence: true, length: { maximum: 50 }
	VALID_EMAIL_REGEX = /\A[\w+\-.]+@[a-z\d\-]+\.[a-z]+\z/i # правильний зразок мила
    validates :email, presence: true, 
                      format: { with: VALID_EMAIL_REGEX },
                      uniqueness: { case_sensitive: false } # метод унікальнисті
    has_secure_password  # приводит к безопастности пароля.
                         # (Валидации наличия и подтверждения автоматически
                         # добавляются has_secure_password.)
    validates :password, length: { minimum: 6 } # валидация длины для пароля
end
