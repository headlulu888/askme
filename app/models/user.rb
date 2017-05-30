require 'openssl'

class User < ActiveRecord::Base
  #параметры работы модуля шифрования паролей
  ITERATIONS = 20000
  DIGEST = OpenSSL::Digest::SHA256.new

  VALID_EMAIL_REGEXP = /\A[\w+\-.]+@[a-z\d\-.]+\.[a-z]+\z/i
  VALID_USERNAME_REGEXP = /\A\w{4,16}\z/

  has_many :questions
  
  # before_validates :downcase_username
  
  attr_accessor :password

  validates :email, :username, presence: true
  validates :email, :username, uniqueness: true
  validates :username, uniqueness: {case_sensitive: false}

  validates :username, length: {maximum: 40}, format: { with: VALID_USERNAME_REGEXP }
  validates :email, format: { with: VALID_EMAIL_REGEXP }

  validates_presence_of :password, on: :create
  validates_confirmation_of :password

  before_save :encrypt_password
  before_save :downcase_username

  # шифрование пароля
  def encrypt_password
    if self.password.present?
      # создаем "соль" - рандомная строка усложняющая задачу хакерам
      self.password_salt = User.hash_to_string(OpenSSL::Random.random_bytes(16))

      # создаем хэш пароля - длинная уникальная строка, из которой невозможно
      # востановить исходный пароль
      self.password_hash = User.hash_to_string(
          OpenSSL::PKCS5.pbkdf2_hmac(self.password, self.password_salt, ITERATIONS, DIGEST.length, DIGEST)
        )
    end
  end

  # служебынй метод. преобразующий бинарную строку в 16-ричный формат, для удобства хранения
  def self.hash_to_string(password_hash)
    password_hash.unpack('H*')[0]
  end

  def self.authenticate(email, password)
    # сперва находим кандидата по email
    user = find_by(email: email)

    # обратите внимание: сравнивается password_hash, а оригинальный
    # пароль так никогда и не сохраняется нигде!
    if user.present? && user.password_hash == User.hash_to_string(OpenSSL::PKCS5.pbkdf2_hmac(password, user.password_salt, ITERATIONS, DIGEST.length, DIGEST))
      user
    else
      nil
    end
  end

  # преобразует в нижний регистр
  def downcase_username
    self.username.downcase!
  end

end