class User < ActiveRecord::Base
	before_save { self.email = email.downcase } # перед зберіганням мила 
	                                            # в бд переводить мило в нижній регістр
  before_create :create_remember_token # Листинг 8.17. Обратный вызов before_create 
                                       # для создания remember_token. 
	
  validates :name, presence: true, length: { maximum: 50 }
	VALID_EMAIL_REGEX = /\A[\w+\-.]+@[a-z\d\-]+\.[a-z]+\z/i # правильний зразок мила
    validates :email, presence: true, 
                      format: { with: VALID_EMAIL_REGEX },
                      uniqueness: { case_sensitive: false } # метод унікальнисті
    has_secure_password  # приводит к безопастности пароля.
                         # (Валидации наличия и подтверждения автоматически
                         # добавляются has_secure_password.)
    validates :password, length: { minimum: 6 } # валидация длины для пароля

  def User.new_remember_token
    SecureRandom.urlsafe_base64
  end

  def User.encrypt(token)
    Digest::SHA1.hexdigest(token.to_s)
  end

  private

    def create_remember_token
      self.remember_token = User.encrypt(User.new_remember_token)
    end

end
